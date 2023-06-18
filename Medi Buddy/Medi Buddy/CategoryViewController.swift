//
//  CategoryViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/16.
//

import UIKit

final class CategoryViewController: UIViewController {
    let categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemCyan
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.textAlignment = .left
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSubView()
        configureConstraint()
    }
    
    private func configureSubView() {
        view.addSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(categoryTitleLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            categoryScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            categoryScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28),
            categoryScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -28),
            categoryScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.trailingAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.bottomAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.frameLayoutGuide.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.frameLayoutGuide.trailingAnchor),
            categoryTitleLabel.widthAnchor.constraint(equalTo: categoryStackView.widthAnchor),
        ])
    }
}
