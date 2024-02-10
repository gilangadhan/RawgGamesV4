//
//  FavoriteRepoImplTest.swift
//  RawgGamesV4Tests
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Combine
import XCTest

@testable import RawgGamesV4
final class FavoriteRepoImplTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let favoriteSource: FavoriteDataSource = FavoriteDataSourceMock()
    private var repo: FavoriteRepo?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = FavoriteRepoImpl(favoriteSource: favoriteSource)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Should success get favorites data from repo without any more process.
    func testGetFavorites() throws {
        repo?
            .getFavorites()
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty
                XCTAssert(isValid)
            }
            .store(in: &cancellables)
    }

    /// Should success add favorite.
    func testAddFavorite() throws {
        /// Add first.
        try? repo?.addFavorite(
            game: GameModel(id: "123", title: "Test", imgSrc: "", released: nil, rating: 0)
        )
    }

    /// Should success remove favorite.
    func testRemoveFavorite() throws {
        /// Remove last inserted data.
        try? repo?.removeFavorite(id: "123")
    }
}

extension FavoriteRepoImplTest {
    class FavoriteDataSourceMock: FavoriteDataSource {
        /// Pretend success get list data from data source.
        func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
            let future = Future<[FavoriteEntity], Error> {
                []
            }
            return future.eraseToAnyPublisher()
        }

        /// Pretend no throw error when add favorite.
        func addFavorite(game: GameModel) throws {
            //
        }

        /// Pretend no throw error when remove favorite.
        func removeFavorite(id: String) throws {
            //
        }
    }
}
