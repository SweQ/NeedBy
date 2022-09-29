//
//  PurchaseCreatorView.swift
//  NeedBuy
//
//  Created by alexKoro on 5.09.22.
//

import UIKit

class PurchaseCreatorView: UIView {
    
    let tableView = UITableView()
    let datePicker = UIDatePicker()
    let backButton = UIButton()
    let nextButton = UIButton()
    let createButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDatePicker()
        setupProductsTableView()
        setupButtons()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupButtons() {
        setupNextButton()
        setupBackButton()
        setupCreateButton()
    }
    
    private func setupCreateButton() {
        self.addSubview(createButton)
        
        createButton.setupStyleForPurchaseView(
            with: Words.createTitle.value(),
            textColor: .white
        )
        createButton.isHidden = true
        setupCreateButtonConstraints()
    }
    
    private func setupCreateButtonConstraints() {
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createButton.heightAnchor.constraint(equalTo: nextButton.heightAnchor),
            createButton.widthAnchor.constraint(equalTo: nextButton.widthAnchor),
            createButton.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            createButton.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor)
        ])
    }
    
    private func setupNextButton() {
        self.addSubview(nextButton)
        
        nextButton.setupStyleForPurchaseView(
            with: Words.nextTitle.value(),
            textColor: .white
        )
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupNextButtonConstraints()
    }
    
    private func setupNextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            nextButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            nextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
    }
    
    private func setupBackButton() {
        self.addSubview(backButton)
        backButton.isHidden = true
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setupStyleForPurchaseView(
            with: Words.backTitle.value(),
            textColor: .white
        )
        
        setupBackButtonConstraints()
    }
    
    private func setupBackButtonConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 10),
            backButton.leftAnchor.constraint(equalTo: nextButton.leftAnchor),
            backButton.rightAnchor.constraint(equalTo: nextButton.rightAnchor),
            backButton.heightAnchor.constraint(equalTo: nextButton.heightAnchor)
        ])
    }
    
    private func setupDatePicker() {
        //datePicker.isHidden = true
        
        datePicker.datePickerMode = .date
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = Date.now
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(datePicker)
        
        setupDatePickerConstraints()
    }
    
    private func setupDatePickerConstraints() {
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            datePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            datePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }

    private func setupProductsTableView() {
        
        self.addSubview(tableView)
        
        tableView.isHidden = true
        
        tableView.register(ProductInBasketViewCell.self, forCellReuseIdentifier: ProductInBasketViewCell.identifier)
        tableView.register(AddProductTableViewCell.self, forCellReuseIdentifier: AddProductTableViewCell.identifier)

        setupTableViewConstraints()
        
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: datePicker.topAnchor),
            tableView.heightAnchor.constraint(equalTo: datePicker.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: datePicker.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: datePicker.centerXAnchor)
        ])
    }
}
