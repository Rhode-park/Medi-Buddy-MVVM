//
//  MediListViewController.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

final class MediListViewController: UIViewController {
    lazy var mediListCollectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureListLayout())
        collectionView.register(MediListCell.self, forCellWithReuseIdentifier: "MediListCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureSubView()
        configureConstraint()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        mediListCollectionView.dataSource = self
    }
    
    private func configureNavigationBar() {
        let addMedicineButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                target: self,
                                                action: #selector(addMedicine))
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(setMedicineList))
        navigationItem.leftBarButtonItem = addMedicineButton
        navigationItem.rightBarButtonItem = settingButton
        title = Date().convertDate()
    }
    
    @objc
    private func addMedicine() {
        print("addMedicine")
    }
    
    @objc
    private func setMedicineList() {
        print("setMedicineList")
    }
    
    private func configureSubView() {
        view.addSubview(mediListCollectionView)
    }
    
    func configureListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            mediListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mediListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mediListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mediListCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MediListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mediListCollectionView.dequeueReusableCell(withReuseIdentifier: "MediListCell", for: indexPath) as? MediListCell else { return MediListCell() }
        
        return cell
    }
}
