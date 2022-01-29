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
    let stargazersCount: Int
    let description: String
    let url: URL
    let isPrivate: Bool
    let owner: GitHubOwner

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case stargazersCount = "stargazers_count"
        case description
        case url = "html_url"
        case owner
        case isPrivate = "private"
    }
    
    struct GitHubOwner: Decodable {
        let login: String
        let avatarUrl: URL
        
        private enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
        }
    }
}
