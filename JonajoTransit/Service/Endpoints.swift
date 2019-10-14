//
//  Endpoints.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/13/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class Endpoints {
    static let shared = Endpoints()
    let stations = "https://api-v3.mbta.com/stops?page%5Boffset%5D=20&page%5Blimit%5D=20&fields%5Bstop%5D=name%2Cdescription%2Clatitude%2Clongitude%2Cvehicle_type"
}
