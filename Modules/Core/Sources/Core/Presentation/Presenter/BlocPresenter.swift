//
//  BlocPresenter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Combine
import Foundation

/// Handle UI  Presenter based on flow Combine `Event` and result `State`.
///
/// Need `debouce` to avoid push event too fast. Set value in `debounceTimeInSeconds`.
open class BlocPresenter<State, Event>: ObservableObject {
    @Published public var state: State
    @Published public var event: Event?
    public var cancellables = Set<AnyCancellable>()
    private var debounceTimeInSeconds: Double

    public init(
        state: State,
        debounceTimeInSeconds: Double = 0
    ) {
        self.state = state
        self.debounceTimeInSeconds = debounceTimeInSeconds
        startListenEvent()
    }

    /// Start listening event based on user action.
    private func startListenEvent() {
        /// Need `debouce` to avoid push event too fast. Set value in `debounceTimeInSeconds`.
        if debounceTimeInSeconds > 0 {
            $event
                .debounce(for: .seconds(debounceTimeInSeconds), scheduler: DispatchQueue.main)
                .sink { [weak self] event in
                    guard let self = self, let event = event else { return }
                    self.handleEvent(event: event)
                }
                .store(in: &cancellables)
            return
        }

        $event
            .sink { [weak self] event in
                guard let self = self, let event = event else { return }
                self.handleEvent(event: event)
            }
            .store(in: &cancellables)
    }

    /// `MUST OVERRIDE THIS`.
    /// To handle flow event from user action or input.
    open func handleEvent(event: Event) {
        fatalError("Must Override func handleEvent")
    }
}
