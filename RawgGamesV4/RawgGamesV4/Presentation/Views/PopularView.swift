//
//  PopularView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI

/// Show list popular games.
/// Has feature of infinite scroll pagination. 
struct PopularView: View {
    @EnvironmentObject var presenter: PopularPresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter

    var body: some View {
        let state = presenter.state
        let status = state.status
        let listGames = state.listGames

        Group {
            if status == .initial {
                InitialView {
                    /// Load more data.
                    presenter.event = .loadMore
                }
            }
            /// Full loading view if state is still loading
            /// and list games is empty.
            else if status == .loading && listGames.isEmpty {
                ProgressView()
            }
            /// Show error message  if error happen.
            else if status == .error && !state.errorMessage.isEmpty {
                VStack {
                    Text(state.errorMessage)
                    Button {
                        presenter.event = .refresh
                    } label: {
                        Text("Refresh")
                    }
                }
            }
            /// Show list games if success.
            else {
                List(
                    listGames,
                    id: \.id
                ) { game in
                    let lastId = listGames.last?.id
                    let isNotLast = lastId != game.id || status == .noMoreData

                    if isNotLast {
                        GameListTile(
                            game: game,
                            destination: presenter.router.goToDetail(game: game)
                        )
                        /// Remove padding in `List`.
                        .listRowInsets(EdgeInsets())
                        /// Remove line separator in `List`.
                        .listRowSeparator(.hidden)
                    } else {
                        VStack {
                            GameListTile(
                                game: game,
                                destination: presenter.router.goToDetail(game: game)
                            )
                            /// Remove padding in `List`.
                            .listRowInsets(EdgeInsets())
                            /// Remove line separator in `List`.
                            .listRowSeparator(.hidden)

                            /// Loading indicator when load more data.
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                        }
                        .onAppear {
                            /// Load more data.
                            presenter.event = .loadMore
                        }
                    }

                }
                .refreshable {
                    /// Pull to refresh.
                    presenter.event = .refresh
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Popular Games")
    }
}

#Preview {
    PopularView()
}
