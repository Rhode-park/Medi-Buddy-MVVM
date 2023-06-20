//
//  MediListViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/10.
//

import UIKit

final class MediListViewController: UIViewController {
    var categoryList: [Category] {
        return MedicineManager.shared.categoryList
    }
    
    lazy var isSectionHidden = [Category: Bool]() {
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
        navigationItem.title = Date().convertDate()
    }
    
    @objc
    private func addMedicine() {
        let addMedicineViewController = AddMedicineViewController()
        addMedicineViewController.sheetPresentationController?.detents = [.medium()]
        addMedicineViewController.addMedicineHandler = { medicine in
            
            if MedicineManager.shared.list.filter({ $0.name == medicine.name && $0.category == medicine.category }).count != 0 {
                MedicineManager.shared.updateMedicine(medicine: medicine)
            } else {
                MedicineManager.shared.addMedicine(medicine: medicine)
            }
            
            self.mediListCollectionView.reloadData()
        }
        
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
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let medicineToDelete = MedicineManager.shared.list.filter { $0.category == MedicineManager.shared.categoryList[indexPath.section] }[indexPath.item]
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { action, view, actionPerformed in
                MedicineManager.shared.deleteMedicine(medicine: medicineToDelete)
                self.mediListCollectionView.reloadData()
                actionPerformed(true)
            }

            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        configuration.headerMode = .supplementary
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
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
        return MedicineManager.shared.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !isSectionHidden[CategoryManager.shared.getCategory(of: section), default: false] {
            return MedicineManager.shared.list.filter { $0.category == categoryList[section] }.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let medicine = MedicineManager.shared.list.filter { $0.category == categoryList[indexPath.section] }[indexPath.item]
        
        guard let cell = mediListCollectionView.dequeueReusableCell(withReuseIdentifier: "MediListCell",
                                                                    for: indexPath) as? MediListCell else { return MediListCell() }
        cell.configureCell(title: medicine.name, count: medicine.doseState)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
              ) as? HeaderView else { return UICollectionReusableView() }
        
        let category = categoryList[indexPath.section]
        
        header.configureHeader(category: category.name.description, time: category.alarmTime.convertTime(), color: .systemCyan)
        header.configureIsCellHidden(isCellHidden: isSectionHidden[CategoryManager.shared.getCategory(of: indexPath.section), default: false])
        header.hideHandler = { [weak self] isHidden in
            self?.isSectionHidden[CategoryManager.shared.getCategory(of: indexPath.section)] = isHidden
        }
        
        return header
    }
}
