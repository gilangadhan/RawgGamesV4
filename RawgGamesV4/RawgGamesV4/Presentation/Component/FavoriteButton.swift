//
//  FavoriteButton.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI
import Games

/// Favorite button in `GameListTile`.
struct FavoriteButton: View {
    let game: GameModel

    @EnvironmentObject var presenter: FavoritePresenter

    private var isFavorite: Bool {
        presenter.isGameFavorite(id: game.id)
    }

    private func addFavorite() {
        presenter.event = .add(game: game)
    }

    private func removeFavorite() {
        presenter.event = .remove(id: game.id)
    }

    var body: some View {
        if !isFavorite {
            Button {
                addFavorite()
            } label: {
                Label("Favorite", systemImage: "heart")
            }
            .tint(Color("FavoriteColor"))
        } else {
            Button {
                removeFavorite()
            } label: {
                Label("Unfavorite", systemImage: "heart.slash")
            }
            .tint(Color("FavoriteColor"))
        }
    }
}

#Preview {
    FavoriteButton(
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
