//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Combine
import SwiftUI

// TODO: Should delete this because it will be never used.
public class GetListPresenter<Req, Res, Interactor: UseCase>: ObservableObject where Interactor.Req == Req, Interactor.Res == [Res] {

    private var cancellables: Set<AnyCancellable> = []

    private let _useCase: Interactor

    @Published public var list: [Res] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false

    public init(useCase: Interactor) {
        _useCase = useCase
    }

    public func getList(req: Req?) {
        if isLoading {
            return
        }

        isLoading = true
        _useCase.execute(req)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
}
