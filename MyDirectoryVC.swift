//
//  MyDirectoryVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 03/04/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import  GoogleMaps
import MapKit

class MyDirectoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCellDelegate1{
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addNewBtn: UIButton!
    
    @IBOutlet weak var addMoreView: UIView!
    
    var nameArray = ["Ali Morshedlou","Bram Naus","Ellyot"]
    var tabNAmeArray = ["My Connections","Trackers"]
    var nameTitle = ""
    var buttonTitleName = ""
    var  tracklistName = ["Ali Morshedlou","Bram Naus"]
    var dateArray = ["29/09/2019","2/10/2019"]
    var addArray = ["Ring Road","New Super Market"]
    var timeArray = ["14:00 PM","9:00 PM"]
   
    @IBOutlet weak var mapButtonView: UIView!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var nameCollection: UICollectionView!
    
    @IBOutlet weak var myDirectorytableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myDirectorytableView.separatorStyle = .none
        myDirectorytableView.isHidden = true
        reginib()
        addNewBtn.layer.cornerRadius = 5
        addNewBtn.clipsToBounds = true
        saveBtn.layer.cornerRadius = 5
        saveBtn.clipsToBounds = true
        addMoreView.isHidden = true
        addNewBtn.isHidden = true
        self.buttonsView.isHidden =  true
        self.mapButtonView.isHidden = true
        self.mapView.isHidden = true
      
        
    }
    
    @IBAction func onPresssedMapViewBtn(_ sender: Any)
    {
   self.buttonsView.isHidden =  true
        mapButtonView.backgroundColor = .clear
        mapButtonView.isHidden = false
        mapView.isHidden = false
//        mapview()
        
    }
    
    @IBAction func onPressedSaveBtn(_ sender: Any)
    {
    
        
    }
    
    @IBAction func onPressedTrackerListBtn(_ sender: Any)
    {
        self.buttonsView.isHidden = false
        self.mapButtonView.isHidden = true
           mapButtonView.isHidden = true
          mapView.isHidden = true

        
    }
    
    
    @IBAction func onPressedAddNewBtn(_ sender: Any)
    {
        addMoreView.isHidden = false
    }
    
    
    @IBAction func onPressedBackArrowBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onPressedSearchBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func reginib()
    {
        let nib = UINib(nibName: "Tabcollectioncell", bundle: nil)
        nameCollection.register(nib, forCellWithReuseIdentifier: "Tabcollectioncell")
         let nib1 = UINib(nibName: "MyDirectoryCell", bundle: nil)
        myDirectorytableView.register(nib1, forCellReuseIdentifier: "MyDirectoryCell")
        let nib2 = UINib(nibName: "TrackerListCell", bundle: nil)
        myDirectorytableView.register(nib2, forCellReuseIdentifier: "TrackerListCell")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNAmeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
                cell.delegate = self
              self.nameTitle = tabNAmeArray[indexPath.row]
              cell.shopLiftingBtn.setTitle(self.nameTitle, for: .normal)
               return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0; print("")

        let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        if collectionView == nameCollection{
            return CGSize(width: itemWidthtop/1.5, height: 30)
        }
//        if collectionView == feedDatacollectionView
//        {
//            return CGSize(width: itemWidthdown, height: 300)
//
//        }
        return CGSize(width: itemWidthdown, height: itemWidthdown)
    }
    func onpressedShopliftingBtn(cell: Tabcollectioncell)
    {
        if cell.shopLiftingBtn.backgroundColor == UIColor.gray
                            {
                   if cell.shopLiftingBtn.titleLabel?.text == "My Connections"
                                {
                   buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
                   self.myDirectorytableView.isHidden = false
                  self.myDirectorytableView.reloadData()
                addNewBtn.isHidden = false
                mapView.isHidden = true
                mapButtonView.isHidden = true
                buttonsView.isHidden = true

                        }
                                
           else if cell.shopLiftingBtn.titleLabel?.text == "Trackers"
                           {
              buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
              self.myDirectorytableView.isHidden = false
             self.myDirectorytableView.reloadData()
           addNewBtn.isHidden = true
            buttonsView.backgroundColor = .clear
            buttonsView.isHidden = false
           }
                                
                                
        }
        else
        {
            self.myDirectorytableView.isHidden = true
              addNewBtn.isHidden = true
               buttonsView.isHidden = true
               mapView.isHidden = true
        }
        
                                
        
    }
    // here working with tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonTitleName == "My Connections"
        {
        return nameArray.count
       }
        else if buttonTitleName == "Trackers"
        {
            return tracklistName.count
            
        }
        return tracklistName.count
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        
         if buttonTitleName == "My Connections"{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDirectoryCell", for: indexPath) as! MyDirectoryCell
        cell.namelbl.text = nameArray[indexPath.row]
        return cell
        }
         else
         {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackerListCell", for: indexPath) as! TrackerListCell
            cell.nameLbl.text = tracklistName[indexPath.row]
            cell.addressLbl.text = addArray[indexPath.row]
            cell.dateLbl.text = dateArray[indexPath.row]
            cell.timeLbl.text = timeArray[indexPath.row]
            return cell
        }
           
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 90
        
    }
    func mapview()
    {
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView.camera = camera
        mapView.delegate = (self as! GMSMapViewDelegate)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.mapView.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    

}
