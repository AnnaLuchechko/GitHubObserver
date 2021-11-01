//
//  UIStoryboard+ViewControllers.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
    var searchViewController: SearchViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            fatalError("SearchViewController couldn't be found in Storyboard file")
        }
        return vc
    }
    
    var detailViewController: DetailViewController {
        guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("DetailViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
