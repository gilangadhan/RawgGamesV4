//
//  File.swift
//
//
//  Created by Dhimas Dewanto on 11/02/24.
//

import Combine
import Core
import Foundation

public struct GetFavoritesRepo<
    FavoriteLocalSrc: LocalSrc,
    MapperRes: Mapper
>: Repo where
FavoriteLocalSrc.Res == FavoriteLocalEntity,
FavoriteLocalSrc.Req == Any,
FavoriteLocalSrc.IdType == String,
MapperRes.DataModel == [FavoriteLocalEntity],
MapperRes.Domain == [FavoriteModel]
{

    public typealias Req = Any

    public typealias Res = [FavoriteModel]

    private let favoriteSrc: FavoriteLocalSrc
    private let mapperRes: MapperRes

    public init(
        favoriteSrc: FavoriteLocalSrc,
        mapperRes: MapperRes
    ) {
        self.favoriteSrc = favoriteSrc
        self.mapperRes = mapperRes
    }

    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        return favoriteSrc
            .getList(nil)
            .map(mapperRes.toDomain)
            .eraseToAnyPublisher()
    }

}
