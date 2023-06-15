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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSubView()
        configureConstraint()
    }
    
    @objc
    private func cancelEditing() {
        print("cancelEditing")
    }
    
    @objc
    private func doneEditing() {
        print("doneEditing")
    }
    
    private func configureSubView() {
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

}
