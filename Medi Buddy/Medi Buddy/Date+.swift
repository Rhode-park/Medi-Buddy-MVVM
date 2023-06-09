//
//  Date+.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import Foundation

extension Date {
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 E요일"
        
        let convertedDate = dateFormatter.string(from: self)
        
        return convertedDate
    }
}
