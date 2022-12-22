//
//  LeftMenuViewController.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 16/12/22.
//

import UIKit
import SideMenu

class LeftMenuNavViewController: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIViewController {
    
    @objc func showLeftMenu() {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true)
    }
    func hideLeftMenu() {
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: true, completion: nil)
    }
}
