//
//  FavoriteState.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Games

/// Handle state in `FavoritePresenter`.
struct FavoriteState {
    var listFavorites: [GameModel] = []
    var errorMessage: String = ""
}
