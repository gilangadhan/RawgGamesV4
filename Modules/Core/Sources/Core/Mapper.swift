//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 10/02/24.
//

public protocol Mapper {
    associatedtype DataModel
    associatedtype Domain

    func toData(domain: Domain) -> DataModel

    func toDomain(data: DataModel) -> Domain
}
