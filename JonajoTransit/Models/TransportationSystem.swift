//
//  TransportationSystem.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/13/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class TransportationSystem : Decodable {
    var data : [GeneralData]?
    
    init(stations: [GeneralData]) {
        self.data = stations
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([GeneralData].self, forKey: .data)
    }
}
