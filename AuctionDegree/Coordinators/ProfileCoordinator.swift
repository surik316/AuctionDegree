//
//  ProfileCoordinator.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 04.01.2022.
//

import Foundation
import UIKit
class ProfileCoordinator: Presentable {
    typealias Result = Void

    let router = DefaultRouter(with: nil)
    var result: ((FlowResult<Void>) -> Void)?
    init() {
        (router.toPresent() as? UINavigationController)?.setNavigationBarHidden(true, animated: false)
        start()
    }
    func start() {
        let module = ProfileVC()
        module.navigation = { [weak self] nav in
            switch nav {
            case .createAuction:
                self?.presentAuctionCreation()
            case .notifications:
                print("")
            case .editProfile:
                print("")
            case .myHistory:
                print("")
            case .myAuctions:
                print("")
            case .getCarType:
                print("")
            }
        }
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
    
    func presentAuctionCreation() {
        let module = AuctionCreationVC()
        let nav = UINavigationController(rootViewController: module)
        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.tintColor = .white
        nav.modalPresentationStyle = .overFullScreen
        module.navigation = { [weak self] nav in
            switch nav {
            case .dismiss:
                self?.router.popModule(animated: true)
            case .create:
                print("Some")
            case .setImage:
                print("")
            }
            
        }
        router.present(nav, animated: true, completion: nil)
    }
}
