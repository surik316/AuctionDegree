//
//  FavouriteCoordinator.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 04.01.2022.
//

import Foundation
import UIKit

class FavouriteCoordinator: Presentable {
    typealias Result = Void

    let router = DefaultRouter(with: nil)
    var result: ((FlowResult<Void>) -> Void)?
    init() {
        (router.toPresent() as? UINavigationController)?.setNavigationBarHidden(true, animated: false)
        start()
    }
    func start() {
        let module = AuctionVC()
        router.setRootModule(module)
    }

    func toPresent() -> UIViewController {
        return router.toPresent()
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
