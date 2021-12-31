//
//  AppCoordinator.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    var childCoordinators: [Coordinator] { get }
    
}

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        let tbController = UITabBarController()
        window.rootViewController = tbController
        window.makeKeyAndVisible()
    }
    
}
