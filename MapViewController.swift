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

    var latitudeValStr : Double?
    var longValStr : Double?
    
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
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitudeValStr = (locValue.latitude)
        self.longValStr = (locValue.longitude)
        print("LAT****",self.latitudeValStr)
        print("LONGTI*****",self.longValStr)
        let userdefaults = UserDefaults.standard.setValue(self.latitudeValStr, forKey: "latitude")
        print("USERDEFAULTlat",userdefaults)
        let checklat = UserDefaults.standard.object(forKey: "latitude")
        print("USERDEFAULTlat",checklat)
        
        let userdefaultslong = UserDefaults.standard.setValue(self.longValStr, forKey: "longitude")
        print("USERDEFAULTlongit",userdefaultslong)
        let checklong = UserDefaults.standard.object(forKey: "longitude")
        print("USERDEFAULTlong",checklong)
        mapView.addAnnotation(annotation)
        
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            annotation.title = placemark.name! + "," + placemark.locality!
            print(placemark.postalCode ?? "")
            print(placemark.country ?? "")
            print("NAME",placemark.name)
            
            //print("SUBLOCALITY",placemark.subLocality)
            print("LOCALITY",placemark.locality)
          //  print("REGION",placemark.region)
           
        }
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
extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
