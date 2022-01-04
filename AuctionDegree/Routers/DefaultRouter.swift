//
//  DefaultRouter.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 04.01.2022.
//

import Foundation
import UIKit

// FIXME: Нужен протокол
class DefaultRouter: Presentable {

    enum DeliveryKind {
        case root(Presentable)
        case push(Presentable)
        case modal(Presentable)
    }

    private let container: UINavigationController
    private(set) var modules: [DeliveryKind] = []

    init(
        with rootModule: Presentable?
    ) {
        if let root = rootModule {
            self.modules = [.root(root)]
            self.container = UINavigationController(rootViewController: root.toPresent())
        } else {
            self.container = UINavigationController(rootViewController: UIViewController())
        }


        if #available(iOS 13.0, *) {
            container.isModalInPresentation = true
        }
        container.navigationBar.setBackgroundImage(UIImage(), for: .default)
        container.navigationBar.shadowImage = UIImage()
        container.navigationBar.isTranslucent = true
        container.navigationBar.barTintColor = .white
        container.navigationBar.tintColor = .white
        container.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func toPresent() -> UIViewController {
        return container
    }
    func removeLastModule() {
        modules.removeLast()
    }
    func present(_ module: Presentable, animated: Bool, isModalInPresentation: Bool = true, completion: (() -> Void)?) {
        if #available(iOS 13.0, *) {
            module.toPresent().isModalInPresentation = isModalInPresentation
        }

        container.present(module.toPresent(), animated: animated, completion: completion)
        modules.append(.modal(module))
    }

    func push(_ module: Presentable, animated: Bool) {
        container.pushViewController(module.toPresent(), animated: animated)
        modules.append(.push(module))
    }

    func setRootModule(_ module: Presentable) {
        container.viewControllers = [module.toPresent()]
        modules = [.root(module)]
    }

    func popModule(animated: Bool) {
        guard let lastModule = self.modules.last else {
            return
        }

        switch lastModule {
        case .root:
            break
        case .push:
            self.container.popViewController(animated: animated)
            self.modules.removeLast()
        case .modal(let module):
            module.toPresent().dismiss(animated: animated, completion: nil)
            self.modules.removeLast()
        }
    }

    func popToRootModule(animated: Bool) {
        container.popToRootViewController(animated: animated)
        modules = [modules[0]]
    }

    func insert(module: Presentable, at index: Int) {
        var viewControllers = self.container.viewControllers
        viewControllers.insert(module.toPresent(), at: index)
        self.container.viewControllers = viewControllers
        self.modules.insert(.push(module), at: index)
    }

    func lastModule() -> Presentable? {
        switch self.modules.last {
        case .modal(let module):
            return module
        case .push(let module):
            return module
        case .root(let module):
            return module
        default:
            return nil
        }
    }

    func enableInteractiveDismiss(_ enable: Bool) {
        if #available(iOS 13.0, *) {
            container.isModalInPresentation = enable == false
        }
    }

    func presentScreen(_ identifier: String) {}
    func processPush(_ push: [String: Any]) {}
    func presentSplash() {}
}
