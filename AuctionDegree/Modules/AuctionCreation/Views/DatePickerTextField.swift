//
//  DatePickerTextField.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 19.02.2022.
//

import Foundation
import UIKit
import SnapKit

class DatePickerTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private var datePickerView = UIDatePicker()
    private let toolBar = UIToolbar()
    private let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .short
        
        datePickerView.preferredDatePickerStyle = .wheels
        inputView = datePickerView
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
    
    private func configureUI() {
        layer.cornerRadius = 15
        font = .systemFont(ofSize: 14, weight: .semibold)
        textColor = UIColor(hex: "565656")
        backgroundColor = UIColor(hex: "EAEAEA")
        self.attributedPlaceholder = NSAttributedString(string: "Дата окончания", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "565656")])
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
        self.text = "\(datePickerView.date)"
        resignFirstResponder()
    }
    
    @objc
    private func cancelTapped() {
        resignFirstResponder()
    }
}
