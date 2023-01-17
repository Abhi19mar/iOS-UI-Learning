//
//  NSObjectExtensions.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 11/01/23.
//

import Foundation

extension NSObject {
    static func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
