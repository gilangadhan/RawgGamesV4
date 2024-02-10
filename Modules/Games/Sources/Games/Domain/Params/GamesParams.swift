//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 10/02/24.
//

public struct GamesParams {
    public var search: String
    public var page: Int
    public var pageSize: Int

    public init(
        search: String = "",
        page: Int = 1,
        pageSize: Int = 10
    ) {
        self.search = search
        self.page = page
        self.pageSize = pageSize
    }
}
