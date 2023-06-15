//
//  Medicine.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/06/13.
//

import Foundation

struct Medicine {
    var name: String
    var maximumDose: Int
    var currentDose: Int
    var category: Category?
    
    var doseState: String {
        return "\(currentDose)/\(maximumDose)"
    }
}
