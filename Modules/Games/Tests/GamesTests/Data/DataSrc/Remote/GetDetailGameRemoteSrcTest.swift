import Combine
import Core
import XCTest

import XCTest
@testable import Games

final class GetDetailGameRemoteSrcTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var src: GetDetailGameRemoteSrc = GetDetailGameRemoteSrc()

    /// Should success get detail data.
    func testExecute() throws {
        let id = "3498"
        src
            .execute(id)
            .sink { _ in
                //
            } receiveValue: { response in
                XCTAssert("\(response.id)" == id)
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
