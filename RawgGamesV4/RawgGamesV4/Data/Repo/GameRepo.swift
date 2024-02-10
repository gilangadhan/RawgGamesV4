//
//  GameRepository.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import Combine
import Games

protocol GameRepo {
    /// Get list games based on page and pageSize.
    /// Fill search if user want to search list games.
    func getList(
        search: String,
        page: Int,
        pageSize: Int
    ) -> AnyPublisher<[GameModel], Error>

    /// Get detail game based on game id.
    func getDetail(
        id: String
    ) -> AnyPublisher<DetailGameModel, Error>
}
