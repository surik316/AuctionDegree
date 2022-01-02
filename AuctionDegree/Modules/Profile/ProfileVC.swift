//
//  ProfileVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 02.01.2022.
//

import Foundation
import UIKit
import SnapKit

class ProfileVC: UIViewController {
    enum Navigation {
        case myAuctions
        case myHistory
        case editProfile
        case notifications
        case createAuction
    }
    private let userImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let functionLabel = UILabel()
    private let functionsStackView = UIStackView()
    private let historyStackView = UIStackView()
    private let logoView = LogoView()
    private let myAuctionView = ProfileElementView()
    private let myHistoryView = ProfileElementView()
    private let editProfileView = ProfileElementView()
    private let notificationsView = ProfileElementView()
    private let createAuctionButton = EntranceButton()
    
    var viewModel = ProfileViewModel()
    var navigation: ((Navigation) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchModel()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(33)
            make.width.equalTo(108)
        }
        
        view.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(72)
        }
        
        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(historyStackView)
        historyStackView.addArrangedSubview(myAuctionView)
        historyStackView.addArrangedSubview(myHistoryView)
        
        historyStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(userNameLabel.snp.bottom).offset(40)
            make.height.equalTo(79)
        }
        
        view.addSubview(functionLabel)
        functionLabel.snp.makeConstraints { make in
            make.leading.equalTo(historyStackView)
            make.top.equalTo(historyStackView.snp.bottom).offset(30)
        }
        
        view.addSubview(functionsStackView)
        functionsStackView.addArrangedSubview(editProfileView)
        functionsStackView.addArrangedSubview(notificationsView)
        
        functionsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(functionLabel.snp.bottom).offset(20)
            make.height.equalTo(79)
        }
        
        view.addSubview(createAuctionButton)
        createAuctionButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        userImageView.layer.cornerRadius = 36
        userImageView.clipsToBounds = true
        userImageView.image = UIImage(named: "another")
        
        historyStackView.backgroundColor = UIColor(hex: "EAEAEA")
        historyStackView.distribution = .fillEqually
        historyStackView.axis = .vertical
        historyStackView.layer.cornerRadius = 15
        historyStackView.isUserInteractionEnabled = true
        
        functionsStackView.backgroundColor = UIColor(hex: "EAEAEA")
        functionsStackView.distribution = .fillEqually
        functionsStackView.axis = .vertical
        functionsStackView.layer.cornerRadius = 15
        functionsStackView.isUserInteractionEnabled = true
        
        userNameLabel.font = .systemFont(ofSize: 27, weight: .medium)
        userNameLabel.text = (viewModel.model!.firstName + " " + viewModel.model!.secondName)
        userNameLabel.textColor = UIColor(hex: "565656")
        userNameLabel.textColor = UIColor(hex: "565656")
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(auctionsTapped(_:)))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(historyTapped(_:)))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(editProfileTapped(_:)))
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(notificationsTapped(_:)))
        myAuctionView.textLabel.text = "Мои Аукционы"
        myAuctionView.addGestureRecognizer(tapGesture1)
        
        myHistoryView.textLabel.text = "История Действий"
        myHistoryView.addGestureRecognizer(tapGesture2)
    
        editProfileView.textLabel.text = "Редактировать данные"
        editProfileView.addGestureRecognizer(tapGesture3)
        
        notificationsView.textLabel.text = "Уведомления"
        notificationsView.addGestureRecognizer(tapGesture4)
        
        functionLabel.textAlignment = .left
        functionLabel.text = "Функции"
        functionLabel.font = .systemFont(ofSize: 22, weight: .medium)
        functionLabel.textColor = UIColor(hex: "565656")
        
        createAuctionButton.nameLabel.text = "Создать аукцион"
        createAuctionButton.addTarget(self, action: #selector(createAuctionTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func auctionsTapped(_ sender: UITapGestureRecognizer) {
        navigation(.myAuctions)?
    }
    
    @objc
    private func historyTapped(_ sender: UITapGestureRecognizer) {
        navigation(.myHistory)?
    }
    
    @objc
    private func editProfileTapped(_ sender: UITapGestureRecognizer) {
        navigation(.editProfile)?
    }
    
    @objc
    private func notificationsTapped(_ sender: UITapGestureRecognizer) {
        navigation(.notifications)?
    }
    @objc
    private func createAuctionTapped(_ sender: UITapGestureRecognizer) {
        navigation(.createAuction)?
    }
}
