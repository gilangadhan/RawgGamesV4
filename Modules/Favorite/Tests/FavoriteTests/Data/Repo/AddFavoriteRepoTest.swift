import Combine
import Core
import XCTest

@testable import Favorite
final class AddFavoriteRepoTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let favoriteSrc: FavoriteLocalSrcMock = FavoriteLocalSrcMock()
    private let mapper: FavoriteTransformer = FavoriteTransformer()
    private var repo: AddFavoritesRepo<FavoriteLocalSrcMock, FavoriteTransformer>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = AddFavoritesRepo(favoriteSrc: favoriteSrc, mapperReq: mapper)
    }

    /// Should success insert 1 favorite.
    func testSuccessAddingFavorite() throws {
        let initialValue = FavoriteModel(
            id: "123",
            title: "title",
            imgSrc: "",
            released: nil,
            rating: 5
        )

        /// Insert single data first to repo.
        repo?
            .execute([initialValue])
            .sink(receiveCompletion: {_ in }, receiveValue: {})
            .store(in: &cancellables)

        /// Check single data with correct value.
        favoriteSrc
            .getList(nil)
            .sink { _ in
                //
            } receiveValue: { favorites in
                let favorite = favorites.first { favorite in
                    favorite.id == initialValue.id &&
                    favorite.title == initialValue.title
                }
                let isValid = favorite != nil
                XCTAssert(isValid)
            }
            .store(in: &cancellables)
    }
}

extension AddFavoriteRepoTest {
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
                    entity.id == id
                }
            }.eraseToAnyPublisher()
        }

    }
}
