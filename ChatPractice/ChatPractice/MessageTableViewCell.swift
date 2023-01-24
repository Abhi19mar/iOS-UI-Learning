//
//  MessageTableViewCell.swift
//  ChatPractice
//
//  Created by Abhishek Goel on 20/12/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var position: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(element: ChatMessageDto) {
        label.text = element.msg
        if element.user == "1" {
            position.constant = 170
            view.backgroundColor = .lightGray
        }
        else {
            position.constant = 0
            view.backgroundColor = .orange
        }
    }
    
}
