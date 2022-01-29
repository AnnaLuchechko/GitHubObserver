//
//  DisposeHostingViewController.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 29.01.2022.
//

import UIKit
import RxSwift
import SwiftUI

class DisposeHostingViewController<T: View>: UIHostingController<T>, DisposeContainer {
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
