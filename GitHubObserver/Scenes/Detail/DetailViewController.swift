//
//  DetailViewController.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 01.11.2021.
//

import UIKit
import RxCocoa
import RxSwift
import WebKit
import RxWebKit

final class DetailViewController: DisposeViewController {
    @IBOutlet private(set) var indicatorView: UIActivityIndicatorView!
    @IBOutlet private(set) var webView: WKWebView!
}

extension DetailViewController: StaticFactory {
    enum Factory {
        static func`default`(repository: GitHubRepository) -> DetailViewController {
            let vc = UIStoryboard.main.detailViewController
            let stateBinder = DetailStateBinder(viewController: vc, repository: repository)
            vc.bag.insert(stateBinder)
            return vc
        }
    }
}
