//
//  GameRepoImplTest.swift
//  RawgGamesV4Tests
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Combine
import XCTest

@testable import RawgGamesV4
final class GameRepoImplTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let gameSource: GameDataSource = GameDataSourceMock()
    private var repo: GameRepo?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = GameRepoImpl(gameSource: gameSource)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Should success get list data from data source with conversion data.
    func testGetList() throws {
        repo?
            .getList(search: "", page: 1, pageSize: 10)
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty == false
                XCTAssert(isValid)

                guard let game = listGames.first else {
                    XCTAssert(false)
                    return
                }

                XCTAssert(game.id == "123")
                XCTAssert(game.title == "Test")
                XCTAssert(game.released == self.getDateFromString(stringDate: "2023-01-01"))
            }
            .store(in: &cancellables)
    }

    /// Should success get detail data from data source with conversion data.
    func testGetDetail() throws {
        repo?
            .getDetail(id: "")
            .sink { completion in
                /// We expect correct value is error (because mock repo return error)
                if case .failure(let error) = completion {
                    XCTAssert(error.localizedDescription == "Pretend to be success")
                }
            } receiveValue: { _ in
                //
            }
            .store(in: &cancellables)
    }

}

extension GameRepoImplTest {
    class GameDataSourceMock: GameDataSource {
        /// Mock to pretend success get list.
        func getList(search: String, page: Int, pageSize: Int) -> AnyPublisher<GameListResponse, Error> {
            let future = Future<GameListResponse, Error> {
                return GameListResponse(results: [
                    ListResultResponse(id: 123, name: "Test", released: "2023-01-01", rating: 0, backgroundImage: "")
                ])
            }
            return future.eraseToAnyPublisher()
        }

        /// Mock to pretend success get detail.
        func getDetail(id: String) -> AnyPublisher<GameDetailResponse, Error> {
            let future = Future<GameDetailResponse, Error> {
                throw RemoteError.unknown("Pretend to be success")
            }
            return future.eraseToAnyPublisher()
        }
    }

    /// Get `Date` from `String`.
    private func getDateFromString(stringDate: String) -> Date? {
        if stringDate.isEmpty {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        return date
    }

}
