//
//  LeftMenuViewController.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 16/12/22.
//

import UIKit

enum Names: String {
    case boy = "Abhishek"
    case girl = "Pranshur"
    
    static var studentsName: [Names] = {
        return [.boy, .girl]
    }()
}

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnCloseMenuTapped(_ sender: Any) {
        hideLeftMenu()
    }
    var menuSelected = Names.boy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)

        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Names.studentsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.label.text = Names.studentsName[indexPath.row].rawValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuSelected = Names.studentsName[indexPath.row]
        switch menuSelected {
        case .boy:
            let controller  = storyboard?.instantiateViewController(withIdentifier: "BoyDetailsViewController") as! BoyDetailsViewController
            navigationController?.pushViewController(controller, animated: true)
        case .girl:
            let controller  = storyboard?.instantiateViewController(withIdentifier: "GirlDetailsViewController") as! GirlDetailsViewController
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}
