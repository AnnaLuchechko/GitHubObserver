//
//  DetailViewController.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 01.11.2021.
//

//import Foundation
//import UIKit
//
//
//final class DetailViewController: UIViewController {
//    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
//    @IBOutlet private weak var webView: WKWebView!
//}
//
//extension DetailViewController: StaticFactory {
//    enum Factory {
//        static func`default`(id: Int) -> MovieDetailViewController {
//            let vc = UIStoryboard.main.detailViewController
//            let driver = MovieDetailDriver.Factory.default(id: id)
//            let stateBinder = MovieDetailStateBinder(viewController: vc, driver: driver)
//            let actionBinder = MovieDetailActionBinder(viewController: vc, driver: driver)
//            let navigationBinder = NavigationPopBinder<MovieDetailViewController>.Factory
//                .pop(viewController: vc, driver: driver.didClose)
//            vc.bag.insert(
//                stateBinder,
//                actionBinder,
//                navigationBinder
//            )
//            return vc
//        }
//    }
//}
