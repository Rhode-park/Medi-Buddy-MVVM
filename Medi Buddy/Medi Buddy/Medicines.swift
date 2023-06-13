//
//  Medicines.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

class Medicines {
    static let shared = Medicines()
    let categoryList = Categories.shared.list
    
    private init() {}
    
    lazy var list = [Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "아침" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "아침" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "아침" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "필요시" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "필요시" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "필요시" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "취침" }).first),
                     Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: categoryList.filter({ $0.categoryName == "취침" }).first)]
}
