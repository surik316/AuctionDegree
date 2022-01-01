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
    
    
    let titleLabel = UILabel()
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
    private func configureUI() {
        layer.cornerRadius = 15
        backgroundColor = UIColor(hex: "EAEAEA")
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(hex: "565656")
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
