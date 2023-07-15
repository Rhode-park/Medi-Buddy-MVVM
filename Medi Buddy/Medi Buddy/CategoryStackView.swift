//
//  CategoryStackView.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/07/13.
//

import UIKit

class CategoryStackView: UIStackView {
    private let category: Category?
    
    var isCategorySelected: Bool? {
        didSet {
            categoryButton.isSelected.toggle()
        }
    }
    
    var categorySelectHandler: ((Category) -> ())?
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .systemCyan
        button.setContentHuggingPriority(.required, for: .horizontal)
        
        return button
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        
        return label
    }()
    
    init(category: Category?, isCategorySelected: Bool?) {
        self.category = category
        self.isCategorySelected = isCategorySelected
        super.init(frame: .zero)
        
        categoryTitleLabel.text = category?.name.description
        
        configureSubview()
        configureConstraint()
        configureTarget()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubview() {
        self.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(categoryButton)
        horizontalStackView.addArrangedSubview(categoryTitleLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            horizontalStackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func configureTarget() {
        categoryButton.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
    }
    
    @objc
    private func selectCategory() {
        isCategorySelected?.toggle()
        
        guard let category else { return }
        
        categorySelectHandler?(category)
    }
    
    func currentCategory(isSelected: Bool) {
        isCategorySelected = isSelected
    }
}
