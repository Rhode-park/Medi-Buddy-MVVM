//
//  HeaderView.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    var isCellHidden = false {
        didSet {
            configureHideButton()
            hideHandler?(isCellHidden)
        }
    }
    
    var hideHandler: ((Bool) -> ())?
    
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
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let alarmTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let hideButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        hideButton.addTarget(self, action: #selector(toggleIsDisplayed), for: .touchUpInside)
        configureSubview()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideHandler = nil
    }
    
    private func configureSubview() {
        self.addSubview(categoryColorView)
        self.addSubview(categoryLabel)
        self.addSubview(alarmView)
        self.addSubview(alarmTimeLabel)
        self.addSubview(hideButton)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            categoryColorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            categoryColorView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            categoryColorView.widthAnchor.constraint(equalTo: categoryColorView.heightAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryColorView.trailingAnchor, constant: 12),
            alarmView.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            alarmView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alarmView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            alarmView.widthAnchor.constraint(equalTo: alarmView.heightAnchor),
            alarmTimeLabel.leadingAnchor.constraint(equalTo: alarmView.trailingAnchor, constant: 8),
            alarmTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hideButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hideButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hideButton.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 1/2),
            hideButton.widthAnchor.constraint(equalTo: hideButton.heightAnchor)
        ])
    }
    
    func configureHeader(category: String, time: String, color: UIColor) {
        categoryLabel.text = category
        alarmTimeLabel.text = time
        categoryColorView.backgroundColor = color
    }
    
    func configureIsCellHidden(isCellHidden: Bool) {
        self.isCellHidden = isCellHidden
    }
    
    private func configureHideButton() {
        if isCellHidden {
            hideButton.setImage(.init(systemName: "chevron.forward.circle"), for: .normal)
        } else {
            hideButton.setImage(.init(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    @objc
    private func toggleIsDisplayed() {
        isCellHidden.toggle()
    }
}
