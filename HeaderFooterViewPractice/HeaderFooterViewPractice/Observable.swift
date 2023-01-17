//
//  Observable.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 11/01/23.
//

import Foundation

class Observable<T> {
    typealias listenerBlock = (T) -> (Void)

    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener:listenerBlock?
    
    init(value: T) {
        self.value = value
    }
    
    func subcribe(block: @escaping listenerBlock) {
        self.listener = block
    }
    
    func subcribeAndPublish(block: @escaping listenerBlock) {
        self.listener = block
        listener?(value)
    }

    func removeObserver() {
        self.listener = nil
    }
}
