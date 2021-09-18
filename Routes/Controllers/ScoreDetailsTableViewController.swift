//
//  ScoreDetailsTableViewController.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/21/21.
//

import UIKit
import RealmSwift

class ScoreDetailsTableViewController: UITableViewController {

    var selectedGame: Score?


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Total: \(String(selectedGame!.scores.reduce(0, +)))"
        print("COUNT IS :", selectedGame!.scores.count)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return selectedGame!.scores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreDetailCell", for: indexPath) as! ScoreTableViewCell
        let basketScore = String(self.selectedGame!.scores[indexPath.row])
//        cell.textLabel?.text = "Basket \(indexPath.row + 1): \(basketScore)"
        cell.basketLabel.text = "\(indexPath.row + 1)"
        cell.scoreLabel.text = "Points \(basketScore)"
        return cell
    }

}
