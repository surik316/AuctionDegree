//
//  ProfileLabel.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 02.01.2022.
//

import Foundation
import UIKit

class ProfileElementView: UIView {
    private let imageView = UIImageView()
    var textLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        isUserInteractionEnabled = true
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        textLabel.textAlignment = .left
        textLabel.font = .systemFont(ofSize: 17, weight: .regular)
        textLabel.textColor = UIColor(hex: "565656")
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(14)
            make.width.equalTo(10)
        }
        imageView.image = UIImage(named: "rightArrow")!
    }
}
