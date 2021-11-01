//
//  SearchDriver.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import RxSwift
import RxCocoa

protocol SearchDriving {
    var isLoading: Driver<Bool> { get }
    var results: Driver<[GitHubRepository]> { get }
    var didSelect: Driver<GitHubRepository> { get }
    
    func search(_ query: String)
    func fetchMore()
    func select(_ model: GitHubRepository)
}

final class SearchDriver: SearchDriving {
    private let activityIndicator = ActivityIndicator()
    
    private let resultsRelay = BehaviorRelay<[GitHubRepository]?>(value: nil)
    private let didSelectRelay = BehaviorRelay<GitHubRepository?>(value: nil)
    
    private var page = 1
    private var totalCount: Int?
    private var previousQuery = ""
    private var isFetching = false
    
    private var searchBag = DisposeBag()

    private let api: GithubApiProvider
    
    var isLoading: Driver<Bool> { activityIndicator.asDriver() }
    var results: Driver<[GitHubRepository]> { resultsRelay.compactMap({ $0 }).asDriver() }
    var didSelect: Driver<GitHubRepository> { didSelectRelay.compactMap({ $0 }).asDriver() }
    
    init(api: GithubApiProvider) {
        self.api = api
    }
    
    func search(_ query: String) {
        searchBag = DisposeBag()

        guard query.count >= 3 else {
            resultsRelay.accept([])
            return
        }
        
        isFetching = true
        page = previousQuery == query ? page + 1 : 1
        previousQuery = query
        let searchResult = api.fetchRepositories(with: query, page: page, perPage: 30) { _ in
            self.isFetching = false
        }
        searchResult.trackActivity(activityIndicator).throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] value in
                guard let value = value else { return }
                self?.totalCount = value.totalCount
                if self?.page == 1 {
                    self?.resultsRelay.accept(value.items)
                } else if let oldData = self?.resultsRelay.value {
                    self?.resultsRelay.accept(oldData + value.items)
                }
            }).disposed(by: searchBag)
    }
    
    func fetchMore() {
        guard !previousQuery.isEmpty, !isFetching, let totalCount = totalCount, let currentCount = resultsRelay.value?.count, currentCount < totalCount else { return }
        search(previousQuery)
    }
    
    func select(_ model: GitHubRepository) {
        didSelectRelay.accept(model)
    }
    
}

extension SearchDriver: StaticFactory {
    enum Factory {
        static var `default`: SearchDriving {
            SearchDriver(api: GithubApi.Factory.default)
        }
    }
}
