//  DashboarethisVC.swift
//  Eithes
//  Created by Shubham Tomar on 19/03/20.
//  Copyright © 2020 Iws. All rights reserved.



import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import AVKit
import AVFoundation
import Kingfisher
import Toast_Swift


protocol dashboardPincodeDelegate{
    func dashboarduserSelectedValue(info : String)
}

class DashboarethisVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MyCellDelegate,dataSelectedDelegate,zipcodeSelectedDelegate,zipcodenewSelectedDelegate,dashboardPincodeDelegate,dataSelectedDelegatefromserch,checking1delegate,dataSelectedDelegate1,passdataOnBackBtnDelegate,profilePicDelegate,UIGestureRecognizerDelegate {
    
    func userprofilePic(info: String) {
        var profilePic = info
        print("PROFILEPIC1",info)
        print("PROFILEPIC2",profilePic)
    }
    
    func userSelectedValue12(info: String) {
        self.pinCodeLbl.text = info
        print("FromMYACCOUNT",self.pinCodeLbl.text)
    }

    
    func userSelectedValue1(info: String) {
        self.pinCodeLbl.text = info
        print("PoliceCODE",self.pinCodeLbl.text)
    }
    
    func navigateToDashboard(isclicked: String) {
        self.pinCodeLbl.text = isclicked
        print("SearchCODE.",self.pinCodeLbl.text)
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

      //  self.pinCodeLbl.text = self.zipCodesArr[row]
        self.zipcodeStr =  self.zipCodesArr[row]
        print("ZIPCODEMM",self.zipcodeStr)
        self.pinCodeLbl.text = self.zipcodeStr ?? ""
        print("ZIPCODEMM11",self.zipcodeStr ?? "")
        print("ZIPCODEMM",self.pinCodeLbl.text!)
        let  userDefaultsfb  = UserDefaults.standard
        userDefaultsfb.setValue(self.zipcodeStr!, forKey: "lastzipcode")
        UserDefaults.standard.synchronize()
        self.dropdownpick.isHidden = true
        getDashBoardData()
        dashboardtableview.reloadData()
        dropdownpick.reloadAllComponents()
        dropdownpick.delegate = self
        dropdownpick.dataSource = self
    }
        
    var backgroundImgArray = ["group_2","group_5","group_7","group_9"]
    var titleLblArray = ["Feeds","Police Department","My Accounts","Community Representative"]
    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]
    var refresh: Bool = false
    var delegate : dashboardPincodeDelegate? = nil
    var selectmenu = 0
    var profilePIcURL : URL?
    var feeds:Array<JSON>?
    var policeDepartment:Array<JSON>?
    var community:Array<JSON>?
    var myCollection:Array<JSON>?
    var collection:[String:JSON]?
    var index:IndexPath?
    var sideMenuOption = ["Dashboard","My Videos","My Contacts","My Profile","Support","Logout","Logout"]
  
//    var sidemenuImages: [UIImage] = [
//        UIImage(named: "MenuFirst")!,
//        UIImage(named: "MenuVideoIcon")!,UIImage(named: "MenuContacts")!]
    
    var sidemenuImages = ["newMenuone.png","MenuVideoIcon.png","MenuContacts.png","MenuProfile.png","MenuSupport.png","MenuLogout.png","MenuLogout.png"]

    var Y_Position:CGFloat? = 10.0 //use your Y position here
    var X_Position:CGFloat? = 100.0 //use your Y position here
    var nofeeds : String?
  //  @IBOutlet weak var dropdownTV: UITableView!
   // @IBOutlet weak var dropTV: UITableView!
  //  @IBOutlet weak var dropImg: UIImageView!
    
    @IBOutlet weak var newview: UIView!
    
    @IBOutlet weak var dropdownpick: UIPickerView!
    @IBOutlet weak var bgImg: UIImageView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var dashboardtableview: UITableView!
    let dashBoardCell = Feedscell()
    @IBOutlet weak var sideMenu: UITableView!
    @IBOutlet weak var currntLbl: UILabel!
    @IBOutlet weak var pinCodeLbl: UILabel!
    @IBOutlet weak var dropdownBttn: UIButton!
    @IBOutlet weak var searchBttn: UIButton!
    @IBOutlet weak var sideMenuLeading: NSLayoutConstraint!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet var mainview: UIView!
    @IBOutlet weak var sosoutlet: UIButton!
    @IBOutlet weak var sosimg: UIImageView!
    @IBOutlet weak var tableHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var tabledataView: UIView!
    var searchzipcode : String?
    var tapgesture = UITapGestureRecognizer()
    var sideMenuOpen = false
    var zipArr : [String] = []
    var zipcodeStr : String?
    var categoryID : Int = 0
    
    @IBOutlet weak var menuBtn: UIButton!
    var userid : String?
    var dashboardZipcodeLbl : String?
    var selecteditem = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // dashboarduserSelectedValue(info: self.pinCodeLbl.text!)
        self.dashboardtableview.isUserInteractionEnabled = true
        self.sideMenu.delegate = self
        self.sideMenu.dataSource = self
        self.dashboardtableview.isScrollEnabled = true
        print("categoryID",categoryID)
        reginib()
        self.dashboardtableview.reloadData()
        searchzipcode =  UserDefaults.standard.object(forKey: "zipcodeuse") as? String
        print("PINSERACH",searchzipcode ?? "90001")
        self.pinCodeLbl.text = searchzipcode
       // sideMenu.isUserInteractionEnabled = false
        let tapping : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
        topView.addGestureRecognizer(tapping)
        tapping.delegate = self
        
        let tappingtable : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
        dashboardtableview.isUserInteractionEnabled = true
        dashboardtableview.addGestureRecognizer(tappingtable)
        tappingtable.delegate = self

        
        let tapping2 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
        firstView.isUserInteractionEnabled = true
        firstView.addGestureRecognizer(tapping2)
        tapping2.delegate = self
        
        
        let tapping3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
        tabledataView.isUserInteractionEnabled = true
        tabledataView.addGestureRecognizer(tapping3)
        tapping2.delegate = self
        
        let tappingclose : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
        newview.isUserInteractionEnabled = true
        newview.addGestureRecognizer(tappingclose)
        tappingclose.delegate = self
        
        
        var value1 = ["a": "AAA", "b": "BBB", "c": "CCC"]
      var d = ["a" : "1","b": "2","c": "3","d": "4","e":"5"]
        for value in Array(d.values) {
            print("PRINTVALUESSSSSSSS","\(value)")
        }
        
//        for (key, value) in value1{
//            print(d["a"] : d["b"])
//         //print("\($0.value) : \(value)")
//        }
//        let tapping3 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
//        mainview.isUserInteractionEnabled = true
//        mainview.addGestureRecognizer(tapping3)
//        tapping2.delegate = self
        
        //self.pinCodeLbl.text = self.dashboardZipcodeLbl
//        print("printLABEL",self.pinCodeLbl.text)
//
//        self.pinCodeLbl.text = zipcodeStr ?? searchzipcode ?? UserDefaults.standard.object(forKey: "zipcodeuse") as! String
//        print("printLABEL",self.pinCodeLbl.text!)
//
//        self.pinCodeLbl.text = zipcodeStr ?? ""
//        print("printLABEL3",self.pinCodeLbl.text)
//
//        self.pinCodeLbl.text = UserDefaults.standard.object(forKey: "zipcodeuse") as! String ?? ""
//        print("printLABEL4",self.pinCodeLbl.text)

       //  self.dashboardtableview.reloadData()

//        if (categoryID != nil) {
//            //print("zipcode",zipcodeStr)
//           // self.pinCodeLbl.text = UserDefaults.standard.object(forKey: "Zipcode") as? String
//           // print("zipcode1",self.pinCodeLbl.text)
//
//            searchDashboardApiCall()
//      searchzipcode =  UserDefaults.standard.object(forKey: "zipcodeuse") as? String
//            self.pinCodeLbl.text = searchzipcode!
////            self.pinCodeLbl.text = zipcodeStr
//     print("PRINT1")
//        }else if (categoryID == 0){
//           // getDashBoardData()
//            print("PRINT2")
//
//        }

        
        if zipcodeStr != "" || zipcodeStr != nil {
            self.pinCodeLbl.text = zipcodeStr
        }
        
        if searchzipcode != "" || searchzipcode != nil  {
          //  print("PINSERACH",searchzipcode!)
           // print("PINCODELATEST",self.pinCodeLbl.text!)
            self.pinCodeLbl.text = searchzipcode
    
        }else{
            let newsstr = (UserDefaults.standard.object(forKey: "lastzipcode") as? String)
                    print("LATESTCODE",newsstr)
                    self.pinCodeLbl.text = newsstr
                    print("PINCODELATEST",self.pinCodeLbl.text!)
        }
        
        if (categoryID == 0) {
            getDashBoardData()
            self.dashboardtableview.reloadData()
           // userSelectedValuefromSerch(info: self.pinCodeLbl.text!)
         //   userSelectedValuefromSerch(info: self.pinCodeLbl.text ?? "90001")
//            let newsstr = (UserDefaults.standard.object(forKey: "lastzipcode") as? String)
//                    print("LATESTCODE",newsstr)
//                    self.pinCodeLbl.text = newsstr
                   // print("PINCODELATEST",self.pinCodeLbl.text!)
        }else{
      searchzipcode =  UserDefaults.standard.object(forKey: "zipcodeuse") as? String
            self.pinCodeLbl.text = searchzipcode!
            print("PINSERACH",searchzipcode!)
            self.pinCodeLbl.text = searchzipcode
            print("PINSERACH",self.pinCodeLbl.text)
            searchDashboardApiCall()
        }
    }
    
    
   
    override func viewWillLayoutSubviews() {
       
        if  (self.dashboardtableview.contentSize.height < self.tableHeightConstrain.constant) {
            dashboardtableview.isScrollEnabled = false
               }else{
                   dashboardtableview.isScrollEnabled = true
        }
      // self.dashboardtableview.contentSize.height = self.tableHeightConstrain.constant
     //   dashboardtableview.isScrollEnabled = true
    }

    @objc func btnAction(){
        print("BTNACTION")
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .repeat, animations: {
            self.dashboardtableview.isUserInteractionEnabled = true
            self.menuBtn.isHidden = false
            self.sideMenuLeading.constant = -280
            self.currntLbl.isHidden = false
            self.pinCodeLbl.isHidden = false
            self.dropdownBttn.isHidden = false
            self.sosoutlet.isHidden = false
            self.sosimg.isHidden = false
            self.newview.isHidden = true
       // self.dropImg.isHidden = false
        }, completion: nil)
       // getDashBoardData()
       //  self.dismiss(animated: true)
     }
    
    @objc func dismissfunc(sender: UIButton!){
        print("DISMISS")
        let btnsendtag: UIButton = sender
               if btnsendtag.tag == 1 {
                   self.dismiss(animated: true, completion: nil)
               }
    }
    
    @objc func toggleSideMenu(notification : NSNotification){
        
    }
  

    func userSelectedValue(info: String) {
        self.pinCodeLbl.text = info
        print("INFO",info)
    }
    
    func userSelectedValueMyAccount(info: String) {
        self.pinCodeLbl.text = info
        print("MYACOUNTPIN",info)
    }
    
    
    func userSelectedValueSection4(info: String) {
        self.pinCodeLbl.text = info
        print("COMMUNITYSECTIONPIN",info)
    }
  
    
    func dashboarduserSelectedValue(info: String) {
        print("DASHBOARD12345",info)
        self.pinCodeLbl.text = info
        print("DASHBOARD12345check",self.pinCodeLbl.text!)
    }
    
    
    func userSelectedValuefromSerch(info: String) {
        print("printSearchPincode",info)
        self.pinCodeLbl.text = info
        print("printSearchPincode1",self.pinCodeLbl.text ?? searchzipcode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dashboardtableview.isUserInteractionEnabled = true
        getProfile()
        getDashBoardData()
        userSelectedValuefromSerch(info: (self.pinCodeLbl.text ?? searchzipcode) ?? "90001")
       // self.dashboardtableview.reloadData()
       // self.pinCodeLbl.text! =  "90001"
        userSelectedValue12(info: self.pinCodeLbl.text ?? "90001")
        userSelectedValue(info: self.pinCodeLbl.text ?? "90001")
        userSelectedValueMyAccount(info: self.pinCodeLbl.text ?? "90001")
        userSelectedValueSection4(info: self.pinCodeLbl.text ?? "90001")
//        print("self.pinchbghggjjj",self.pinCodeLbl.text!)
//        let newsstr = (UserDefaults.standard.object(forKey: "lastzipcode") as? String)
//        print("LATESTCODE",newsstr)
//        self.pinCodeLbl.text = newsstr
//        print("PINCODELATEST",self.pinCodeLbl.text!)
//        self.dashboardtableview.reloadData()
//        self.dashboardtableview.delegate = self
//        self.dashboardtableview.dataSource = self
//        getDashBoardData()
//        self.dashboardtableview.reloadData()
// userSelectedValue(info: self.pinCodeLbl.text ?? "333")
        self.menuBtn.setImage(UIImage(named: "menu-1"), for: .normal)
        self.dropdownpick.isHidden = true
        self.feeds?.removeAll()
        self.policeDepartment?.removeAll()
        self.community?.removeAll()
        self.myCollection?.removeAll()
        self.collection?.removeAll()
       
     //   self.pinCodeLbl.text = searchzipcode ?? "201301"
        self.dropdownpick.backgroundColor = .white
        //self.dropdownpick?.layer.borderWidth = 1.0
        self.dropdownpick?.layer.cornerRadius = 3.0
        self.dropdownpick?.layer.masksToBounds = true
        self.dropdownpick.delegate = self
        self.dropdownpick.dataSource = self
    }
    
    
    @IBAction func dropBtnAction(_ sender: UIButton) {
        self.dropdownpick.isHidden = false
    }
    
    
    func dropShadowToView(view : UIView){
        //view.center = self.view.center
        //view.backgroundColor = UIColor.yellow
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        //self.view.addSubview(viewShadow)
    }
    
    
    let zipcodelist = "http://178.62.83.145:7000/api/v1/zipcode_list"
    
    func zipcodeApiList12() {
        Alamofire.request(zipcodelist, method: .get).responseJSON {(response) in
            let responseJson : JSON = JSON(response.value!)
            print("nbvmghvmghvg",responseJson)
            self.countryResonse(json: responseJson)
        }
    }

    
    func countryResonse(json : JSON){
        if json["status"] == "200" {
                    let newcode = json["data"]["zipcode"].stringValue
                    self.zipArr.append(newcode)
                    print("ZIPCODEARR",self.zipArr)
        }
    }
    
    let  userid1  =  UserDefaults.standard.object(forKey: "userid") as? String ?? "0"
    
    func getProfile(){
            
              let parameter:[String:String] = [
                  "user_id": userid1
              ]

              print("\nThe parameters for login : \(parameter)\n")

              let activityData = ActivityData()
              NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
              
              DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.view_profile, dataDict: parameter, { (json) in
                  print(json)
                  NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                  
                  if json["status"].stringValue == "200" {
                      let datadic = json["data"].dictionaryValue
                      print("DATADIC",datadic)
                      self.profilePIcURL = URL(string: json["data"]["profile_pic"].stringValue)
                      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                     // print("NEWURL",self.profilePIcURL!)
                      self.sideMenu.reloadData()
//                      self.fullNameTF.text = json["data"]["name"].stringValue
//                      self.emailTF.text = json["data"]["email"]u.stringValue
//                      self.addressTF.text = json["data"]["address"].stringValue
//                      self.phoneNumberTF.text = json["data"]["phone_number"].stringValue
                     // print(url)
//                      let imgData = UserDefaults.standard.set(url, forKey: "pimg")
//                      print("IMAGEDATAshow",imgData)
//                      UserDefaults.standard.synchronize()
//
//                      let newstr =  UserDefaults.standard.object(forKey: "pimg")
//                      print("IMAGEDATA1",newstr)

//                      if url != nil{
//                          self.profilePictureImgView.kf.setImage(with: url)
//                      }
//                      else{
//                          self.profilePictureImgView.image = UIImage(named: "bitmap-2")
//                      }
                  }else {
                      Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                          return
                      })

      //                let banner = NotificationBanner(title: "Alert", subtitle: json["msg"].stringValue , style: .danger)
      //                banner.show(queuePosition: .front)
                  }
                  
              }) { (error) in
                  print(error)
                  NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
              }
  }
    
    
    
    func getDashBoardData(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
        
       let  userid  =  UserDefaults.standard.object(forKey: "userid") as? String ?? ""
        print("USERID77777",userid)
        let parameter:[String:String] = [
            "zipcode": self.pinCodeLbl.text ?? "90001",
            "user_id": userid ?? "0"
        ]
        print("\nThe parameters for Dashboard ZIPCODES : \(parameter)\n")
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.dashboard_Data, dataDict: parameter, { (json) in
            self.feeds?.removeAll()
            self.policeDepartment?.removeAll()
            self.community?.removeAll()
            self.myCollection?.removeAll()
            
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            if json["status"].stringValue == "200" {
                                if let data = json["data"].dictionary{
                                    print("DATASHOW",data)
                                    self.collection = data
                                    if let feed = data["feeds"]?.array{
                                        self.feeds = feed
                                        print("FEEDDATADISPLAY",feed)
                                        self.policeDepartment?.removeAll()
                                    }else {
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in feeds", withError: nil, onClose: {
                                            return
                                        })
                                    }
                                    if self.feeds == [] {
                                        self.nofeeds = "Nodata"
                                        print("NO DATA FOUND",self.nofeeds!)
                                       // self.nofeeds! = "No data"
                                       // self.dashBoardCell.textLabel?.text = "BHAGYA"
                                    }
                                    if let communities = data["community"]?.array{
                                        self.community = communities
                                    }else{
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in Community", withError: nil, onClose: {
                                            return
                                        })
                                    }
                                    
                                    if let policeDepart = data["police_department"]?.array{
                                        self.policeDepartment = policeDepart
                                        print("POLICEDATA",policeDepart)
                                        print("POLICEDATA",self.policeDepartment!)

                                    }
                                    else{
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in police", withError: nil, onClose: {
                                            return
                                        })
                                    }
                                    if let myaccountData = data["my_account_data"]?.array{
                                        self.myCollection = myaccountData
                                        print("MYAccountDATA",myaccountData)
                                        print("MYAccountDATA",self.myCollection!)
                                        
                                    }
                                    else{

                                        
                                    }
                                    if self.myCollection == [] {
                                        self.nofeeds = "NoAccountdata"
                                        print("No data",self.nofeeds)
                                    }
                                    if self.policeDepartment == [] {
                                        self.nofeeds = "NoPolicedata"
                                        self.nofeeds! = "No Police DATA"
                                        print("No Police DATA",self.nofeeds!)
//                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No POLICEDATA", withError: nil, onClose: {
//                                            return
//                                        })
                                    }
                                }
                                print("POLICEDEPARTENTDATA/n  \(self.policeDepartment!)")
                                print("/nCOMMUNITY \(self.community!)")
                                print("/MYACCOUNTDATA \(self.myCollection!)")
                                print("/n FEEDSDATA\(self.feeds!)")
                                if self.community == [] {
                                    print("COMMUNITY",self.community)
                                    self.nofeeds = "NoCommunity"
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No community DATA", withError: nil, onClose: {
//                                        return
//                                    })
                                }
                                if  self.feeds == [] {
                                  //  self.dashBoardCell.textLabel?.text = "BHAGYA"
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in feeds", withError: nil, onClose: {
//                                        return
//                                    })
                                }else{
                                    let url = self.feeds?[0]["url"].stringValue
                                    let videoURL = URL(string: url ?? "")
                                    if  videoURL != nil{
                                    
                                    let player = AVPlayer(url: videoURL!)
                                    let playerController = AVPlayerViewController()
                                    playerController.player = player

                                    playerController.view.frame = self.topView.bounds
                                    self.topView.addSubview(playerController.view)
                                    self.addChild(playerController)

                                    player.play()
                                    
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.dashboardtableview.reloadData()
                                    }
                                }
                            }else {
                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                    return
                                })
                            }
                            
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }
    
        
    func searchDashboardApiCall(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
        
        print("searchpin",self.pinCodeLbl.text!)
        
        let parameter:[String:String] = [
            "zipcode" : self.pinCodeLbl.text!,
            "category_id": String(categoryID)
        ]
        
        print("\nThe parameters for search Dashboard : \(parameter)\n")
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.dashboard_Data, dataDict: parameter, { (json) in
            
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            if json["status"].stringValue == "200" {
                                if let data = json["data"].dictionary{
                                    print("DATASHOW",data)
                                    self.pinCodeLbl.text = self.searchzipcode
                                    print("PINSEARCH",self.searchzipcode)
                                    ("PINSEARCH",self.pinCodeLbl.text)
                                    self.collection = data
                                    if let feed = data["feeds"]?.array{
                                        self.feeds = feed
                                        print("FEED",feed)
                                    }else {
                                        print("NO DATA FOUND")
//  Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in feeds", withError: nil, onClose: {
//                                            return
//                                        })
                                    }
                                    if let communities = data["community"]?.array{
                                        self.community = communities
                                    }else{
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in Community", withError: nil, onClose: {
                                            return
                                        })
                                    }
                                                                        
                                    if let policeDepart = data["police_department"]?.array{
                                        self.policeDepartment = policeDepart
                                        print("POLICEDATA",policeDepart)
                                        print("POLICEDATA",self.policeDepartment!)
                                    }
                                    else{
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in police", withError: nil, onClose: {
                                            return
                                        })
                                        
                                    }
                                    
                                    if let myaccountData = data["my_account_data"]?.array{
                                        
                                        self.myCollection = myaccountData
                                        print("MYAccountDATA",myaccountData)
                                        print("MYAccountDATA",self.myCollection!)

                                    }
                                }
                                print("/n \(self.feeds!)")
                                print("POLICEDEPARTENTDATA/n  \(self.policeDepartment!)")
                                print("/n \(self.community!)")
                                print("/n \(self.myCollection!)")
                                if  self.feeds == [] {
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "No data found in feeds", withError: nil, onClose: {
//                                        return
//                                    })
                                }else{
                                    let url = self.feeds![0]["url"].stringValue
                                    let videoURL = URL(string: url)
                                    if  videoURL != nil{
                                    
                                    let player = AVPlayer(url: videoURL!)
                                    let playerController = AVPlayerViewController()
                                    playerController.player = player

                                    playerController.view.frame = self.topView.bounds
                                    self.topView.addSubview(playerController.view)
                                    self.addChild(playerController)
                                    player.play()
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.dashboardtableview.reloadData()
                                    }
                                }
                                self.dashboardtableview.reloadData()
                            }else {
                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                    return
                                })
                            }
                            
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }

    
    @IBAction func sidemenuBttn(_ sender: UIButton) {
        
        print("MENU")
        if self.sideMenuLeading.constant == -280 {
            getProfile()
            
//            if sender.isSelected == true {
//                print("MENUKKLLDFK")
//                self.searchBttn.isSelected = false
//                print("SEARCHKKKK",self.searchBttn.isSelected)
//            }else{
//                print("HHFFKKJJJ")
//                self.searchBttn.isSelected = true
//            }
            
            UIView.animateKeyframes(withDuration: 5, delay: 0, options: .repeat, animations: {
                self.menuBtn.isHidden = true
                self.currntLbl.isHidden = true
                self.pinCodeLbl.isHidden = true
                self.dropdownBttn.isHidden = true
                self.newview.isHidden = false
                self.dashboardtableview.isUserInteractionEnabled = false
                self.sideMenuLeading.constant = 0
            }, completion: nil)
        }
        else{
            self.dashboardtableview.isUserInteractionEnabled = true
//            UIView.animateKeyframes(withDuration: 5, delay: 0, options: .repeat, animations: {
//                self.menuBtn.isHidden = false
//                self.menuBtn.setImage(UIImage(named: "menu-1"), for: .normal)
//                self.sideMenuLeading.constant = -200
//                self.currntLbl.isHidden = false
//                self.pinCodeLbl.isHidden = false
//                self.dropdownBttn.isHidden = false
//                self.searchBttn.isHidden = false
//                self.dropImg.isHidden = false
//            }, completion: nil)
            
        }
    }
    
    @IBAction func onPressedSearchBtn(_ sender: Any){
       
        if  self.sideMenuLeading.constant == -280 {
            print("PRINTOPENMENU")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
            vc?.delegate2 = self
            self.present(vc!, animated: true, completion: nil)
                       
        }else{
            let tapping45 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
            searchBttn.addGestureRecognizer(tapping45)
            tapping45.delegate = self
            searchBttn.isSelected = true
            self.sideMenuLeading.constant = 0
        }
    }
    
    @IBAction func newBtnCheck(_ sender: Any) {
        print("CHECKINGbUTTONCLICK")
    }
    
    func reginib()
    {
          let nib1 = UINib(nibName: "Feedscell", bundle: nil)
          dashboardtableview.register(nib1, forCellReuseIdentifier: "Feedscell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
         if tableView == self.dashboardtableview{
            
             return self.backgroundImgArray.count
        }else{
            return min(self.sideMenuOption.count, self.sidemenuImages.count)
        }
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if tableView == self.dashboardtableview{
            self.index = indexPath
               let cell = tableView.dequeueReusableCell(withIdentifier: "Feedscell", for: indexPath) as! Feedscell
                cell.delegate = self
            let nib = UINib(nibName: "FeedsCollectionVC", bundle: nil)
            cell.Feedcollection.register(nib, forCellWithReuseIdentifier: "FeedsCollectionVC")
            
            if indexPath.row == 0{
                cell.Feedcollection.tag = 101
            if(self.feeds?.count == 0) || (self.feeds?.count == nil)||(self.feeds == []){
                self.policeDepartment?.removeAll()
                cell.Feedcollection.reloadData()
                cell.newlbl.isHidden = false
                cell.Feedcollection.reloadData()
                  //  if self.feeds == [] {
                        print("NOFEEDS",self.feeds?.count)
                     //   cell.textLabel?.text = "No data found!"
                      //  cell.textLabel?.textAlignment = .center
                }
                else{
                    cell.newlbl.isHidden = true
                    cell.Feedcollection.reloadData()
                   // cell.textLabel?.isHidden = true
                }
            }
             if indexPath.row == 1{

                cell.Feedcollection.tag = 201
                 if (self.policeDepartment?.count == 0) || (self.policeDepartment?.count == nil) || (self.policeDepartment == []) {
                     cell.newlbl.isHidden = false
                     cell.Feedcollection.reloadData()
                     print("NoPolicedata",self.policeDepartment)
                  //  if self.nofeeds! == "No Police DATA" {
                        print("NoPolice data")
                }else{
                    cell.newlbl.isHidden = true
                    cell.Feedcollection.reloadData()
                }
            }
            else if indexPath.row == 2{
                cell.Feedcollection.tag = 301
                if (self.myCollection?.count == 0) || (self.policeDepartment?.count == nil) || (self.myCollection == []) {
                 //   cell.nodataLbl.isHidden = false
                    cell.newlbl.isHidden = false
                    cell.Feedcollection.reloadData()
                    print("NoMYACCOUNTdata",self.myCollection)
                    
               //cell.textLabel?.text = "No data found!"
               //cell.textLabel?.textAlignment = .center
                 //   cell.Feedcollection.reloadData()
                 // cell.feedCollectionHeight.constant = 0.0
                }
                else{
                    cell.newlbl.isHidden = true
                    cell.Feedcollection.reloadData()
                }
            }
            else if indexPath.row == 3{

                cell.Feedcollection.tag = 401

                if (self.community?.count == 0) || (self.community?.count == nil) || (self.community == []){
                    //cell.nodataLbl.isHidden = false
                    cell.newlbl.isHidden = false
                    cell.Feedcollection.reloadData()
                    print("NoCommunitydata",self.community)
                }
                else{
                    cell.newlbl.isHidden = true
                    cell.Feedcollection.reloadData()
                }
            }
            cell.Feedcollection.delegate = self
            cell.Feedcollection.dataSource = self
            cell.backgroundImg.image = UIImage(named:backgroundImgArray[indexPath.row])
            
            cell.titleLbl.text = titleLblArray[indexPath.row]
              return cell
            
        }else{
            
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SMProfileCell", for: indexPath) as! SMProfileCell
                
                let useNamestr : String =  UserDefaults.standard.object(forKey: "username") as? String ?? "0"
                cell.userNameLbl.text = useNamestr
                cell.userImg.layer.cornerRadius = cell.userImg.frame.height/2
              //  cell.userImg.layer.masksToBounds = true
                cell.userImg.clipsToBounds = true
                if  self.profilePIcURL == nil  {
                    cell.userImg.image = UIImage(named: "bitmap-2")
                }else{
                    cell.userImg.kf.setImage(with: self.profilePIcURL!)
                }
               
                cell.backclosebtn.setTitle("", for: .normal)
                cell.backclosebtn.setImage(UIImage(named: "cancelbox"), for: .normal)
               cell.backclosebtn.addTarget(self, action: #selector(self.dismissfunc), for: .touchUpInside)
              //  cell.cancelBtn.tag = 1                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SMOptionCell", for: indexPath) as! SMOptionCell
                cell.optionName.text = self.sideMenuOption[indexPath.row - 1]
                cell.optionImg?.image = UIImage(named: self.sidemenuImages[indexPath.row - 1])
                
                return cell
            }
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selecteditem = indexPath.row ?? 0
        print("SELCTEDITEM",selecteditem)
        if tableView == self.sideMenu{
            if indexPath.row == 0 {
                print("FIRSTiNDEX")
                let cell = tableView.dequeueReusableCell(withIdentifier: "SMProfileCell", for: indexPath) as! SMProfileCell
                print("FIRST")
                cell.backclosebtn.isUserInteractionEnabled = true
                
                let tappingview : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
                print("SECOND")
                cell.backclosebtn.addGestureRecognizer(tappingview)
                tappingview.delegate = self
            }
            
            if indexPath.row == 1{
                print("SELCTEDITEM1",selecteditem)
                print("Dashboard path")
                let next = self.storyboard?.instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
              //  next.delegate = self
                self.dashboardZipcodeLbl = self.pinCodeLbl.text!
               print("searchpin",self.pinCodeLbl.text!)
                print("searchpincheck",self.dashboardZipcodeLbl)
                let  userDefaultstwitter  = UserDefaults.standard
                userDefaultstwitter.setValue((self.dashboardZipcodeLbl!), forKey: "zipcodeuse")as? String
                 UserDefaults.standard.synchronize()
                self.pinCodeLbl.text! = self.dashboardZipcodeLbl ?? zipcodeStr ?? ""
                print("searchpin12",self.pinCodeLbl.text!)
                print(self.pinCodeLbl.text!)
              // getDashBoardData()
               self.present(next, animated: true, completion: nil)
            }
            
            if indexPath.row == 2{
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "UserBenifitVC") as! UserBenifitVC
               self.present(next, animated: true, completion: nil)
            }
            
            if indexPath.row == 3{
                print("Contacts")
                let next = self.storyboard?.instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
               self.present(next, animated: true, completion: nil)
               // self.navigationController?.pushViewController(next, animated: true)
            }
            
            if indexPath.row == 4{
                print("myprofile")
                let profilevc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
               self.present(profilevc, animated: true, completion: nil)
               // self.navigationController?.pushViewController(next, animated: true)
            }
            
            if indexPath.row == 5 {
                let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "SupportViewC") as! SupportViewC
                self.present(loginVc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(loginVc, animated: false)
            }
            
            if indexPath.row == 6 {
     let logoutVc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
     self.present(logoutVc, animated: true, completion: nil)
               // self.pinCodeLbl.text = "90001"
           // self.navigationController?.pushViewController(loginVc, animated: false)
            }

        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == sideMenu{
//            return 50
//        }
//       // return 0
//   }
   
    func onPressedArrowBtn(cell: Feedscell)
    {
       let indexPath = self.dashboardtableview.indexPath(for: cell)
        self.selectmenu = indexPath?.row ?? 0
        if  self.sideMenuLeading.constant == -280 {
           
            if indexPath?.row == 0{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewFeedVC1") as! ViewFeedVC1
                    vc.delegate = self
                  // vc?.firstzipcodeLbl!  = searchzipcode!
                   print("pincodelbl",self.pinCodeLbl.text!)
                vc.firstzipcodeLbl = self.pinCodeLbl.text!
                print("Viewzipcode",vc.firstzipcodeLbl)
                   self.present(vc, animated: true, completion: nil)
              //  self.navigationController?.pushViewController(vc!, animated: true)
            }
                if indexPath?.row == 1{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PoliceDepartmentVC") as? PoliceDepartmentVC
                    vc?.delegate = self
                    vc?.userZipcodeStr = self.pinCodeLbl.text!
                    print("pincodelblzipcode",vc?.userZipcodeStr)
                    self.present(vc!, animated: true, completion: nil)
                  //  self.navigationController?.pushViewController(vc!, animated: true)
                }
            
            if indexPath?.row == 2 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyACcountVC") as? MyACcountVC
                vc?.delegate = self
                vc?.myaccountzipcode = self.pinCodeLbl.text!
                print("MyAccountzipcode",vc?.myaccountzipcode!)
                self.present(vc!, animated: true, completion: nil)
            }
             if indexPath?.row == 3{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityrepersentativeVC") as? CommunityrepersentativeVC
                 vc?.delegate = self
                 vc?.commuZipcodestr = self.pinCodeLbl.text!
                 print("Cmmunizipcode",vc?.commuZipcodestr)
                self.present(vc!, animated: true, completion: nil)
            }
            else{
      // self.navigationController?.pushViewController(vc!, animated: true)
                }
        }else{
            let tappingbtn : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.btnAction))
            cell.forwordArrowBtn.addGestureRecognizer(tappingbtn)
            tappingbtn.delegate = self
        }
     }
    
    @IBAction func sosButton(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ChooseCategoryVC") as! ChooseCategoryVC
        next.modalPresentationStyle = .fullScreen
        next.zipcodeStr = self.pinCodeLbl.text
        self.present(next, animated: true, completion: nil)
    }
    
}

extension DashboarethisVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.index!.row == 0{
            print("INCOLLECTIONFEED",self.feeds?.count)
            return self.feeds?.count ?? 0
        }
        else if self.index!.row == 1{
            print("INCOLLECTION",self.policeDepartment?.count)
            return self.policeDepartment?.count ?? 0
        }
        else if self.index!.row == 2{
            return  self.myCollection?.count ?? 0
        }
        else if self.index?.row == 3{
            return self.community?.count ?? 0
        }
        return 5
    }
         
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCollectionVC", for: indexPath) as! FeedsCollectionVC
             
            if collectionView.tag == 101{
               // self.policeDepartment?.removeAll()
    cell.postTitleLbl.text = self.feeds![indexPath.row]["category"].stringValue
                    print("POSTFEEDDATA",cell.postTitleLbl.text)
                    }
                     if collectionView.tag == 201{
                        self.policeDepartment!.count > 0
                        cell.postTitleLbl.isHidden = true
                        cell.userProfileImg.isHidden = true
                        cell.bgView.isHidden = false
                            let url = URL(string: self.policeDepartment![indexPath.row]["profile_pic"].stringValue ?? "")
                           cell.descriptionImg.kf.setImage(with: url)
                            print("IMAGESINCECLL",url)
                            cell.bgNameLbl.text = self.policeDepartment![indexPath.row]["name"].stringValue ?? ""
                            cell.bgPhoneLbl.text = self.policeDepartment![indexPath.row]["phone_number"].stringValue
                    }
                     if collectionView.tag == 301{
                        
                        cell.postTitleLbl.isHidden = true
                        cell.userProfileImg.isHidden = true
                        cell.bgView.isHidden = false
                      //  let url = URL(string: self.myCollection![indexPath.row]["profile_pic"].stringValue ?? "")
                     //   cell.descriptionImg.kf.setImage(with: url)
                        cell.bgNameLbl.text = self.myCollection![indexPath.row]["title"].stringValue
                        cell.bgPhoneLbl.text = self.myCollection![indexPath.row]["category"].stringValue
                    //return 0
                    }
                     if collectionView.tag == 401{
                        cell.postTitleLbl.isHidden = true
                        cell.userProfileImg.isHidden = true
                        cell.bgView.isHidden = false
                        let url = URL(string: self.community![indexPath.row]["profile_pic"].stringValue)
                        cell.descriptionImg.kf.setImage(with: url)
                        cell.bgNameLbl.text = self.community![indexPath.row]["name"].stringValue
                        cell.bgPhoneLbl.text = self.community![indexPath.row]["phone_number"].stringValue
        //            return self.community?.count ?? 0
                    }
           return cell
       
         }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionwidth = collectionView.bounds.width
           return CGSize(width: collectionwidth/3, height: collectionwidth/2)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 101{
            
            let url = self.feeds![indexPath.row]["url"].stringValue
            
            if url != ""{
            let videoURL = URL(string: url)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            }
        }
        else if collectionView.tag == 201{
            let phoneNumber = self.policeDepartment?[indexPath.row]["phone_number"].stringValue
            if let url = URL(string: "tel://\(phoneNumber!)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else if collectionView.tag == 301{
           // return 0
        }
        else if collectionView.tag == 401{
            let phoneNumber = self.community?[indexPath.row]["phone_number"].stringValue
            if let url = URL(string: "tel://\(phoneNumber!)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}
