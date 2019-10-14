//
//  Stations.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/13/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import CoreLocation

class Attributes: Decodable {
    let latitude, longitude: Double?
    let name: String?
    let vehicleType: Int?
    let coordinate: CLLocation?
    let color: UIColor?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, name, description
        case vehicleType = "vehicle_type"
    }
    
    enum vehicleTypes: Int {
        case lightRail
        case heavyRail
        case comuterRail
        case bus
        case ferry
    }
    
    init(latitude: Double?, longitude: Double?, name: String, vehicleType: Int?, description: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.vehicleType = vehicleType
        self.coordinate = nil
        self.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.description = description
    }
    
    init() {
        self.latitude = 0
        self.longitude = 0
        self.name = ""
        self.vehicleType = 0
        self.coordinate = CLLocation(latitude: 0, longitude: 0)
        self.color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.description = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try? values.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        vehicleType = try? values.decodeIfPresent(Int.self, forKey: .vehicleType)
        description = try? values.decodeIfPresent(String.self, forKey: .description)
        coordinate = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
        switch vehicleType {
        case vehicleTypes.lightRail.rawValue:
            color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        case vehicleTypes.heavyRail.rawValue:
            color = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        case vehicleTypes.comuterRail.rawValue:
            color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        case vehicleTypes.bus.rawValue:
            color = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        case vehicleTypes.ferry.rawValue:
            color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        default:
            color = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
