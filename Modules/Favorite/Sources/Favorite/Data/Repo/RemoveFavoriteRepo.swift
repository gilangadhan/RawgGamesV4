//
//  File.swift
//
//
//  Created by TMLI IT Dev on 11/02/24.
//

import Combine
import Core
import Foundation

public struct RemoveFavoritesRepo<
    FavoriteLocalSrc: LocalSrc,
    MapperReq: Mapper
>: Repo where
FavoriteLocalSrc.Res == FavoriteLocalEntity,
FavoriteLocalSrc.Req == Any,
FavoriteLocalSrc.IdType == String,
MapperReq.DataModel == [FavoriteLocalEntity],
MapperReq.Domain == [FavoriteModel]
{

    public typealias Req = String

    public typealias Res = Void

    private let favoriteSrc: FavoriteLocalSrc
    private let mapperReq: MapperReq

    public init(
        favoriteSrc: FavoriteLocalSrc,
        mapperReq: MapperReq
    ) {
        self.favoriteSrc = favoriteSrc
        self.mapperReq = mapperReq
    }

    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        return favoriteSrc
            .remove(id: req ?? "")
            .eraseToAnyPublisher()
    }

}
