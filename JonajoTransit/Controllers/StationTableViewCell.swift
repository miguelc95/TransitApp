//
//  StationTableViewCell.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import CoreLocation

class StationTableViewCell: UITableViewCell {
    
    var station = Attributes() {
        didSet {
            textLabel?.text = station.name
            textLabel?.textColor = UIColor(named: "text")
            detailTextLabel?.textColor = station.color
            if let stationCoordinate = station.coordinate, station.latitude != nil {
                let distance = round(Double(LocationManager.shared.coordinate.distance(from: stationCoordinate)))
                if distance < 1000 {
                    detailTextLabel?.text = "\(distance.cleanDecimal()) mts"
                } else {
                    detailTextLabel?.text = "\(round((distance/1000)).cleanDecimal()) kms"

                }
            } else {
                detailTextLabel?.text = "No information"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
