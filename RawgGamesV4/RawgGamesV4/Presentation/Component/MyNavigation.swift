//
//  MyNavigation.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI

/// Use`NavigationStack` or `NavigationView` based on iOS version.
struct MyNavigation<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}
