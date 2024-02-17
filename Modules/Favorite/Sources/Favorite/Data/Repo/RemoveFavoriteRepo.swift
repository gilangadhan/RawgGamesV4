//
//  File.swift
//
//
//  Created by Dhimas Dewanto on 11/02/24.
//

import Combine
import Core
import Foundation

public struct RemoveFavoritesRepo<
    FavoriteLocalSrc: LocalSrc
>: Repo where
FavoriteLocalSrc.Res == FavoriteLocalEntity,
FavoriteLocalSrc.Req == Any,
FavoriteLocalSrc.IdType == String
{

    public typealias Req = String

    public typealias Res = Void

    private let favoriteSrc: FavoriteLocalSrc

    public init(
        favoriteSrc: FavoriteLocalSrc
    ) {
        self.favoriteSrc = favoriteSrc
    }

    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        return favoriteSrc
            .remove(id: req ?? "")
            .eraseToAnyPublisher()
    }

}
