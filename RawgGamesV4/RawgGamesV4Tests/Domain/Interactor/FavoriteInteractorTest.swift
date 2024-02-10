//
//  FavoriteInteractorTest.swift
//  RawgGamesV4Tests
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Combine
import XCTest

@testable import RawgGamesV4
final class FavoriteInteractorTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let repo: FavoriteRepo = FavoriteRepoMock()
    private var interactor: FavoriteUseCase?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = FavoriteInteractor(repo: repo)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Should success get favorites data from repo without any more process.
    func testGetFavorites() throws {
        interactor?
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
        try? interactor?.addFavorite(
            game: GameModel(id: "123", title: "Test", imgSrc: "", released: nil, rating: 0)
        )

        /// Check if it's not empty.
        interactor?
            .getFavorites()
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty == false
                XCTAssert(isValid)
            }
            .store(in: &cancellables)
    }

    /// Should success remove favorite.
    func testRemoveFavorite() throws {
        /// Add first.
        try? interactor?.addFavorite(
            game: GameModel(id: "123", title: "Test", imgSrc: "", released: nil, rating: 0)
        )

        /// Check if it's not empty.
        interactor?
            .getFavorites()
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty == false
                XCTAssert(isValid)
            }
            .store(in: &cancellables)

        /// Remove last inserted data.
        try? interactor?.removeFavorite(id: "123")

        /// Check if it's empty
        interactor?
            .getFavorites()
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty
                XCTAssert(isValid)
            }
            .store(in: &cancellables)
    }

}

extension FavoriteInteractorTest {
    class FavoriteRepoMock: FavoriteRepo {
        @Published private var listFavorites: [GameModel] = []

        func getFavorites() -> AnyPublisher<[GameModel], Error> {
            let future = Future<[GameModel], Error> {
                return self.listFavorites
            }
            return future.eraseToAnyPublisher()
        }

        func addFavorite(game: GameModel) throws {
            listFavorites.append(game)
        }

        func removeFavorite(id: String) throws {
            listFavorites.removeAll { game in
                game.id == id
            }
        }
    }
}
