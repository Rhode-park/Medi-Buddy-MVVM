//
//  MediListViewController.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import UIKit

final class MediListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
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
    }
    
    @objc
    private func addMedicine() {
        print("addMedicine")
    }
    
    @objc
    private func setMedicineList() {
        print("setMedicineList")
    }
}

