//
//  AuctionItemsCoordinator.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 04.01.2022.
//

import Foundation
import UIKit

class AuctionItemsCoordinator: Presentable {
    typealias Result = Void

    let router = DefaultRouter(with: nil)
    var result: ((FlowResult<Void>) -> Void)?
    init() {
        (router.toPresent() as? UINavigationController)?.setNavigationBarHidden(true, animated: false)
        start()
    }
    func start() {
        let module = PropertiesVC()
        module.navigation = { [weak self] model in
            self?.presentAuction(moedl: model)
        }
        router.setRootModule(module)
    }

    func toPresent() -> UIViewController {
        return router.toPresent()
    }
    
    func presentAuction(moedl: PropertiesModel) {
        let module = AuctionVC()
        let nav = UINavigationController(rootViewController: module)
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.tintColor = .white
        nav.modalPresentationStyle = .overFullScreen
        module.navigation = { [weak self] nav in
            switch nav {
            case .back:
                self?.router.popModule(animated: true)
            }
            
        }
        router.present(nav, animated: true, completion: nil)
    }
    
    func presentScreen(_ identifier: String) {
    }
    func processPush(_ push: [String: Any]) {
        if let modalModule = router.modules.filter({ (kind) -> Bool in
            switch kind {
            case .modal:
                return true
            default:
                return false
            }
        }).last {
            switch modalModule {
            case .modal(let module):
                module.processPush(push)
            default:
                break
            }
        } else if let screenID = push[CoordinatorConstants.Push.screen] as? String {
            presentScreen(screenID)
        }
    }
}
