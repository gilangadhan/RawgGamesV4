//
//  File.swift
//
//
//  Created by Dhimas Dewanto on 10/02/24.
//

import Combine

public protocol Repo {
    associatedtype Req
    associatedtype Res

    func execute(_ req: Req?) -> AnyPublisher<Res, Error>
}
