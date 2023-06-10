//
//  HeaderView.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    private let categoryColorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let alarmView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "alarm")
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let alarmTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        categoryColorView.backgroundColor = .systemBlue
        categoryLabel.text = "아침"
        alarmTimeLabel.text = "06:30 am"
        configureSubview()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubview() {
        self.addSubview(categoryColorView)
        self.addSubview(categoryLabel)
        self.addSubview(alarmView)
        self.addSubview(alarmTimeLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            categoryColorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            categoryColorView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3/5),
            categoryColorView.widthAnchor.constraint(equalTo: categoryColorView.heightAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryColorView.trailingAnchor, constant: 12),
            alarmView.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            alarmView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alarmView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3/5),
            alarmView.widthAnchor.constraint(equalTo: alarmView.heightAnchor),
            alarmTimeLabel.leadingAnchor.constraint(equalTo: alarmView.trailingAnchor, constant: 8),
            alarmTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
