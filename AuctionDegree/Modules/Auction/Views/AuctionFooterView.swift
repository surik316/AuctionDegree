//
//  AuctionFooterView.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 13.03.2022.
//

import Foundation
import UIKit
import SnapKit

final class AuctionFooterView: UICollectionReusableView {
    
    private let statusLabel = UILabel()
    private let startDateLabel = UILabel()
    private let valueStartDateLabel = UILabel()
    private let exirationDateLabel = UILabel()
    private let valueExirationDateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        addSubview(startDateLabel)
        startDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
        }
        
        addSubview(valueStartDateLabel)
        valueStartDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(startDateLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(startDateLabel.snp.bottom).offset(3)
        }
        
        addSubview(exirationDateLabel)
        exirationDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(startDateLabel.snp.top)
        }
        
        addSubview(valueExirationDateLabel)
        valueExirationDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(exirationDateLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(exirationDateLabel.snp.bottom).offset(3)
        }
    }
    
    private func configureUI() {
        startDateLabel.text = "Осталось:"
        startDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        startDateLabel.textColor = UIColor(hex: "565656")
        
        valueStartDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        valueStartDateLabel.textColor = UIColor(hex: "565656")
        valueStartDateLabel.text = "4 дня"
        
        exirationDateLabel.text = "Завершение:"
        exirationDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        exirationDateLabel.textColor = UIColor(hex: "565656")
        
        valueExirationDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        valueExirationDateLabel.textColor = UIColor(hex: "565656")
        valueExirationDateLabel.text = "29.11.2021 12:00"
        
    }
    func configure(text: String, startDate: String, endDate: String) {
        
    }
}
