//
//  PopularRouter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import SwiftUI
import Games

/// Handle router view in `PopularView`.
class PopularRouter {
    func goToDetail(game: GameModel) -> some View {
        /// To register [detailPresenter] to [environmentObject].
        let detailPresenter = Injection.shared.getDetail(game: game)

        let view = DetailView(presenter: detailPresenter)

        return view
    }
}
