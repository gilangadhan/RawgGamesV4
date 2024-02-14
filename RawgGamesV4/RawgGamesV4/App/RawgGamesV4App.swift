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
    init() {
        Container.registerServices()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
