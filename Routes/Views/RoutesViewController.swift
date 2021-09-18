//
//  ViewController.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/7/21.
//

import UIKit
import RealmSwift
import MapKit

protocol AddCoordinatesDelegate {
    func addCoordinates(points: [Loop])
}
private let reuseIdentifier = "RouteCell"

class RoutesViewController: UITableViewController {
//    let realm = try! Realm()
    let realm = try! Realm()

    @IBOutlet var myTableView: UITableView!
    var delegate: AddCoordinatesDelegate?
    var trails: Results<Trail>!
    var points: Results<Point>?
//    var selectedTrail: Trail?
//    var allTrails = [MKPolyline]()
    var allLoops = [Loop]()
    
    let trailSections = ["beginner", "intermediate", "advanced", "classical only"]


//    var selectedTrail: Trail? {
//        didSet {
//            loadItems()
//        }
//    }
    var selectedPoints: List<Point>?
    override func viewDidLoad() {
        super.viewDidLoad()
//        let realmPath = Bundle.main.url(forResource: "TrailData", withExtension: "realm")!
//        var realmConfiguration = Realm.Configuration(fileURL: realmPath, readOnly: true)
//        realm = try! Realm(configuration: realmConfiguration)
        

        trails = realm.objects(Trail.self).distinct(by: ["name"])

        points = realm.objects(Point.self)
//        loadLoops()
        title = "Trails"
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(UINib(nibName: "RouteCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goToMap))
        loadItems()
        loadPoints()

//        let trailCategories = trails.distinct(by: ["difficulty"])
//        for i in trailCategories{
//            print(i.difficulty)
//        }
//        let item = trails.filter("difficulty == %@", "beginner")
//        print("Item: ", item)
        self.tableView.rowHeight = 50.0
    }
    
//    func loadLoops() {
//        for trail in trails {
//            if trail.isChecked {
//                allLoops.append(Loop(polyline: trail.createPolyline(trail: trail), trail: trail))
//            }
//        }
//    }
//
//    func createPolyline(trail: Trail) -> MKPolyline {
//        var coords = [CLLocationCoordinate2D]()
//        for point in trail.points {
//            let latitude = (point.latitude as NSString).doubleValue
//            let longitude = (point.longitude as NSString).doubleValue
//            coords.append(CLLocationCoordinate2D(latitude: latitude,longitude: longitude))
//        }
//        let route = MKPolyline(coordinates: coords, count: coords.count)
//        return route
//    }
    
    @objc func goToMap() {
        delegate?.addCoordinates(points: allLoops)
        self.navigationController?.popViewController(animated: true)
    }
    

    //MARK: - Tableview Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return trailSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return trailSections[section].capitalized
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = trails.filter("difficulty == %@", trailSections[section]).distinct(by: ["name"])
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        trails = realm.objects(Trail.self)

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RouteCell
        let item = trails.filter("difficulty == %@", trailSections[indexPath.section]).distinct(by: ["name"])[indexPath.row]
//        let item = trails[indexPath.row]
//        cell.textLabel?.text = item.name
        cell.label.text = item.name
        cell.distanceLabel.text = "\(item.distance) km"
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let trail = trails?.filter("difficulty == %@", trailSections[indexPath.section]).distinct(by: ["name"])[indexPath.row] {
            let duplicateTrails = realm.objects(Trail.self).filter("name == %@", trail.name)
            do {
                try realm.write {
                    for item in duplicateTrails {
                        item.isChecked = !item.isChecked
                    }
                }
            } catch {
                print("Error saving isChecked, \(error)")
            }

        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        selectedPoints = trails[indexPath.row].points
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        if let destinationVC = segue.destination as? PointsViewController{
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVC.selectedTrail = trails[indexPath.row]
//        }
//        }
    }
    

    //MARK: - Model Manipulation Methods
    
    func save(trail: Trail) {
        do {
            try realm.write {
                realm.add(trail)
            }
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        trails = realm.objects(Trail.self)
        tableView.reloadData()
    }

    func loadPoints() {
        points = realm.objects(Point.self)
//        points = selectedTrail?.points.sorted(byKeyPath: "lattitude", ascending: true)
    }
    
//    func loadItems() {
//        pointsArray = selectedTrail?.points.sorted(byKeyPath: "title", ascending: true)
//        tableView.reloadData()
//    }
    
//func loadPoints(with request: NSFetchRequest<Point> = Point.fetchRequest(), predicate: NSPredicate) {
//    request.predicate = predicate
//    do {
//        pointsArray = try context.fetch(request)
//    } catch {
//        print("Error fetching data from context \(error)")
//    }
//}
}

//MARK: - Search Bar Methods

extension RoutesViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Trail> = Trail.fetchRequest()
//        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//        loadItems(with: request)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
}

