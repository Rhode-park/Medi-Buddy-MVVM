//
//  Observable.swift
//  Medi Buddy
//
//  Created by Rhode on 2023/07/02.
//

final class Observable<T> {
    var listener: ((T) -> Void)?
    
    var value: T {
        didSet { listener?(value) }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
