//
//  AppDelegate.swift
//  GitHubObserver
//
//  Created by Anna Luchechko on 31.10.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            App.shared.startInterface(in: window)
        }
        
        return true
    }
}
