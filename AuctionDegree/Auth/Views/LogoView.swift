//
//  LogoView.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 29.12.2021.
//

import Foundation
import UIKit
import SnapKit

class LogoView: UIView {
    
    private let titleLabel = UILabel()
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
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func configureUI() {
        layer.cornerRadius = 8
        backgroundColor = UIColor(hex: "1E1E1E")
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 10, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.text = "АУКЦИОН АВТОМОБИЛЕЙ"
    }
}
