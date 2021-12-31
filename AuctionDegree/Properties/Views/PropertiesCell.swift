//
//  PropertiesCell.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit
import SnapKit

class PropertiesCell: UITableViewCell {
    private let propertyImageView = UIImageView()
    private let favouriteButton = UIButton()
    private let propertyName = UILabel()
    private let startTitleLable = UILabel()
    private let startValueLable = UILabel()
    private let endTitleLable = UILabel()
    private let endValueLable = UILabel()
    private let detailButton = EntranceButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        
        addSubview(propertyImageView)
        propertyImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(230)
        }
        
        addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { make in
            make.width.equalTo(14)
            make.height.equalTo(23)
            make.top.equalTo(propertyImageView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-9)
        }
        
        addSubview(propertyName)
        propertyName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(propertyImageView.snp.bottom).offset(15)
        }
        
        addSubview(startTitleLable)
        startTitleLable.snp.makeConstraints { make in
            make.leading.equalTo(propertyName.snp.leading)
            make.top.equalTo(propertyName.snp.bottom).offset(15)
        }
        
        addSubview(startValueLable)
        startValueLable.snp.makeConstraints { make in
            make.leading.equalTo(startTitleLable.snp.leading)
            make.top.equalTo(startTitleLable.snp.bottom).offset(4)
        }
        
        addSubview(endTitleLable)
        endTitleLable.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX)
            make.top.equalTo(startTitleLable.snp.top)
        }
        
        addSubview(endValueLable)
        endValueLable.snp.makeConstraints { make in
            make.leading.equalTo(endTitleLable.snp.leading)
            make.top.equalTo(startValueLable.snp.top)
        }
        
        addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(46)
        }
    }
    private func configureUI() {
        backgroundColor = UIColor(hex: "1E1E1E")
        layer.cornerRadius = 34
        
        propertyName.font = .systemFont(ofSize: 22, weight: .bold)
        propertyName.textColor = .white
        
        startTitleLable.font = .systemFont(ofSize: 12, weight: .regular)
        startTitleLable.text = "Осталось:"
        
        startValueLable.font = .systemFont(ofSize: 12, weight: .regular)
        
        
        endTitleLable.font = .systemFont(ofSize: 12, weight: .regular)
        endTitleLable.text = "Завершение:"
        
        endValueLable.font = .systemFont(ofSize: 12, weight: .regular)
        
        propertyImageView.layer.cornerRadius = 34
    }
    
    func setUpCell(model: PropertiesModel) {
        propertyImageView.image = model.image
        propertyName.text = model.name
        endValueLable.text = model.endDate
        model.isFavourite ? favouriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal) : favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        startValueLable.text = "4 дня"
    }
}
