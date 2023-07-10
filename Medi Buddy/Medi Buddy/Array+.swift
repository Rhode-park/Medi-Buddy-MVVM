//
//  Array+.swift
//  Medi Buddy
//
//  Created by Jinah Park on 2023/07/09.
//

extension Array {
    subscript(at index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
