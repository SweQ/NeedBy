//
//  CheckDetailsViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 8.09.22.
//

import UIKit

class CheckDetailsViewController: UIViewController {
    
    let checkDetailsView = CheckDetailsView()
    var presenter: CheckDetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCheckDetailsView()
        setupBar()
    }
    
    private func setupBar() {
        title = presenter?.getCheckTitle() ?? "-"
        navigationController?.navigationBar.prefersLargeTitles = true
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    private func setupCheckDetailsView() {
        view.addSubview(checkDetailsView)
        
        checkDetailsView.tableView.dataSource = self
        checkDetailsView.tableView.delegate = self
        
        checkDetailsView.tableView.register(
            CheckDetailsTableViewCell.self,
            forCellReuseIdentifier: CheckDetailsTableViewCell.identifier)
        checkDetailsView.tableView.register(
            CheckPriceTableViewCell.self,
            forCellReuseIdentifier: CheckPriceTableViewCell.identifier)
        
        setupCheckDetailsViewConstraints()
    }
    
    private func setupCheckDetailsViewConstraints() {
        checkDetailsView.setupTotalConstraints(with: view)
    }

}

//MARK: -UITableViewDelegate and DataSource
extension CheckDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 1.0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter?.getPurchaseProductsCount() ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CheckDetailsTableViewCell.identifier
            ) as? CheckDetailsTableViewCell,
                  let purchasedProduct = presenter?.getPurchasedProduct(at: indexPath)
            else {
                return UITableViewCell()
            }
            
            cell.config(with: purchasedProduct)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CheckPriceTableViewCell.identifier
            ) as? CheckPriceTableViewCell  else { return UITableViewCell() }
            
            cell.totalPriceLabel.text = presenter?.getTotalPrice().shortString() ?? "0.00"
            return cell
        }
    }
}

//MARK: -CheckDetailsControllerProtocol
extension CheckDetailsViewController: CheckDetailsControllerProtocol {
    
}
