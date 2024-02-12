import Combine
import Core
import XCTest

@testable import Favorite
final class RemoveFavoriteRepoTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let favoriteSrc: FavoriteLocalSrcMock = FavoriteLocalSrcMock()
    private let mapper: FavoriteTransformer = FavoriteTransformer()
    private var repo: RemoveFavoritesRepo<FavoriteLocalSrcMock>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = RemoveFavoritesRepo(favoriteSrc: favoriteSrc)
    }

    /// Should success insert 1 favorite.
    func testSuccessRemove() throws {
        guard let repo = repo else {
            return
        }

        let initialValue = FavoriteLocalEntity(
            id: "123",
            title: "title",
            imgSrc: "",
            rating: 5,
            released: nil
        )

        /// Insert single data first.
        favoriteSrc
            .add(entities: [initialValue])
            .sink(receiveCompletion: {_ in }, receiveValue: {})
            .store(in: &cancellables)

        /// Then, remove it.
        repo
            .execute(initialValue.id)
            .sink(receiveCompletion: { [weak self] completion in
                /// Only check if remove is completed.
                if case .finished = completion {
                    guard let self = self else { return }

                    /// Should be empty..
                    favoriteSrc
                        .getList(nil)
                        .sink { _ in
                        } receiveValue: { favorites in
                            let favorite = favorites.first { favorite in
                                favorite.id == initialValue.id
                            }
                            let isEmpty = favorite == nil
                            XCTAssert(isEmpty)
                        }
                        .store(in: &cancellables)
                }
            }, receiveValue: {})
            .store(in: &cancellables)
    }
}

extension RemoveFavoriteRepoTest {
    class FavoriteLocalSrcMock: LocalSrc {

        @Published private var listFavorites: [FavoriteLocalEntity] = []

        public typealias Req = Any

        public typealias Res = FavoriteLocalEntity

        public typealias IdType = String

        func getList(_ request: Req?) -> AnyPublisher<[Res], Error> {
            return Future<[Res], Error> {
                return self.listFavorites
            }.eraseToAnyPublisher()
        }

        func get(id: String) -> AnyPublisher<Res?, Error> {
            return Future<Res?, Error> {
                return self.listFavorites.first { entity in
                    entity.id == id
                }
            }.eraseToAnyPublisher()
        }

        func add(entities: [Res]) -> AnyPublisher<Void, Error> {
            return Future<Void, Error> {
                self.listFavorites += entities
            }.eraseToAnyPublisher()
        }

        func update(id: String, entity: Res) -> AnyPublisher<Void, Error> {
            return Future<Void, Error> {
                self.listFavorites.removeAll { entity in
                    entity.id == id
                }
                self.listFavorites.append(entity)
            }.eraseToAnyPublisher()
        }

        func remove(id: String) -> AnyPublisher<Void, Error> {
            return Future<Void, Error> {
                self.listFavorites.removeAll { entity in
                    return entity.id == id
                }
            }.eraseToAnyPublisher()
        }

    }
}
