//
//  FavoriteEvent.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Games

/// Handle event in `FavoritePresenter`.
enum FavoriteEvent {
    case add(game: GameModel)
    case remove(id: String)
}
