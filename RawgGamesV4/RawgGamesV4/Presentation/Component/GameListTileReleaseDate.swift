//
//  GameListTileReleaseDate.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI
import Games

/// View for release date in `GameListTile`
struct GameListTileReleaseDate: View {
    let game: GameModel

    @Environment(\.locale) var locale

    /// Get string formatted date from `game`.
    private func getStrDate() -> String {
        guard let released = game.released else {
            return ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.locale = locale
        let date = dateFormatter.string(
            from: released
        )
        return date
    }
    
    var body: some View {
        let bgColor = Color(UIColor.systemBackground)
        
        if #available(iOS 16, *) {
            Text(getStrDate())
                .padding(5)
                .background(bgColor.opacity(0.9))
                .clipShape(
                    .rect(
                        bottomLeadingRadius: 10
                    )
                )
        } else {
            Text(getStrDate())
                .padding(5)
                .background(bgColor.opacity(0.9))
        }
    }
}
