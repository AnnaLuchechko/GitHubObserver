//
//  ViewModelType.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
