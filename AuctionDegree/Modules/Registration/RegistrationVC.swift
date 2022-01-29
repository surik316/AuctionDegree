//
//  RegistrationVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 30.01.2022.
//

import Foundation
import UIKit
import SnapKit

class RegistrationVC: UIViewController {
    enum Navigation {
        case back
        case registration
    }
    private let label = UILabel()
    private let regButton = EntranceButton()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let confirmPasswordTextField = AuthTextField()
    var navigation: ((Navigation) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configureUI()
    }
    
    
    private func setUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        label.font = .systemFont(ofSize: 18)
        label.text = "Регистрация"
        label.textAlignment = .center
        label.textColor = .black
    }
}
