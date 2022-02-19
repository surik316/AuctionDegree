//
//  PhotoButton.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 05.01.2022.
//

import Foundation
import UIKit
import SnapKit

class PhotoButton: UIButton {
    
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
        layer.cornerRadius = 5
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.gray.cgColor
        clipsToBounds = true
        
        nameLabel.text = "Войти"
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
    }
}
