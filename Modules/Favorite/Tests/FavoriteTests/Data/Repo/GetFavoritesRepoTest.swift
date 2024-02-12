import Combine
import Core
import XCTest

@testable import Favorite
final class GetFavoritesRepoTest: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private let favoriteSrc: FavoriteLocalSrcMock = FavoriteLocalSrcMock()
    private let mapper: FavoriteTransformer = FavoriteTransformer()
    private var repo: GetFavoritesRepo<FavoriteLocalSrcMock, FavoriteTransformer>?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = GetFavoritesRepo(favoriteSrc: favoriteSrc, mapperRes: mapper)
    }

    /// Should success get favorites data from repo without any more process.
    func testGetListEmpty() throws {
        repo?
            .execute(nil)
            .sink { _ in
                //
            } receiveValue: { listGames in
                let isValid = listGames.isEmpty
                XCTAssert(isValid)
            }
            .store(in: &cancellables)
    }

    /// Should success get favorites data from repo without any more process
    /// and get single correct response.
    func testGetSingleCorrect() throws {
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

        /// Get single data with correct value.
        repo?
            .execute(nil)
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

extension GetFavoritesRepoTest {
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

//import Combine
//import XCTest
//
//@testable import RawgGamesV4
//final class FavoriteInteractorTest: XCTestCase {
//    private var cancellables = Set<AnyCancellable>()
//    private let repo: FavoriteRepo = FavoriteRepoMock()
//    private var interactor: FavoriteUseCase?
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        interactor = FavoriteInteractor(repo: repo)
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    /// Should success get favorites data from repo without any more process.
//    func testGetFavorites() throws {
//        interactor?
//            .getFavorites()
//            .sink { _ in
//                //
//            } receiveValue: { listGames in
//                let isValid = listGames.isEmpty
//                XCTAssert(isValid)
//            }
//            .store(in: &cancellables)
//    }
//
//    /// Should success add favorite.
//    func testAddFavorite() throws {
//        /// Add first.
//        try? interactor?.addFavorite(
//            game: GameModel(id: "123", title: "Test", imgSrc: "", released: nil, rating: 0)
//        )
//
//        /// Check if it's not empty.
//        interactor?
//            .getFavorites()
//            .sink { _ in
//                //
//            } receiveValue: { listGames in
//                let isValid = listGames.isEmpty == false
//                XCTAssert(isValid)
//            }
//            .store(in: &cancellables)
//    }
//
//    /// Should success remove favorite.
//    func testRemoveFavorite() throws {
//        /// Add first.
//        try? interactor?.addFavorite(
//            game: GameModel(id: "123", title: "Test", imgSrc: "", released: nil, rating: 0)
//        )
//
//        /// Check if it's not empty.
//        interactor?
//            .getFavorites()
//            .sink { _ in
//                //
//            } receiveValue: { listGames in
//                let isValid = listGames.isEmpty == false
//                XCTAssert(isValid)
//            }
//            .store(in: &cancellables)
//
//        /// Remove last inserted data.
//        try? interactor?.removeFavorite(id: "123")
//
//        /// Check if it's empty
//        interactor?
//            .getFavorites()
//            .sink { _ in
//                //
//            } receiveValue: { listGames in
//                let isValid = listGames.isEmpty
//                XCTAssert(isValid)
//            }
//            .store(in: &cancellables)
//    }
//
//}
//
//extension FavoriteInteractorTest {
//    class FavoriteRepoMock: FavoriteRepo {
//        @Published private var listFavorites: [GameModel] = []
//
//        func getFavorites() -> AnyPublisher<[GameModel], Error> {
//            let future = Future<[GameModel], Error> {
//                return self.listFavorites
//            }
//            return future.eraseToAnyPublisher()
//        }
//
//        func addFavorite(game: GameModel) throws {
//            listFavorites.append(game)
//        }
//
//        func removeFavorite(id: String) throws {
//            listFavorites.removeAll { game in
//                game.id == id
//            }
//        }
//    }
//}
