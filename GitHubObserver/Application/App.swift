//
//  App.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit

final class App {
    static let shared = App()
    
    func startInterface(in window: UIWindow) {
        let searchViewController = SearchViewController.Factory.default
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        
        window.rootViewController = searchNavigationController
        window.makeKeyAndVisible()
    }
}
