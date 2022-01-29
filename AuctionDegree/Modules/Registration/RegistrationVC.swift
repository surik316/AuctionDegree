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
    private let emailTextField = AuthTextField(type: .loginTextField)
    private let passwordTextField = AuthTextField(type: .passwordTextField)
    private let confirmPasswordTextField = AuthTextField(type: .confirmPasswordTextField)
    private let stackView = UIStackView()
    private let viewModel: RegistrationViewModelProtocol = RegistrationViewModel()
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
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(label.snp.bottom).offset(150)
            make.height.equalTo(view.frame.width)
        }
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(regButton)
        
        let backNavigationItem = UIBarButtonItem(
            image: UIImage(named: "back_rounded")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
        backNavigationItem.tintColor = .white
        navigationItem.leftBarButtonItem = backNavigationItem
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        label.font = .systemFont(ofSize: 18)
        label.text = "Регистрация"
        label.textAlignment = .center
        label.textColor = .black
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        regButton.nameLabel.text = "Зарегистрироваться"
        let enterGesture = UITapGestureRecognizer(target: self, action: #selector(enterAction))
        regButton.addGestureRecognizer(enterGesture)
    }
    
    @objc
    private func enterAction() {
        if passwordTextField.text == confirmPasswordTextField.text {
            viewModel.registrationRequest(login: emailTextField.text, password: passwordTextField.text) {
                self.navigation?(.registration)
            }
        }
    }
    
    @objc
    private func backAction() {
        self.navigation?(.back)
    }
}
