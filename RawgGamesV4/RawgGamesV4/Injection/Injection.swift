//
//  Injection.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Core
import Favorite
import Games
import Swinject

/// Dependency injection for UI and presenter.
final class Injection {

    /// Create singleton of`Injection`.
    static let shared: Injection = Injection()

    private init() {}

    /// Get presenter for popular.
    func getPopular() -> PopularPresenter {
        return PopularPresenter(
            gameUseCase: Container.gamesUseCase
        )
    }

    /// Get presenter for favorite.
    func getFavorite() -> FavoritePresenter {
        return FavoritePresenter(
            getFavoritesUseCase: Container.getFavoritesUseCase,
            addFavoritesUseCase: Container.addFavoritesUseCase,
            removeFavoritesUseCase: Container.removeFavoritesUseCase
        )
    }

    /// Get presenter for search games.
    func getSearch() -> SearchPresenter {
        return SearchPresenter(
            gameUseCase: Container.gamesUseCase
        )
    }

    /// Get presenter for detail game.
    func getDetail(game: GameModel) -> DetailPresenter {
        return DetailPresenter(
            gameUseCase: Container.detailGameUseCase,
            game: game
        )
    }

}
