//
//  HTTPClient.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import RxSwift
import RxCocoa

protocol HTTPClientProvider {
    func get(url: String) -> Observable<Data?>
    func post(url: String, params: [String: Any]) -> Observable<Data?>
}

final class HTTPClient: HTTPClientProvider {
    func get(url: String) -> Observable<Data?> {
        guard let url = URL(string: url) else { return Observable.empty() }
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.data(request: request)
            .map { Optional.init($0) }
            .catchAndReturn(nil)
    }
    
    func post(url: String, params: [String: Any]) -> Observable<Data?> {
        guard let url = URL(string: url) else { return Observable.empty() }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        request.httpBody = jsonData
        return URLSession.shared.rx.data(request: request)
            .map { Optional.init($0) }
            .catchAndReturn(nil)
    }
}
