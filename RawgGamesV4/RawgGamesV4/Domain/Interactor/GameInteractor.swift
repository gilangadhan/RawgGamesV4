////
////  GameInteractor.swift
////  RawgGamesV4
////
////  Created by Dhimas Dewanto on 07/02/24.
////
//
//import Combine
//import Games
//
//class GameInteractor: GameUseCase {
//    private let repo: GameRepo
//
//    init(repo: GameRepo) {
//        self.repo = repo
//    }
//
//    /// Get list games based on page and pageSize.
//    /// Fill search if user want to search list games.
//    func getList(
//        search: String,
//        page: Int,
//        pageSize: Int
//    ) -> AnyPublisher<[GameModel], Error> {
//        let result = repo.getList(search: search, page: page, pageSize: pageSize)
//        return result
//    }
//
//    /// Get detail game based on game id.
//    func getDetail(id: String) -> AnyPublisher<DetailGameModel, Error> {
//        let result = repo.getDetail(id: id)
//        return result
//    }
//}
