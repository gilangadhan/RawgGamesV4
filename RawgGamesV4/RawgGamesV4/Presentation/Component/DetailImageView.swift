//
//  DetailImageView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Games
import SwiftUI

/// SwiftUI View for image in DetailView.
struct DetailImageView: View {
    let detail: DetailGameModel

    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: detail.bgImg)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Text("Sorry, \(detail.name) image not available")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 100)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 100)
                }
            }
            AsyncImage(url: URL(string: detail.moreBgImg)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Text("Sorry, \(detail.name) image not available")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 100)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 100)
                }
            }
            .mask(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.white.opacity(0.01),
                            Color.white
                        ]
                    ),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
    }
}
