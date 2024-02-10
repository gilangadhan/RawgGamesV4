////
////  GameRepoImpl.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 07/02/24.
////
//
//import Combine
//import Foundation
//import Games
//
//class GameRepoImpl: GameRepo {
//    private let gameSource: GameDataSource
//    private let mapper: GameMapper = GameMapper()
//
//    init(gameSource: GameDataSource) {
//        self.gameSource = gameSource
//    }
//
//    /// Get list games based on page and pageSize.
//    /// Fill search if user want to search list games.
//    func getList(
//        search: String,
//        page: Int,
//        pageSize: Int
//    ) -> AnyPublisher<[GameModel], Error> {
//        let source = gameSource
//            .getList(search: search, page: page, pageSize: pageSize)
//            .map(mapper.toListGames)
//        return source.eraseToAnyPublisher()
//    }
//
//    /// Get detail game based on game id.
//    func getDetail(id: String) -> AnyPublisher<DetailGameModel, Error> {
//        let source = gameSource
//            .getDetail(id: id)
//            .map(mapper.toDetailGame)
//        return source.eraseToAnyPublisher()
//    }
//}
