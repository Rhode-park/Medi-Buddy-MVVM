//
//  Categories.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

import Foundation

class Categories {
    static let shared = Categories()
    
    private init() {}
    
    var list = [Category(categoryName: .morning, alarmTime: Date(), isAlarmed: true),
                Category(categoryName: .inNeed, alarmTime: Date(), isAlarmed: true),
                Category(categoryName: .beforeBed, alarmTime: Date(), isAlarmed: true),
                Category(categoryName: .custom("비염약"), alarmTime: Date(), isAlarmed: true),
                Category(categoryName: .custom("알러지약"), alarmTime: Date(), isAlarmed: true)]
}
