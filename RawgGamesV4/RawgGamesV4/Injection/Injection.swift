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

    private func provideGameUseCase
    <U: UseCase>() ->
    U where U.Req == GamesParams, U.Res == [GameModel] {
        return gameUseCase as! U
    }

    private func provideDetailUseCase
    <U: UseCase>() ->
    U where U.Req == String, U.Res == DetailGameModel {
        return detailGameUseCase as! U
    }

    private func provideGetFavoritesUseCase
    <U: UseCase>() ->
    U where U.Req == Any, U.Res == [FavoriteModel] {
        return getFavoritesUseCase as! U
    }

    private func provideAddFavoritesUseCase
    <U: UseCase>() ->
    U where U.Req == [FavoriteModel], U.Res == Void {
        return addFavoritesUseCase as! U
    }

    private func provideRemoveFavoritesUseCase
    <U: UseCase>() ->
    U where U.Req == String, U.Res == Void {
        return removeFavoritesUseCase as! U
    }

    /// Get presenter for popular.
    func getPopular() -> PopularPresenter {
        return PopularPresenter(
            gameUseCase: provideGameUseCase()
        )
    }

    /// Get presenter for favorite.
    func getFavorite() -> FavoritePresenter {
        return FavoritePresenter(
            getFavoritesUseCase: provideGetFavoritesUseCase(),
            addFavoritesUseCase: provideAddFavoritesUseCase(),
            removeFavoritesUseCase: provideRemoveFavoritesUseCase()
        )
    }

    /// Get presenter for search games.
    func getSearch() -> SearchPresenter {
        return SearchPresenter(
            gameUseCase: provideGameUseCase()
        )
    }

    /// Get presenter for detail game.
    func getDetail(game: GameModel) -> DetailPresenter {
        return DetailPresenter(
            gameUseCase: provideDetailUseCase(),
            game: game
        )
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
typealias GameUseCaseType = Interactor<
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

/// Declase use case to get list games.
private let gameUseCase: GameUseCaseType = {
    let remote = GetGamesRemoteSrc()
    let repo = GetGamesRepo(
        getGamesSrc: remote,
        mapperRes: GamesTransformer(),
        mapperReq: GamesReqTranformer()
    )
    let interactor = Interactor(repo: repo)
    return interactor
}()

/// Declare use case to get detail game.
private let detailGameUseCase: GetDetailGameUseCase = {
    let remote = GetDetailGameRemoteSrc()
    let repo = GetDetailGameRepo(
        getDetailGameSrc: remote,
        mapperRes: DetailGameTransformer()
    )
    let interactor = Interactor(repo: repo)
    return interactor
}()

/// Declair use case to get list favorites.
private let getFavoritesUseCase: GetFavoritesUseCase = {
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
}()

/// Declare use case to add favorite.
private let addFavoritesUseCase: AddFavoritesUseCase = {
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
}()

/// Declare use case to remove favorite.s
private let removeFavoritesUseCase: RemoveFavoritesUseCase = {
    let manager = CoreDataManager.manager
    let local = FavoriteLocalSrc(
        manager: manager
    )
    let repo = RemoveFavoritesRepo(
        favoriteSrc: local
    )
    let interactor = Interactor(repo: repo)
    return interactor
}()
