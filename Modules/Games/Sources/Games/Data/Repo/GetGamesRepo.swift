//
//  File.swift
//
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Combine
import Core
import Foundation

public struct GetGamesRepo<
    GetGamesRemoteSrc: RemoteSrc,
    MapperRes: Mapper,
    MapperReq: Mapper
>: Repo where
GetGamesRemoteSrc.Res == GamesRes,
GetGamesRemoteSrc.Req == GamesReq,
MapperRes.DataModel == GamesRes,
MapperRes.Domain == [GameModel],
MapperReq.DataModel == GamesReq,
MapperReq.Domain == GamesParams
{

    public typealias Req = GamesParams

    public typealias Res = [GameModel]

    private let getGamesSrc: GetGamesRemoteSrc
    private let mapperRes: MapperRes
    private let mapperReq: MapperReq

    public init(
        getGamesSrc: GetGamesRemoteSrc,
        mapperRes: MapperRes, 
        mapperReq: MapperReq
    ) {
        self.getGamesSrc = getGamesSrc
        self.mapperRes = mapperRes
        self.mapperReq = mapperReq
    }

    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        guard let req = req else {
            return getGamesSrc
                .execute(nil)
                .map(mapperRes.toDomain)
                .eraseToAnyPublisher()
        }

        return getGamesSrc
            .execute(mapperReq.toData(domain: req))
            .map(mapperRes.toDomain)
            .eraseToAnyPublisher()
    }

}
