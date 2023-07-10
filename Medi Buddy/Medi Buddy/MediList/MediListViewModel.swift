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
    
    let isSectionHiddens: Observable<[Category?: Bool]> = .init([Category : Bool]())
}

extension MediListViewModel {
    func category(of indexPath: IndexPath) -> Category {
        return categoryList[indexPath.section]
    }
    
    func categoryCount() -> Int {
        return categoryList.count
    }
    
    func medicine(of indexPath: IndexPath) -> Medicine {
        return medicineList.filter { $0.category == categoryList[indexPath.section] }[indexPath.item]
    }
    
    func medicineCount(of section: Int) -> Int {
        if !isSectionHiddens.value[CategoryManager.shared.getCategory(at: section), default: false] {
            return medicineList.filter { $0.category == categoryList[section] }.count
        } else {
            return 0
        }
    }
    
    func addMedicine(medicine: Medicine) {
        if MedicineManager.shared.list.filter({ $0.name == medicine.name && $0.category == medicine.category }).count != 0 {
            MedicineManager.shared.updateMedicine(medicine: medicine)
        } else {
            MedicineManager.shared.addMedicine(medicine: medicine)
        }
    }
    
    func medicineToDelete(indexPath: IndexPath) -> Medicine {
        return MedicineManager.shared.list.filter { $0.category == MedicineManager.shared.categoryList[indexPath.section] }[indexPath.item]
    }
    
    func deleteMedicine(medicine: Medicine) {
        MedicineManager.shared.deleteMedicine(medicine: medicine)
    }
    
    func hideSection(of indexPath: IndexPath, isHidden: Bool) {
        isSectionHiddens.value[CategoryManager.shared.getCategory(at: indexPath.section)] = isHidden
    }
    
    func isSectionHidden(of indexPath: IndexPath) -> Bool {
        return isSectionHiddens.value[CategoryManager.shared.getCategory(at: indexPath.section), default: false]
    }
}
