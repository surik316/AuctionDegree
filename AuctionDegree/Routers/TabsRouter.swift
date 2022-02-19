//
//  TabsRouter.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 04.01.2022.
//

import Foundation
import UIKit

class TabsRouter: Presentable{

    private var modules: [Presentable] = []
    private(set) var tabs: [Presentable]
    let container = UITabBarController()

    init(with items: [Presentable]) {
        self.tabs = items
        self.container.viewControllers = items.map { $0.toPresent() }
        configure()
    }

    private func configure() {
//        container.tabBar.backgroundColor = UIColor(hex: "FFFFFF")
//        container.tabBar.barTintColor = .clear
////        container.tabBar.isTranslucent = true
//        container.tabBar.tintColor = UIColor(hex: "007AFF")
    }

    func toPresent() -> UIViewController {
        return self.container
    }

    func present(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
        container.present(module.toPresent(), animated: animated, completion: completion)
        modules.append(module)
    }
    func push(_ module: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let nav = UINavigationController(rootViewController: module)
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.tintColor = .white
        nav.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.topViewController() {
            topController.present(nav, animated: animated, completion: completion)
        }
        modules.append(module)
    }
    func setRootModules(_ modules: [Presentable]) {
        self.tabs = modules
        container.viewControllers = modules.map { $0.toPresent() }
    }

    func popModule(animated: Bool) {
        if let module = modules.last {
            module.toPresent().dismiss(animated: animated, completion: nil)
            self.modules.removeLast()
        }
    }

    func insert(module: Presentable, at index: Int) {
        var viewControllers = container.viewControllers
        viewControllers?.insert(module.toPresent(), at: index)
        container.viewControllers = viewControllers
        tabs.insert(module, at: index)
    }

    func lastModule() -> Presentable? {
        return modules.last ?? container
    }

    func presentScreen(_ identifier: String) {}
    func processPush(_ push: [String: Any]) {}
}
