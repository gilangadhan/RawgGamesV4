//
//  FavoriteView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI

/// Show favorite games.
struct FavoriteView: View {
    @EnvironmentObject var presenter: FavoritePresenter
    @EnvironmentObject var popularPresenter: PopularPresenter

    var body: some View {
        let state = presenter.state
        let listGames = state.listFavorites

        Group {
            if listGames.isEmpty {
                Text("You don't have favorite games")
            } else {
                List(
                    listGames,
                    id: \.id
                ) { game in
                    GameListTile(
                        game: game,
                        destination: presenter.router.goToDetail(game: game)
                    )
                    /// Remove padding in `List`.
                    .listRowInsets(EdgeInsets())
                    /// Remove line separator in `List`.
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Your Favorites")
    }
}

#Preview {
    FavoriteView()
}
