//
//  AppDelegate.swift
//  NSCache
//
//  Created by Gerardo Valencia on 24/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let vc = ViewController()
        
        if let window = window {
            
            navigationController.pushViewController(vc, animated: false)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
        }
        
        return true
        
    }

}

