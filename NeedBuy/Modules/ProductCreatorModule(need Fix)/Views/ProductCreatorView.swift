//
//  ProductCreatorView.swift
//  NeedBuy
//
//  Created by alexKoro on 19.08.22.
//

import UIKit

class ProductCreatorView: UIView {
    
    let productImageView = UIImageView()
    let changeImageButton = RoundButton()
    let productDetailsView = ProductDetailsView()
    var costTextField: UITextField {
        return productDetailsView.costTextField
    }
    var measureTextField: UITextField {
        return productDetailsView.measureTextField
    }
    var nameTextField: UITextField {
        return productDetailsView.nameTextField
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .white
        setupImageView()
        setupChangeImageButton()
        setupProductDetailsView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func editMode(isOn: Bool) {
        editModeFor(textField: nameTextField, isOn: isOn)
        editModeFor(textField: costTextField, isOn: isOn)
        editModeFor(textField: measureTextField, isOn: isOn)

        changeImageButton.isHidden = !isOn
    }
    
    private func editModeFor(textField: UITextField, isOn: Bool) {
        textField.layer.borderWidth = isOn ? 0.2 : 0
        textField.isEnabled = isOn
    }
    
    private func setupImageView() {
        
        addSubview(productImageView)
        
        productImageView.image = UIImage(named: "product")
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.borderColor = UIColor.lightGray.cgColor
        productImageView.clipsToBounds = true
        productImageView.isUserInteractionEnabled = true
        setupImageViewAnchors()
    }
    
    private func setupImageViewAnchors() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            productImageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func setupChangeImageButton() {
        productImageView.addSubview(changeImageButton)
        changeImageButton.setTitle("Change image", for: .normal)
        changeImageButton.setTitleColor(.black, for: .normal)
        changeImageButton.titleLabel?.adjustsFontSizeToFitWidth = true
        changeImageButton.setTitleColor(.lightGray, for: .highlighted)
        changeImageButton.backgroundColor = .white
        changeImageButton.isHidden = true
        setupChangeButtonAnchors()
    }
    
    private func setupChangeButtonAnchors() {
        changeImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeImageButton.heightAnchor.constraint(equalToConstant: 36),
            changeImageButton.widthAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 0.5),
            changeImageButton.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            changeImageButton.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor)
        ])
    }
    
    private func setupProductDetailsView() {
        addSubview(productDetailsView)
        setupProductDetailsAnchors()
    }
    
    private func setupProductDetailsAnchors() {
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productDetailsView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productDetailsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            productDetailsView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            productDetailsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
