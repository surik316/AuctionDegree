//
//  AuthTextField.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 26.12.2021.
//

import Foundation
import UIKit
import SnapKit

class AuthTextField: UITextField {
    enum TypeField {
        case nameTextField
        case fuelTextField
        case engineCapacityTextField
        case boxTypeCarTextField
        case mileageTextField
        case loginTextField
        case passwordTextField
        case confirmPasswordTextField
        case model
        case manufactured
    }
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    init(type: TypeField) {
        super.init(frame: .zero)
        setupUI()
        configureUI()
        switch type {
        case .nameTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Название", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .fuelTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Топливо", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .engineCapacityTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Обьем двигателя", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .boxTypeCarTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Тип коробки", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .mileageTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Пробег", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .loginTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .passwordTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .model:
            self.attributedPlaceholder = NSAttributedString(string: "Модель", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .manufactured:
            self.attributedPlaceholder = NSAttributedString(string: "Производитель", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        case .confirmPasswordTextField:
            self.attributedPlaceholder = NSAttributedString(string: "Подтвердите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
    }
    private func configureUI() {
        layer.cornerRadius = 15
        backgroundColor = UIColor(hex: "EAEAEA")
        textColor = UIColor(hex: "565656")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
