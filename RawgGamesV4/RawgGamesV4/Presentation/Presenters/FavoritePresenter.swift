//
//  FavoritePresenter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Core
import Favorite
import Games
import SwiftUI

/// Presenter to get list favorite games, also action to add or remove favorite.
class FavoritePresenter: BlocPresenter<FavoriteState, FavoriteEvent> {
    private let getFavoritesUseCase: Injection.GetFavoritesUseCase
    private let addFavoritesUseCase: Injection.AddFavoritesUseCase
    private let removeFavoritesUseCase: Injection.RemoveFavoritesUseCase
    let router = FavoriteRouter()

    init(
        getFavoritesUseCase: Injection.GetFavoritesUseCase,
        addFavoritesUseCase: Injection.AddFavoritesUseCase,
        removeFavoritesUseCase: Injection.RemoveFavoritesUseCase
    ) {
        self.getFavoritesUseCase = getFavoritesUseCase
        self.addFavoritesUseCase = addFavoritesUseCase
        self.removeFavoritesUseCase = removeFavoritesUseCase
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
        addFavoritesUseCase
            .execute([toFavorite(game)])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                /// If use case response error.
                if case .failure(let error) = completion {
                    state.errorMessage = error.localizedDescription
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    /// Remove favorite from use case.
    private func removeFavorite(id: String) {
        removeFavoritesUseCase
            .execute(id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                /// If use case response error.
                if case .failure(let error) = completion {
                    state.errorMessage = error.localizedDescription
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    /// Listen changes of list favorite games.
    private func listenFavorites() {
        getFavoritesUseCase
            .execute(nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                /// If use case response error.
                if case .failure(let error) = completion {
                    state.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] listFavorites in
                guard let self = self else { return }
                
                state.listFavorites = listFavorites.map({ favorite in
                    self.toGame(favorite)
                })
                state.errorMessage = ""
            }
            .store(in: &cancellables)
    }

    func toFavorite(_ game: GameModel) -> FavoriteModel {
        FavoriteModel(
            id: game.id,
            title: game.title,
            imgSrc: game.imgSrc,
            released: game.released,
            rating: game.rating
        )
    }

    func toGame(_ favorite: FavoriteModel) -> GameModel {
        GameModel(
            id: favorite.id,
            title: favorite.title,
            imgSrc: favorite.imgSrc,
            released: favorite.released,
            rating: favorite.rating
        )
    }

}
