//
//  File.swift
//
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Core

public struct FavoriteTransformer: Mapper {

    public typealias DataModel = [FavoriteLocalEntity]

    public typealias Domain = [FavoriteModel]

    public init() {}

    public func toData(domain: [FavoriteModel]) -> [FavoriteLocalEntity] {
        domain.map { value in
            FavoriteLocalEntity(
                id: value.id,
                title: value.title,
                imgSrc: value.imgSrc,
                rating: value.rating,
                released: value.released
            )
        }
    }

    public func toDomain(data: [FavoriteLocalEntity]) -> [FavoriteModel] {
        data.map { value in
            FavoriteModel(
                id: value.id,
                title: value.title,
                imgSrc: value.imgSrc,
                released: value.released,
                rating: value.rating
            )
        }
    }

}
