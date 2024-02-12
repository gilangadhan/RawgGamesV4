import Combine
import Core
import CoreData
import XCTest

@testable import Favorite
final class FavoriteLocalSrcTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let manager = CoreDataManager.manager
    private var favoriteSrc: FavoriteLocalSrc?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try clearAllData()
        favoriteSrc = FavoriteLocalSrc(manager: manager)
    }

    /// Clear data of Core Data first.
    private func clearAllData() throws {
        guard let container = manager.container else { return }
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteEntity")
        fetchRequest.returnsObjectsAsFaults = false
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }

    /// Should success get favorites without any error.
    func testGetList() throws {
        favoriteSrc?
            .getList(nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTAssert(true)
                case .failure(_):
                    XCTAssert(false)
                }
            }, receiveValue: { _ in
                //
            })
            .store(in: &cancellables)
    }

    /// Should success add favorite
    func testAdd() throws {
        print("ADD")

        let add1 = FavoriteLocalEntity(
            id: "add_123",
            title: "title 1",
            imgSrc: "",
            rating: 5,
            released: nil
        )
        let add2 = FavoriteLocalEntity(
            id: "add_456",
            title: "title 2",
            imgSrc: "",
            rating: 5,
            released: nil
        )

        favoriteSrc?
            .add(entities: [add1, add2])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                if case .finished = completion {
                    favoriteSrc?
                        .getList(nil)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { _ in
                            //
                        }, receiveValue: { listFavorites in
                            /// Check list favorites items.
                            let is2Items = listFavorites.count == 2
                            let isAdd1 = listFavorites.first(where: { $0.id == add1.id }) != nil
                            let isAdd2 = listFavorites.first(where: { $0.id == add2.id }) != nil
                            XCTAssert(is2Items)
                            XCTAssert(isAdd1)
                            XCTAssert(isAdd2)
                        })
                        .store(in: &cancellables)
                }
            }, receiveValue: { _ in
                //
            })
            .store(in: &cancellables)
    }

}
