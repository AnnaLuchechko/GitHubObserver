//
//  DefaultInitializable.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation

protocol DefaultInitializable {
    associatedtype ReturnType
    static var `default`: ReturnType { get }
}

protocol Mockable {
    associatedtype MockReturnType
    static var mock: MockReturnType { get }
}

protocol StaticFactory {
    associatedtype Factory
}

extension StaticFactory {
    static var factory: Factory.Type { return Factory.self }
}
