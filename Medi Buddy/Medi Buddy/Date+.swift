//
//  Date+.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/06/10.
//

import Foundation

extension Date {
    func convertMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월"
        
        let convertedMonth = dateFormatter.string(from: self)
        
        return convertedMonth
    }
    
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 E요일"
        
        let convertedDate = dateFormatter.string(from: self)
        
        return convertedDate
    }
    
    func convertTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let convertedTime = dateFormatter.string(from: self)
        
        return convertedTime
    }
}
