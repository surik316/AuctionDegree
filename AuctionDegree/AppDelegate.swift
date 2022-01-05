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
    private var appCoordinator: Presentable!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let favouriteCoordinator = FavouriteCoordinator()
        favouriteCoordinator.start()
        let auctionItemsCoordinator = AuctionItemsCoordinator()
        auctionItemsCoordinator.start()
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        
        let tbController = TabBarCoordinator(with:  [.init(module: favouriteCoordinator, icon: UIImage(systemName: "bookmark.circle")!, title: ""), .init(module: auctionItemsCoordinator, icon: UIImage(systemName: "note.text")!, title: ""), .init(module: profileCoordinator, icon: UIImage(systemName: "person.crop.circle")!, title: "")])
        appCoordinator = tbController
        
        window?.rootViewController = appCoordinator.toPresent()
        window?.makeKeyAndVisible()
        return true
    }

}
