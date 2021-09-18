//
//  CollectionViewCell.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/22/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func prepareForReuse() {
        layer.cornerRadius = 10
        backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)

    }

}


