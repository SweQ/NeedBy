//
//  ProductCreatorViewController.swift
//  NeedBuy
//
//  Created by alexKoro on 20.07.22.
//

import UIKit

class ProductCreatorViewController: UIViewController {
    
    var productCreatorView: ProductCreatorView!
    var presenter: ProductCreatorPresenterProtocol!
    let imagePickerVC = UIImagePickerController()
    var tapGesture: UITapGestureRecognizer!
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        setupTableView()
        setupView()
        presenter.prepareViewToAppear()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setupTotalConstraints(with: view)
    }
    
    private func setupEditBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
    }
    
    private func setupView() {
        setupProductCreatorView()
    }
    
    private func setupProductCreatorView() {
        productCreatorView = ProductCreatorView()
        setupElementsActions()
        
        productCreatorView.nameTextField.delegate = self
        productCreatorView.costTextField.delegate = self
    }
    
    private func setupProductCreatorViewAnchors() {
        productCreatorView.setupTotalConstraints(with: view)
    }
    
    private func setupElementsActions() {
        productCreatorView.changeImageButton.addTarget(self, action: #selector(changeImageButtonPressed), for: .touchUpInside)
        productCreatorView.measureTextField.addTarget(
            self,
            action: #selector(measureTextFieldBeginEdidting),
            for: .editingDidBegin
        )
    }
    
    private func setupSaveBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
    }
    
    @objc private func saveButtonPressed() {
        save()
        switchOffEditingMode()
    }
    
    @objc func changeImageButtonPressed() {
        showPhotoPickerVC()
    }
    
    @objc private func tapGestureHandler() {
        productCreatorView.nameTextField.resignFirstResponder()
        productCreatorView.costTextField.resignFirstResponder()
    }
    
    @objc private func editButtonPressed() {
        turnOnEditingMode()
    }
    
    @objc private func measureTextFieldBeginEdidting() {
        let measureAlert = createMeasureAlertController()
        present(measureAlert, animated: true)
    }
    
    private func checkCostTextField(textField: UITextField) {
        if let text = textField.text?.replacingOccurrences(of: ",", with: "."),
           costStringIsDouble(stringData: text)
        {
            textField.text = text
        } else {
            textField.text = "0.00"
        }
    }
    
    private func costStringIsDouble(stringData: String) -> Bool {
        if stringData.isDouble() {
            return true
        } else {
            showErrorAlert(with: Words.errorTitle.value(),
                           message: "\(Words.costIsNotCorrect.value())!\n\(Words.exampleTitle.value()): \"1.5\", \"1\"")
            return false
        }
    }
    
    private func save() {
        
        let name = productCreatorView.nameTextField.text ?? ""
        let measure = Measure.init(rawValue: productCreatorView.measureTextField.text ?? "") ?? Measure.pcs
        let cost = Double(productCreatorView.costTextField.text ?? "0") ?? 0
        
        let image = productCreatorView.productImageView.image
        
        presenter.save(
            productName: name,
            productMeasure: measure,
            productCost: cost,
            productImage: image)
    }
    
    private func showPhotoPickerVC() {
        let photoPicker = PhotoPicker.shared.create { [weak self] image in
            guard let image = image else { return }
            self?.presenter.updateProductImage(image: image) { [weak self] in
                self?.productCreatorView.productImageView.image = image
            }
        }
        present(photoPicker, animated: true)
    }
    
    private func createMeasureAlertController() -> UIAlertController {
        var actions: [UIAlertAction] = []
        for measure in Measure.allCases {
            let action = UIAlertAction(
                title: measure.rawValue,
                style: .default) { [weak self] action in
                    self?.productCreatorView.measureTextField.text = action.title ?? ""
                    self?.productCreatorView.measureTextField.resignFirstResponder()
                }
            actions.append(action)
        }
        
        let alert = AlertCreator.shared.createAlertWithCancel(
            title: Words.selectMeasure.value(),
            message: nil,
            style: .actionSheet,
            actions: actions
        )
        
        return alert
    }
    
    private func showErrorAlert(with title: String, message: String?) {
        let errorAlert = AlertCreator.shared.createErrorAlert(with: title, message: message)
        present(errorAlert, animated: true)
    }

}

//MARK: -ProductCreatorViewProtocol
extension ProductCreatorViewController: ProductCreatorViewProtocol {
    func showEditingProduct(product: Product) {
        productCreatorView.nameTextField.text = product.name ?? ""
        productCreatorView.costTextField.text = "\(product.cost)"
        productCreatorView.measureTextField.text = product.measure ?? ""
        productCreatorView.productImageView.image = product.image
        print(productCreatorView.productImageView.image?.imageOrientation == .up)
    }
    
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func turnOnEditingMode() {
        productCreatorView.editMode(isOn: true)
        setupSaveBarButton()
    }
    
    func switchOffEditingMode() {
        productCreatorView.editMode(isOn: false)
        setupEditBarButton()
    }
}

//MARK: -UITextFieldDelegate
extension ProductCreatorViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard productCreatorView.costTextField === textField else {
            textField.resignFirstResponder()
            return true
        }
        
        checkCostTextField(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard productCreatorView.costTextField === textField else { return }
        checkCostTextField(textField: textField)
    }
    
}

//MARK: -UITableViewDelegate and DataSource
extension ProductCreatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height + 36 //36 - height keyboardToolbar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.contentView.addSubview(productCreatorView)
        productCreatorView.setupTotalConstraints(with: cell.contentView)
        cell.contentView.addGestureRecognizer(tapGesture)
        
        return cell
    }
}
