//
//  Category.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

import Foundation

struct Category: Equatable {
    let id: UUID
    var categoryName: String
    var categoryColor: Int
    var alarmTime: Date
    var isAlarmed: Bool
    
    init(id: UUID = UUID(), categoryName: String, categoryColor: Int = 0x68B984, alarmTime: Date, isAlarmed: Bool) {
        self.id = id
        self.categoryName = categoryName
        self.categoryColor = categoryColor
        self.alarmTime = alarmTime
        self.isAlarmed = isAlarmed
    }
}
