//
//  Category.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

import Foundation

struct Category: Hashable {
    enum Name: Hashable {
        case morning
        case noon
        case evening
        case beforeBed
        case inNeed
        case custom(String)
        
        var description: String {
            switch self {
            case .morning:
                return "아침"
            case .noon:
                return "점심"
            case .evening:
                return "저녁"
            case .beforeBed:
                return "취침전"
            case .inNeed:
                return "필요시"
            case .custom(let name):
                return name
            }
        }
    }
    
    var name: Name
    var categoryColor: Int
    var alarmTime: Date
    var isAlarmed: Bool
    
    init(categoryName: Name, categoryColor: Int = 0x68B984, alarmTime: Date, isAlarmed: Bool) {
        self.name = categoryName
        self.categoryColor = categoryColor
        self.alarmTime = alarmTime
        self.isAlarmed = isAlarmed
    }
}
