//
//  AddMedicineViewModel.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/07/05.
//

import Foundation


final class AddMedicineViewModel {
    private var categoryList: CategoryManager {
        return CategoryManager.shared
    }
    
    let selectedCategory: Observable<Category.Name> = .init(Category.Name.morning)
}

extension AddMedicineViewModel {
    func firstCategory() -> String? {
        return categoryList.list.first?.name.description
    }
    
    func category() -> Category? {
        return categoryList.getCategory(of: selectedCategory.value)
    }
    
    func addMedicine(name: String, maximumDose: Int) -> Medicine {
        let category = CategoryManager.shared.getCategory(of: selectedCategory.value)
        
        return Medicine(name: name, maximumDose: maximumDose, currentDose: .zero, category: category)
    }
}
