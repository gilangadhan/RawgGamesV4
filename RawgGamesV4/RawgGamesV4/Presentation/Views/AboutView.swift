//
//  AboutView.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import SwiftUI

/// Show about me view.
struct AboutView: View {
    @EnvironmentObject var localePresenter: LocalePresenter

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
                .padding(.top, 20)
                .padding(.bottom, 20)
            Text("Created by:")
            Text("Dhimas Bagus Rizky Dewanto")
                .bold()
                .padding(.bottom, 20)

            List {
                Picker("Language/Bahasa", selection: $localePresenter.state) {
                    Text("Indonesia").tag(LocalePresenter.locId)
                    Text("English").tag(LocalePresenter.locEn)
                }
            }
        }
        .navigationTitle("About Me")
    }
}

#Preview {
    AboutView()
}
