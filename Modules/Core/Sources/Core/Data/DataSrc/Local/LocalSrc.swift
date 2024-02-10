//
//  File.swift
//
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Combine

public protocol LocalSrc {
    associatedtype Req
    associatedtype Res

    func getList(request: Req?) -> AnyPublisher<[Res], Error>
    func get(id: String) -> AnyPublisher<Res, Error>
    func add(entities: [Res]) -> AnyPublisher<Void, Error>
    func update(id: Int, entity: Res) -> AnyPublisher<Void, Error>
}
