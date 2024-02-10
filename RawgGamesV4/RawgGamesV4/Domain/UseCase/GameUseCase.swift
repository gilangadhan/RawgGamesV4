////
////  GameUseCase.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 07/02/24.
////
//
//import Combine
//import Games
//
//protocol GameUseCase {
//    /// Get list games based on page and pageSize.
//    /// Fill search if user want to search list games.
//    func getList(
//        search: String,
//        page: Int,
//        pageSize: Int
//    ) -> AnyPublisher<[GameModel], Error>
//
//    /// Get detail game based on game id.
//    func getDetail(
//        id: String
//    ) -> AnyPublisher<DetailGameModel, Error>
//}
//
///// Need to setup default value of `func` in `protocol`.
//extension GameUseCase {
//    /// Set `search` default value.
//    func getList(
//        search: String = "",
//        page: Int,
//        pageSize: Int
//    ) -> AnyPublisher<[GameModel], Error> {
//        return getList(
//            search: search,
//            page: page,
//            pageSize: pageSize
//        )
//    }
//}
