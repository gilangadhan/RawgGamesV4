//
//  GameUseCaseTest.swift
//  RawgGamesV4Tests
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Combine
import XCTest

@testable import RawgGamesV4
final class GameInteratorTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let repo: GameRepo = GameRepoMock()
    private var interactor: GameUseCase?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = GameInteractor(repo: repo)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Should success get list data from repo without any more process.
    func testGetList() throws {
        interactor?
            .getList(search: "", page: 1, pageSize: 10)
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty
                XCTAssert(isValid)
            }
            .store(in: &cancellables)
    }

    /// Should success get detail data from repo without any more process.
    func testGetDetail() throws {
        interactor?
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

extension GameInteratorTest {
    class GameRepoMock: GameRepo {
        /// Mock to pretend success get list.
        func getList(search: String, page: Int, pageSize: Int) -> AnyPublisher<[GameModel], Error> {
            let future = Future<[GameModel], Error> {
                return []
            }
            return future.eraseToAnyPublisher()
        }
        
        /// Mock to pretend success get detail.
        func getDetail(id: String) -> AnyPublisher<DetailGameModel, Error> {
            let future = Future<DetailGameModel, Error> {
                throw RemoteError.unknown("Pretend to be success")
            }
            return future.eraseToAnyPublisher()
        }
    }
}
