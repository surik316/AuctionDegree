//
//  AuthViewController.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 26.12.2021.
//

import Foundation
import SnapKit
import UIKit

class AuthViewController: UIViewController {
    enum Navigation {
        case enter
        case resetPassword
        case registration
    }
    private let loginTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let logoView = LogoView()
    private let entranceButton = EntranceButton()
    private let resetPasswordLabel = UILabel()
    private let registrationLabel = UILabel()
    private let titleRegistrationLabel = UILabel()
    
    
    var navigation: ((Navigation) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview().offset(-50)
            make.height.equalTo(60)
        }
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(loginTextField.snp.bottom).offset(10)
            make.height.equalTo(60)
        }
        
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginTextField.snp.top).offset(-120)
            make.width.equalTo(108)
            make.height.equalTo(33)
        }
        
        view.addSubview(entranceButton)
        entranceButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(75)
        }
        
        view.addSubview(resetPasswordLabel)
        resetPasswordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(entranceButton.snp.bottom).offset(15)
        }
        
        view.addSubview(titleRegistrationLabel)
        titleRegistrationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        view.addSubview(registrationLabel)
        registrationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        loginTextField.titleLabel.text = "Логин"
        passwordTextField.titleLabel.text = "Пароль"
        
        
        entranceButton.addTarget(self, action: #selector(entranceButtonTapped), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
        
        resetPasswordLabel.text = "Забыли пароль ?"
        resetPasswordLabel.textAlignment = .center
        resetPasswordLabel.textColor = .blue
        resetPasswordLabel.isUserInteractionEnabled = true
        let resetPasswordGesture = UITapGestureRecognizer(target: self, action: #selector(resetButtonTapped(_:)))
        resetPasswordLabel.addGestureRecognizer(resetPasswordGesture)
        
        titleRegistrationLabel.text = "У вас нет аккаунта ?"
        titleRegistrationLabel.textAlignment = .center
        titleRegistrationLabel.textColor = .black
        
        registrationLabel.text = "Зарегистрироваться"
        registrationLabel.textColor = .blue
        registrationLabel.textAlignment = .center
        registrationLabel.isUserInteractionEnabled = true
        let registrationGesture = UITapGestureRecognizer(target: self, action: #selector(registrationButtonTapped(_:)))
        registrationLabel.addGestureRecognizer(registrationGesture)
        
    }
    
    @objc
    private func entranceButtonTapped() {
        navigation?(.enter)
    }
    
    @objc
    private func resetButtonTapped(_ sender: UITapGestureRecognizer) {
        navigation?(.resetPassword)
    }
    
    @objc
    private func registrationButtonTapped(_ sender: UITapGestureRecognizer) {
        navigation?(.registration)
    }
    
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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
