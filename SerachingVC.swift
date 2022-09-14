//
//  SerachingVC.swift
//  Eithes

//  Created by Shubham Tomar on 23/03/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import TweeTextField
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import DropDown

protocol dataSelectedDelegatefromserch{
    func userSelectedValuefromSerch(info : String)
}

protocol dataSelectedDelegatetoview{
    func userSelectedsearch(info : String)
}

protocol checking1delegate{
    func navigateToDashboard(isclicked : String)
}


class SerachingVC: UIViewController,dataSelectedDelegatetoview, dataSelectedDelegate,checking1delegate {
    func navigateToDashboard(isclicked: String) {
        self.locationTF.text = isclicked
    }
    
    func userSelectedsearch(info: String) {
        self.locationTF.text = info
    }
    
    func userSelectedValue(info: String) {
        print("askakska")
    }
    
    
    @IBOutlet weak var catOutlet: UIButton!
    
    @IBOutlet weak var categoryListTF: TweeActiveTextField!
    
    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]

    var dataArray:[JSON]?
    var catNameArr : [String] = []
    var catIDArr : [Int] = []
    var catID : Int = 0
    let zipcodeDropdown = DropDown()
    let catDropdown = DropDown()

    
    var delegate1 : dataSelectedDelegatefromserch? = nil
    var delegate : dataSelectedDelegatetoview? = nil
    var delegate2 : checking1delegate? = nil

    var isSerach : String?
    @IBOutlet weak var locationBtn: UIButton!

    @IBOutlet weak var locationTF: TweeActiveTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catOutlet.addSubview(catDropdown)
        
       // let height: CGFloat = self.dropDown.frame.size.height
       // let width: CGFloat = self.dropDown.frame.size.width
       // dropDown.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        locationBtn.setTitle("", for: .normal)
        catOutlet.setTitle("", for: .normal)
//        dropDown.anchorView = (categoryListTF.text as? AnchorView)
//        dropDown.dataSource = zipCodesArr
////        self.locationTF.inputView = zipcodedropdown
//        self.categoryListTF.inputView = zipcodedropdown

      //  if (self.locationTF.text != nil) == isFirstResponder {
           
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                self.locationTF?.text = zipCodesArr[index]
//             // }

//        }
        getcateogryList()

    }
    
   
    @IBAction func onPressclosedbtn(_ sender: UIButton)
    
    {
        self.dismiss(animated: true, completion: nil)
   // self.navigationController?.popViewController(animated: true)
//        if (self.locationTF.text != "") && (self.categoryListTF.text != "") {
//            self.view.makeToast("Please click on search", duration: 3.0, position: .bottom)
//
//         //   Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please click on search")
//
//        }else{
//            self.dismiss(animated: true, completion: nil)
//
//        }
    }
    
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        
            zipcodeDropdown.anchorView = (locationTF as? AnchorView)
            
            zipcodeDropdown.dataSource = zipCodesArr
         //   zipcodeDropdown.direction = .top

            zipcodeDropdown.show()
            zipcodeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.locationTF?.text = zipCodesArr[index]
             // }
        }
        
    }
    
    
    @IBAction func catBtnAction(_ sender: UIButton) {
        if (locationTF.text!.isEmpty){
            self.view.makeToast("Please select zipcode!", duration: 3.0, position: .bottom)
           // Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please select zipcode!")
        }else{
            self.catOutlet.addSubview(catDropdown)

            catDropdown.anchorView = (categoryListTF as? AnchorView)

            catDropdown.dataSource = catNameArr
            
         //   catDropdown.updateConstraints()

            catDropdown.cellHeight = 50
            catDropdown.show()

            catDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.categoryListTF?.text = catNameArr[index]
             // }
        }
            
        }
        
    }
    
    @IBAction func searchBttnAction(_ sender: Any) {
        
//        if (locationTF.text == "") && (categoryListTF.text == "") {
//            self.view.makeToast("Please Select Zipcode & Category!", duration: 3.0, position: .bottom)
//           return
//        }
        
        if  (categoryListTF.text == "") {
            self.view.makeToast("Please Select Category!", duration: 3.0, position: .bottom)
            return
        }else {
            self.dismiss(animated: true, completion: nil)
            self.delegate2?.navigateToDashboard(isclicked: self.locationTF.text!)
            if isSerach == "Viewfeed" {
                let feedvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewFeedVC1") as! ViewFeedVC1
                isSerach = "Viewfeed"
                feedvc.passcont = isSerach
              //  vc.delegate = self
              //  feedvc.firstzipcodeLbl = self.locationTF.text!
                print("Searchhhhhh1",locationTF.text!)
                print("Searchhhhhh12",feedvc.firstzipcodeLbl)
              //  feedvc.firstzipcodeLbl = self.locationTF.text!
                self.present(feedvc, animated: true, completion: nil)
               // self.navigationController?.pushViewController(feedvc, animated: true)
            }
//
//            if isSerach == "UserBenifit" {
//                let uservc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserBenifitVC") as! UserBenifitVC
//
//                uservc.userZipcodeStr = self.locationTF.text!
//                self.present(uservc, animated: true, completion: nil)
//            }
//
//            if isSerach == "PolicDepart" {
//                let policevc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PoliceDepartmentVC") as! PoliceDepartmentVC
//                policevc.userZipcodeStr = self.locationTF.text!
//                self.present(policevc, animated: true, completion: nil)
//            }
//
//            if isSerach == "MyDirect" {
//                let directvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
//                self.present(directvc, animated: true, completion: nil)
//            }
//
//            if isSerach == "Commutative" {
//                let commvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityrepersentativeVC") as! CommunityrepersentativeVC
//                commvc.commuZipcodestr = self.locationTF.text!
//
//                self.present(commvc, animated: true, completion: nil)
//            }
            
                
//                let searchingvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
//                self.present(searchingvc, animated: true, completion: nil)

            
                
//            let vc1 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
//            vc1.zipcodeStr = (self.locationTF?.text!)!
//            vc1.categoryID = self.catID
//            print("LOCATION",(self.locationTF?.text!)!)
//            print("LOCATION123",vc1.zipcodeStr!)
//            (vc1.zipcodeStr!) = vc1.self.pinCodeLbl?.text! ?? ""
//            let  userDefaultstwitter  = UserDefaults.standard
//            userDefaultstwitter.setValue((self.locationTF?.text!)!, forKey: "zipcodeuse")as? String
//             UserDefaults.standard.synchronize()
//            print("LOCATION1234",(self.locationTF?.text!)!)
//        let strv =   UserDefaults.standard.object(forKey: "zipcodeuse") as? String
//            print("CATEGORYpinlbl",strv!)
//            print("CATEGORY",(self.categoryListTF?.text!)!)
//            print("LOCATION",vc1.categoryID)
//            print("CATIS",self.catID)
//            if (delegate1 != nil) {
//                let information : String = self.locationTF.text ?? ""
//                print("SECONDZIPCODE",information)
//                print("SECONDZIPCODE",self.locationTF.text)
//                delegate1!.userSelectedValuefromSerch(info: information)
//                print("SECONDZIPCODElast",information)
//            }
//            self.present(vc1, animated: true, completion: nil)
        }
        
//        if  !Reachability.isConnectedToNetwork() {
//            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
//                return
//        }

     //   self.navigationController?.popViewController(animated: true)
    
    }
    
   
    
func getcateogryList()   {
         if  !Reachability.isConnectedToNetwork() {
             Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                 return
         }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
         
         let parameter:[String:String] = [
             "user_id": userid
         ]
         print("\nThe parameters for Dashboard category1234: \(parameter)\n")
         let activityData = ActivityData()
         NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
         DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.categoryList, dataDict: parameter, { (json) in
                             print(json)
                             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                             if json["status"].stringValue == "200" {

                                 if let data = json["data"].array{
                                     self.dataArray = data
                                
                                     print("DATAOFCATAGEORYLIST",self.dataArray!)
                                     print("CATNAME",self.catNameArr)

                                     for i in 0..<(self.dataArray!.count) {
                                       let newcode = data[i]["name"].stringValue
                                       self.catNameArr.append(newcode)
                                       print("CATNAMEARR",self.catNameArr)
                                         self.catID = data[i]["category_id"].intValue ?? 0
                                         self.catIDArr.append(self.catID)
                                         print("CATIDARR",self.catIDArr)
                               }
                                
//                                     DispatchQueue.main.async {
//                                        // self.zipcodedropdown.delegate = self
//                                        // self.zipcodedropdown.dataSource = self
//                                       //  self.zipcodedropdown.reloadAllComponents()
//
//                                     }
//
                                 }
                       
                             }else {
                                 self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)                                
                             }
             
                         }) { (error) in
                             print(error)
                             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                         }
     }
    

}
