//
//  ViewController.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 16/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.configureUI(nav: self.navigationController)

    }
}

