//
//  ScoreTableViewCell.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/27/21.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var basketLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
