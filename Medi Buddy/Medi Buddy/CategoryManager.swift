//
//  CategoryManager.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

import Foundation

class CategoryManager {
    static let shared = CategoryManager()
    
    private init() {}
    
    var list = [Category(categoryName: .morning, alarmTime: Date(timeIntervalSinceNow: -5000), isAlarmed: true),
                Category(categoryName: .inNeed, alarmTime: Date(timeIntervalSinceNow: -1500), isAlarmed: true),
                Category(categoryName: .beforeBed, alarmTime: Date(timeIntervalSinceNow: -1000), isAlarmed: true),
                Category(categoryName: .custom("비염약"), alarmTime: Date(timeIntervalSinceNow: -2000), isAlarmed: true),
                Category(categoryName: .custom("알러지약"), alarmTime: Date(timeIntervalSinceNow: -3000), isAlarmed: true)]
    
    func getCategory(of name: Category.Name) -> Category? {
        return list.first { $0.name == name }
    }
}
