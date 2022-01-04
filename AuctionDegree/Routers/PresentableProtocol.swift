//
//  PresentableProtocol.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 04.01.2022.
//

import Foundation
import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController
    func presentScreen(_ identifier: String)
    func processPush(_ push: [String: Any])
}

extension UIViewController: Presentable {
    func presentScreen(_ identifier: String) {
    }
    
    func processPush(_ push: [String: Any]) {
    }
    func toPresent() -> UIViewController {
        return self
    }
}
