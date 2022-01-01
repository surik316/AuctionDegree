//
//  EntranceButton.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 29.12.2021.
//

import Foundation
import UIKit
import SnapKit

class EntranceButton: UIButton {
    
    var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    private func configureUI() {
        backgroundColor = UIColor(hex: "0A84FF")
        layer.cornerRadius = 24
        
        nameLabel.text = "Войти"
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
    }
}
