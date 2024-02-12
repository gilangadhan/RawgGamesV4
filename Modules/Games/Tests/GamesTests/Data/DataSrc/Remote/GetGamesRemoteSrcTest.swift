import Combine
import Core
import XCTest

import XCTest
@testable import Games

final class GetGamesRemoteSrcTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var src: GetGamesRemoteSrc = GetGamesRemoteSrc()

    /// Should success get list data with total of pageSize.
    func testExecute() throws {
        let pageSize = 10
        let req = GamesReq(search: "", page: 1, pageSize: pageSize)
        src
            .execute(req)
            .sink { _ in
                //
            } receiveValue: { response in
                let results = response.results
                XCTAssert(results.count == pageSize)
            }
            .store(in: &cancellables)
    }

    /// Should success search with first result is title (name) from search.
    func testExecuteWithSearch() throws {
        let search = "Witcher"
        let req = GamesReq(search: search, page: 1, pageSize: 10)
        src
            .execute(req)
            .sink { _ in
                //
            } receiveValue: { response in
                let results = response.results
                let firstItem = results.first
                if let firstItem = firstItem {
                    XCTAssert(firstItem.name.contains("Grand"))
                } else {
                    XCTAssert(false)
                }
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
