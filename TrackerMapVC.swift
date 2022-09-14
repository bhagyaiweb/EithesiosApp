//
//  TrackerMapVC.swift
//  Eithes
//
//  Created by iws044 on 10/12/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import MapKit
import CoreLocation
import GoogleMaps

class TrackerMapVC: UIViewController,CLLocationManagerDelegate , MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var datalistTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.layer.cornerRadius = 20
        mapView.layer.masksToBounds = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }
            mapView.delegate = self
            mapView.mapType = .standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true

            if let coor = mapView.userLocation.location?.coordinate{
                mapView.setCenter(coor, animated: true)
            }
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        mapView.mapType = MKMapType.standard
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are Here"
        mapView.addAnnotation(annotation)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell1 = self.datalistTV.dequeueReusableCell(withIdentifier: "datacell")
        as! TrackerListCell
        
       // cell1.nameLbl.text = "Jack"
        return cell1
               // set the text from the data model
             //  cell.textLabel?.text = self.animals[indexPath.row]
    }

   

}
