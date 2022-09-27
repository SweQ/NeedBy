//
//  PropertyView.swift
//  NeedBuy
//
//  Created by alexKoro on 22.09.22.
//

import UIKit

class PropertyView: UIView {
    
    private let titleLabel = UILabel()
    let valueTextField = UITextField()
    
    init(placeholder: String?, title: String) {
        super.init(frame: .zero)
        setupLabel(with: title)
        setupTextField(with: placeholder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(with title: String) {
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.applyTitleFont()
        setupLabelAnchors()
    }
    
    private func setupLabelAnchors() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func setupTextField(with placeholder: String?) {
        addSubview(valueTextField)
        valueTextField.isEnabled = false
        valueTextField.placeholder = placeholder ?? ""
        valueTextField.layer.cornerRadius = 5
        valueTextField.layer.borderColor = UIColor.lightGray.cgColor
        valueTextField.layer.borderWidth = 0
        valueTextField.indentLeft(size: 10)
        valueTextField.indentRight(size: 5)
        valueTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        valueTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        setupTextFieldAnchors()
    }
    
    private func setupTextFieldAnchors() {
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            valueTextField.leftAnchor.constraint(equalTo: leftAnchor),
            valueTextField.rightAnchor.constraint(equalTo: rightAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count > 15 {
            textField.text = text.prefix(15).description
        }
    }
}
