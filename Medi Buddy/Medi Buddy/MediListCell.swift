//
//  MediListCell.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

final class MediListCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MediListCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .center
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
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            countLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 40),
            countLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
    }
    
    func configureCell(medicine: Medicine) {
        titleLabel.text = medicine.name
        countLabel.text = medicine.doseState
    }
}
