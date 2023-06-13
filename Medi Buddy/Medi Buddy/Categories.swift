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
    
    var list = [Category(categoryName: "기본", alarmTime: Date(), isAlarmed: true)]
}
