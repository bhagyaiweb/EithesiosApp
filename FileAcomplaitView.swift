//
//  FileAcomplaitView.swift
//  Eithes
//
//  Created by sumit bhardwaj on 30/07/21.
//  Copyright © 2021 Iws. All rights reserved.


import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift
import NVActivityIndicatorView
import DropDown

class FileAcomplaitView: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var policeDepartmentTxt: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var complaintForTxt: UITextField!
    
    @IBOutlet weak var departmentBtn: UIButton!
    
    
    
    var dataArray:[JSON]?
    var dataDepartmentList:[JSON]?
    var categoryNameArr : [String] = []
    var departmentNameArr : [String] = []
    var departmentIDArr : [Int] = []


    var categoryIDArr : [Int] = []
    var categoryID : Int = 0
    var departmentID : Int = 0
    let catDropdown = DropDown()
    let zipcodeDropdown = DropDown()
    let departmentDropdown = DropDown()

    

    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]

    @IBOutlet weak var categoryOutlet: UIButton!
    
    @IBOutlet weak var zipcodeOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryOutlet.addSubview(catDropdown)
        categoryOutlet.setTitle("", for: .normal)
        zipcodeOutlet.setTitle("", for: .normal)
        departmentBtn.setTitle("", for: .normal)



        setPlaceholder()
//        recordView.layer.cornerRadius = 23
//        recordView.layer.borderWidth = 1
//        recordView.layer.borderColor = UIColor.white.cgColor
        backbtn.setTitle("", for: .normal)
        getcateogryList()
        departemntListApi()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func catgoryAction(_ sender: Any) {
//        if (categoryTxt.text!.isEmpty){
//            self.view.makeToast("Please select category!", duration: 3.0, position: .bottom)
//        }else{
            self.categoryOutlet.addSubview(catDropdown)

            catDropdown.anchorView = (categoryTxt as? AnchorView)

            catDropdown.dataSource = categoryNameArr
            
            catDropdown.cellHeight = 35
            catDropdown.show()

            catDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.categoryTxt?.text = categoryNameArr[index]
        }
            
      //  }
    }
    
    
    @IBAction func zipcodeAction(_ sender: Any) {
        zipcodeDropdown.anchorView = (zipCode as? AnchorView)
        
        zipcodeDropdown.dataSource = zipCodesArr
     //   zipcodeDropdown.direction = .top

        zipcodeDropdown.show()
        zipcodeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.zipCode?.text = zipCodesArr[index]
         // }
    }
        
    }
    
    @IBAction func departmentSelectActn(_ sender: Any) {
        self.departmentBtn.addSubview(departmentDropdown)

        departmentDropdown.anchorView = (policeDepartmentTxt as? AnchorView)

        departmentDropdown.dataSource = departmentNameArr
        
        departmentDropdown.cellHeight = 30
        departmentDropdown.show()

        departmentDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.policeDepartmentTxt?.text = departmentNameArr[index]
    }
    }
    
    
    @IBOutlet weak var backbtn: UIButton!
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
       
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let logoutVc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
       // self.present(logoutVc, animated: true, completion: nil)
         self.navigationController?.pushViewController(logoutVc, animated: false)
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
                                         print("CATNAME",self.categoryNameArr)

                                         for i in 0..<(self.dataArray!.count) {
                                           let newcode = data[i]["name"].stringValue
                                           self.categoryNameArr.append(newcode)
                                           print("CATNAMEARR",self.categoryNameArr)
                                             self.categoryID = data[i]["category_id"].intValue ?? 0
                                             self.categoryIDArr.append(self.categoryID)
                                             print("CATIDARR",self.categoryIDArr)
                                   }
                                    
                                     }
                           
                                 }else {
                                     self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)

    //                                 Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
    //                                     return
    //                                 })
                                 }
                 
                             }) { (error) in
                                 print(error)
                                 NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                             }
         }
    
    
    func departemntListApi()   {
             if  !Reachability.isConnectedToNetwork() {
                 Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                     return
             }
            let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
             
        let parameter:[String:String] = [:]
             
           //  print("\nThe parameters for Dashboard category1234: \(parameter)\n")
             
             let activityData = ActivityData()
             NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
             DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getDepartmentsList, dataDict: parameter, { (json) in
                                 print(json)
                                 NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                 if json["status"].stringValue == "200" {

                                     if let data = json["data"].array{
                                         self.dataDepartmentList = data
                                    
                                         print("DATAOFCATAGEORYLIST",self.dataDepartmentList!)
                                         print("DEPARTMENTNAME",self.departmentNameArr)

                                         for i in 0..<(self.dataDepartmentList!.count) {
                                           let newcode = data[i]["department"].stringValue
                                           self.departmentNameArr.append(newcode)
                                           print("CATNAMEARR",self.departmentNameArr)
                                             self.departmentID = data[i]["id"].intValue ?? 0
                                             self.departmentIDArr.append(self.departmentID)
                                             print("CATIDARR",self.departmentIDArr)
                                   }
                                    
                                     }
                           
                                 }else {
                                     self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)

                                 }
                 
                             }) { (error) in
                                 print(error)
                                 NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                             }
         }

    @IBAction func submitBtnActn(_ sender: Any) {
        
        if nameTxt.text!.count == 0 {
                    self.view.makeToast("Please enter your name!", duration: 3.0, position: .bottom)
                        return
                    }
        
        
        if !(nameTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(nameTxt.text ?? "")
        } else {
                    print("text length",nameTxt.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter your name!", duration: 3.0, position: .bottom
                    )
                return
                }
        
                    if categoryTxt.text!.count == 0 {
                        self.view.makeToast("Please select category!", duration: 3.0, position: .bottom)

                            return
                    }
        
        
        if !(categoryTxt.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(categoryTxt.text ?? "")
        } else {
                    print("text length",categoryTxt.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please select category!", duration: 3.0, position: .bottom
                    )
                return
                }
                    
    
        
        if titleTxt.text!.count == 0 {
                        self.view.makeToast("Please enter title!", duration: 3.0, position: .bottom)
                      
                        return
                    }
      
       
        if policeDepartmentTxt.text!.count == 0 {
                     self.view.makeToast("Please select Department!", duration: 3.0, position: .bottom)
           
            return
        }
        if zipCode.text!.count == 0 {
                     self.view.makeToast("Please select zipcode!", duration: 3.0, position: .bottom)
           
            return
        }
        if complaintForTxt.text!.count == 0 {
                     self.view.makeToast("Please enter complaint!", duration: 3.0, position: .bottom)
           
            return
        }
        
                    
                    if  !Reachability.isConnectedToNetwork() {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                            return
                    }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

                    let parameter:[String:String] = [
                        "user_id"  : userid,
                        "name": self.nameTxt.text!,
                        "category": self.categoryTxt.text!,
                        "title": self.titleTxt.text!,
                        "department": self.policeDepartmentTxt.text!,
                        "zipcode": self.zipCode.text!,
                        "complain_detail": self.complaintForTxt.text!

                    ]

                    print("\nThe parameters for login : \(parameter)\n")

                    let activityData = ActivityData()
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                    
                    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.fileAComplaint, dataDict: parameter, { (json) in
                        print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                           
//                                DispatchQueue.main.async {
//                                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
//                                    self.present(vc!, animated: true)
//                                   //  self.navigationController?.pushViewController(vc!, animated: true)
//                                }
                    
                        }else {
                            
                            self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
//                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                return
//                            })

            //                let banner = NotificationBanner(title: "Alert", subtitle: json["msg"].stringValue , style: .danger)
            //                banner.show(queuePosition: .front)
                        }
                        
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
        
    }
    
    
    func setPlaceholder(){
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Name",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        categoryTxt.attributedPlaceholder = NSAttributedString(string: "Category",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        titleTxt.attributedPlaceholder = NSAttributedString(string: "Title",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        policeDepartmentTxt.attributedPlaceholder = NSAttributedString(string: "Department",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        zipCode.attributedPlaceholder = NSAttributedString(string: "ZipCode",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        complaintForTxt.attributedPlaceholder = NSAttributedString(string: "Complaint for?",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
  
    /*
    // MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
