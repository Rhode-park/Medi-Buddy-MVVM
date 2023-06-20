//
//  MedicineManager.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

class MedicineManager {
    static let shared = MedicineManager()
    
    private init() {}
    
    private(set) var list = [Medicine(name: "프로비질", maximumDose: 2, currentDose: 2, category: CategoryManager.shared.getCategory(of: .morning)),
                     Medicine(name: "명인탄산리튬정", maximumDose: 2, currentDose: 1, category: CategoryManager.shared.getCategory(of: .morning)),
                     Medicine(name: "콘서타OROS서방정27mg", maximumDose: 3, currentDose: 2, category: CategoryManager.shared.getCategory(of: .morning)),
                     Medicine(name: "콘서타OROS서방정18mg", maximumDose: 1, currentDose: 0, category: CategoryManager.shared.getCategory(of: .inNeed)),
                     Medicine(name: "펨도필러스유산균", maximumDose: 2, currentDose: 0, category: CategoryManager.shared.getCategory(of: .inNeed)),
                     Medicine(name: "오메가3", maximumDose: 4, currentDose: 2, category: CategoryManager.shared.getCategory(of: .beforeBed)),
                     Medicine(name: "명인탄산리튬정150mg", maximumDose: 3000, currentDose: 200, category: CategoryManager.shared.getCategory(of: .custom("비염약"))),
                     Medicine(name: "아리피진정5mg", maximumDose: 2, currentDose: 1, category: CategoryManager.shared.getCategory(of: .custom("비염약")))]
    
    var categoryList: [Category] {
        return Set(list.compactMap{ $0.category }).sorted { $0.alarmTime < $1.alarmTime }
    }
    
    func addMedicine(medicine: Medicine) {
        list.append(medicine)
    }
}
