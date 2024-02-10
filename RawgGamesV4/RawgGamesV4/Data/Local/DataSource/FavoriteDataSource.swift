////
////  FavoriteDataSource.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 08/02/24.
////
//
//import Combine
//import Games
//
///// Handle favorite from local storage.
//protocol FavoriteDataSource {
//    /// Get favorite games from local storage.
//    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error>
//
//    /// Save favorite game to local storage.
//    func addFavorite(game: GameModel) throws
//
//    /// Remove favorite game from local storage based on id.
//    func removeFavorite(id: String) throws
//}
