//
//  DetailViewController.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 01.11.2021.
//

import UIKit
import SwiftUI

final class DetailViewController: DisposeHostingViewController<DetailView> {
    @IBOutlet private(set) var indicatorView: UIActivityIndicatorView!

}

extension DetailViewController: StaticFactory {
    enum Factory {
        static func`default`(repository: GitHubRepository) -> DetailViewController {
            let vc = DetailViewController(rootView: DetailView(repository: repository))
            let stateBinder = DetailStateBinder(viewController: vc, repository: repository)
            vc.bag.insert(stateBinder)
            return vc
        }
    }
}
