//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Combine
import Foundation

public struct Interactor<Req, Res, R: Repo>: UseCase
where R.Req == Req, R.Res == Res {

    private let repo: R

    public init(repo: R) {
        self.repo = repo
    }

    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        repo.execute(req)
    }
}
