//
//  GithubRepository.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation

struct GitHubRepository: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let stargazersCount: Int
    let url: URL

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case url = "html_url"
    }
}
