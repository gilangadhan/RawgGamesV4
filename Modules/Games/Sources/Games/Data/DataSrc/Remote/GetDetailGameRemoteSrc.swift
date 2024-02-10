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

public struct GetDetailGameRemoteSrc: RemoteSrc {

    public typealias Req = String

    public typealias Res = DetailGameRes

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
            guard let id = req else {
                throw RemoteError.unknown("GameDataSourceImpl.getList req is nil")
            }

            let params = DetailGameParameters(key: self.apiKey)

            let response = await AF.request("\(self.baseUrl)/games/\(id)", parameters: params)
                .validate()
                .serializingDecodable(DetailGameRes.self)
                .response

            if let afError = response.error {
                throw afError
            }

            if let value = response.value {
                return value
            }

            throw RemoteError.unknown("GameDataSourceImpl.getDetail not respond")
        }
        return future.eraseToAnyPublisher()
    }

}
