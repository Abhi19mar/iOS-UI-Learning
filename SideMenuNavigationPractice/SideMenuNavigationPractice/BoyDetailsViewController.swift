//
//  BoyDetailsViewController.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 19/12/22.
//

import UIKit

class BoyDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        self.navigationItem.setHidesBackButton(true, animated: true)
        headerView.configureUI(nav: self.navigationController)
        // Do any additional setup after loading the view.
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
