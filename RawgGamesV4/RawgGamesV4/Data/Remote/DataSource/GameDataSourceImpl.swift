////
////  GameDataSourceImpl.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 07/02/24.
////
//
//import Alamofire
//import Combine
//import Foundation
//
//class GameDataSourceImpl: GameDataSource {
//    private let baseUrl = "https://api.rawg.io/api"
//
//    /// Get api key from `ApiKey.plist` file.
//    ///
//    /// Add`ApiKey.plist` in `Config` folder, with "ApiKey" as key for api key.
//    private var apiKey: String {
//        guard let path = Bundle.main.path(forResource: "ApiKey", ofType: "plist") else {
//            return ""
//        }
//        let dict = NSDictionary(contentsOfFile: path)
//        let apiKey = dict?["ApiKey"] as? String ?? ""
//        return apiKey
//    }
//
//    /// Get list games based on page and pageSize.
//    /// Fill search if user want to search list games.
//    func getList(
//        search: String,
//        page: Int,
//        pageSize: Int
//    ) -> AnyPublisher<GameListResponse, Error> {
//        let future = Future<GameListResponse, Error> {
//            var params = ListParameters(
//                key: self.apiKey,
//                page: page,
//                pageSize: pageSize,
//                ordering: "-popularity"
//            )
//            if search.isEmpty == false {
//                params.search = search
//                params.ordering = nil
//            }
//
//            let response = await AF.request("\(self.baseUrl)/games", parameters: params)
//                .validate()
//                .serializingDecodable(GameListResponse.self)
//                .response
//
//            if let afError = response.error {
//                throw afError
//            }
//
//            if let value = response.value {
//                return value
//            }
//
//            throw RemoteError.unknown("GameDataSourceImpl.getList not respond")
//        }
//
//        return future.eraseToAnyPublisher()
//    }
//
//    /// Get detail game based on game id.
//    func getDetail(id: String) -> AnyPublisher<GameDetailResponse, Error> {
//        let future = Future<GameDetailResponse, Error> {
//            let params = DetailParameters(key: self.apiKey)
//
//            let response = await AF.request("\(self.baseUrl)/games/\(id)", parameters: params)
//                .validate()
//                .serializingDecodable(GameDetailResponse.self)
//                .response
//
//            if let afError = response.error {
//                throw afError
//            }
//
//            if let value = response.value {
//                return value
//            }
//
//            throw RemoteError.unknown("GameDataSourceImpl.getDetail not respond")
//        }
//        return future.eraseToAnyPublisher()
//    }
//}
