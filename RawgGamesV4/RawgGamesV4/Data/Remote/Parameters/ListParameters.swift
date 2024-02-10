//
//  ListParameter.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 09/02/24.
//

import Foundation

/// Parameters to get list from api.
struct ListParameters: Codable {
    var key: String
    var page: Int
    var pageSize: Int
    var search: String?
    var ordering: String?

    enum CodingKeys: String, CodingKey {
        case key, page, search, ordering
        case pageSize = "page_size"
    }
}
