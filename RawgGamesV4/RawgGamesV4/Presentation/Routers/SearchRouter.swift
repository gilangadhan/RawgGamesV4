//
//  SearchRouter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import SwiftUI
import Games

/// Handle router view in `SearchView`.
class SearchRouter {
    func goToDetail(game: GameModel) -> some View {
        /// To register [detailPresenter] to [environmentObject].
        let detailPresenter = Injection.shared.getDetail(game: game)

        let view = DetailView(presenter: detailPresenter)

        return view
    }
}
