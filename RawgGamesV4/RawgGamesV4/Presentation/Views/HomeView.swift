//
//  ContentView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI

/// Main home view. Contain tab to switch view popular, search, favorite, and about.
struct HomeView: View {
    @StateObject var popularPresenter = Injection.shared.getPopular()
    @StateObject var favoritePresenter = Injection.shared.getFavorite()

    var body: some View {
        let tabView = TabView {
            MyNavigation {
                PopularView()
            }
            .tabItem {
                Label(
                    "Popular",
                    systemImage: "gamecontroller"
                )
            }
            MyNavigation {
                SearchView()
            }
            .tabItem {
                Label(
                    "Search",
                    systemImage: "magnifyingglass.circle"
                )
            }
            MyNavigation {
                FavoriteView()
            }
            .tabItem {
                Label(
                    "Favorite",
                    systemImage: "heart"
                )
            }
            MyNavigation {
                AboutView()
            }
            .tabItem {
                Label(
                    "About",
                    systemImage: "person.circle"
                )
            }
        }

        Group {
            if #available(iOS 16, *) {
                tabView
                    .toolbarColorScheme(
                        .light,
                        for: .tabBar
                    )
            } else {
                tabView
                    .preferredColorScheme(.light)
            }
        }
        .environmentObject(popularPresenter)
        .environmentObject(favoritePresenter)
    }
}

#Preview {
    HomeView()
}
