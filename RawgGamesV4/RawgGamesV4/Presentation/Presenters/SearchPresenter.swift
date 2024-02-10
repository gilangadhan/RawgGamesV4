//
//  SearchPresenter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Combine
import Core
import Foundation
import Games

/// Presenter to handle search games.
/// NOTE: Doesn't have infinite scroll pagination like `PopularPresenter`. 
class SearchPresenter: BlocPresenter<SearchState, SearchEvent> {
    private let gameUseCase: Injection.GameUseCaseType
    let router = SearchRouter()

    init(gameUseCase: Injection.GameUseCaseType) {
        self.gameUseCase = gameUseCase
        super.init(state: SearchState())
    }

    /// To handle flow event from user action or input.
    override func handleEvent(event: SearchEvent) {
        switch event {
        case .onSearch(let search):
            searchGames(search)
        }
    }

    /// Start searching games.
    /// NOTE: Doesn't have infinite scroll pagination like `PopularPresenter`.
    private func searchGames(_ search: String) {
        if search.isEmpty {
            state = SearchState()
            return
        }

        if state.isLoading {
            return
        }

        state.isLoading = true

        let params = GamesParams(
            search: search
        )

        gameUseCase
            .execute(params)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                /// If use case response error.
                if case .failure(let error) = completion {
                    state.isLoading = false
                    state.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] listGames in
                guard let self = self else { return }

                state.isLoading = false
                state.errorMessage = ""
                state.searchResults = listGames
            }
            .store(in: &cancellables)

    }
}
