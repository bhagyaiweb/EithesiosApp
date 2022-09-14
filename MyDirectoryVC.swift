
//  MyDirectoryVC.swift
//  Eithes
//  Created by Shubham Tomar on 03/04/20.
//  Copyright © 2020 Iws. All rights reserved.



import UIKit
import GoogleMaps
import MapKit
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import Accelerate
import MessageUI


class MyDirectoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCellDelegate1,MFMessageComposeViewControllerDelegate,GMSMapViewDelegate,MyDirectoryCellDelegate {
    
    func callbtnTapped(cell: MyDirectoryCell) {
        print("PRINTING")
        if self.buttonTitleName == "My Connections"{
            let indexPath = self.myDirectorytableView.indexPath(for: cell)
            let number = self.myConnections[indexPath!.row]["phone_number"].stringValue
            print("MYCONNECT",number)
            self.dialNumber(number: number)
        }
        else{
            let indexPath = self.myDirectorytableView.indexPath(for: cell)
            let number = self.myConnections[indexPath!.row]["phone_number"].stringValue
            print("NUMBERConnection",number)
            self.dialNumber(number: number)
        }
    }
    
    
    func messagebtnTapped(cell: MyDirectoryCell) {
        if   self.buttonTitleName == "My Connections"{
            let indexPath = self.myDirectorytableView.indexPath(for: cell)
            let number = self.myConnections[indexPath!.row]["name"].stringValue
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "Enter a message details here";
            messageVC.recipients = [number]
            messageVC.messageComposeDelegate = self
            self.present(messageVC, animated: true, completion: nil)
        }
        
    }
    
    

   // @IBOutlet weak var mapView: GMSMapView!
   // @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var addNewBtn: UIButton!
    
    var nameArray = ["Ali Morshedlou","Bram Naus","Ellyot"]
    var tabNAmeArray = ["My Connections","Trackers"]
    var nameTitle = ""
    var buttonTitleName = "My Connections"
    var  tracklistName = ["Ali Morshedlou","Bram Naus"]
    var dateArray = ["29/09/2019","2/10/2019"]
    var addArray = ["Ring Road","New Super Market"]
    var timeArray = ["14:00 PM","9:00 PM"]
    
    var myConnections = Array<JSON>()
    var trackersList = Array<JSON>()

    
    var selecteditem = 0
   
   let tbcell = MyDirectoryCell()
    
    @IBOutlet weak var mapButtonView: UIView!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var nameCollection: UICollectionView!
    
    @IBOutlet weak var myDirectorytableView: UITableView!
    
    @IBOutlet weak var nodataLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myDirectorytableView.separatorStyle = .none
        myDirectorytableView.isHidden = false
        myDirectorytableView.reloadData()
        if buttonTitleName == "My Connections"
                     {
            getConnectionList()
        self.myDirectorytableView.isHidden = false
       self.myDirectorytableView.reloadData()
            reginib()
                }
        myDirectorytableView.isHidden = false
        myDirectorytableView.reloadData()
        self.dismiss(animated: true)
        addNewBtn.layer.cornerRadius = 5
        addNewBtn.clipsToBounds = true
      //  saveBtn.layer.cornerRadius = 5
       // saveBtn.clipsToBounds = true
       // addMoreView.isHidden = true
        addNewBtn.isHidden = false
        self.buttonsView.isHidden =  true
        self.mapButtonView.isHidden = true
      //  self.mapView.isHidden = true
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getConnectionList()
        self.nodataLbl.isHidden = true
        myDirectorytableView.isHidden = false
        myDirectorytableView.reloadData()
    }
    
   
   
   
    @IBAction func serchingBtnAction(_ sender: UIButton) {
        let myvc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        myvc?.isSerach = "MyDirect"
        self.present(myvc!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onPresssedMapViewBtn(_ sender: Any)
    {
        self.buttonsView.isHidden =  false
        self.mapButtonView.backgroundColor = .clear
        self.mapButtonView.isHidden = false
       //mapView.isHidden = false
       //mapview()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "TrackerMapVC") as! TrackerMapVC
       // self.navigationController?.pushViewController(next, animated: true)
      //  self.navigationController?.popViewController(animated: true)
        self.present(next, animated: true, completion: nil)
       // self.popoverPresentationController(next)
    }
    
    @IBAction func onPressedSaveBtn(_ sender: Any)
    {
      
    }
    
    @IBAction func onPressedTrackerListBtn(_ sender: Any)
    {
        self.buttonsView.isHidden = false
       // self.mapButtonView.isHidden = true
        self.mapButtonView.isHidden = false
      //  mapView.isHidden = false
    }
    
    
    @IBAction func sosButonAction(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ChooseCategoryVC") as! ChooseCategoryVC
       self.present(next, animated: true, completion: nil)
    }
    
    
    @IBAction func onPressedAddNewBtn(_ sender: Any)
    {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AddNewConnectionVC") as! AddNewConnectionVC
       self.present(next, animated: true, completion: nil)
    }
    
    
    @IBAction func onPressedBackArrowBtn(_ sender: Any)
    {
        //self.navigationController?.popViewController(animated: true)
      //  self.dismiss(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPressedSearchBtn(_ sender: Any)
    {
       // self.navigationController?.pushViewController(vc!, animated: true)
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
        if   self.selecteditem == indexPath.row  {
            cell.shopLiftingBtn.backgroundColor = UIColor.blue
            print("self.selcvv",self.selecteditem)
//            if indexPath.row == 0 {
//                getConnectionList()
//            }
//            if indexPath.row == 1 {
//             //   getTrackerLists()
//            }
        // self.feedDatacollectionView.isHidden = false
        }else {

         cell.shopLiftingBtn.backgroundColor = UIColor.gray
     }
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
       
        if indexPath.row == 0 {
            cell.shopLiftingBtn.isSelected = true
            cell.shopLiftingBtn.backgroundColor = UIColor.blue
            buttonTitleName = "My Connections"
            self.myDirectorytableView.isHidden = false
            let tbcell = MyDirectoryCell()
            tbcell.namelbl.text = nameArray[indexPath.row]
            tbcell.mapBtn.isHidden = true
           // tbcell.callBtn.addTarget(self, action: #selector(callbtnTapped), for: .touchUpInside)
           // tbcell.mapBtn.addTarget(self, action: #selector(mapcheck), for: .touchUpInside)
            myDirectorytableView.reloadData()
        }else{
            cell.shopLiftingBtn.isSelected = false
            cell.shopLiftingBtn.backgroundColor = UIColor.gray
            self.myDirectorytableView.isHidden = true
        }

    }
    let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
    
    func getConnectionList(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
            let parameter:[String:String] = [
                "user_id": userid
        ]
        
        print("\nThe parameters of ConnectionList : \(parameter)\n")
        self.myConnections.removeAll()
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getmyConnectionList, dataDict: parameter, { (json) in
            print("PARMASINDIRECTORY",parameter)
                            print(json)
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

                            if json["status"].stringValue == "200" {
                               self.nodataLbl.isHidden = true

                                if let data = json["data"].array{
                                    self.myConnections = data
                                    print("MYDICDATA",data)
                                    print("MYDICDATA12",self.myConnections)
                                    self.myDirectorytableView.reloadData()
                                    self.myDirectorytableView.isHidden = false
                                    self.myDirectorytableView.reloadData()
                                }
//                                DispatchQueue.main.async {
//                                 self.myDirectorytableView.reloadData()
//                                }
                            }else {
                              //  self.myConnections.removeAll()
                              //  self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                                self.nodataLbl.isHidden = false
                                let msg = json["msg"].stringValue
                                self.nodataLbl.text = msg
                               
                            }
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }
    
    
    func getTrackerLists(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
            let parameter:[String:String] = [
                "user_id": userid
            ]
            print("\nThe parameters for TRackers : \(parameter)\n")
            //self.trackersList.removeAll()
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getTrackerList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    self.nodataLbl.isHidden = true

                                    if let data = json["data"].array{
                                        self.trackersList = data
                                        print("TRACKERSLIST",self.trackersList)
                                      //  self.addVideosButton.isHidden = true
                                        self.myDirectorytableView.reloadData()
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.myDirectorytableView.reloadData()
                                    }
                                    self.myDirectorytableView.reloadData()
                                }else {
                                   // self.trackersList.removeAll()
                                    
                                   // self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                                    self.nodataLbl.isHidden = false
                                    let msg = json["msg"].stringValue
                                    self.nodataLbl.text = msg
                                    
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                        return
//                                    })
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
  
    func deletebtnTapped(cell: MyDirectoryCell) {
        
        let alert = UIAlertController(title: "Remove this connection", message: "Are you sure to remove this connection.", preferredStyle: .alert)

        
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let indexPath = self.myDirectorytableView.indexPath(for: cell)
            cell.delegate =  self

            print(self.myConnections[indexPath!.row]["connection_id"].stringValue)
            let parameter:[String:String] = [
                "user_id": self.userid,
                                "connection_id":self.myConnections[indexPath!.row]["connection_id"].stringValue
                            ]

                            print("\nThe parameters for delete : \(parameter)\n")
                            let activityData = ActivityData()
                            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                            
                            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.deleteConnection, dataDict: parameter, { (json) in
                                print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                                   
                                  //  self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                        self.myDirectorytableView.isHidden = true
                                        self.myConnections.removeAll()
                                        self.getConnectionList()
                                    })
                                }else {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                                    
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                        return
//                                    })
                                }
                                
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onpressedShopliftingBtn(cell: Tabcollectioncell)
    {
        
        
        let indexpath = self.nameCollection.indexPath(for: cell)
        self.selecteditem = indexpath?.row ?? 0
        
        DispatchQueue.main.async {
            self.nameCollection.reloadData()
            self.myDirectorytableView.reloadData()
        }
        
//        if selecteditem == 0 {
//            // cell.shopLiftingBtn.titleLabel?.text = "My Connections"
//              //  buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//            getConnectionList()
//            self.myDirectorytableView.isHidden = false
//           self.myDirectorytableView.reloadData()
//        }
//
//        if selecteditem == 1 {
//            // cell.shopLiftingBtn.titleLabel?.text = "My Connections"
//              //  buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//            self.myDirectorytableView.isHidden = false
//
//            getTrackerLists()
//
////            if self.buttonTitleName == "Trackers" {
////                getTrackerLists()
////                self.myDirectorytableView.reloadData()
////
////            }
//           // getTrackerLists()
//          //  self.myDirectorytableView.isHidden = false
//          // self.myDirectorytableView.reloadData()
//        }
        
        if cell.shopLiftingBtn.backgroundColor == UIColor.gray
                            {
                   if cell.shopLiftingBtn.titleLabel?.text == "My Connections"
                                {
                   buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
                       getConnectionList()
                   self.myDirectorytableView.isHidden = false
                  self.myDirectorytableView.reloadData()

                       addNewBtn.isHidden = false
                        buttonsView.backgroundColor = .clear
                        buttonsView.isHidden = true
                        }
           else if cell.shopLiftingBtn.titleLabel?.text == "Trackers"
                           {
              buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
               getTrackerLists()
              self.myDirectorytableView.isHidden = false
             self.myDirectorytableView.reloadData()
               addNewBtn.isHidden = true
             //  mapView.isHidden = true
               mapButtonView.isHidden = true
               buttonsView.isHidden = true

           }
        }
//        else
//        {
//          //  self.myDirectorytableView.isHidden = true
////              addNewBtn.isHidden = true
////               buttonsView.isHidden = true
////               mapView.isHidden = true
//        }
    }
    // here working with tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonTitleName == "My Connections"
        {
            print("COUNTnew",self.myConnections.count)

            return self.myConnections.count
        }
        if buttonTitleName == "Trackers"{
            print("COUNT",trackersList.count)
            return trackersList.count
        }
        return myConnections.count
//        else if buttonTitleName == "Trackers"
//        {
//            print("TRACKERSLISTCOUNT",trackersList.count)
//            return trackersList.count
//        }
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        
         if buttonTitleName == "My Connections"{
             let cell = tableView.dequeueReusableCell(withIdentifier: "MyDirectoryCell", for: indexPath) as! MyDirectoryCell
            // cell.callBtn.addTarget(self, action: #selector(callbtnTapped), for: .touchUpInside)
            // if self.myConnections.count > 0 {
            // let data = self.myConnections[indexPath.row].dictionaryValue

            // print("DATADICTIONARY",data)
            // self.myDirectorytableView.reloadData()
             cell.namelbl.text! = self.myConnections[indexPath.row]["name"].stringValue
             print("DATADICTIONARY12812",cell.namelbl.text!)
             
             cell.phoneLbl.text = self.myConnections[indexPath.row]["phone_number"].stringValue
             
             if self.myConnections[indexPath.row]["profile_pic"].stringValue != ""{
                 let imgURL = URL(string: self.myConnections[indexPath.row]["profile_pic"].stringValue)
                     cell.picImgView.kf.setImage(with: imgURL)

//                     if imgURL == nil {
//
//                  // imgURL == URL(string: data["profile_pic"]!.stringValue) ?? UIImage(named: "")
//                     }else{
//
//                         cell.picImgView.kf.setImage(with: imgURL)
//                         NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

//                     }
                 }
             cell.delegate = self

             cell.mapBtn.isHidden = true
               //  cell.mapBtn.addTarget(self, action: #selector(mapcheck), for: .touchUpInside)
           //  }
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDirectoryCell", for: indexPath) as! MyDirectoryCell
//           cell.namelbl.text = nameArray[indexPath.row]
//        cell.mapBtn.addTarget(self, action: #selector(mapcheck), for: .touchUpInside)
            
        return cell
        }else {
              //  buttonTitleName == "Trackers"

               let cell = tableView.dequeueReusableCell(withIdentifier: "TrackerListCell", for: indexPath) as! TrackerListCell
                let data = self.trackersList[indexPath.row].dictionaryValue
            cell.nameLbl.text =  data["name"]?.stringValue
          
            cell.addressLbl.text = data["location"]?.stringValue
            
            var dateStr = data["created_at"]?.stringValue
             //cell.dateLbl.text = data["created_at"]?.stringValue
            print("DATESHT",dateStr!)
            var strArray = dateStr?.components(separatedBy: "T")
            print("strARRAY",strArray!)
            print(strArray![0])

            cell.dateLbl.text = strArray![0]
            
            var timestr = strArray![1]
            
            print(timestr)
            timestr.removeLast()
           print("NEWSTR",timestr)
            timestr.removeLast()
            print("NEWSTR1",timestr)
            timestr.removeLast()
            print("NEWSTR2",timestr)
            timestr.removeLast()
            print("NEWSTR3",timestr)
            timestr.removeLast()
            print("NEWSTR4",timestr)
            
            cell.timeLbl.text = timestr

           //let timestr =
           // days = "\u200c2017-09-10"
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
          var date = formatter.date(from: dateStr!)

            let imgURL = URL(string: data["profile_pic"]?.stringValue ?? "")
            if imgURL == nil {
                
         // imgURL == URL(string: data["profile_pic"]!.stringValue) ?? UIImage(named: "")
            }else{
                cell.trackerImgView.kf.setImage(with: imgURL!)


            }
            
           // data["location"]?.stringValue
           // cell.dateLbl.text = dateArray[indexPath.row]
          //  data["created_at"]?.stringValue
              // cell.timeLbl.text = data["at_time"]?.stringValue
//                let imgURL = URL(string: data["profile_pic"]?.stringValue ?? "")
//                cell.trackerImgView.kf.setImage(with: imgURL!)
               return cell
            
           }
           
           
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 90
        
    }
    
   
    
    
    @objc func mapcheck(){
        let next = self.storyboard?.instantiateViewController(withIdentifier: "TrackerMapVC") as! TrackerMapVC
        self.present(next, animated: true, completion: nil)
       // self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    @objc func mapview()
    {
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        mapView.camera = camera
     //   mapView.delegate = (self as GMSMapViewDelegate)
        
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
      //  self.mapView.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
            
        case .cancelled:
            print("Message was cancelled")
        case .failed:
            print("Message failed")
        case .sent:
            print("Message was sent")
        default:
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }

    

}
extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
