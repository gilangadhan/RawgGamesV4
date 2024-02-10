//
//  File.swift
//
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Core

public struct GamesReqTranformer: Mapper {

    public typealias DataModel = GamesReq

    public typealias Domain = GamesParams

    public init() {}

    public func toData(domain: Domain) -> DataModel {
        GamesReq(search: domain.search, page: domain.page, pageSize: domain.pageSize)
    }

    public func toDomain(data: DataModel) -> Domain {
        GamesParams(search: data.search, page: data.page, pageSize: data.pageSize)
    }

}
