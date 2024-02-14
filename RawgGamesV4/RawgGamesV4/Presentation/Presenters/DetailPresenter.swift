//
//  DetailPresenter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Core
import Foundation
import Games

/// Presenter to get detail game.
class DetailPresenter: BlocPresenter<DetailState, DetailEvent> {
    private let gameUseCase: GetDetailGameUseCase

    init(
        gameUseCase: GetDetailGameUseCase,
        game: GameModel
    ) {
        self.gameUseCase = gameUseCase
        super.init(
            state: DetailState(
                game: game
            )
        )
    }

    /// To handle flow event from user action or input.
    override func handleEvent(event: DetailEvent) {
        switch event {
        case .loadData:
            loadData()
        }
    }

    /// Get formatted string from date.
    func getDateString(date: Date?, locale: Locale) -> String {
        guard let date else {
            return ""
        }

        /// Create Date Formatter
        let dateFormatter = DateFormatter()

        /// Set Date Format
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = locale

        /// Convert Date to String
        return dateFormatter.string(from: date)
    }

    /// Load detail data.
    private func loadData() {
        if case .loading  = state.status {
            return
        }

        state.status = .loading

        gameUseCase
            .execute(state.game.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                /// If use case response error.
                if case .failure(let error) = completion {
                    state.status = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] detail in
                guard let self = self else { return }
                
                state.status = .success(detail)
            }
            .store(in: &cancellables)
    }
}
