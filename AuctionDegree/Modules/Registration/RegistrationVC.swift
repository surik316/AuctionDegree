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
        self.navigationController?.navigationBar.isTranslucent = false
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
        regButton.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func enterAction() {
        if viewModel.checkPaswwordCoincidence(first: passwordTextField.text, second: confirmPasswordTextField.text) {
            viewModel.registrationRequest(login: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] result in
                switch result {
                case .success:
                    self?.navigation?(.registration)
                case .failure:
                    debugPrint("registration failure")
                }
            }
        }
    }
    
    @objc
    private func backAction() {
        self.navigation?(.back)
    }
    
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
