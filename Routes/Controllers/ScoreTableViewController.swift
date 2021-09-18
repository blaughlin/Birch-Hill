//
//  ScoreTableViewController.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/19/21.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ScoreTableViewController: UITableViewController {
//    @IBOutlet weak var textLabel: UILabel!
    let realm = try! Realm()
    var scores: Results<Score>!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Scores"
        scores = realm.objects(Score.self)
        print("Count", scores.count)
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        tableView.rowHeight = 80.0

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scores?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tying")
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        print("yes")
        let finalScore = String(scores[indexPath.row].scores.reduce(0, +))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let gameDate = scores[indexPath.row].date!
        cell.textLabel?.text = "\(dateFormatter.string(from: gameDate)) Total Score: \(finalScore)"
        cell.accessoryType = .detailButton
        cell.tintColor = .systemBlue


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "scoreDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ScoreDetailsTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedGame = scores?[indexPath.row]
        }
    }
    

}

//MARK: - Swipe Cell Delegate Methods

extension ScoreTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            if let gameForDeletion = self.scores?[indexPath.row] {
                do {
                    try self.realm.write {
                        self.realm.delete(gameForDeletion)
                    }
                } catch {
                        print("Error deleting game \(error)")
                    }
            }
            print("Item deleted")
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
}
