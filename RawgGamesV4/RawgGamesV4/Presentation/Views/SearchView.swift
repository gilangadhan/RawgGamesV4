//
//  SearchView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import SwiftUI
import Games

/// Show search games.
/// NOTE: Doesn't have infinite scroll pagination like `PopularPresenter`.
struct SearchView: View {
    @StateObject private var presenter: SearchPresenter = Injection.shared.getSearch()
    @State private var searchText: String = ""

    var listGames: [GameModel] {
        presenter.state.searchResults
    }

    var body: some View {
        Group {
            if presenter.state.isLoading {
                ProgressView()
            } else if searchText.isEmpty && listGames.isEmpty {
                Text("Please search any games")
            } else if searchText.isEmpty == false && listGames.isEmpty {
                Text("Press enter to search")
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
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            presenter.event = .onSearch(search: searchText)
        }
        .onChange(of: searchText) { newSearchText in
            if newSearchText.isEmpty {
                presenter.event = .onSearch(search: "")
            }
        }
        .navigationTitle("Search Games")
    }
}

#Preview {
    SearchView()
}
