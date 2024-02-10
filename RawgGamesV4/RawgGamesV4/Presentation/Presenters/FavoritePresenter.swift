//
//  FavoritePresenter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Core
import SwiftUI
import Games

/// Presenter to get list favorite games, also action to add or remove favorite.
class FavoritePresenter: BlocPresenter<FavoriteState, FavoriteEvent> {
    private let favoriteUseCase: FavoriteUseCase
    let router = FavoriteRouter()
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
        super.init(state: FavoriteState())
        listenFavorites()
    }

    /// To handle flow event from user action or input.
    override func handleEvent(event: FavoriteEvent) {
        switch event {
        case .add(let game):
            addFavorite(game: game)
        case .remove(let id):
            removeFavorite(id: id)
        }
    }
    
    /// Get game is favorited based on id.
    func isGameFavorite(id: String) -> Bool {
        let favorite = getFavoriteGame(id: id)
        return favorite != nil
    }
    
    /// Filter `listGames` by id.
    ///
    /// Use this if we want to get dynamic is favorite status.
    private func getFavoriteGame(id: String) -> GameModel? {
        let game = state.listFavorites.first(where: { game in game.id == id})
        return game
    }
    
    /// Add favorite to use case.
    private func addFavorite(game: GameModel) {
        do {
            try favoriteUseCase.addFavorite(game: game)
            state.errorMessage = ""
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }
    
    /// Remove favorite from use case.
    private func removeFavorite(id: String) {
        do {
            try favoriteUseCase.removeFavorite(id: id)
            state.errorMessage = ""
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }
    
    /// Listen changes of list favorite games.
    private func listenFavorites() {
        favoriteUseCase.getFavorites()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                /// If use case response error.
                if case .failure(let error) = completion {
                    state.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] listFavorites in
                guard let self = self else { return }
                
                state.listFavorites = listFavorites
                state.errorMessage = ""
            }
            .store(in: &cancellables)
    }
}
