//
//  DetailView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import SwiftUI
import Games

/// Show detail game.
struct DetailView: View {
    @StateObject var presenter: DetailPresenter
    @EnvironmentObject var popularPresenter: PopularPresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter

    private var state: DetailState {
        return presenter.state
    }

    private var status: DetailStateStatus {
        return state.status
    }

    /// Get is favorite status.
    ///
    /// Use this instead of `game.isFavorite` because we need to
    /// get real-time favorite status (if user open detail both from popular view
    /// and favorite view, favorite can't sync if we use `game.isFavorite`)
    private var isFavorite: Bool {
        return favoritePresenter.isGameFavorite(id: state.game.id)

    }

    private func addFavorite(_ game: GameModel) {
        favoritePresenter.event = .add(
            game: game
        )
    }

    private func removeFavorite(_ game: GameModel) {
        favoritePresenter.event = .remove(
            id: game.id
        )
    }

    var body: some View {
        Group {
            switch status {
            case .initial:
                InitialView {
                    /// Load more data.
                    presenter.event = .loadData
                }
            case .loading:
                /// View when loading.
                ProgressView()
            case .error(let errorMessage):
                /// If error happen, show this message.
                Text(errorMessage)
                    .multilineTextAlignment(.center)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding(20)
            case .success(let detail):
                ScrollView {
                    ZStack(alignment: .bottom) {
                        /// Image view.
                        DetailImageView(
                            detail: detail
                        )
                        .padding(.bottom, 70)

                        /// Rating and score view.
                        HStack(alignment: .top) {
                            Spacer()
                            VStack {
                                Text("\(detail.metacritic)")
                                    .bold()
                                    .font(.system(size: 36))
                                Text("Metacritic")
                            }
                            Spacer()
                            VStack {
                                Text(String(format: "%.1f", detail.rating))
                                    .bold()
                                    .font(.system(size: 36))
                                Text("Rating")
                            }
                            Spacer()
                            VStack {
                                Text("\(detail.playtime)")
                                    .bold()
                                    .font(.system(size: 36))
                                Text("Playtime")
                                Text("(hours)")
                            }
                            Spacer()
                        }
                    }

                    /// Release date view.
                    VStack {
                        Text("Release Date")
                            .bold()
                        Text(
                            presenter.getDateString(
                                date: detail.released
                            )
                        )
                        .font(.system(size: 36))
                    }
                    .padding(20)

                    /// Description view.
                    VStack {
                        Text("Description")
                            .bold()
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .padding(.bottom, 10)
                        Text(detail.description)
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle(state.game.title)
        .toolbar {
            ToolbarItem {
                if isFavorite {
                    /// Button to remove is favorite.
                    Button {
                        removeFavorite(state.game)
                    } label: {
                        HStack {
                            Text("Unfavorite")
                            Image(systemName: "heart.slash")
                        }
                    }
                    .tint(Color("FavoriteColor"))
                } else {
                    /// Button to add is favorite.
                    Button {
                        addFavorite(state.game)
                    } label: {
                        HStack {
                            Text("Favorite")
                            Image(systemName: "heart.fill")
                        }
                    }
                    .tint(Color("FavoriteColor"))
                }
            }
        }
    }
}

#Preview {
    DetailView(
        presenter: Injection.shared.getDetail(
            game: GameModel(
                id: "3498",
                title: "Grand Theft Auto V",
                imgSrc: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
                released: getDateFromString(
                    stringDate: "2015-05-18"
                ),
                rating: 4.5
            )
        )
    )
}

/// Get `Date` from `String`.
private func getDateFromString(stringDate: String) -> Date? {
    if stringDate.isEmpty {
        return nil
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: stringDate)
    return date
}
