//
//  PropertiesCell.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit
import SnapKit

final class PropertiesCell: UITableViewCell {
    private let propertyImageView = UIImageView()
    private let favouriteButton = UIButton()
    private let propertyName = UILabel()
    private let startTitleLable = UILabel()
    private let startValueLable = UILabel()
    private let endTitleLable = UILabel()
    private let endValueLable = UILabel()
    private let detailButton = EntranceButton()
    private let dateFormatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        
        contentView.addSubview(propertyImageView)
        propertyImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(230)
        }

        contentView.addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(28)
            make.top.equalTo(propertyImageView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-9)
        }

        contentView.addSubview(propertyName)
        propertyName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(propertyImageView.snp.bottom).offset(15)
        }

        contentView.addSubview(startTitleLable)
        startTitleLable.snp.makeConstraints { make in
            make.leading.equalTo(propertyName.snp.leading)
            make.top.equalTo(propertyName.snp.bottom).offset(15)
        }
        
        contentView.addSubview(startValueLable)
        startValueLable.snp.makeConstraints { make in
            make.leading.equalTo(startTitleLable.snp.leading)
            make.top.equalTo(startTitleLable.snp.bottom).offset(4)
        }

        contentView.addSubview(endTitleLable)
        endTitleLable.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX)
            make.top.equalTo(startTitleLable.snp.top)
        }

        contentView.addSubview(endValueLable)
        endValueLable.snp.makeConstraints { make in
            make.leading.equalTo(endTitleLable.snp.leading)
            make.top.equalTo(startValueLable.snp.top)
        }
        
        contentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(46)
        }
    }
    private func configureUI() {
        contentView.backgroundColor = UIColor(hex: "565656")
        contentView.layer.cornerRadius = 34
        backgroundColor = .white
        
        propertyName.font = .systemFont(ofSize: 22, weight: .bold)
        propertyName.textColor = .white
        
        startTitleLable.font = .systemFont(ofSize: 12, weight: .regular)
        startTitleLable.text = "Осталось:"
        
        startValueLable.font = .systemFont(ofSize: 12, weight: .regular)
        
        
        endTitleLable.font = .systemFont(ofSize: 12, weight: .regular)
        endTitleLable.text = "Завершение:"
        
        endValueLable.font = .systemFont(ofSize: 12, weight: .regular)
        
        propertyImageView.layer.cornerRadius = 34
        propertyImageView.layer.masksToBounds = true
        detailButton.nameLabel.text = "Подробнее"
        
        selectionStyle = .none
    }
    
    func setUpCell(model: PropertiesModel) {
        if model.image != nil {
            
        } else {
            propertyImageView.image = UIImage(named: "car")!
        }
        propertyName.text = model.name
        endValueLable.text = model.endDate
        favouriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        startValueLable.text = getNormalDate(str: model.endDate ?? "")
    }
    
    func getNormalDate(str: String) -> String {
        guard let date = dateFormatter.date(from: str) else {return ""}
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        return dateFormatter.string(from: date)
    }
}
