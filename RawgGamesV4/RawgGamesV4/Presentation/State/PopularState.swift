//
//  PopularDataState.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import Games

/// Handle state in `PopularPresenter`.
struct PopularState {
    var status: PopularStateStatus = .initial
    var listGames: [GameModel] = []
    var errorMessage: String = ""
    var page: Int = 1
    var pageSize: Int = 10
}

enum PopularStateStatus {
    case initial
    case loading
    case success
    case noMoreData
    case error
}
