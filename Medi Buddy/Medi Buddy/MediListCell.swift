//
//  MediListCell.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

final class MediListCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureSubview()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubview() {
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            countLabel.topAnchor.constraint(equalTo: self.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configureCell(title: String, count: String) {
        titleLabel.text = title
        countLabel.text = count
    }
}
