//
//  RawgGamesV4App.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI
import Swinject

@main
struct RawgGamesV4App: App {
    @StateObject var localePresenter: LocalePresenter = Injection.shared.getLocale()
    
    init() {
        Container.registerServices()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.locale, .init(identifier: localePresenter.state))
                .environmentObject(localePresenter)
        }
    }
}
