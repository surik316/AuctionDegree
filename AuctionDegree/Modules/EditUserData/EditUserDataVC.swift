//
//  EditUserDataVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 21.02.2022.
//

import Foundation
import UIKit
import SnapKit

class EditUserDataVC: UIViewController {
    enum Action {
        case back
        case apply
    }
    private let usernameTextField = CustomTextField()
    private let changePhotoImageView = UIImageView()
    private let applyChangesButton = EntranceButton()
    
    var navigation: ((Action) -> Void)?
    var viewModel: EditUserDataViewModelProtocol = EditUserDataViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(changePhotoImageView)
        changePhotoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(changePhotoImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        view.addSubview(applyChangesButton)
        applyChangesButton.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(65)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        usernameTextField.text = "Имя"
        changePhotoImageView.layer.cornerRadius = 16
        changePhotoImageView.contentMode = .scaleToFill
        changePhotoImageView.image = UIImage(named: "emptyPhoto")
        
        let backNavigationItem = UIBarButtonItem(
            image: UIImage(named: "back_rounded")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
        backNavigationItem.tintColor = .white
        navigationItem.leftBarButtonItem = backNavigationItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
        
        applyChangesButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
        applyChangesButton.configure(title: "Подтвердить изменения")
        
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        changePhotoImageView.addGestureRecognizer(imageGesture)
    }
    
    @objc
    private func backAction() {
        navigation?(.back)
    }
    
    @objc
    private func imageTapped() {
        
    }
    
    @objc
    private func apply() {
        viewModel.updateUserData(username: usernameTextField.text, image: changePhotoImageView.image) { [weak self]  in
            self?.navigation?(.apply)
        }
    }
    
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        usernameTextField.resignFirstResponder()
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
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
