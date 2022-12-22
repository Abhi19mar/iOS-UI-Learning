//
//  MenuTableViewCell.swift
//  SideMenuNavigationPractice
//
//  Created by Abhishek Goel on 16/12/22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
