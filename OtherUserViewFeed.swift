 
//  OtherUserViewFeed.swift
//  Eithes
//  Created by Shubham Tomar on 13/04/20.
//  Copyright © 2020 Iws. All rights reserved.
import UIKit
import GoogleMaps
import  GooglePlaces
class OtherUserViewFeed: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var nameArray = ["Dorothy Powers","Yoandra Sans","Sarah Xandre"]
        var  commentArray = ["Stay safe buddy!","We’re reaching at your destination.","Just called the police, they are reaching."]
       var notifiedContactName = ["Allef Michel","Michael Dam","Daniel Xavier","Joelson Melo","Bruce Mars","Taiwili Kayan","Daniel Xavier","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich"]
    
    @IBOutlet weak var bckArrowBtn: UIButton!
    
    @IBOutlet weak var joinFeedImageView: UIView!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBOutlet weak var otherUserMapView: GMSMapView!
    
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var jointStreamBtn: UIButton!
    
    @IBOutlet weak var viewFeedTableView: UITableView!
    
    @IBOutlet weak var iconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewFeedTableView.separatorStyle = .none
        commentView.layer.cornerRadius = 5
        commentView.clipsToBounds = true
        jointStreamBtn.layer.cornerRadius = 5
        jointStreamBtn.clipsToBounds = true
        timerButton.layer.cornerRadius = 12
        timerButton.clipsToBounds = true
        stopBtn.layer.cornerRadius = 12
        stopBtn.clipsToBounds = true
        popupView.isHidden = true
        popupView.layer.cornerRadius = 10
        popupView.clipsToBounds = true
        otherUserMapView.isHidden = true
        otherUserMapView.layer.cornerRadius = 15
         distanceView.layer.cornerRadius = 5
        otherUserMapView.clipsToBounds = true
        distanceView.isHidden = true
        joinFeedImageView.isHidden = true
          reginib()
    }
    
    @IBAction func onPressedStopBtn(_ sender: Any)
    {
         bckArrowBtn.isHidden = true
        otherUserMapView.isHidden = false
         popupView.isHidden = true
          distanceView.isHidden = false
        joinFeedImageView.isHidden = true
        iconImage.isHidden = false

    }
    @IBAction func onPressedTimerBtn(_ sender: Any)
    {
        bckArrowBtn.isHidden = true
        popupView.isHidden = false
        otherUserMapView.isHidden = true
          distanceView.isHidden = true
           joinFeedImageView.isHidden = true
          iconImage.isHidden = false
        
    }
    
    @IBAction func onPressedBckArrowBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onPressedIconImage(_ sender: Any)
    {
        joinFeedImageView.isHidden = false
        bckArrowBtn.isHidden = true
        popupView.isHidden = true
        otherUserMapView.isHidden = true
        distanceView.isHidden = true
        iconImage.isHidden = true
        
    }
    
    
    func reginib()
    {
        let nib = UINib(nibName: "SosStartCell", bundle: nil)
        viewFeedTableView.register(nib, forCellReuseIdentifier: "SosStartCell")
        
    }
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"SosStartCell", for: indexPath) as! SosStartCell
               cell.layer.backgroundColor = UIColor.clear.cgColor
               cell.nameLbl.text = nameArray[indexPath.row]
               cell.commentLbl.text  = commentArray[indexPath.row]
               
               return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func locatonmapview()
        {
            
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
            otherUserMapView.camera = camera
            otherUserMapView.delegate = (self as! GMSMapViewDelegate)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.otherUserMapView.addSubview(mapView)

            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
        
 
}
    
}
