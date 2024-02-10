//
//  AboutView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI

/// Show about me view.
struct AboutView: View {
    var body: some View {
        VStack {
            Image("ProfileImage")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .padding(.bottom, 20)
            Text("Created by:")
            Text("Dhimas Bagus Rizky Dewanto").bold()
        }
        .navigationTitle("About Me")
    }
}

#Preview {
    AboutView()
}
