////
////  GameMapper.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 08/02/24.
////
//
//import Foundation
//import Games
//
///// To convert type data from Data to Domain.
//class GameMapper {
//    /// Convert `GameListResponse` to list `[GameModel]`.
//    func toListGames(_ response: GameListResponse) -> [GameModel] {
//        return response.results.map { result in
//            let released = self.getDateFromString(stringDate: result.released)
//            return GameModel(
//                id: "\(result.id)",
//                title: result.name,
//                imgSrc: result.backgroundImage,
//                released: released,
//                rating: result.rating
//            )
//        }
//    }
//
//    /// Convert list `[FavoriteEntity]` to list`[GameModel]`.
//    func toFavorites(_ entities: [FavoriteEntity]) -> [GameModel] {
//        return entities.map { result in
//            return GameModel(
//                id: result.id ?? "",
//                title: result.title ?? "",
//                imgSrc: result.imgSrc ?? "",
//                released: result.released,
//                rating: result.rating
//            )
//        }
//    }
//
//    /// Convert `GameDetailResponse` to `DetailGameModel`.
//    func toDetailGame(_ detailRaw: GameDetailResponse) -> DetailGameModel {
//        let description = convertDesc(desc: detailRaw.description)
//        let released = getDateFromString(stringDate: detailRaw.released)
//        let detail = DetailGameModel(
//            id: detailRaw.id,
//            name: detailRaw.name,
//            released: released,
//            description: description,
//            metacritic: detailRaw.metacritic,
//            rating: detailRaw.rating,
//            playtime: detailRaw.playtime,
//            bgImg: detailRaw.backgroundImage,
//            moreBgImg: detailRaw.backgroundImageAdditional
//        )
//        return detail
//    }
//
//    /// Get `Date` from string format.
//    private func getDateFromString(stringDate: String) -> Date? {
//        if stringDate.isEmpty {
//            return nil
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let date = dateFormatter.date(from: stringDate)
//        return date
//    }
//
//    /// Convert raw description (with html tag) to corrected string format.
//    private func convertDesc(desc: String) -> String {
//        return desc
//            .replacingOccurrences(of: "\n", with: "\n\n")
//            .replacingOccurrences(of: "<p>", with: "")
//            .replacingOccurrences(of: "</p>", with: "")
//            .replacingOccurrences(of: "<br/>", with: "")
//            .replacingOccurrences(of: "<br />", with: "")
//            .replacingOccurrences(of: "<br>", with: "")
//            .replacingOccurrences(of: "<em>", with: "")
//            .replacingOccurrences(of: "</em>", with: "")
//            .replacingOccurrences(of: "<strong>", with: "")
//            .replacingOccurrences(of: "</strong>", with: "")
//            .replacingOccurrences(of: "<ul>", with: "")
//            .replacingOccurrences(of: "</ul>", with: "")
//            .replacingOccurrences(of: "<li>", with: "\n 💡 ")
//            .replacingOccurrences(of: "</li>", with: "")
//            .replacingOccurrences(of: "&#39;s", with: "'s")
//            .replacingOccurrences(of: "<h1>", with: "")
//            .replacingOccurrences(of: "</h1>", with: "")
//            .replacingOccurrences(of: "<h2>", with: "")
//            .replacingOccurrences(of: "</h2>", with: "")
//            .replacingOccurrences(of: "<h3>", with: "")
//            .replacingOccurrences(of: "</h3>", with: "")
//            .replacingOccurrences(of: "<h4>", with: "")
//            .replacingOccurrences(of: "</h4>", with: "")
//            .replacingOccurrences(of: "<h5>", with: "")
//            .replacingOccurrences(of: "</h5>", with: "")
//            .replacingOccurrences(of: "<h6>", with: "")
//            .replacingOccurrences(of: "</h6>", with: "")
//    }
//}
