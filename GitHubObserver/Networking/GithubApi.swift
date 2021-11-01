//
//  GithubRequest.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import RxSwift
import RxCocoa

protocol GithubApiRepositoriesProvider {
    func fetchRepositories(with query: String, page: Int?, perPage: Int?, completion: @escaping (Bool) -> ()?) -> Observable<GithubRepositoriesResponse?>
}

protocol GithubApiProvider: GithubApiRepositoriesProvider { }

extension GithubApiProvider {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

final class GithubApi: GithubApiProvider {
    
    private let httpClient: HTTPClientProvider
    
    init(httpClient: HTTPClientProvider = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func fetchRepositories(with query: String, page: Int?, perPage: Int?, completion: @escaping (Bool) -> ()?) -> Observable<GithubRepositoriesResponse?> {
        return httpClient.get(url: "\(baseURL)/search/repositories?q=\(query)&page=\(page ?? 1)&per_page=\(perPage ?? 30)").map { data -> GithubRepositoriesResponse? in
                guard let data = data, let response = try? JSONDecoder().decode(GithubRepositoriesResponse.self, from: data) else {
                    completion(false)
                    return nil
                }
                completion(true)
                return response
        }
    }
    
}

extension GithubApi: StaticFactory {
    enum Factory {
        static let `default`: GithubApiProvider = GithubApi()
    }
}
