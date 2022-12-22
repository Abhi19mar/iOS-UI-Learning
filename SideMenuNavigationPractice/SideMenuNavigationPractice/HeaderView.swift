//
//  HeaderView.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 19/12/22.
//

import UIKit

class HeaderView: UIView {
    @IBOutlet var contentView: UIView!
  
    @IBOutlet weak var menuButton: UIButton! {
        didSet {
            menuButton.setImage(UIImage(named: "imageDrawer"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
            nib.instantiate(withOwner: self, options: nil)
            contentView.frame = bounds
            addSubview(contentView)
    }    
    
    func configureUI(nav: UINavigationController?) {
        menuButton.addTarget(nav, action: #selector(self.parentViewController?.showLeftMenu), for: .touchUpInside)
    }
}

extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

