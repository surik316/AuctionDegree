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
    private let nameTextField = CustomTextField(type: .nameTextField)
    private let modelTextField = CustomTextField(type: .model)
    private let yearTextField = CustomTextField(type: .nameTextField)
    private let manufacturerTextField = CustomTextField(type: .manufactured)
    private let fuelTextField = CustomTextField(type: .fuelTextField)
    private let engineCapacityTextField = CustomTextField(type: .engineCapacityTextField)
    private let boxTypeCarTextField = CustomTextField(type: .boxTypeCarTextField)
    private let mileageTextField = CustomTextField(type: .mileageTextField)
    private let customCollectionView = UIImageView()
    private let canOnTextField = AuctionCreationTextField()
    private let canDriveTextField = AuctionCreationTextField()
    private let expirationDate = DatePickerTextField()
    private let createButton = EntranceButton()
    private let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 20.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        )
        return ScrollableStackView(config: config)
    }()
    private let horizontalStackView = UIStackView()
    
    var viewModel : AuctionCreationViewModelProtocol = AuctionCreationViewModel()
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
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(55)
        }
        
        view.addSubview(scrollableStackView)
        scrollableStackView.snp.makeConstraints { make in
            make.top.equalTo(customCollectionView.snp.bottom).offset(15)
            make.bottom.equalTo(createButton.snp.top).offset(-10)
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
        scrollableStackView.addArrangedSubview(modelTextField)
        scrollableStackView.addArrangedSubview(manufacturerTextField)
        scrollableStackView.addArrangedSubview(yearTextField)
        scrollableStackView.addArrangedSubview(horizontalStackView)
        scrollableStackView.addArrangedSubview(fuelTextField)
        scrollableStackView.addArrangedSubview(engineCapacityTextField)
        scrollableStackView.addArrangedSubview(boxTypeCarTextField)
        scrollableStackView.addArrangedSubview(mileageTextField)
        scrollableStackView.addArrangedSubview(expirationDate)
        
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
        [fuelTextField, engineCapacityTextField,
         boxTypeCarTextField, mileageTextField,
         modelTextField, yearTextField,
         manufacturerTextField,
         expirationDate].forEach { el in
            el.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(40)
            }
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func createTapped(_ sender: UITapGestureRecognizer) {
        viewModel.loadModel(name: nameTextField.text ?? "",
                            manufacturer: manufacturerTextField.text ?? "",
                            model: modelTextField.text ?? "",
                            year: yearTextField.text ?? "",
                            itemNumber: "",
                            starting: canOnTextField.text ?? "",
                            fuelType: fuelTextField.text ?? "",
                            engineCapacity: engineCapacityTextField.text ?? "",
                            transmissionType: boxTypeCarTextField.text ?? "",
                            mileage: mileageTextField.text ?? "",
                            endDate: expirationDate.text ?? "")
        viewModel.createAuction { [weak self] in
            self?.navigation?(.create)
        }
    }
    
    @objc
    private func goBackPressed() {
        navigation?(.dismiss)
    }
    
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
        fuelTextField.resignFirstResponder()
        engineCapacityTextField.resignFirstResponder()
        boxTypeCarTextField.resignFirstResponder()
        mileageTextField.resignFirstResponder()
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/1.6
            }
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
