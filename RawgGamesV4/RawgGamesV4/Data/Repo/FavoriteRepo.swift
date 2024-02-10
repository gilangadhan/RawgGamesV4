//
//  FavoriteRepo.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Combine
import Games

protocol FavoriteRepo {
    /// Get favorite games.
    func getFavorites() -> AnyPublisher<[GameModel], Error>

    /// Save favorite game.
    func addFavorite(game: GameModel) throws

    /// Remove favorite game based on id.
    func removeFavorite(id: String) throws
}
