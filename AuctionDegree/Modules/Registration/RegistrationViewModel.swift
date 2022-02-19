//
//  RegistrationViewModel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 30.01.2022.
//

import Foundation
import UIKit

enum ResultRequest {
    case success
    case failure
}

protocol RegistrationViewModelProtocol {
    func registrationRequest(login: String, password: String, completion: ((ResultRequest) -> Void)?)
    func checkPaswwordCoincidence(first: String?, second: String?) -> Bool
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    init() {}
    
    func registrationRequest(login: String, password: String, completion: ((ResultRequest) -> Void)?) {
        let model = AuthModel(login: login, password: password)
        let dict = try? JSONSerialization.jsonObject(with: JSON.encoder.encode(model)) as? [String: String] ?? [:]
        NetworkEngine.request(endpoint: AuctionEndPoint.registration, bodyReq: dict!) { (result: Result<AuthTokenModel, Error>) in
            switch result {
            case .success(let model):
                UserDefaults.standard.userToken = model.token
                completion?(.success)
            case .failure(let error):
                completion?(.failure)
                debugPrint("Registration error \(error)")
            }
        }
    }
    
    func checkPaswwordCoincidence(first: String?, second: String?) -> Bool {
        guard let first = first else { return false }
        guard let second = second else { return false }
        
        return first == second
    }
}
