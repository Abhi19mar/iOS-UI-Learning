//
//  UIViewExtensions.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 11/01/23.
//

import UIKit

extension UIView {
    
    static func nib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    static func loadFromNib(_ name: String) -> UIView? {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    static func reuseIdentifier() -> String {
        return className()
    }
}
