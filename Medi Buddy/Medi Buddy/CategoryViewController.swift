//
//  CategoryViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/16.
//

import UIKit

final class CategoryViewController: UIViewController {
    private var categoryList: [Category] {
        return CategoryManager.shared.list
    }
    
    private var categoryStackViewDictionary = [Category: CategoryStackView]()
    
    private var currentSelectedCategory: Category?
    private var previousSelectedCategory: Category?
    
    var selectedCategoryHandler: ((Category) -> ())?
    
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
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let mainStackView: UIStackView = {
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
        configureCategoryStackView()
        configureTarget()
    }
    
    private func configureSubView() {
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
        view.addSubview(mainTitleLabel)
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainTitleLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 24),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            mainTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            mainScrollView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 16),
            mainScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            mainScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            mainStackView.topAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureTarget() {
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneEditing), for: .touchUpInside)
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
        
        guard let currentSelectedCategory else { return }
        
        selectedCategoryHandler?(currentSelectedCategory)
    }
    
    private func createCategoryStackView(category: Category) {
        let categoryStackView = CategoryStackView(category: category, isCategorySelected: false)
        categoryStackView.categorySelectHandler = { selectedCategory in
            self.previousSelectedCategory = self.currentSelectedCategory
            self.selectCategoryStackView()
            self.currentSelectedCategory = selectedCategory
        }
        categoryStackViewDictionary[category] = categoryStackView
        mainStackView.addArrangedSubview(categoryStackView)
    }
    
    private func configureCategoryStackView() {
        categoryList.forEach { category in
            createCategoryStackView(category: category)
        }
    }
    
    private func selectCategoryStackView() {
        guard let previousSelectedCategory else { return }
        
        let stackView = categoryStackViewDictionary[previousSelectedCategory]
        stackView?.isCategorySelected = false
    }
}
