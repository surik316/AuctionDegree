//
//  AuctionCreationVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 03.01.2022.
//

import Foundation
import UIKit
import SnapKit

class AuctionCreationVC: UIViewController {
    enum Navigation {
        case create
        case setImage
    }
    
    private let logoView = LogoView()
    private let titleLabel = UILabel()
    private let nameTextField = AuthTextField()
    private let fuelTextField = AuthTextField()
    private let engineCapacityTextField = AuthTextField()
    private let boxTypeCarTextField = AuthTextField()
    private let mileageTextField = AuthTextField()
    private let customCollectionView = UIImageView()
    private let canOnTextField = AuctionCreationTextField()
    private let canDriveTextField = AuctionCreationTextField()
    private let createButton = EntranceButton()
    
    var viewModel = AuctionCreationViewModel()
    var navigation: ((Navigation) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.equalTo(108)
            make.height.equalTo(33)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoView.snp.bottom).offset(60)
        }
        
        view.addSubview(customCollectionView)
        customCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(217)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(customCollectionView.snp.trailing)
            make.top.equalTo(customCollectionView.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        view.addSubview(canOnTextField)
        canOnTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
            make.height.equalTo(40)
        }
        view.addSubview(canDriveTextField)
        canDriveTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.trailing.equalTo(customCollectionView.snp.trailing)
            make.leading.equalTo(view.snp.centerX).offset(5)
            make.height.equalTo(40)
        }
        
        view.addSubview(fuelTextField)
        fuelTextField.snp.makeConstraints { make in
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(customCollectionView.snp.trailing)
            make.top.equalTo(canOnTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
        }

        view.addSubview(engineCapacityTextField)
        engineCapacityTextField.snp.makeConstraints { make in
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(customCollectionView.snp.trailing)
            make.top.equalTo(fuelTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
        }

        view.addSubview(boxTypeCarTextField)
        boxTypeCarTextField.snp.makeConstraints { make in
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(customCollectionView.snp.trailing)
            make.top.equalTo(engineCapacityTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
        }

        view.addSubview(mileageTextField)
        mileageTextField.snp.makeConstraints { make in
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(customCollectionView.snp.trailing)
            make.top.equalTo(boxTypeCarTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-60)
            make.height.equalTo(65)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.text = "Создание аукциона"
        titleLabel.textColor = UIColor(hex: "565656")
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Название", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        canOnTextField.attributedPlaceholder = NSAttributedString(string: "Заводится", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        canDriveTextField.attributedPlaceholder = NSAttributedString(string: "На ходу", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        fuelTextField.attributedPlaceholder = NSAttributedString(string: "Топливо", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        engineCapacityTextField.attributedPlaceholder = NSAttributedString(string: "Обьем двигателя", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        boxTypeCarTextField.attributedPlaceholder = NSAttributedString(string: "Тип коробки", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        mileageTextField.attributedPlaceholder = NSAttributedString(string: "Пробег", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        customCollectionView.image = UIImage(named: "car")
        customCollectionView.layer.cornerRadius = 15
        customCollectionView.clipsToBounds = true
        
        createButton.addTarget(self, action: #selector(createTapped(_:)), for: .touchUpInside)
        createButton.nameLabel.text = "Создать"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        fuelTextField.resignFirstResponder()
        engineCapacityTextField.resignFirstResponder()
        boxTypeCarTextField.resignFirstResponder()
        mileageTextField.resignFirstResponder()
    }
    
    @objc
    private func createTapped(_ sender: UITapGestureRecognizer) {
        navigation?(.create)
    }
}
