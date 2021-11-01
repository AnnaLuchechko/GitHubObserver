//
//  DicoverViewModel.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class SearchStateBinder: ViewControllerBinder {
    typealias Item = GitHubRepository
    
    struct Section: SectionModelType {
        let items: [Item]
        
        init(items: [Item]) {
            self.items = items
        }
        
        init(original: Self, items: [Item]) {
            self.items = items
        }
    }
    
    unowned let viewController: SearchViewController
    private let driver: SearchDriving
    private let dataSource: RxTableViewSectionedReloadDataSource<Section>
    
    init(viewController: SearchViewController,
         driver: SearchDriving,
         dataSource: RxTableViewSectionedReloadDataSource<Section>) {
        self.viewController = viewController
        self.driver = driver
        self.dataSource = dataSource
        
        bind()
    }
    
    func dispose() { }
    
    func bindLoaded() {
        viewController.statusBarStyle = .lightContent
        viewController.navigationItem.title = "GitHub Browser"
                
        viewController.searchController.obscuresBackgroundDuringPresentation = false
        viewController.searchController.hidesNavigationBarDuringPresentation = false
        viewController.searchController.searchBar.placeholder = "Search Repositories"
        viewController.searchController.searchBar.text = "Genesis"
        viewController.navigationItem.searchController = viewController.searchController
        viewController.definesPresentationContext = true
        
        viewController.tableView.register(UINib(nibName: String(describing: RepositoryCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RepositoryCell.self))
        
        let section = driver.results.map(Section.init).map({ [$0] })
        
        viewController.bag.insert(
            driver.isLoading.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible),
            section.drive(viewController.tableView.rx.items(dataSource: dataSource))
        )
    }

}

extension SearchStateBinder: StaticFactory {
    enum Factory {
        static func `default`(_ viewController: SearchViewController, driver: SearchDriving) -> SearchStateBinder {
            let dataSource = RxTableViewSectionedReloadDataSource(configureCell: cellFactory)
            return SearchStateBinder(viewController: viewController, driver: driver, dataSource: dataSource)
        }
    }

    private static func cellFactory(_: TableViewSectionedDataSource<Section>, tableView: UITableView, indexPath: IndexPath, item: Section.Item) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self), for: indexPath) as? RepositoryCell {
            cell.configure(withRepositoryItem: item)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
