//
//  RemoteError.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import Foundation

/// Enum to handle throw error for`DataSource`
enum RemoteError: Error {
    case urlNil(String)
    case serverError(String)
    case unknown(String)
}

extension RemoteError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlNil(let error):
            return error
        case .serverError(let error):
            return error
        case .unknown(let error):
            return error
        }
    }
}
