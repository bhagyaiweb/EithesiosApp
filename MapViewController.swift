//
//  MapViewController.swift
//  Eithes
//
//  Created by sumit bhardwaj on 03/08/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var TOPView: UIView!
    
    var locationManager: CLLocationManager!

    
    override func viewDidLoad() {
        super.viewDidLoad()


        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
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
    
    override func viewDidLayoutSubviews() {
                TOPView.layer.cornerRadius = 5
                mapView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
//     func layoutSubviews() {
//        super.layoutSubviews()
//        TOPView.layer.cornerRadius = 5
//        mapView.roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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

}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
