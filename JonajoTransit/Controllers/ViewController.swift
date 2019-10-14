//
//  ViewController.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/13/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var stations = [Attributes]() {
        didSet {
            if let location = self.locationManager.location {
            self.stations.sort{ Double($0.coordinate!.distance(from: location)) < Double($1.coordinate!.distance(from: location))}
                self.stationTableView.reloadSections([0], with: .automatic)
            }
        }
    }
    let locationManager = CLLocationManager()
    @IBOutlet weak var stationTableView: UITableView!
    let cellId = "stationCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stationTableView.delegate = self
        self.stationTableView.dataSource = self
        self.stationTableView.register(StationTableViewCell.self, forCellReuseIdentifier: cellId)
        setUpView()
        startMonitoringLocation()
        getData(nil)
        
    }
    
    @objc fileprivate func getData(_:UIBarButtonItem?) {
        Network.getExternalData(fileLocation: Endpoints.shared.stations) {(event:TransportationSystem?, error) in
            guard let generalData = event?.data else {
                self.alert(message: error!.localizedDescription, title: "Error")
                return
            }
            self.stations = generalData.map({
                if let att = $0.attributes {
                    return att
                }else {
                    return Attributes()
                }})
        }
        
    }
    
    fileprivate func setUpView(){
        self.title = "Stations"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        if #available(iOS 13.0, *) {
            let bar = self.navigationController?.navigationBar
            bar?.barTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            bar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else {
            self.navigationController?.navigationBar.prefersLargeTitles = true

        }
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(getData))
        reloadButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = reloadButton



    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StationTableViewCell
        cell.station = stations[indexPath.row]
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            LocationManager.shared.coordinate = location
            self.stations.sort{ Double($0.coordinate!.distance(from: location)) < Double($1.coordinate!.distance(from: location))}
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = StationDetailViewController()
        detailViewController.station = stations[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // Do any additional setup after loading the view.
    
    func startMonitoringLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    
}
