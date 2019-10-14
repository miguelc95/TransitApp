//
//  Location.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager {
    
    var coordinate : CLLocation
    static var shared = LocationManager()
    
    init() {
        coordinate = CLLocation(latitude: 0, longitude: 0)
    }

}
