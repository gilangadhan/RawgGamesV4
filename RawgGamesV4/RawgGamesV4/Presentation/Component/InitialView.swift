//
//  InitialView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import SwiftUI

/// View for initial state that can load data if it's appear (appear invisible).
struct InitialView: View {
    let onAppear: () -> Void

    var body: some View {
        Rectangle()
            .hidden()
            .onAppear {
                onAppear()
            }
    }
}
