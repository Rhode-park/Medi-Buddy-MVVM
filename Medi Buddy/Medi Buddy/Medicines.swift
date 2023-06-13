//
//  Medicines.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

let categoryList = Categories.shared.list

class Medicines {
    
    
    var list = [Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "기본" }).first)]
}
