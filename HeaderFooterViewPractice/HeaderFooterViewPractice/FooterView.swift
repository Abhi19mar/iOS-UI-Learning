//
//  FooterView.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 11/01/23.
//

import UIKit

class FooterView: UIView {
    var title: FooterTitle = .none
    var socialConnectType: SocialConnectType = .none
    
    @IBOutlet var btnAboutArray: [UIButton]! {
        didSet {
            title = .about
            for btn in 0...(btnAboutArray.count - 1) {
                btnAboutArray[btn].setTitle(title.checkTitle(tag: btn), for: .normal)
            }
        }
    }
    
    @IBOutlet var btnProductArray: [UIButton]! {
        didSet {
            title = .product
            for btn in 0...(btnProductArray.count - 1) {
                btnProductArray[btn].setTitle(title.checkTitle(tag: btn), for: .normal)
            }
        }
    }
    
    @IBOutlet var btnConnectArray: [UIButton]! {
        didSet {
            title = .connect
            for btn in 0...(btnConnectArray.count - 1) {
                btnConnectArray[btn].setTitle(title.checkTitle(tag: btn), for: .normal)
                btnConnectArray[btn].setImage(UIImage(named: title.getImage(tag: btn)), for: .normal)
                btnConnectArray[btn].addTarget(self, action: #selector(socialButttonsClicked(sender:)), for: .touchUpInside)
            }
        }
    }
    
    @objc func socialButttonsClicked(sender: UIButton) {
        switch sender.tag {
        case 0:
            socialConnectType = .linkedin
            socialConnectType.createLink()
        case 1:
            socialConnectType = .facebook
            socialConnectType.createLink()
        case 2:
            socialConnectType = .twitter
            socialConnectType.createLink()
        case 3:
            socialConnectType = .instagram
            socialConnectType.createLink()
        case 4:
            socialConnectType = .gmail
            socialConnectType.createLink()
        default:
            break
        }
    }
}
