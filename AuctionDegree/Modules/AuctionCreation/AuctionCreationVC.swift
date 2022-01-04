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
        case dismiss
    }
    
    private let logoView = LogoView()
    private let titleLabel = UILabel()
    private let nameTextField = AuthTextField(type: .nameTextField)
    private let fuelTextField = AuthTextField(type: .fuelTextField)
    private let engineCapacityTextField = AuthTextField(type: .engineCapacityTextField)
    private let boxTypeCarTextField = AuthTextField(type: .boxTypeCarTextField)
    private let mileageTextField = AuthTextField(type: .mileageTextField)
    private let customCollectionView = UIImageView()
    private let canOnTextField = AuctionCreationTextField()
    private let canDriveTextField = AuctionCreationTextField()
    private let createButton = EntranceButton()
    private let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 20.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 0.0, left: 0.0, bottom: -65.0, right: 0.0)
        )
        return ScrollableStackView(config: config)
    }()
    private let horizontalStackView = UIStackView()
    
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
        view.addSubview(scrollableStackView)
        scrollableStackView.snp.makeConstraints { make in
            make.top.equalTo(customCollectionView.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
            make.leading.equalTo(customCollectionView.snp.leading)
            make.trailing.equalTo(customCollectionView.snp.trailing)
        }
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 20
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.addArrangedSubview(canOnTextField)
        horizontalStackView.addArrangedSubview(canDriveTextField)
        
        scrollableStackView.scrollView.showsVerticalScrollIndicator = false
        scrollableStackView.addArrangedSubview(nameTextField)
        scrollableStackView.addArrangedSubview(horizontalStackView)
        scrollableStackView.addArrangedSubview(fuelTextField)
        scrollableStackView.addArrangedSubview(engineCapacityTextField)
        scrollableStackView.addArrangedSubview(boxTypeCarTextField)
        scrollableStackView.addArrangedSubview(mileageTextField)
        nameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        canOnTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        canDriveTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        [fuelTextField, engineCapacityTextField, boxTypeCarTextField, mileageTextField].forEach { el in
            el.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(40)
            }
        }
        
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(55)
        }
        
        let backNavigationItem = UIBarButtonItem(
            image: UIImage(named: "back_rounded")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(goBackPressed)
        )
        backNavigationItem.tintColor = .white
        navigationItem.leftBarButtonItem = backNavigationItem
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.text = "Создание аукциона"
        titleLabel.textColor = UIColor(hex: "565656")
        
        canOnTextField.attributedPlaceholder = NSAttributedString(string: "Заводится", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
        canDriveTextField.attributedPlaceholder = NSAttributedString(string: "На ходу", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
        
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
    
    @objc
    private func goBackPressed() {
        navigation?(.dismiss)
    }
}
