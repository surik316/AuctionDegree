//
//  AuctionHeaderView.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 13.03.2022.
//

import Foundation
import SnapKit
import UIKit


final class AuctionHeaderView: UICollectionReusableView {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func configureUI() {
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(hex: "565656")
    }
    func configure(text: String) {
        label.text = text
    }
}
