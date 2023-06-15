//
//  MediCalendarViewController.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/15.
//

import UIKit

final class MediCalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let monthPicker = UIBarButtonItem(title: "2023년 06월", style: .plain, target: self, action: #selector(pickMonth))
        monthPicker.tintColor = .label
        
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(setMedicineCalendar))
        settingButton.tintColor = .systemCyan
        
        navigationItem.leftBarButtonItem = monthPicker
        navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc
    private func pickMonth() {
        print("pickMonth")
    }
    
    @objc
    private func setMedicineCalendar() {
        print("setMedicineCalendar")
    }
}
