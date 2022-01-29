//
//  DetailStateBinder.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 01.11.2021.
//

import Foundation

final class DetailStateBinder: ViewControllerBinder {
    unowned let viewController: DetailViewController
    private let repository: GitHubRepository
    
    init(viewController: DetailViewController, repository: GitHubRepository) {
        self.viewController = viewController
        self.repository = repository
        bind()
    }
    
    func dispose() { }
    
    func bindLoaded() {
        viewController.statusBarStyle = .lightContent
        viewController.navigationItem.title = repository.name
        
//        viewController.webView.load(URLRequest(url: repository.url))
//
//        _ = viewController.webView.rx.didFinishLoad.subscribe(onNext: { [weak self] _ in
//            self?.viewController.indicatorView.isHidden = true
//        }).disposed(by: viewController.bag)
//        _ = viewController.webView.rx.didStartLoad.subscribe(onNext: { [weak self] _ in
//            self?.viewController.indicatorView.isHidden = false
//        }).disposed(by: viewController.bag)
    }
}
