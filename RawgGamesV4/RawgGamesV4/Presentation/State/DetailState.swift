//
//  DetailState.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Games

/// Handle state in `DetailPresenter`.
struct DetailState {
    var status: DetailStateStatus = .initial
    var game: GameModel
}

enum DetailStateStatus {
    case initial
    case loading
    case success(DetailGameModel)
    case error(String)
}
