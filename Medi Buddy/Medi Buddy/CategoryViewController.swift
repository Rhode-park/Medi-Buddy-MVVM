//
//  CategoryViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/16.
//

import UIKit

final class CategoryViewController: UIViewController {
    var categoryList: [Category] {
        return CategoryManager.shared.list
    }
    
    var categoryButtonList = [UIButton: Category]()
    var currentSelectedButton: UIButton?
    
    var selectedCategoryHandler: ((Category) -> ())?
    
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
    
    let categoryMainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSubView()
        configureConstraint()
        configureCategoryButton()
    }
    
    private func configureSubView() {
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
        view.addSubview(categoryMainTitleLabel)
        view.addSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryStackView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryMainTitleLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 24),
            categoryMainTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            categoryMainTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            categoryScrollView.topAnchor.constraint(equalTo: categoryMainTitleLabel.bottomAnchor, constant: 16),
            categoryScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            categoryScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            categoryScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.trailingAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.bottomAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.frameLayoutGuide.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.frameLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc
    private func cancelEditing() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func doneEditing() {
        defer {
            self.dismiss(animated: true)
        }
        
        guard let currentSelectedButton else { return }
        
        guard let currentSelectedCategory = categoryButtonList[currentSelectedButton] else { return }
        
        selectedCategoryHandler?(currentSelectedCategory)
    }
    
    private func createCategoryHorizontalStackView(category: Category) {
        let categoryHorizontalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            return stackView
        }()
        
        let categoryButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            button.setImage(UIImage(systemName: "square"), for: .normal)
            button.tintColor = .systemCyan
            button.setContentHuggingPriority(.required, for: .horizontal)
            
            return button
        }()
        
        let categoryTitleLabel: UILabel = {
            let label = UILabel()
            label.text = category.name.description
            label.font = .preferredFont(forTextStyle: .body)
            label.textColor = .label
            
            return label
        }()
        
        categoryButtonList[categoryButton] = category
        
        categoryStackView.addArrangedSubview(categoryHorizontalStackView)
        categoryHorizontalStackView.addArrangedSubview(categoryButton)
        categoryHorizontalStackView.addArrangedSubview(categoryTitleLabel)
        
        NSLayoutConstraint.activate([
            categoryHorizontalStackView.widthAnchor.constraint(equalTo: categoryStackView.widthAnchor),
        ])
    }
    
    private func configureCategoryStackView() {
        categoryList.forEach { category in
            createCategoryHorizontalStackView(category: category)
        }
    }
    
    private func configureCategoryButton() {
        for index in 0...categoryStackView.arrangedSubviews.count-1 {
            guard let categoryButton = categoryStackView.arrangedSubviews[index].subviews.first as? UIButton else { return }
            categoryButton.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
        }
    }
    
    func selectCategoryButton(selectedCategory: Category?) {
        configureCategoryStackView()
        
        guard let selectedButton = categoryButtonList.first (where: { $0.value == selectedCategory })?.key else {
            guard let firstCategoryButton = categoryStackView.arrangedSubviews.first?.subviews.first as? UIButton else { return }
            firstCategoryButton.isSelected = true
            
            return
        }
        
        selectedButton.isSelected = true
    }
    
    @objc
    private func selectCategory(button: UIButton) {
        for index in 0...categoryStackView.arrangedSubviews.count-1 {
            guard let categoryButton = categoryStackView.arrangedSubviews[index].subviews.first as? UIButton else { return }
            if categoryButton.isSelected {
                categoryButton.isSelected = false
            }
        }
        
        button.isSelected.toggle()
        currentSelectedButton = button
    }
}
