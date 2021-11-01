//
//  Driver.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableConvertibleType {
    func asDriver(_ file: StaticString = #file,
                  _ function: StaticString = #function,
                  _ line: UInt = #line,
                  onError: ((Error) -> Void)? = nil) -> Driver<Element> {
        asObservable()
            .do(onError: { error in
                onError?(error)
                print(error)
            })
            .asDriver(onErrorRecover: { _ in .never() })
    }
    
    func asDriver(onError `default`: @escaping @autoclosure () -> Element) -> Driver<Element> {
        return Observable.create { observer in
            self.asObservable()
                .subscribe(onNext: observer.onNext, onError: { error in
                    print(error)
                    observer.onNext(`default`())
                },
                onCompleted: observer.onCompleted)
            }
            .asDriver(onErrorRecover: { _ in .never() })
    }
}
