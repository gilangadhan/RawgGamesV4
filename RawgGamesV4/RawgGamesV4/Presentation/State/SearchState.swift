//
//  SearchState.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Games

/// Handle state in `SearchPresenter`.
struct SearchState {
    var isLoading: Bool = false
    var searchResults: [GameModel] = []
    var errorMessage: String = ""
}
