//
//  TabBarCoordinator.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit

class TabBarCoordinator: NSObject, Coordinator {
    typealias Result = Void

    private let router: TabsRouter

    var result: ((FlowResult<Void>) -> Void)?
    init(with items: [TabBarControllerItem]) {
        self.router = .init(with: items.map { $0.module })
        super.init()
        router.container.delegate = self
        items.forEach { (item) in
            item.module.toPresent().tabBarItem = .init(title: item.title, image: item.icon, tag: 0)
        }
    }

    func start() {
    }

    func toPresent() -> UIViewController {
        return self.router.toPresent()
    }

    func processPush(_ push: [String: Any]) {
        let activeIndex = router.container.selectedIndex

        router.tabs[activeIndex].processPush(push)
    }
    
    func presentScreen(_ identifier: String) {
    }
}

extension TabBarCoordinator {
    struct TabBarControllerItem {
        let module: Presentable
        let icon: UIImage
        let title: String
    }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let item = tabBarController.tabBar.selectedItem

        guard let itemTitle = item?.title else {
            return
        }
    }
}
