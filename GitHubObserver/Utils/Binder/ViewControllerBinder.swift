//
//  ViewControllerBinder.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation
import RxSwift
import RxViewController

protocol Binding {
    func bind()
}

// MARK: - ViewControllerBinder

protocol ViewControllerBinder: Disposable {
    associatedtype DisposeViewControllerContainer: UIViewController, DisposeContainer
    
    var viewController: DisposeViewControllerContainer { get }
    
    func bindLoaded()
}

extension ViewControllerBinder {
    var bag: DisposeBag {
        viewController.bag
    }
}

extension ViewControllerBinder where Self: AnyObject {
    func bind() {
        viewController.rx.viewDidLoad
            .subscribe(onNext: unowned(self, in: Self.bindLoaded))
            .disposed(by: viewController.bag)
    }
    
    var binded: Self {
        bind()
        return self
    }
}

