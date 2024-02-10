////
////  GameDataSource.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 07/02/24.
////
//
//import Combine
//
//protocol GameDataSource {
//    /// Get list games based on page and pageSize.
//    /// Fill search if user want to search list games.
//    func getList(
//        search: String,
//        page: Int,
//        pageSize: Int
//    ) -> AnyPublisher<GameListResponse, Error>
//
//    /// Get detail game based on game id.
//    func getDetail(
//        id: String
//    ) -> AnyPublisher<GameDetailResponse, Error>
//}
