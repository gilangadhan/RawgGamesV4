//
//  FavoriteInteractor.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Combine
import Games

class FavoriteInteractor: FavoriteUseCase {
    
    private let repo: FavoriteRepo

    init(repo: FavoriteRepo) {
        self.repo = repo
    }

    func getFavorites() -> AnyPublisher<[GameModel], Error> {
        return repo.getFavorites()
    }

    func addFavorite(game: GameModel) throws {
        try repo.addFavorite(game: game)
    }

    func removeFavorite(id: String) throws {
        try repo.removeFavorite(id: id)
    }

}
