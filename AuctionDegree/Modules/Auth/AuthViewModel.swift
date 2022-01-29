//
//  AuthViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 26.12.2021.
//

import Foundation
import UIKit

protocol AuthViewModelProtocol {
    func authRequest(model: AuthModel)
    var needStart: (() -> Void)? {get set}
}
class AuthViewModel: AuthViewModelProtocol {
    
    private var login: String?
    private var password: String?
    var needStart: (() -> Void)?
    init() {
        self.login = ""
        self.password = ""
    }
    
    func authRequest(model: AuthModel) {
        self.login = model.login
        self.login = model.password
        let dict = try? JSONSerialization.jsonObject(with: JSON.encoder.encode(model)) as? [String: String] ?? [:]
        
        NetworkEngine.request(endpoint: CoronaEndPoint.auth, bodyReq: dict!) { (result: Result<AuthTokenModel, Error>) in
            switch result {
            case .success(let model):
                UserDefaults.standard.userToken = model.token
                self.needStart?()
                debugPrint("User token: \(model.token)")
            case .failure(let failure):
                debugPrint("Auth error \(failure)")
            }
        }
    }
    
}
