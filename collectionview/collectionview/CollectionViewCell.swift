//
//  CollectionViewCell.swift
//  collectionview
//
//  Created by Abhishek Goel on 15/06/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var outlet2: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    public func configure(with image : UIImage){
        outlet2.image = image
    }
    
}
