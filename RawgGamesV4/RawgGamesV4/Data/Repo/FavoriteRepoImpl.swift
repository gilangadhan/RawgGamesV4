//
//  FavoriteRepoImpl.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Combine
import Games

class FavoriteRepoImpl: FavoriteRepo {
    private let favoriteSource: FavoriteDataSource
    private let mapper: GameMapper = GameMapper()

    init(favoriteSource: FavoriteDataSource) {
        self.favoriteSource = favoriteSource
    }

    /// Get favorite games.
    func getFavorites() -> AnyPublisher<[GameModel], Error> {
        let source = favoriteSource.getFavorites()
            .map(mapper.toFavorites)
            .eraseToAnyPublisher()
        return source
    }

    /// Save favorite game.
    func addFavorite(game: GameModel) throws {
        try favoriteSource.addFavorite(game: game)
    }

    /// Remove favorite game based on id.
    func removeFavorite(id: String) throws {
        try favoriteSource.removeFavorite(id: id)
    }
}
