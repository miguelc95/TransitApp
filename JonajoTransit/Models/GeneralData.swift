//
//  GeneralData.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class GeneralData: Decodable {
    let attributes : Attributes?
    
    enum CodingKeys: String, CodingKey {
        case attributes = "attributes"
    }
    
    init(attributes: Attributes) {
        self.attributes = attributes
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.attributes = try? values.decodeIfPresent(Attributes.self, forKey: .attributes)
    }
}
