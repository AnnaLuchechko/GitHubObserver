//
//  DisposeViewController.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit
import RxSwift

protocol DisposeContainer {
    var bag: DisposeBag { get }
}

class DisposeViewController: UIViewController, DisposeContainer {
    let bag = DisposeBag()

    static var defaultStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    var statusBarStyle = defaultStatusBarStyle {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var statusBarUpdateAnimation: UIStatusBarAnimation = .none {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var isStatusBarHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Override

    override var prefersStatusBarHidden: Bool {
        isStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        statusBarUpdateAnimation
    }
}
