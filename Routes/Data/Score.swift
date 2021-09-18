//
//  Score.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/19/21.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var date: Date?
    var scores = List<Int>()
    
}
