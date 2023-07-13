//
//  AddMedicineViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/15.
//

import UIKit

final class AddMedicineViewController: UIViewController {
    private let viewModel = AddMedicineViewModel()
    
    var addMedicineHandler: ((Medicine) -> ())?
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemCyan
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .systemCyan
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let medicineTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "약 이름"
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let doseLabel: UILabel = {
        let label = UILabel()
        label.text = "복용량"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var doseIntLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let doseIntStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        return stepper
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        categoryButton.backgroundColor = .systemCyan
        categoryButton.setTitle(viewModel.firstCategory(), for: .normal)
        doseIntLabel.text = "1정"
        configureSubView()
        configureConstraint()
        configureTarget()
        bind()
    }
    
    private func bind() {
        viewModel.selectedCategory.bind { categoryName in
            self.categoryButton.setTitle(categoryName.description, for: .normal)
        }
    }
    
    private func configureTarget() {
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneEditing), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
        doseIntStepper.addTarget(self, action: #selector(presentStepper), for: .touchUpInside)
    }
    
    @objc
    private func selectCategory() {
        let categoryViewController = CategoryViewController()
        categoryViewController.sheetPresentationController?.detents = [.medium()]
        
        categoryViewController.selectedCategoryHandler = { category in
            self.viewModel.selectedCategory.value = category.name
        }
        
        self.present(categoryViewController, animated: true)
    }
    
    @objc
    private func cancelEditing() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func doneEditing() {
        validateMedicine()
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
        view.addSubview(categoryButton)
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
            categoryButton.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
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
    
    private func addMedicine(name: String) {
        let maximumDose = Int(doseIntStepper.value)
        let medicine = viewModel.addMedicine(name: name, maximumDose: maximumDose)
        addMedicineHandler?(medicine)
    }
    
    private func validateMedicine() {
        guard let medicineName = medicineTextField.text,
              medicineName != "" else {
            displayEmptyAlert()
            
            return
        }
        addMedicine(name: medicineName)
        self.dismiss(animated: true)
    }
    
    private func displayEmptyAlert() {
        let alert = UIAlertController(title: nil, message: "추가하고자하는 약의 이름을 입력하시오", preferredStyle: UIAlertController.Style.alert)
        let okayAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okayAction)
        
        present(alert, animated: false)
    }
}
