//
//  AppDelegate.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 26.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = AuthViewController()
        
        return true
    }

}

