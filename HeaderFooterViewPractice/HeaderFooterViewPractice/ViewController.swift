//
//  ViewController.swift
//  HeaderFooterViewPractice
//
//  Created by Abhishek Goel on 05/01/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var footerView: XibView! {
        didSet {
            footerView.contentView.subcribe { view in
                if let view = view as? FooterView {
                    self.footer = view
                }
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    private let sectionTitle = ["Sales", "HR", "Marketing", "Accounts","Finance"]
    private let userDetails = [["Ram", "Mohan", "Sohan"], ["Tarun", "Keshav", "Aman"], ["Raghav", "Mahesh"], ["Madhav"], ["Amrit", "Sanjay", "Swati"]]
    private var footer: FooterView! {
        didSet {
            tableView.tableFooterView = footer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "FooterTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "footer")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetails[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.textLabel?.text = userDetails[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! FooterTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
