import Combine
import Core
import XCTest

import XCTest
@testable import Games

final class GetGamesRepoTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let getGamesSrc: GetGamesRemoteSrcMock = GetGamesRemoteSrcMock()
    private var repo: GetGamesRepo<GetGamesRemoteSrcMock, GamesTransformer, GamesReqTranformer>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = GetGamesRepo(
            getGamesSrc: getGamesSrc,
            mapperRes: GamesTransformer(),
            mapperReq: GamesReqTranformer()
        )
    }

    /// Should success get list data from data source with conversion data.
    func testExecute() throws {
        let req = GamesParams(search: "", page: 1, pageSize: 10)
        repo?
            .execute(req)
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

    /// Should success get list data from data source with conversion data with search.
    func testExecuteWithSearch() throws {
        let req = GamesParams(search: "HAHAHA", page: 1, pageSize: 10)
        repo?
            .execute(req)
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
                XCTAssert(game.title == req.search)
                XCTAssert(game.released == self.getDateFromString(stringDate: "2023-01-01"))
            }
            .store(in: &cancellables)
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

extension GetGamesRepoTest {
    class GetGamesRemoteSrcMock: RemoteSrc {

        typealias Req = GamesReq

        typealias Res = GamesRes

        func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
            return Future<Res, Error> {
                guard let req = req else {
                    return GamesRes(results: [])
                }

                if req.search.isEmpty == false {
                    return GamesRes(results: [
                        ListResultResponse(id: 123, name: req.search, released: "2023-01-01", rating: 0, backgroundImage: "")
                    ])
                }

                return GamesRes(results: [
                    ListResultResponse(id: 123, name: "Test", released: "2023-01-01", rating: 0, backgroundImage: "")
                ])
            }.eraseToAnyPublisher()
        }
    }
}
