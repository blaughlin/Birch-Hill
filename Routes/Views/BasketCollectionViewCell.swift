//
//  BasketCollectionViewCell.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/24/21.
//

import UIKit

class BasketCollectionViewCell: UICollectionViewCell {
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var bucketLabel: UILabel!
    
    func setLabel(label:String, bucket:String) {
        myLabel.text = label
        bucketLabel.text = bucket
    }
}
