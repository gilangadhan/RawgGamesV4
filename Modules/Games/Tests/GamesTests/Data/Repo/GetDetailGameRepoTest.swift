import Combine
import Core
import XCTest

import XCTest
@testable import Games

final class GetDetailGameRepoTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let getDetailGameSrc: GetDetailGameRemoteSrcMock = GetDetailGameRemoteSrcMock()
    private var repo: GetDetailGameRepo<GetDetailGameRemoteSrcMock, DetailGameTransformer>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = GetDetailGameRepo(
            getDetailGameSrc: getDetailGameSrc,
            mapperRes: DetailGameTransformer()
        )
    }

    /// Should success get detail data from data source with conversion data.
    func testExecute() throws {
        let id = "1234"
        repo?
            .execute(id)
            .sink { _ in
            } receiveValue: { detail in
                XCTAssert("\(detail.id)" == id)
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

extension GetDetailGameRepoTest {
    class GetDetailGameRemoteSrcMock: RemoteSrc {

        typealias Req = String

        typealias Res = DetailGameRes

        func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
            return Future<Res, Error> {
                guard let req = req else {
                    throw RemoteError.unknown("Req or id is empty")
                }

                return DetailGameRes(
                    id: Int(req) ?? 0,
                    name: "",
                    released: "",
                    description: "",
                    metacritic: 5,
                    rating: 4,
                    playtime: 50,
                    backgroundImage: "",
                    backgroundImageAdditional: ""
                )
            }.eraseToAnyPublisher()
        }
    }
}
