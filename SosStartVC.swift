//
//  SosStartVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 08/04/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class SosStartVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var nameArray = ["Dorothy Powers","Yoandra Sans","Sarah Xandre"]
     var  commentArray = ["Stay safe buddy!","We’re reaching at your destination.","Just called the police, they are reaching."]
    var notifiedContactName = ["Allef Michel","Michael Dam","Daniel Xavier","Joelson Melo","Bruce Mars","Taiwili Kayan","Daniel Xavier","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich"]
    
    @IBOutlet weak var locationView: GMSMapView!
    
    @IBOutlet weak var videoCollectionVIew: UICollectionView!
    @IBOutlet weak var sumbitBtn: UIButton!
    @IBOutlet weak var complainView: UIView!
    @IBOutlet weak var notifiedContactCollectionview: UICollectionView!
    @IBOutlet weak var collectoionNotifiedContactsView: UIView!
    @IBOutlet weak var videoListView: UIView!
    @IBOutlet weak var sosMapView: GMSMapView!
    @IBOutlet weak var SosStartTable: UITableView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var timerBtn: UIButton!
    
    @IBOutlet weak var contactNotifiedView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerBtn.layer.cornerRadius = 12
        timerBtn.clipsToBounds = true
        videoCollectionVIew.delegate = self
        videoCollectionVIew.dataSource =  self
        SosStartTable.backgroundColor = .clear
        SosStartTable.separatorStyle = .none
        collectoionNotifiedContactsView.layer.cornerRadius = 20
        collectoionNotifiedContactsView.clipsToBounds = true
        self.notifiedContactCollectionview.backgroundColor = UIColor.clear
        videoListView.isHidden = true
        videoListView.backgroundColor = UIColor.black
        videoListView.layer.cornerRadius = 20
        videoListView.clipsToBounds = true
        complainView.layer.cornerRadius = 25
        complainView.clipsToBounds = true
        sumbitBtn.layer.cornerRadius = 10
        sumbitBtn.clipsToBounds = true
        //complainView.isHidden = false
        locationView.isHidden = true
        locationView.layer.cornerRadius = 25
        locationView.clipsToBounds = true
        mapview()
        reginib()
    }
//    override func viewWillAppear(_ animated: Bool) {
//
//        collectoionNotifiedContactsView.isHidden = true
//        videoCollectionVIew.isHidden = true
//        notifiedContactCollectionview.isHidden = true
//
//    }
    //let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))
   // contactNotifiedView.addGestureRecognizer(tap)

    // Then, you should implement the handler, which will be called each time when a tap event occurs:

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    }
    
    @IBAction func complaintBtnAction(_ sender: UIButton) {
        complainView.isHidden = false
    }
    
    @IBAction func onPressedSumbitBtn(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SumbitVideoVC") as? SumbitVideoVC
        self.present(vc!, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onpressedTimerBtn(_ sender: Any)
    {
        complainView.isHidden = true
    }
    
    @IBAction func onPressedStopBtn(_ sender: Any)
    {
        locationView.isHidden =  true
    }
    
    
    func reginib()
    {
        let nib = UINib(nibName: "SosStartCell", bundle: nil)
        SosStartTable.register(nib, forCellReuseIdentifier: "SosStartCell")
        let nib1 = UINib(nibName: "NotifiedContactCell", bundle: nil)
        notifiedContactCollectionview.register(nib1, forCellWithReuseIdentifier: "NotifiedContactCell")
    }
    
    @IBAction func onpressAddBtn(_ sender: Any)
    {
        videoListView.isHidden = false
    }
    
    @IBAction func onPressedarrowBtn(_ sender: Any)
    {
        collectoionNotifiedContactsView.isHidden = true
    }
    
    // working with collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == notifiedContactCollectionview{
    return notifiedContactName.count
        }
        else if collectionView == videoCollectionVIew
        {
            return 4
        }
        return notifiedContactName.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == notifiedContactCollectionview{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotifiedContactCell", for: indexPath) as! NotifiedContactCell
         cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.nameLbl.text = notifiedContactName[indexPath.row]
         return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.layer.backgroundColor = UIColor.clear.cgColor
            return cell
        }
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let layout = collectionViewLayout as! UICollectionViewFlowLayout
                  layout.minimumLineSpacing = 0
                  layout.minimumInteritemSpacing = 0
                  let numberOfItemsPerRow: CGFloat = 4.0; print("")

        _ = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
                  let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
          
            if collectionView == notifiedContactCollectionview
            {
//                let layout = collectionViewLayout as! UICollectionViewFlowLayout
//                          layout.minimumLineSpacing = 0
//                          layout.minimumInteritemSpacing = 0
//                          let numberOfItemsPerRow: CGFloat = 4.0
//                print("***")
//
//                          let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
//                _ = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
//                   return CGSize(width: itemWidthdown, height: 143)
            }
            if collectionView == videoCollectionVIew
            {  let layout = collectionViewLayout as! UICollectionViewFlowLayout
                          layout.minimumLineSpacing = 5
                          layout.minimumInteritemSpacing = 5
                          let numberOfItemsPerRow: CGFloat = 2.0; print("")

                _ = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
                          let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
                
                return CGSize(width: itemWidthdown, height: 200)
    
            }
            return CGSize(width: itemWidthdown, height: itemWidthdown)
        }
    
    
    // working with table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell =  tableView.dequeueReusableCell(withIdentifier:"SosStartCell", for: indexPath) as! SosStartCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.nameLbl.text = nameArray[indexPath.row]
        cell.commentLbl.text  = commentArray[indexPath.row]
        return cell
           
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func mapview(){
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        sosMapView.camera = camera
//        sosMapView.delegate = (self as! GMSMapViewDelegate)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.sosMapView.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
     
    func locatonmapview(){
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
            sosMapView.camera = camera
    //        sosMapView.delegate = (self as! GMSMapViewDelegate)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.locationView.addSubview(mapView)

            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
        }

}
