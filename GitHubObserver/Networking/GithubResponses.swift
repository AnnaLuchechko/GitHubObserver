//
//  GithubResponces.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation

struct GithubRepositoriesResponse: Decodable {
    let items: [GitHubRepository]
    let totalCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}
