//
//  PopularPresenter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import Combine
import Core
import SwiftUI
import Games

/// Presenter to handle list popular games.
/// Has feature of infinite scroll pagination.
class PopularPresenter: BlocPresenter<PopularState, PopularEvent> {
    private let gameUseCase: GamesUseCaseType
    let router = PopularRouter()

    init(gameUseCase: GamesUseCaseType) {
        self.gameUseCase = gameUseCase
        super.init(state: PopularState())
    }

    /// To handle flow event from user action or input.
    override func handleEvent(event: PopularEvent) {
        switch event {
        case .loadMore:
            loadData()
        case .refresh:
            loadData(isRefresh: true)
        }
    }

    /// Start load data of list popular games.
    /// Has feature of infinite scroll pagination.
    ///
    /// Set `isRefresh` if user do pull to refresh.
    private func loadData(
        isRefresh: Bool = false
    ) {
        if state.status == .loading {
            return
        }

        state.status = .loading

        let page = isRefresh ? 1 : state.page

        let params = GamesParams(
            page: page,
            pageSize: state.pageSize
        )

        gameUseCase
            .execute(params)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                /// If use case response error.
                if case .failure(let error) = completion {
                    state.status = .error
                    state.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] listGames in
                guard let self = self else { return }

                /// If response show empty data, no more data will be fetch.
                if listGames.isEmpty {
                    state.status = .noMoreData
                    return
                }
                
                state.status = .success
                state.errorMessage = ""
                if isRefresh {
                    state.listGames = listGames
                    state.page = 1
                } else {
                    state.listGames += listGames
                    state.page += 1
                }
            }
            .store(in: &cancellables)

    }
}
