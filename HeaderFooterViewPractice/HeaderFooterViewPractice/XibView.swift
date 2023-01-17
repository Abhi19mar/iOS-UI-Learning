//
//  XibView.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 11/01/23.
//

import UIKit

@IBDesignable
class XibView: UIView {
    let contentView = Observable<UIView?>(value: nil)
    @IBInspectable var nibName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView.value?.prepareForInterfaceBuilder()
    }
    
    func loadNibView() {
        if contentView.value == nil {
            xibSetup()
        }
    }
    
    private func xibSetup() {
        guard let nibName = nibName, let view = UIView.loadFromNib(nibName) else {
            return
        }
        view.frame = bounds
        view.autoresizingMask =
        [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView.value = view
    }
}
