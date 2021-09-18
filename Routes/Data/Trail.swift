//
//  Trail.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/9/21.
//

import Foundation
import RealmSwift
import MapKit

class Trail: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var isChecked = false
    @objc dynamic var difficulty = ""
    @objc dynamic var distance = 0.0
    let points = List<Point>()

    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func createPolyline(trail: Trail) -> CustomPolyline {
        var coords = [CLLocationCoordinate2D]()
        for point in trail.points {
            let latitude = (point.latitude as NSString).doubleValue
            let longitude = (point.longitude as NSString).doubleValue
            coords.append(CLLocationCoordinate2D(latitude: latitude,longitude: longitude))
        }
        let route = CustomPolyline(coordinates: coords, count: coords.count)
        if trail.difficulty == "beginner"{
            route.color = .green

        }else if trail.difficulty == "intermediate"{
            route.color = .blue

        } else if trail.difficulty == "advanced" {
            route.color = .purple
        } else {
            route.color = .brown
        }
        
        if trail.isChecked {
            route.alpha = 0.8
        } else {
            route.alpha = 0.1
        }
        return route
    }
}
