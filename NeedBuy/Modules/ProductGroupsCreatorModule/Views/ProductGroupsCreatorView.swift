//
//  ProductGroupsCreatorView.swift
//  NeedBuy
//
//  Created by alexKoro on 12.09.22.
//

import UIKit

class ProductGroupsCreatorView: UIView {
    
    var tableView =  UITableView()
    var saveButton = RoundButton()
    var addComponentButton = RoundButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupTableView()
        setupAddComponentButton()
        setupSaveButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupAddComponentButton() {
        self.addSubview(addComponentButton)
        addComponentButton.translatesAutoresizingMaskIntoConstraints = false
        addComponentButton.setTitle("Add component", for: .normal)
        addComponentButton.backgroundColor = .black
        addComponentButton.isEnabled = true
        setupAddComponentButtonConstraints()
    }
    
    private func setupAddComponentButtonConstraints() {
        NSLayoutConstraint.activate([
            addComponentButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            addComponentButton.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 20),
            addComponentButton.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: -20),
            addComponentButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func setupSaveButton() {
        self.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .black
        setupSaveButtonConstraints()
    }
    
    private func setupSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: addComponentButton.bottomAnchor, constant: 20),
            saveButton.leftAnchor.constraint(equalTo: addComponentButton.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: addComponentButton.rightAnchor),
            saveButton.heightAnchor.constraint(equalTo: addComponentButton.heightAnchor)
        ])
    }
    
    
    
}
