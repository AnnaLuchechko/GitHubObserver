//
//  SearchActionBinder.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation

final class SearchActionBinder: ViewControllerBinder {
    unowned let viewController: SearchViewController
    private let driver: SearchDriving
    
    init(viewController: SearchViewController,
         driver: SearchDriving) {
        self.viewController = viewController
        self.driver = driver
        
        bind()
    }
    
    func dispose() { }
    
    func bindLoaded() {
        let query = viewController.searchController.searchBar.rx.text.orEmpty
        let didSelectItem = viewController.tableView.rx.modelSelected(GitHubRepository.self)
        let fetchMore = viewController.tableView.rx.reachedBottom.asObservable()
                
        viewController.bag.insert(query.bind(onNext: driver.search), didSelectItem.bind(onNext: driver.select), fetchMore.bind(onNext: driver.fetchMore))
    }
}
