//
//  AuctionCreationTextField.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 03.01.2022.
//

import Foundation
import UIKit
import SnapKit

class AuctionCreationTextField: UITextField {
    
    
    let imageView = UIImageView()
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private let pickerView = UIPickerView()
    private let data = ["none", "True", "False"]
    private let toolBar = UIToolbar()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(15)
            make.width.equalTo(12)
        }
    }
    
    private func configureUI() {
        imageView.image = UIImage(named: "downArrow")
        pickerView.delegate = self
        pickerView.dataSource = self
        inputView = pickerView
        layer.cornerRadius = 15
        font = .systemFont(ofSize: 14, weight: .semibold)
        textColor = UIColor(hex: "565656")
        backgroundColor = UIColor(hex: "EAEAEA")
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @objc
    private func doneTapped() {
        resignFirstResponder()
    }
    
    @objc
    private func cancelTapped() {
        resignFirstResponder()
    }
}

extension AuctionCreationTextField: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            self.text = ""
        } else {
            self.text = data[row]
        }
    }
}

extension AuctionCreationTextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}
