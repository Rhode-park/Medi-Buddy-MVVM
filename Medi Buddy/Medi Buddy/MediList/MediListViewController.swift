//
//  MediListViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/10.
//

import UIKit

final class MediListViewController: UIViewController {
    let viewModel = MediListViewModel()
    
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
        bind()
    }
    
    func bind() {
        viewModel.isSectionHiddens.bind { _ in
            self.mediListCollectionView.reloadData()
        }
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
            self.viewModel.addMedicine(medicine: medicine)
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
            let medicineToDelete = self.viewModel.medicineToDelete(indexPath: indexPath)
            let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { action, view, actionPerformed in
                self.viewModel.deleteMedicine(medicine: medicineToDelete)
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
        return viewModel.categoryCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.medicineCount(of: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let medicine = viewModel.medicine(of: indexPath)
        
        guard let cell = mediListCollectionView.dequeueReusableCell(withReuseIdentifier: "MediListCell",
                                                                    for: indexPath) as? MediListCell else { return MediListCell() }
        cell.configureCell(medicine: medicine)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderView",
                for: indexPath
              ) as? HeaderView else { return UICollectionReusableView() }
        
        let category = viewModel.category(of: indexPath)
        
        header.configureHeader(category: category)
        header.configureIsCellHidden(isCellHidden: viewModel.isSectionHidden(of: indexPath))
        header.hideHandler = { [weak self] isHidden in
            self?.viewModel.hideSection(of: indexPath, isHidden: isHidden)
        }
        
        return header
    }
}
