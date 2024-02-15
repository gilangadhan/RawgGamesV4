//
//  LocalePresenter.swift
//  RawgGamesV4
//
//  Created by TMLI IT Dev on 15/02/24.
//

import Core
import Foundation

/// Presenter to change localization or language.
///
/// `State` and `Event` is String locale.
class LocalePresenter: BlocPresenter<String, String> {
    static let locId: String = "id"
    static let locEn: String = "en"
    private let language: String = "language"

    init() {
        let initialLanguage = UserDefaults.standard.string(forKey: language)
        super.init(
            state: initialLanguage ?? LocalePresenter.locEn
        )
        listenLanguagePicker()
    }

    /// Handle event from user input.
    override func handleEvent(event: String) {
        /// Save to `UserDefaults`.
        UserDefaults.standard.set(event, forKey: language)
    }

    private func listenLanguagePicker() {
        $state.sink { [weak self] state in
            self?.event = state
        }.store(in: &cancellables)
    }
}
