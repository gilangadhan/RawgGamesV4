//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 10/02/24.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetGamesRemoteSrc: RemoteSrc {
    
    public typealias Req = GamesReq

    public typealias Res = GamesRes

    private let baseUrl = "https://api.rawg.io/api"

    public init() {}

    /// Get api key from `ApiKey.plist` file.
    ///
    /// Add`ApiKey.plist` in `Config` folder, with "ApiKey" as key for api key.
    private var apiKey: String {
        guard let path = Bundle.main.path(forResource: "ApiKey", ofType: "plist") else {
            return ""
        }
        let dict = NSDictionary(contentsOfFile: path)
        let apiKey = dict?["ApiKey"] as? String ?? ""
        return apiKey
    }
    
    public func execute(_ req: Req?) -> AnyPublisher<Res, Error> {
        let future = Future<Res, Error> {
            guard let req = req else {
                throw RemoteError.unknown("GameDataSourceImpl.getList req is nil")
            }

            let page = req.page
            let pageSize = req.pageSize
            let search = req.search

            var params = GamesParameters(
                key: self.apiKey,
                page: page,
                pageSize: pageSize,
                ordering: "-popularity"
            )
            if search.isEmpty == false {
                params.search = search
                params.ordering = nil
            }

            let response = await AF.request("\(self.baseUrl)/games", parameters: params)
                .validate()
                .serializingDecodable(Res.self)
                .response

            if let afError = response.error {
                throw afError
            }

            if let value = response.value {
                return value
            }

            throw RemoteError.unknown("GameDataSourceImpl.getList not respond")
        }

        return future.eraseToAnyPublisher()
    }

}
