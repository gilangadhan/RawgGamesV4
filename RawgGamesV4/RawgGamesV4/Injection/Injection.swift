//
//  Injection.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Core
import Favorite
import Games

final class Injection {
    /// Create singleton of`Injection`.
    static let shared: Injection = Injection()

    private init() {}

    typealias GameUseCaseType = Interactor<
        GetGamesRepo<GetGamesRemoteSrc, GamesTransformer, GamesReqTranformer>.Req,
            GetGamesRepo<GetGamesRemoteSrc, GamesTransformer, GamesReqTranformer>.Res,
            GetGamesRepo<GetGamesRemoteSrc, GamesTransformer, GamesReqTranformer>>

    typealias GetDetailGameUseCase = Interactor<
        GetDetailGameRepo<GetDetailGameRemoteSrc, DetailGameTransformer>.Req,
            GetDetailGameRepo<GetDetailGameRemoteSrc, DetailGameTransformer>.Res,
            GetDetailGameRepo<GetDetailGameRemoteSrc, DetailGameTransformer>>

    typealias GetFavoritesUseCase = Interactor<
        GetFavoritesRepo<FavoriteLocalSrc, FavoriteTransformer>.Req,
            GetFavoritesRepo<FavoriteLocalSrc, FavoriteTransformer>.Res,
            GetFavoritesRepo<FavoriteLocalSrc, FavoriteTransformer>>

    typealias AddFavoritesUseCase = Interactor<
        AddFavoritesRepo<FavoriteLocalSrc, FavoriteTransformer>.Req,
            AddFavoritesRepo<FavoriteLocalSrc, FavoriteTransformer>.Res,
            AddFavoritesRepo<FavoriteLocalSrc, FavoriteTransformer>>

    typealias RemoveFavoritesUseCase = Interactor<
        RemoveFavoritesRepo<FavoriteLocalSrc>.Req,
            RemoveFavoritesRepo<FavoriteLocalSrc>.Res,
            RemoveFavoritesRepo<FavoriteLocalSrc>>

    // Create singleton of data source.
//    private static let gameSource: GameDataSource = GameDataSourceImpl()
//    private static let favoriteSource: FavoriteDataSource = FavoriteDataSourceImpl(
//        manager: CoreDataManager.manager
//    )

    // Create singleton of repo.
//    private static let gameRepo: GameRepo = GameRepoImpl(
//        gameSource: gameSource
//    )
//    private static let favoriteRepo: FavoriteRepo = FavoriteRepoImpl(
//        favoriteSource: favoriteSource
//    )

    // Create singleton of use case.
    private static var gameUseCase: GameUseCaseType {
        let remote = GetGamesRemoteSrc()
        let repo = GetGamesRepo(
            getGamesSrc: remote,
            mapperRes: GamesTransformer(),
            mapperReq: GamesReqTranformer()
        )
        let interactor = Interactor(repo: repo)
        return interactor
    }
    private static var detailGameUseCase: GetDetailGameUseCase {
        let remote = GetDetailGameRemoteSrc()
        let repo = GetDetailGameRepo(
            getDetailGameSrc: remote,
            mapperRes: DetailGameTransformer()
        )
        let interactor = Interactor(repo: repo)
        return interactor
    }
    private static var getFavoritesUseCase: GetFavoritesUseCase {
        let manager = CoreDataManager.manager
        let local = FavoriteLocalSrc(
            manager: manager
        )
        let repo = GetFavoritesRepo(
            favoriteSrc: local,
            mapperRes: FavoriteTransformer()
        )
        let interactor = Interactor(repo: repo)
        return interactor
    }
    private static var addFavoritesUseCase: AddFavoritesUseCase {
        let manager = CoreDataManager.manager
        let local = FavoriteLocalSrc(
            manager: manager
        )
        let repo = AddFavoritesRepo(
            favoriteSrc: local,
            mapperReq: FavoriteTransformer()
        )
        let interactor = Interactor(repo: repo)
        return interactor
    }
    private static var removeFavoritesUseCase: RemoveFavoritesUseCase {
        let manager = CoreDataManager.manager
        let local = FavoriteLocalSrc(
            manager: manager
        )
        let repo = RemoveFavoritesRepo(
            favoriteSrc: local
        )
        let interactor = Interactor(repo: repo)
        return interactor
    }
//    private static let favoriteUseCaseOld: FavoriteUseCase = FavoriteInteractor(
//        repo: favoriteRepo
//    )

    /// Get presenter for popular.
    func getPopular() -> PopularPresenter {
        return PopularPresenter(
            gameUseCase: Injection.gameUseCase
        )
    }

    /// Get presenter for favorite.
    func getFavorite() -> FavoritePresenter {
        return FavoritePresenter(
            getFavoritesUseCase: Injection.getFavoritesUseCase,
            addFavoritesUseCase: Injection.addFavoritesUseCase,
            removeFavoritesUseCase: Injection.removeFavoritesUseCase
        )
    }

    /// Get presenter for search games.
    func getSearch() -> SearchPresenter {
        return SearchPresenter(
            gameUseCase: Injection.gameUseCase
        )
    }

    /// Get presenter for detail game.
    func getDetail(game: GameModel) -> DetailPresenter {
        return DetailPresenter(
            gameUseCase: Injection.detailGameUseCase,
            game: game
        )
    }
}
