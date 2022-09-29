//
//  ProductDetailsView.swift
//  NeedBuy
//
//  Created by alexKoro on 21.09.22.
//

import Foundation
import UIKit

class ProductDetailsView: UIView {
    
    var nameTextField: UITextField {
        return namePropertyView.valueTextField
    }
    var costTextField: UITextField {
        return costPropertyView.valueTextField
    }
    var measureTextField: UITextField {
        return measurePropertyView.valueTextField
    }
    
    let namePropertyView = PropertyView(placeholder: "\(Words.nameTitle.value())*", title: Words.nameTitle.value())
    let costPropertyView = PropertyView(placeholder: "\(Words.costTitle.value()) (\(Words.defaultWord.value()) 0)",
                                        title: Words.costTitle.value())
    let measurePropertyView = PropertyView(placeholder: "\(Words.measureTitle.value()) (\(Words.defaultWord.value()) \(Words.pcs.value()).)",
                                           title: Words.measureTitle.value())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameProperty()
        setupCostProperty()
        setupMeasureProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: -Setup Name
    private func setupNameProperty() {
        addSubview(namePropertyView)
        setupNamePropertyAnchors()
    }
    
    private func setupNamePropertyAnchors() {
        namePropertyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namePropertyView.topAnchor.constraint(equalTo: topAnchor),
            namePropertyView.leftAnchor.constraint(equalTo: leftAnchor),
            namePropertyView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//MARK: -Setup Cost
    private func setupCostProperty() {
        addSubview(costPropertyView)
        costTextField.keyboardType = .decimalPad
        costTextField.setupCancelToolbar()
        setupCostPropertyAnchors()
    }
    
    private func setupCostPropertyAnchors() {
        costPropertyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            costPropertyView.topAnchor.constraint(equalTo: namePropertyView.bottomAnchor, constant: 10),
            costPropertyView.widthAnchor.constraint(equalTo: namePropertyView.widthAnchor),
            costPropertyView.centerXAnchor.constraint(equalTo: namePropertyView.centerXAnchor),
            costPropertyView.heightAnchor.constraint(equalTo: namePropertyView.heightAnchor)
        ])
    }
    
//MARK: -Setup Measure
    private func setupMeasureProperty() {
        addSubview(measurePropertyView)
        measureTextField.inputView = UIView(frame: .zero)
        setupMeasurePropertyAnchors()
    }
    
    private func setupMeasurePropertyAnchors() {
        measurePropertyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            measurePropertyView.topAnchor.constraint(equalTo: costPropertyView.bottomAnchor, constant: 10),
            measurePropertyView.widthAnchor.constraint(equalTo: namePropertyView.widthAnchor),
            measurePropertyView.centerXAnchor.constraint(equalTo: namePropertyView.centerXAnchor),
            measurePropertyView.heightAnchor.constraint(equalTo: namePropertyView.heightAnchor)
        ])
    }
}
