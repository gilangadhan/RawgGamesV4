//
//  File.swift
//
//
//  Created by Dhimas Dewanto on 10/02/24.
//

import Combine
import Core
import Foundation

public struct GetDetailGameRepo<
    GetDetailGameRemoteSrc: RemoteSrc,
    MapperRes: Mapper
>: Repo where
GetDetailGameRemoteSrc.Res == DetailGameRes,
GetDetailGameRemoteSrc.Req == String,
MapperRes.DataModel == DetailGameRes,
MapperRes.Domain == DetailGameModel
{

    public typealias Req = String

    public typealias Res = DetailGameModel

    private let getDetailGameSrc: GetDetailGameRemoteSrc
    private let mapperRes: MapperRes

    public init(
        getDetailGameSrc: GetDetailGameRemoteSrc,
        mapperRes: MapperRes
    ) {
        self.getDetailGameSrc = getDetailGameSrc
        self.mapperRes = mapperRes
    }

    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        guard let req = req else {
            return getDetailGameSrc
                .execute(nil)
                .map(mapperRes.toDomain)
                .eraseToAnyPublisher()
        }

        return getDetailGameSrc
            .execute(req)
            .map(mapperRes.toDomain)
            .eraseToAnyPublisher()
    }

}
