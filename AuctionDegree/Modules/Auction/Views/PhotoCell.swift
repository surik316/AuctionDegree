//
//  PhotoCell.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation
import Foundation
import UIKit

final class PhotoCell: UICollectionViewCell {
    private let propertyImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        contentView.addSubview(propertyImageView)
        propertyImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 34
        contentView.backgroundColor = UIColor(hex: "EAEAEA")
    }
    
    func configure(image: UIImage) {
        propertyImageView.image = image
    }
}
