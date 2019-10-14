//
//  StationDetailViewController.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit
import MapKit

class StationDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionView: UIView!
    
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    var station = Attributes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        mapView.delegate = self

        // Do any additional setup after loading the view.
    }

    func setupViews() {
        descriptionView.backgroundColor = UIColor(named: "Views")

        self.navigationController?.navigationBar.tintColor = .white
        self.title = station.name
        descriptionLbl.text = station.description == nil ? "No description" : station.description
        if let stationCoordinate = station.coordinate, station.latitude != nil {
            let distance = round(Double(LocationManager.shared.coordinate.distance(from: stationCoordinate)))
            if distance < 1000 {
                distanceLbl?.text = "\(distance.cleanDecimal()) meters"
            } else {
                distanceLbl?.text = "\(round((distance/1000)).cleanDecimal()) kms"
                
            }
        } else {
            distanceLbl?.text = "No information"
        }
        
        let stationAnnotation = MKPointAnnotation()
        stationAnnotation.title = station.name
        stationAnnotation.coordinate = CLLocationCoordinate2DMake(station.coordinate?.coordinate.latitude ?? 0, station.coordinate?.coordinate.longitude ?? 0)
        mapView.addAnnotation(stationAnnotation)
        let center = CLLocationCoordinate2DMake(station.coordinate?.coordinate.latitude ?? 0, station.coordinate?.coordinate.longitude ?? 0)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }

    @IBAction func getDirections(_ sender: Any) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(station.coordinate?.coordinate.latitude ?? 0, station.coordinate?.coordinate.longitude ?? 0)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = station.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
