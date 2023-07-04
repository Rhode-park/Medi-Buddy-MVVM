//
//  MediListViewModel.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/07/02.
//

import Foundation

class MediListViewModel {
    var medicineList: [Medicine] {
        return MedicineManager.shared.list
    }
    
    var categoryList: [Category] {
        return MedicineManager.shared.categoryList
    }
    
    let isSectionHiddens: Observable<[Category: Bool]> = .init([Category : Bool]())
}

extension MediListViewModel {
    func medicine(of indexPath: IndexPath) -> Medicine {
        return medicineList.filter { $0.category == categoryList[indexPath.section] }[indexPath.item]
    }
    
    func medicineCount(of section: Int) -> Int {
        if !isSectionHiddens.value[CategoryManager.shared.getCategory(of: section), default: false] {
            return medicineList.filter { $0.category == categoryList[section] }.count
        } else {
            return 0
        }
    }
    
    func hideSection(of indexPath: IndexPath, isHidden: Bool) {
        isSectionHiddens.value[CategoryManager.shared.getCategory(of: indexPath.section)] = isHidden
    }
    
    func isSectionHidden(of indexPath: IndexPath) -> Bool {
        return isSectionHiddens.value[CategoryManager.shared.getCategory(of: indexPath.section), default: false]
    }
}
