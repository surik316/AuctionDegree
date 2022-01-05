//
//  GetTypeCarVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 05.01.2022.
//

import Foundation
import SnapKit
import UIKit
import Vision

class GetTypeCarVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    enum Navigation {
        case takePhoto
        case getCarType
        case dismiss
    }
    private let photoImageView = UIImageView()
    private let takePhotoButton = PhotoButton()
    private let takePhotoFromLibraryButton = PhotoButton()
    private let stackView = UIStackView()
    private let getTypeCarButton = EntranceButton()
    private let carNumberTextField = CarNumberTextField()
    private let viewWithImage = UIView()
    
    var navigation: ((Navigation) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    private func setupUI() {
        view.addSubview(viewWithImage)
        viewWithImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(400)
        }
        viewWithImage.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(takePhotoButton)
        stackView.addArrangedSubview(takePhotoFromLibraryButton)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(viewWithImage.snp.bottom).offset(20)
            make.leading.equalTo(viewWithImage.snp.leading)
            make.trailing.equalTo(viewWithImage.snp.trailing)
            make.height.equalTo(50)
        }
        view.addSubview(getTypeCarButton)
        getTypeCarButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(stackView.snp.leading).offset(15)
            make.trailing.equalTo(stackView.snp.trailing).offset(-15)
            make.height.equalTo(50)
        }
        
        view.addSubview(carNumberTextField)
        carNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(getTypeCarButton.snp.bottom).offset(20)
            make.leading.equalTo(getTypeCarButton.snp.leading)
            make.height.equalTo(50)
            make.width.equalTo(250)
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
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        takePhotoButton.nameLabel.text = "Сделать Фото"
        takePhotoButton.nameLabel.textColor = .black
        takePhotoButton.nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        takePhotoButton.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
        
        takePhotoFromLibraryButton.nameLabel.text = "Галерея"
        takePhotoFromLibraryButton.nameLabel.textColor = .black
        takePhotoFromLibraryButton.nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        takePhotoFromLibraryButton.addTarget(self, action: #selector(getPhotoTapped), for: .touchUpInside)
        
        getTypeCarButton.nameLabel.text = "Узнать марку машины"
        getTypeCarButton.nameLabel.textColor = .white
        getTypeCarButton.nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        
        viewWithImage.backgroundColor = .gray
        viewWithImage.layer.cornerRadius = 14
        
        photoImageView.layer.cornerRadius = 14
        photoImageView.clipsToBounds = true
        
        carNumberTextField.attributedPlaceholder =
        NSAttributedString(string: " Номер машины", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc
    private func takePhotoTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @objc
    private func getPhotoTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @objc
    private func goBackPressed() {
        navigation?(.dismiss)
    }
    
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        carNumberTextField.resignFirstResponder()
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/1.2
            }
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photoImageView.contentMode = .scaleToFill
            photoImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        recognizeText(image: photoImageView.image)
    }
    private func recognizeText(image: UIImage?) {
        guard let image = image?.cgImage else { return }
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        let request = VNRecognizeTextRequest { [weak self ] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                return
            }
            let text = observations.compactMap ({
                $0.topCandidates(1).first?.string
            }).joined(separator: " ")
            DispatchQueue.main.async {
                self?.carNumberTextField.text = text
            }
        }
        request.recognitionLanguages = ["en-US", "ru-RU"]
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
