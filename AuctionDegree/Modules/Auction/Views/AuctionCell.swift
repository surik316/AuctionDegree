//
//  AuctionCell.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation
import UIKit

final class AuctionCell: UICollectionViewCell {
    
    struct Model {
        let title: String
        let subtitile: String
    }

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            
        }
        
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureUI() {
        
        contentView.backgroundColor = UIColor(hex: "EAEAEA")
        
        titleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = UIColor(hex: "565656")
        
        valueLabel.font = .systemFont(ofSize: 12, weight: .regular)
        valueLabel.textColor = UIColor(hex: "565656")
    }
    
    func setup(model: Model) {
        titleLabel.text = model.title
        valueLabel.text = model.subtitile
    }
}
