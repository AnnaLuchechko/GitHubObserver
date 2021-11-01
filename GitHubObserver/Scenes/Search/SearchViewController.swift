//
//  DiscoverViewController.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit
import RxSwift

final class SearchViewController: DisposeViewController {
    @IBOutlet private(set) var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)
}

extension SearchViewController: StaticFactory {
    enum Factory {
        static var `default`: SearchViewController {
            let vc = UIStoryboard.main.searchViewController
            let driver = SearchDriver.Factory.default
            let stateBinder = SearchStateBinder.Factory.default(vc, driver: driver)
            let actionBinder = SearchActionBinder(viewController: vc, driver: driver)
            let navigationBinder = NavigationPushBinder<GitHubRepository, SearchViewController>.Factory
                .push(viewController: vc,
                      driver: driver.didSelect,
                      factory: searchControllerFactory)
            vc.bag.insert(
                stateBinder,
                actionBinder,
                navigationBinder
            )
            return vc
        }
        
        private static func searchControllerFactory(_ item: GitHubRepository) -> UIViewController? {
            DetailViewController.Factory.default(repository: item)
        }
    }
}
