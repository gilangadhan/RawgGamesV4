//
//  GameListTile.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import CachedAsyncImage
import Games
import SwiftUI

/// View for tile in List in popular games, search games, and favorite games.
struct GameListTile<TargetView: View>: View {
    let game: GameModel

    /// `NavigationLink` target destination View.
    let destination: TargetView

    @EnvironmentObject var presenter: FavoritePresenter

    private var isFavorite: Bool {
        presenter.isGameFavorite(id: game.id)
    }

    /// Get title and if game is favorited or not.
    private func getGameTitle() -> String {
        if isFavorite {
            return "💚 \(game.title)"
        }
        return game.title
    }

    var body: some View {
        let bgColor = Color(UIColor.systemBackground)

        CachedAsyncImage(url: URL(string: game.imgSrc)) { phase in
            if let image = phase.image {
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(
                        /// For some reason, if we want to use
                        /// `NavigationLink` in image, it will show arrow
                        /// on the right side. This is one of solution to remove
                        /// those arrow.
                        ///
                        /// This is only the way for `NavigationLink` for image.
                        /// Another way will show ui bug, either `AsyncImage` always
                        /// reload when scrolling, or show unwanted right arrow.
                        NavigationLink {
                            destination
                        } label: {
                            EmptyView()
                        }
                    )
            } else if phase.error != nil {
                Image(
                    systemName: "exclamationmark.triangle"
                )
                .foregroundColor(.red)
                .font(.system(size: 60))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 80)
                .background(
                    /// For some reason, if we want to use
                    /// `NavigationLink` in image, it will show arrow
                    /// on the right side. This is one of solution to remove
                    /// those arrow.
                    ///
                    /// This is only the way for `NavigationLink` for image.
                    /// Another way will show ui bug, either `AsyncImage` always
                    /// reload when scrolling, or show unwanted right arrow.
                    NavigationLink {
                        destination
                    } label: {
                        EmptyView()
                    }
                )
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 100)
            }
        }
        /// Ranking (based on popularity).
        .overlay(
            HStack(spacing: 2) {
                Image(systemName: "star")
                Text(String(format: "%.1f", game.rating))
            }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(bgColor.opacity(0.9))
                .clipShape(
                    .rect(
                        cornerRadius: 10
                    )
                )
                .padding(10),
            alignment: .topLeading
        )
        /// Release date.
        .overlay(
            GameListTileReleaseDate(game: game),
            alignment: .topTrailing
        )
        /// TItle.
        .overlay(
            Text(getGameTitle())
                .multilineTextAlignment(.center)
                .padding(7)
                .frame(maxWidth: .infinity)
                .background(bgColor.opacity(0.9)),
            alignment: .bottom
        )
        /// Swipe to favorite.
        .swipeActions(
            edge: .trailing,
            allowsFullSwipe: false
        ) {
            FavoriteButton(
                game: game
            )
        }
    }
}

#Preview {
    GameListTile(
        game: GameModel(
            id: "3498",
            title: "Grand Theft Auto V",
            imgSrc: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
            released: getDateFromString(
                stringDate: "2015-05-18"
            ),
            rating: 4.5
        ),
        destination: EmptyView()
    )
}

#Preview {
    GameListTile(
        game: GameModel(
            id: "3498",
            title: "Grand Theft Auto V",
            imgSrc: "https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg",
            released: getDateFromString(
                stringDate: "2015-05-18"
            ),
            rating: 4.5
        ),
        destination: EmptyView()
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
