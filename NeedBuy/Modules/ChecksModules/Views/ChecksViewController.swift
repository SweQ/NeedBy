//
//  ChecksViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import UIKit

class ChecksViewController: UIViewController {
    
    let checksView = BigTableView()
    var presenter: ChecksPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChecksView()
        setupBar()
    }
    
    private func setupBar() {
        setupTitle(title: Words.checksTitle.value())
    }
    
    private func setupChecksView() {
        view.addSubview(checksView)
        
        setupChecksViewConstraints()
        setupTableView()
    }
    
    private func setupTableView() {
        checksView.tableView.register(CheckTableViewCell.self, forCellReuseIdentifier: CheckTableViewCell.identifier)

        checksView.tableView.delegate = self
        checksView.tableView.dataSource = self
    }
    
    private func setupChecksViewConstraints() {
        checksView.setupTotalConstraints(with: view)
    }

}

//MARK: -ChecksViewControllerProtocol
extension ChecksViewController: ChecksViewControllerProtocol {
    var tableView: UITableView? {
        return checksView.tableView
    }
}

//MARK: -UITableViewDelegate and DataSource
extension ChecksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getChecksCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckTableViewCell.identifier
        ) as? CheckTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.dateLabel.text = presenter?.getChecksTitle(at: indexPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openCheck(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: Words.deleteTitle.value())
        { [weak self] _, _, _ in
            self?.presenter?.deleteCheck(at: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
