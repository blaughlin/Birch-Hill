//
//  MapViewController.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/7/21.
//

import UIKit
import MapKit
import RealmSwift

class MapViewController: UIViewController,  CLLocationManagerDelegate, MKMapViewDelegate {

    var scoreArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    fileprivate let locationManager = CLLocationManager()

    @IBOutlet var getLocationLabel: UILabel!
    var name: String? = "Birch Hill"
    var coords = [CLLocationCoordinate2D]()
    var currentLocation: CLLocationCoordinate2D!
    var testline = MKPolyline()
    var allTrails = [MKPolyline]()
    let realm = try! Realm()
    var myHeading = 0
    var trails: Results<Trail>!
    var baskets: [MKPointAnnotation] = []
    var showBaskets = true
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        mapView.showsCompass = true
        mapView.showsUserLocation = true
//        mapView.isRotateEnabled = true
//        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
        title = name
//        locationLabel.text = "Location:"
//        locationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//        locationLabel.numberOfLines = 0
        trails = realm.objects(Trail.self)
        loadLoops()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Trails", style: .plain, target: self, action: #selector(chooseTrails))
        baskets = addPoints()
        segmentController.addTarget(self, action: #selector(switchType), for: .valueChanged)
        let birchHillCoordinate = CLLocationCoordinate2D(latitude: 64.868788, longitude: -147.647658)
        let birchHillRegion = MKCoordinateRegion(center: birchHillCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(birchHillRegion, animated: true)

//        let camera = MKMapCamera(lookingAtCenter: birchHillCoordinate, fromDistance: 1000, pitch: 0, heading: heading!)
//        self.mapView.setCamera(camera, animated: false)



    }
    

    @IBAction func toggleBaskets(_ sender: UIBarButtonItem) {
        self.showBaskets = !showBaskets
        if self.showBaskets {
            for basket in self.baskets {
                self.mapView.addAnnotation(basket)
            }
        } else {
            for basket in self.baskets {
                self.mapView.removeAnnotation(basket)
            }
        }
    }
    
    @objc fileprivate func switchType() {
        switch segmentController.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            return
        }
    }
    
    @IBAction func getLocationPressed(_ sender: Any) {
        if (self.currentLocation != nil) {
            self.getLocationLabel.text = ("lat: \(self.currentLocation.latitude), lon: \(self.currentLocation.longitude)")
        }
    }
    
    func updateSideTrailOvelays() {
        for trail in self.trails {
            if trail.isChecked {
                
            }
        }
    }
    
    func addPoints() -> [MKPointAnnotation] {
        let disc1 = MKPointAnnotation()
        disc1.title = "Basket 01"
        disc1.coordinate = CLLocationCoordinate2D(latitude: 64.867988, longitude: -147.650484)
        mapView.addAnnotation(disc1)
        let disc2 = MKPointAnnotation()
        disc2.title = "Basket 02"
        disc2.coordinate = CLLocationCoordinate2D(latitude: 64.867077, longitude: -147.651317)
        mapView.addAnnotation(disc2)
        let disc3 = MKPointAnnotation()
        disc3.title = "Basket 03"
        disc3.coordinate = CLLocationCoordinate2D(latitude: 64.866273, longitude: -147.654250)
        mapView.addAnnotation(disc3)
        let disc4 = MKPointAnnotation()
        disc4.title = "Basket 04"
        disc4.coordinate = CLLocationCoordinate2D(latitude: 64.865771, longitude: -147.656588)
        mapView.addAnnotation(disc4)
        let disc5 = MKPointAnnotation()
        disc5.title = "Basket 05"
        disc5.coordinate = CLLocationCoordinate2D(latitude: 64.865067, longitude: -147.657248)
        mapView.addAnnotation(disc5)
        let disc6 = MKPointAnnotation()
        disc6.title = "Basket 06"
        disc6.coordinate = CLLocationCoordinate2D(latitude: 64.865780, longitude: -147.655418)
        mapView.addAnnotation(disc6)
        
        let disc7 = MKPointAnnotation()
        disc7.title = "Basket 07"
        disc7.coordinate = CLLocationCoordinate2D(latitude: 64.865962, longitude: -147.652772)
        mapView.addAnnotation(disc7)
        
        let disc8 = MKPointAnnotation()
        disc8.title = "Basket 08"
        disc8.coordinate = CLLocationCoordinate2D(latitude: 64.866618, longitude: -147.650135)
        mapView.addAnnotation(disc8)
        
        let disc9 = MKPointAnnotation()
        disc9.title = "Basket 09"
        disc9.coordinate = CLLocationCoordinate2D(latitude: 64.868788, longitude: -147.647658)
        mapView.addAnnotation(disc9)
        
        let disc10 = MKPointAnnotation()
        disc10.title = "Basket 10"
        disc10.coordinate = CLLocationCoordinate2D(latitude: 64.867282, longitude: -147.648812)
        mapView.addAnnotation(disc10)
        
        let disc11 = MKPointAnnotation()
        disc11.title = "Basket 11"
        disc11.coordinate = CLLocationCoordinate2D(latitude: 64.866223, longitude: -147.650115)
        mapView.addAnnotation(disc11)
        
        let disc12 = MKPointAnnotation()
        disc12.title = "Basket 12"
        disc12.coordinate = CLLocationCoordinate2D(latitude: 64.865333, longitude: -147.652552)
        mapView.addAnnotation(disc12)
        
        let disc13 = MKPointAnnotation()
        disc13.title = "Basket 13"
        disc13.coordinate = CLLocationCoordinate2D(latitude: 64.864560, longitude: -147.650610)
        mapView.addAnnotation(disc13)
        
        let disc14 = MKPointAnnotation()
        disc14.title = "Basket 14"
        disc14.coordinate = CLLocationCoordinate2D(latitude: 64.865292, longitude: -147.651653)
        mapView.addAnnotation(disc14)
        
        let disc15 = MKPointAnnotation()
        disc15.title = "Basket 15"
        disc15.coordinate = CLLocationCoordinate2D(latitude: 64.865963, longitude: -147.649506)
        mapView.addAnnotation(disc15)
        
        let disc16 = MKPointAnnotation()
        disc16.title = "Basket 16"
        disc16.coordinate = CLLocationCoordinate2D(latitude: 64.866905, longitude: -147.647726)
        mapView.addAnnotation(disc16)
        
        let disc17 = MKPointAnnotation()
        disc17.title = "Basket 17"
        disc17.coordinate = CLLocationCoordinate2D(latitude: 64.867910, longitude: -147.646572)
        mapView.addAnnotation(disc17)
        
        let disc18 = MKPointAnnotation()
        disc18.title = "Basket 18"
        disc18.coordinate = CLLocationCoordinate2D(latitude: 64.868339, longitude: -147.647402)
        mapView.addAnnotation(disc18)
        
        return([disc1, disc2, disc3, disc4, disc5, disc6, disc7, disc8, disc9, disc10, disc11, disc12, disc13, disc14, disc15, disc16, disc17, disc18])
    }
    
    func searchCoordinates(userLocation: CLLocation) {
        var closestDistance = Double.infinity
        var closestTrail: Trail?
        for trail in self.trails {
            let coordinates = trail.points
                    for point in coordinates {
                        let distanceFromUser = userLocation.distance(from: CLLocation(latitude: Double(point.latitude)!, longitude: Double(point.longitude)!))
                        if distanceFromUser < closestDistance {
                            closestDistance = distanceFromUser
                            closestTrail = trail
                        }
            }
        }
        if closestDistance < 50 {
            if let onTrail = closestTrail {
                self.title = onTrail.name
            }
        } else {
            self.title = "Searching for trail"
        }
    }
    
    @objc func chooseTrails() {
        let controller = RoutesViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func showScore(bucketId: String) {
        let scoreController = self.storyboard?.instantiateViewController(withIdentifier: "ScoreCardViewController") as! ScoreCardViewController
        scoreController.delegate = self
        scoreController.currentBucket = bucketId
        scoreController.scores = self.scoreArray
        navigationController?.pushViewController(scoreController, animated: false)
    }
    
    func loadLoops() {
        for trail in trails {
            self.mapView.addOverlay(trail.createPolyline(trail: trail))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        mapView.camera.heading = newHeading.magneticHeading
//        self.myHeading = newHeading
//        mapView.setCamera(mapView.camera, animated: false)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Need to add an if statement to determine if user is

//        let region = MKCoordinateRegion(center: locations.first!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let camera = MKMapCamera(lookingAtCenter: locations.first!.coordinate, fromDistance: 1000, pitch: 0, heading: mapView.camera.heading)
//        mapView.setRegion(region, animated: true)
        mapView.setCamera(camera, animated: false)
        guard  let userLocation: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        self.currentLocation = userLocation
//        locationLabel.text = ("lat: \(userLocation.latitude), lon: \(userLocation.longitude)")
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        searchCoordinates(userLocation: location)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? CustomPolyline {
            let testlineRenderer = MKPolylineRenderer(overlay: polyline)
            testlineRenderer.strokeColor = polyline.color!
            testlineRenderer.alpha = polyline.alpha!
            testlineRenderer.lineWidth = 2.0
            return testlineRenderer
        }
        fatalError("Something wrong...")
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        if let bucketToBeSent = view.annotation?.title {
            showScore(bucketId: bucketToBeSent!)
            mapView.deselectAnnotation(view as? MKAnnotation, animated: false)
        }
    }
    
}

    


extension MapViewController: AddCoordinatesDelegate {
    func addCoordinates(points: [Loop]) {
        for poll in mapView.overlays {
             mapView.removeOverlay(poll)
         }
        self.loadLoops()
        }
    
}

extension MapViewController: updateScoreDelegate {
    func updateScore(scores: [Int]) {
        self.scoreArray = scores
    }
    
    
}

