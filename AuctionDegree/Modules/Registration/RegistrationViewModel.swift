//
//  RegistrationViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 30.01.2022.
//

import Foundation
import UIKit
protocol RegistrationViewModelProtocol {
    func registrationRequest(login: String, password: String, completion: (() -> Void)?)
}
class RegistrationViewModel: RegistrationViewModelProtocol {
    
    init() {}
    
    func registrationRequest(login: String, password: String, completion: (() -> Void)?) {
        let model = AuthModel(login: login, password: password)
        let dict = try? JSONSerialization.jsonObject(with: JSON.encoder.encode(model)) as? [String: String] ?? [:]
        NetworkEngine.request(endpoint: CoronaEndPoint.registration, bodyReq: dict!) { (result: Result<AuthTokenModel, Error>) in
            switch result {
            case .success(let model):
                UserDefaults.standard.userToken = model.token
                completion?()
            case .failure(let error):
                debugPrint("Registration error \(error)")
            }
        }
    }
}
