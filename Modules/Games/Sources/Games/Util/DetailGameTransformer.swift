//
//  File.swift
//
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Core
import Foundation

public struct DetailGameTransformer: Mapper {

    public typealias DataModel = DetailGameRes

    public typealias Domain = DetailGameModel

    public init() {}

    public func toData(domain: Domain) -> DataModel {
        let released = getStringFromDate(stringDate: domain.released)
        let detail = DetailGameRes(
            id: domain.id,
            name: domain.name,
            released: released,
            description: domain.description,
            metacritic: domain.metacritic,
            rating: domain.rating,
            playtime: domain.playtime,
            backgroundImage: domain.bgImg,
            backgroundImageAdditional: domain.moreBgImg
        )
        return detail
    }

    public func toDomain(data: DataModel) -> Domain {
        let description = convertDesc(desc: data.description)
        let released = getDateFromString(stringDate: data.released)
        let detail = DetailGameModel(
            id: data.id,
            name: data.name,
            released: released,
            description: description,
            metacritic: data.metacritic,
            rating: data.rating,
            playtime: data.playtime,
            bgImg: data.backgroundImage,
            moreBgImg: data.backgroundImageAdditional
        )
        return detail
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

    /// Convert raw description (with html tag) to corrected string format.
    private func convertDesc(desc: String) -> String {
        return desc
            .replacingOccurrences(of: "\n", with: "\n\n")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<br/>", with: "")
            .replacingOccurrences(of: "<br />", with: "")
            .replacingOccurrences(of: "<br>", with: "")
            .replacingOccurrences(of: "<em>", with: "")
            .replacingOccurrences(of: "</em>", with: "")
            .replacingOccurrences(of: "<strong>", with: "")
            .replacingOccurrences(of: "</strong>", with: "")
            .replacingOccurrences(of: "<ul>", with: "")
            .replacingOccurrences(of: "</ul>", with: "")
            .replacingOccurrences(of: "<li>", with: "\n 💡 ")
            .replacingOccurrences(of: "</li>", with: "")
            .replacingOccurrences(of: "&#39;s", with: "'s")
            .replacingOccurrences(of: "<h1>", with: "")
            .replacingOccurrences(of: "</h1>", with: "")
            .replacingOccurrences(of: "<h2>", with: "")
            .replacingOccurrences(of: "</h2>", with: "")
            .replacingOccurrences(of: "<h3>", with: "")
            .replacingOccurrences(of: "</h3>", with: "")
            .replacingOccurrences(of: "<h4>", with: "")
            .replacingOccurrences(of: "</h4>", with: "")
            .replacingOccurrences(of: "<h5>", with: "")
            .replacingOccurrences(of: "</h5>", with: "")
            .replacingOccurrences(of: "<h6>", with: "")
            .replacingOccurrences(of: "</h6>", with: "")
    }
}
