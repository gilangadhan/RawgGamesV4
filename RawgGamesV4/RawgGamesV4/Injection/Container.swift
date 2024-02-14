//
//  Container.swift
//  RawgGamesV4
//
//  Created by TMLI IT Dev on 13/02/24.
//

import Core
import Favorite
import Games
import Swinject

/// Dependency injection for modules (use case, repo).
extension Container {
    static let shared = Container()

    /// Get use case to get list games.
    static var gamesUseCase: GamesUseCaseType {
        shared.resolve(GamesUseCaseType.self)!
    }

    /// Get use case to get detail game.
    static var detailGameUseCase: GetDetailGameUseCase {
        shared.resolve(GetDetailGameUseCase.self)!
    }

    /// Get use case to get list favorites.
    static var getFavoritesUseCase: GetFavoritesUseCase {
        shared.resolve(GetFavoritesUseCase.self)!
    }

    /// Get use case to add favorite.
    static var addFavoritesUseCase: AddFavoritesUseCase {
        shared.resolve(AddFavoritesUseCase.self)!
    }

    /// Get use case to remove favorite.
    static var removeFavoritesUseCase: RemoveFavoritesUseCase {
        shared.resolve(RemoveFavoritesUseCase.self)!
    }

    /// Register depencency injeciton in `Container`.
    static func registerServices() {
        registerFavoriteServices()
        registerGameServices()
    }

    /// Register use case from favorite module.
    private static func registerFavoriteServices() {
        /// Declair use case to get list favorites.
        shared.register(GetFavoritesUseCase.self) { _ in
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

        /// Declare use case to add favorite.
        shared.register(AddFavoritesUseCase.self) { _ in
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

        /// Declare use case to remove favorite.
        shared.register(RemoveFavoritesUseCase.self) { _ in
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
    }

    /// Register use case from Game module.
    private static func registerGameServices() {
        /// Declase use case to get list games.
        shared.register(GamesUseCaseType.self) { _ in
            let remote = GetGamesRemoteSrc()
            let repo = GetGamesRepo(
                getGamesSrc: remote,
                mapperRes: GamesTransformer(),
                mapperReq: GamesReqTranformer()
            )
            let interactor = Interactor(repo: repo)
            return interactor
        }

        /// Declare use case to get detail game.
        shared.register(GetDetailGameUseCase.self) { _ in
            let remote = GetDetailGameRemoteSrc()
            let repo = GetDetailGameRepo(
                getDetailGameSrc: remote,
                mapperRes: DetailGameTransformer()
            )
            let interactor = Interactor(repo: repo)
            return interactor
        }
    }

}

/// Type data of get games repo.
typealias GetGamesRepoType = GetGamesRepo<
    GetGamesRemoteSrc,
    GamesTransformer,
    GamesReqTranformer
>

/// Type data of get detail game repo
typealias GetDetailGameRepoType = GetDetailGameRepo<
    GetDetailGameRemoteSrc,
    DetailGameTransformer
>

/// Type data of get list favorites repo
typealias GetFavoritesRepoType = GetFavoritesRepo<
    FavoriteLocalSrc,
    FavoriteTransformer
>

/// Type data of add favorite repo
typealias AddFavoritesRepoType = AddFavoritesRepo<
    FavoriteLocalSrc,
    FavoriteTransformer
>

/// Type data of remove favorite repo.
typealias RemoveFavoritesRepoType = RemoveFavoritesRepo<
    FavoriteLocalSrc
>

/// Type data of get list game use case.
typealias GamesUseCaseType = Interactor<
    GetGamesRepoType.Req,
    GetGamesRepoType.Res,
    GetGamesRepoType
>

/// Type data of get detail of game use case
typealias GetDetailGameUseCase = Interactor<
    GetDetailGameRepoType.Req,
    GetDetailGameRepoType.Res,
    GetDetailGameRepoType
>

/// Type data of get list favorites use case
typealias GetFavoritesUseCase = Interactor<
    GetFavoritesRepoType.Req,
    GetFavoritesRepoType.Res,
    GetFavoritesRepoType
>

/// Type data of add favorite use case
typealias AddFavoritesUseCase = Interactor<
    AddFavoritesRepoType.Req,
    AddFavoritesRepoType.Res,
    AddFavoritesRepoType
>

/// Type data of remove favorite use case.
typealias RemoveFavoritesUseCase = Interactor<
    RemoveFavoritesRepoType.Req,
    RemoveFavoritesRepoType.Res,
    RemoveFavoritesRepoType
>
