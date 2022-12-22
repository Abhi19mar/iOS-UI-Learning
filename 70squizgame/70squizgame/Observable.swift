//
//  Observable.swift
//  70squizgame
//
//  Created by Abhishek Goel on 06/12/22.
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
