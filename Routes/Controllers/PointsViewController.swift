//
//  PointsViewController.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/7/21.
//

import UIKit
import RealmSwift

class PointsViewController: UITableViewController {
    let realm = try! Realm()
    var pointsArray: Results<Point>?
    var selectedTrail: Trail? {
        didSet{
            loadItems()
            print(pointsArray?.count ?? 1)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointsArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath)
//        if let item = pointsArray?[indexPath.row] {
//            cell.textLabel?.text = "\(String(item.latitude)), \(String(item.longitude))"
//        } else {
//            cell.textLabel?.text = "No Points"
//        }
        return cell
    }


    //MARK: - Data Manipulation Methods
//    func saveItems() {
//        do {
//            try context.save()
//        } catch {
//            print("Error saving context \(error)")
//        }
//        self.tableView.reloadData()
//    }
//
    func loadItems() {
        pointsArray = selectedTrail?.points.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    //MARK: - Add New Points



}

