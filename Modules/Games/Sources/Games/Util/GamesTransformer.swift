//
//  File.swift
//
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Core
import Foundation

public struct GamesTransformer: Mapper {

    public typealias DataModel = GamesRes

    public typealias Domain = [GameModel]

    public init() {}

    public func toData(domain: Domain) -> DataModel {
        return GamesRes(results: domain.map({ game in
            return ListResultResponse(
                id: Int(game.id) ?? 0,
                name: game.title,
                released:
                    getStringFromDate(stringDate: game.released),
                rating: game.rating,
                backgroundImage: game.imgSrc
            )
        }))
    }

    public func toDomain(data: DataModel) -> Domain {
        return data.results.map { result in
            let released = self.getDateFromString(stringDate: result.released)
            return GameModel(
                id: "\(result.id)",
                title: result.name,
                imgSrc: result.backgroundImage,
                released: released,
                rating: result.rating
            )
        }
    }

    /// Get `Date` from string format.
    private func getDateFromString(stringDate: String) -> Date? {
        if stringDate.isEmpty {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        return date
    }

    /// Get `Date` from string format.
    private func getStringFromDate(stringDate: Date?) -> String {
        guard let stringDate = stringDate else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: stringDate)
        return date
    }

}
