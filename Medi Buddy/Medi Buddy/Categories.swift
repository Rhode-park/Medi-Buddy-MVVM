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
    
    var list = [Category(categoryName: "아침", alarmTime: Date(), isAlarmed: true), Category(categoryName: "필요시", alarmTime: Date(), isAlarmed: true), Category(categoryName: "취침", alarmTime: Date(), isAlarmed: true)]
}
