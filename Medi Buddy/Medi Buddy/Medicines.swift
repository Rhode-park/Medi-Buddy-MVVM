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
    
    lazy var list = [Medicine(medicineName: "프로비질", maximumDose: 2, currentDose: 2, category: .morning),
                     Medicine(medicineName: "명인탄산리튬정", maximumDose: 2, currentDose: 1, category: .morning),
                     Medicine(medicineName: "콘서타OROS서방정27mg", maximumDose: 3, currentDose: 2, category: .morning),
                     Medicine(medicineName: "콘서타OROS서방정18mg", maximumDose: 1, currentDose: 0, category: .inNeed),
                     Medicine(medicineName: "펨도필러스유산균", maximumDose: 2, currentDose: 0, category: .inNeed),
                     Medicine(medicineName: "오메가3", maximumDose: 4, currentDose: 2, category: .custom("비염약")),
                     Medicine(medicineName: "명인탄산리튬정150mg", maximumDose: 3, currentDose: 2, category: .custom("비염약")),
                     Medicine(medicineName: "아리피진정5mg", maximumDose: 2, currentDose: 1, category: .beforeBed)]
}
