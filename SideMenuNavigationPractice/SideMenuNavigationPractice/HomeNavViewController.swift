//
//  HomeNavViewController.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 19/12/22.
//

import UIKit
import SideMenu

class HomeNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSideMenu()
        // Do any additional setup after loading the view.
    }
    
    func configureSideMenu() {
        
        var sideMenuSettings = SideMenuSettings()
        sideMenuSettings.menuWidth = UIScreen.main.bounds.size.width
        sideMenuSettings.presentationStyle = .menuSlideIn
        sideMenuSettings.statusBarEndAlpha = 0
        
        let vcLeftMenuNav: LeftMenuNavViewController = (self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavViewController") as? LeftMenuNavViewController)!
        vcLeftMenuNav.settings = sideMenuSettings
        SideMenuManager.default.leftMenuNavigationController = vcLeftMenuNav
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
