//
//  RouteCell.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/13/21.
//

import UIKit

class RouteCell: UITableViewCell {


    @IBOutlet weak var view: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
