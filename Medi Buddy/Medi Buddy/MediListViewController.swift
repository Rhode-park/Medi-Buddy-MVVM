//
//  MediListViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/10.
//

import UIKit

final class MediListViewController: UIViewController {
    let categoryList = Categories.shared.list
    let medicineList = Medicines.shared.list
    var isSectionHidden = [false, false, false] {
        didSet {
            mediListCollectionView.reloadData()
        }
    }
    
    lazy var mediListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureListLayout())
        collectionView.register(MediListCell.self, forCellWithReuseIdentifier: "MediListCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
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
        view.backgroundColor = .systemBackground
        mediListCollectionView.dataSource = self
    }
    
    private func configureNavigationBar() {
        let addMedicineButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                target: self,
                                                action: #selector(addMedicine))
        addMedicineButton.tintColor = .systemCyan
        
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(setMedicineList))
        settingButton.tintColor = .systemCyan
        
        navigationItem.leftBarButtonItem = addMedicineButton
        navigationItem.rightBarButtonItem = settingButton
        title = Date().convertDate()
    }
    
    @objc
    private func addMedicine() {
        let addMedicineViewController = AddMedicineViewController()
        addMedicineViewController.sheetPresentationController?.detents = [.medium()]
        
        self.present(addMedicineViewController, animated: true)
    }
    
    @objc
    private func setMedicineList() {
        print("setMedicineList")
    }
    
    private func configureSubView() {
        view.addSubview(mediListCollectionView)
    }
    
    func configureListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(0.4))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(self.mediListCollectionView.frame.height/8))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(0.06))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
            section.boundarySupplementaryItems = [header]
            
            return section
        }, configuration: configuration)
        
        return layout
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isSectionHidden[section] {
            return medicineList.filter({ $0.category == categoryList[section] }).count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = medicineList.filter({ $0.category == categoryList[indexPath.section] })[indexPath.item].medicineName
        let maximumDose = medicineList.filter({ $0.category == categoryList[indexPath.section] })[indexPath.item].maximumDose
        let currentDose = medicineList.filter({ $0.category == categoryList[indexPath.section] })[indexPath.item].currentDose
        let doseState = "\(currentDose)/\(maximumDose)"
        
        guard let cell = mediListCollectionView.dequeueReusableCell(withReuseIdentifier: "MediListCell",
                                                                    for: indexPath) as? MediListCell else { return MediListCell() }
        cell.configureCell(title: title, count: doseState)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
              ) as? HeaderView else { return UICollectionReusableView() }
        
        header.configureHeader(category: categoryList[indexPath.section].categoryName, time: categoryList[indexPath.section].alarmTime.convertTime(), color: .systemCyan)
        header.configureIsCellHidden(isCellHidden: isSectionHidden[indexPath.section])
        header.hideHandler = { [weak self] isHidden in
            self?.isSectionHidden[indexPath.section] = isHidden
        }
        
        return header
    }
}
