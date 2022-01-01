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
    var appCoordinator: AppCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AuctionVC()
        window?.makeKeyAndVisible()
        //appCoordinator = AppCoordinator(window: window!)
        //appCoordinator?.start()
        return true
    }

}

