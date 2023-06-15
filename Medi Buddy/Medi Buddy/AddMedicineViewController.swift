//
//  AddMedicineViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/15.
//

import UIKit

final class AddMedicineViewController: UIViewController {
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(cancelEditing), for: .touchUpInside)
        button.tintColor = .systemCyan
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.addTarget(self, action: #selector(doneEditing), for: .touchUpInside)
        button.tintColor = .systemCyan
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let medicineTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "약 이름"
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let doseLabel: UILabel = {
        let label = UILabel()
        label.text = "복용량"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var doseIntLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var doseIntStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(presentStepper), for: .touchUpInside)
        
        let decrementImage = stepper.decrementImage(for: .normal)
        decrementImage?.withTintColor(.systemCyan)
        let incrementImage = stepper.incrementImage(for: .normal)
        incrementImage?.withTintColor(.systemCyan)
        
        stepper.setDecrementImage(decrementImage, for: .normal)
        stepper.setIncrementImage(incrementImage, for: .normal)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        return stepper
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        doseIntLabel.text = "1정"
        configureSubView()
        configureConstraint()
    }
    
    @objc
    private func cancelEditing() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func doneEditing() {
        print("doneEditing")
        self.dismiss(animated: true)
    }
    
    @objc
    private func presentStepper() {
        let doseInt = Int(doseIntStepper.value)
        doseIntLabel.text = "\(doseInt)정"
    }
    
    private func configureSubView() {
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
        view.addSubview(medicineTextField)
        view.addSubview(categoryLabel)
        view.addSubview(doseLabel)
        view.addSubview(doseIntLabel)
        view.addSubview(doseIntStepper)
        view.addSubview(memoLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            medicineTextField.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 28),
            medicineTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            medicineTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryLabel.topAnchor.constraint(equalTo: medicineTextField.bottomAnchor, constant: 28),
            categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doseLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            doseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doseIntStepper.centerYAnchor.constraint(equalTo: doseLabel.centerYAnchor),
            doseIntStepper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            doseIntLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            doseIntLabel.trailingAnchor.constraint(equalTo: doseIntStepper.leadingAnchor, constant: -8),
            memoLabel.topAnchor.constraint(equalTo: doseLabel.bottomAnchor, constant: 16),
            memoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }

}
