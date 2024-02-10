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
    associatedtype IdType

    func getList(_ request: Req?) -> AnyPublisher<[Res], Error>

    func get(id: IdType) -> AnyPublisher<Res?, Error>

    func add(entities: [Res]) -> AnyPublisher<Void, Error>

    func update(id: IdType, entity: Res) -> AnyPublisher<Void, Error>

    func remove(id: IdType) -> AnyPublisher<Void, Error>

}
