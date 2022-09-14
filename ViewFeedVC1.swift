
//  ViewFeedVC1.swift
//  Eithes
//  Created by Shubham Tomar on 20/03/20.
//  Copyright © 2020 Iws. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import AVKit
import AVFoundation



protocol dataSelectedDelegate{
    func userSelectedValue(info : String)
}


class ViewFeedVC1: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCellDelegate1,UIPickerViewDelegate,UIPickerViewDataSource,dataSelectedDelegatetoview, dataSelectedDelegate,checking1delegate{
    
    func navigateToDashboard(isclicked: String) {
     print("ISCLIKED",isclicked)
        self.ziplbl.text = isclicked
        self.firstzipcodeLbl = isclicked
        print("ISCLIKED",self.ziplbl.text!)
        print("ISCLIKED1234",self.firstzipcodeLbl)
    }
    
    
    func userSelectedValue(info: String) {
        print("XIPCODE",info)
    }

    
    
    func userSelectedsearch(info: String) {
        self.ziplbl.text =  info
        print("XIPCODEyy",info)
        print("XIPCODE",self.ziplbl.text)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return zipCodesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return zipCodesArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.ziplbl.text = self.zipCodesArr[row]
        self.zipcodeDropdown.isHidden = true
        getshoplifting()
        feedDatacollectionView.reloadData()
        firstzipcodeLbl = self.zipCodesArr[row]
        self.ziplbl.text = firstzipcodeLbl
    }
    
    
    @IBOutlet weak var serachBtn: UIButton!
    
    @IBOutlet weak var nodataLbl: UILabel!
    
    var delegate : dataSelectedDelegate? = nil
    @IBOutlet weak var zipcodeDropdown: UIPickerView!
    
    @IBOutlet weak var zipcodeBtn: UIButton!
    
    var passcont : String?
    @IBOutlet weak var feedDatacollectionView: UICollectionView!
    @IBOutlet weak var tabCollectionView: UICollectionView!
    var dataArray:[JSON]?
    var newstr = [String]()
    var btnArray = ["Shoplifting","Child abuse","Adventure","Sports"]
    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]
    var indexpath:IndexPath?
    var selectRow = 0
    var collection:Array<JSON>?
    var categorystr : String?
    var imgUrl : String?
    var teypestr : String?
    var zipcodeStr : String?
    var firstzipcodeLbl : String = ""
    var nameStr : String = "Traffic Stop"
    var category_id = "1"
    var selectBtn  : String = "Traffic Stop"
  

    override func viewDidLoad(){
    super.viewDidLoad()
        reginib()
        print("PASSCOUNT",passcont ?? "NIL")
        var newvar = UserDefaults.standard.setValue(passcont, forKey: "count")
        print("USERDEFAULTS",newvar)
        self.zipcodeDropdown.isHidden = true
        self.zipcodeDropdown.backgroundColor = .white
        //self.dropdownpick?.layer.borderWidth = 1.0
        self.zipcodeDropdown?.layer.cornerRadius = 3.0
        self.zipcodeDropdown?.layer.masksToBounds = true
        feedDatacollectionView.delegate = self
        feedDatacollectionView.dataSource = self
        feedDatacollectionView.layoutIfNeeded()
        getCategoryData()
        
      //  self.ziplbl.text = firstzipcodeLbl
//        let  userDefaultsfb  = UserDefaults.standard
//        userDefaultsfb.setValue(self.ziplbl.text, forKey: "zip")
//        UserDefaults.standard.synchronize()
       // cell.shopLiftingBtn.addTarget(self, action: Selector(("buttonAction")), for: UIControl.Event.touchUpInside)
     //   getshoplifting()
       // feedDatacollectionView.reloadData()
        self.feedDatacollectionView.isHidden = false
        feedDatacollectionView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.zipcodeBtn.setTitle("", for: .normal)
        self.zipcodeDropdown.isHidden = true
        self.ziplbl.text = firstzipcodeLbl
        
    }
    
    
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    @IBOutlet weak var ziplbl: UILabel!
    
    
    @IBAction func onPressedsearchBtn(_ sender: Any){
         serachBtn.isSelected = true
        print("SELECTEDINSERACH",serachBtn.isSelected )
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
            vc?.isSerach = "Viewfeed"
            vc?.delegate2 = self
            self.present(vc!, animated: true, completion: nil)
     
    }
    
    @IBAction func zipdropdownBtn(_ sender: UIButton) {
                
        self.zipcodeDropdown.isHidden = false
    }
    
    @IBAction func onPressedSosbtn(_ sender: Any){
        
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChooseCategoryVC") as? ChooseCategoryVC
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func OnpressedBackArrowBtn(_ sender: Any){
        
        if serachBtn.isSelected == true {
            print("SELECTED",serachBtn.isSelected)
            if (delegate != nil) {
                let information : String = self.ziplbl.text ?? ""
                print("SECONDZIPCODE",information)
                print("SECONDZIPCODE",self.ziplbl.text)
                delegate!.userSelectedValue(info: information)
                print("SECONDZIPCODElast",information)
            }
        }else{
            print("SELECTED1",serachBtn.isSelected)
        }
        
        self.dismiss(animated: true,completion: nil)
    }
    
    
     func reginib() {
           let nib = UINib(nibName: "Tabcollectioncell", bundle: nil)
           tabCollectionView.register(nib, forCellWithReuseIdentifier: "Tabcollectioncell")
       }
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tabCollectionView {
            return self.dataArray?.count ?? 0
        }
        return  self.collection?.count ?? 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        if collectionView ==  self.tabCollectionView
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
            cell.shopLiftingBtn.layer.cornerRadius = 5
            let title = self.dataArray?[indexPath.row]["name"].string
            cell.shopLiftingBtn.setTitle(title, for: .normal)
           // self.feedDatacollectionView.isHidden = false
                        cell.delegate = self
            if   self.selectRow == indexPath.row  {
               // cell.shopLiftingBtn.showsTouchWhenHighlighted = false
                cell.shopLiftingBtn.backgroundColor = UIColor.blue
       // self.category_id = "\(self.dataArray?[indexPath.row]["category_id"].intValue ?? 0)"
                selectBtn = self.dataArray?[indexPath.row]["name"].stringValue ?? ""
                print("NAMESTR",selectBtn)
               getshoplifting()
            }else {
             cell.shopLiftingBtn.backgroundColor = UIColor.gray
         }
            return cell
       }
        else
        {
          //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ViewFeedCollectionCell
            cell.categoryLbl.text = categorystr
            cell.isliveLbl.text = self.zipcodeStr ?? ""
            
//            let urlfeed = URL(string: self.collection![indexPath.row]["url"].stringValue ?? "")
//            print("URLFROMLIST&&&&",urlfeed)
//            if urlfeed == nil {
//                cell.bgimgview.image = UIImage(named: "image")
//
//            }else{
//                self.getThumbnailImageFromVideoUrl(url: urlfeed!) { (thumbImage) in
//                    print("INFEEDIMAGE",thumbImage)
//
//                    cell.bgimgview.image = thumbImage
//                }
//            }
            
           // cell.bgView.isHidden = false
          //  cell.policeNameLbl.text = self.collection?[indexPath.row]["name"].stringValue
          //  cell.categoryLbl.text = self.collection![indexPath.row]["category"].string
//
//           // let newname  = self.collection?[indexPath.row]["category"].stringValue ?? ""
//           // newstr.append(newname)
//            print("NEWSTR",cell.categoryLbl.text)
//           // let url = URL(string: self.collection![indexPath.row]["url"].stringValue )
//           // print("URL",url)
//          //  cell.bgimgview.kf.setImage(with: url)
//           cell.isliveLbl.text = self.collection![indexPath.row]["zipcode"].stringValue ?? ""
         //   cell.bgPhoneLbl.text = self.collection![indexPath.row]["type"].stringValue

            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        let numberOfItemsPerRow: CGFloat = 2.0;
       // print("")

        let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        if collectionView == tabCollectionView{
            return CGSize(width: itemWidthtop/2, height: 30)
        }
        if collectionView == feedDatacollectionView
        {
            return CGSize(width: itemWidthdown, height: 300)
        }
        return CGSize(width: itemWidthdown, height: itemWidthdown)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let videoURL = URL(string: imgUrl ?? "")
            if  videoURL != nil{
            let player = AVPlayer(url: videoURL!)
            let playerController = AVPlayerViewController()
            playerController.player = player
                self.present(playerController, animated: true) {
                    playerController.player!.play()
                  
                }
              //  self.feedDatacollectionView.reloadData()

             //   self.nameStr.removeAll()
              //  self.feedDatacollectionView.reloadData()
              //  self.feedDatacollectionView.isHidden = false

//                                            playerController.view.frame =
//                                                self.topView.bounds
//                                            self.topView.addSubview(playerController.view)
//                                            self.addChild(playerController)

         //   player.play()

            }
    }
    
    

    func onpressedShopliftingBtn(cell: Tabcollectioncell)
    {
       
        let indexpath = self.tabCollectionView.indexPath(for: cell)
        self.selectRow = indexpath?.row ?? 0
        self.tabCollectionView.reloadData()

//        DispatchQueue.main.async {
//            self.feedDatacollectionView.reloadData()
//
//               }
        
//        selectBtn = self.dataArray?[indexpath!.row]["name"].stringValue ?? ""
//        print("NAMESTR",selectBtn)
//       getshoplifting()
//        self.feedDatacollectionView.reloadData()
        
        
//        if self.selectRow == 0  {
//           selectBtn  = "Traffic Stop"
//
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//         //   feedDatacollectionView.isHidden = true
//
//        }
//        if self.selectRow == 1  {
//            selectBtn = "Public Assault"
//
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//
//            feedDatacollectionView.reloadData()
//           // feedDatacollectionView.isHidden = true
//
//        }
//        if self.selectRow == 2  {
//            selectBtn = "Private Assault"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 3  {
//            nameStr = "Injury Blood Loss"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//
//        }
//        if self.selectRow == 4  {
//
//            nameStr = "Police Brutality"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 5  {
//            nameStr = "Medical Alert"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 6  {
//            nameStr = "Abduction"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 7  {
//            nameStr = "Harassment"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 8  {
//            nameStr = "Michael Test"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 9  {
//            nameStr = "Gang Related"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 10  {
//            nameStr = "Shoplifting"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 11  {
//            nameStr = "Child Abuse"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 12  {
//            nameStr = "Advanture"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 13  {
//            nameStr = "Sports"
//            getshoplifting()
//            feedDatacollectionView.isHidden = false
//            feedDatacollectionView.reloadData()
//
//        }
        
        
//
//        if self.selectRow == 1  {
//            feedDatacollectionView.reloadData()
//
//        }
//        if self.selectRow == 2 {
//            getshoplifting()
//            self.feedDatacollectionView.reloadData()
//        }
//
//        if cell.shopLiftingBtn.backgroundColor ==  UIColor.gray
//        {
//            self.feedDatacollectionView.isHidden = false
//        }
//        else
//        {
//              self.feedDatacollectionView.isHidden = true
//        }
//        if cell.shopLiftingBtn.backgroundColor == .gray{
//           self.indexpath = self.tabCollectionView.indexPath(for: cell)
//            self.tabCollectionView.reloadData()
//        }
//        else{
//            self.indexpath = nil
//            self.tabCollectionView.reloadData()
//        }

}
    
    func getCategoryData() {
         if  !Reachability.isConnectedToNetwork() {
             Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                 return
         }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
         
         let parameter:[String:String] = [
             "user_id": userid
         ]
         
         print("\nThe parameters for Dashboard : \(parameter)\n")
         
         let activityData = ActivityData()
         NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
         
         DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.categoryList, dataDict: parameter, { (json) in
                             print(json)
                             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                             if json["status"].stringValue == "200" {
                                 self.nodataLbl.isHidden = true
                                 if let data = json["data"].array{
                                     self.dataArray = data
                                     
                                     print("DATAOFCATAGEORYLIST",self.dataArray!)
                                     
                                     DispatchQueue.main.async {
                                         self.tabCollectionView.reloadData()

                                     }
                                 }
                       
                             }else {
                                 let msg = json["msg"].stringValue
                                 print("MESSAGEPRINT",msg)
                                 self.nodataLbl.isHidden = false
                                 self.nodataLbl.text = msg
//                                 Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                     return
//                                 })
                             }
 //
                         }) { (error) in
                             print(error)
                             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                         }
     }
    
    func getshoplifting(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
        
        print("NAMESTR11",nameStr)
        print("nameapi",selectBtn)
            let parameter:[String:String] = [
                "user_id": userid,
                "category": selectBtn ?? "",
                "status":   "1",
                "zipcode": self.ziplbl.text ?? ""
            ]
            
            print("\nThe parameters for ViewfeedDepartment Data : \(parameter)\n")
            self.collection?.removeAll()
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getShopliftingList, dataDict: parameter, { [self] (json) in
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    self.nodataLbl.isHidden = true

                                 //   print("DATACOLLECTION",json["status"].stringValue)
                                    self.nameStr.removeAll()
                                    if let data = json["data"].array{
                                        self.collection = data
                                        print("VIEWFEED",data)
                                        print("VIEWFEED*****",self.collection!)
                                        self.categorystr = self.collection![0]["category"].string
                                        print("cate7777",self.categorystr!)
                                        self.newstr.append(categorystr ?? "")
                                        //self.teypestr = self.collection![0]["type"].string
                                       // print("cate7777",self.teypestr!)
                                        self.zipcodeStr = self.collection![0]["zipcode"].string
                                        print("cate7777",self.zipcodeStr!)
                                            imgUrl  = self.collection![0]["url"].stringValue
                                        print("URLIMGURL*******",imgUrl!)
//                                        let videoURL = URL(string: imgUrl ?? "")
//                                            if  videoURL != nil{
//
//                                            let player = AVPlayer(url: videoURL!)
//                                            let playerController = AVPlayerViewController()
//                                            playerController.player = player
//                                                playerController.player = player
//                                                self.present(playerController, animated: true) {
//                                                    playerController.player!.play()
//                                                }
//
//                                                self.feedDatacollectionView.reloadData()
//
//                                                self.nameStr.removeAll()
//                                                self.feedDatacollectionView.reloadData()
//                                                self.feedDatacollectionView.isHidden = false
//
////                                            playerController.view.frame =
////                                                self.topView.bounds
////                                            self.topView.addSubview(playerController.view)
////                                            self.addChild(playerController)
//
//                                         //   player.play()
//
//                                            }
                                        self.feedDatacollectionView.reloadData()

                                        self.feedDatacollectionView.isHidden = false
                                        
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.feedDatacollectionView.reloadData()
                                    }
                                   

                                }else {
                                    let msg = json["msg"].stringValue
                                    print("MESSAGEPRINT",msg)
                                    self.feedDatacollectionView.isHidden = true
                                    self.nodataLbl.isHidden = false
                                    self.nodataLbl.text = msg
//                                    self.feedDatacollectionView.isHidden = true
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                        return
//                                    })
                                }
                                
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
}


