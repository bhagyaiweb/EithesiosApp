
//  BeforeGoingLiveMsgVC.swift
//  Eithes
//  Created by Admin on 10/08/22.
//  Copyright © 2022 Iws. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class BeforeGoingLiveMsgVC: UIViewController {

    var sidStr : String?
    var token : String?
    var connectionInrangeStr : String?
    var usersCount : String?
    var categoryIDSTring : String?
    var subCategorySTR : String?
    var resourceIDstr : String?
    var channelNameStr : String?
    var latvalDouble: Double?
    var longvalDouble: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.latvalDouble  = UserDefaults.standard.object(forKey: "latitude") as? Double
        print("VALUESDGGHGFGFG : ", self.latvalDouble?.string)
        self.longvalDouble  = UserDefaults.standard.object(forKey: "longitude") as? Double
        print("VALUELONGDouble : ", self.longvalDouble?.string)
    }
        
   
    @IBAction func goLiveBtnAction(_ sender: Any) {
        let livesteam = liveStreamViewController()
        //livesteam.stoprecodingStr = getsidvalue as! String
       // as! String
       // print("PRINTSTOPRECORDING",livesteam.stoprecodingStr!)
        livesteam.categoryStr = self.categoryIDSTring
        livesteam.subCateStr = self.subCategorySTR
        print("livesteam",livesteam.subCateStr)
        livesteam.modalPresentationStyle = .fullScreen
        self.present(livesteam, animated: true, completion: nil)
       // aquireApiCall()
    }

    
    func SosStartApiCall(){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
    var channelName12 = UserDefaults.standard.object(forKey: "username") as! String
    print(channelName12)
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

        print("LONGITUDE",latvalDouble)
        
    let parameter:[String:String] = [
        "zipcode": "201301",
        "user_id": useridtoagora,
        "category_id" : categoryIDSTring ?? "",
        "category_name" : subCategorySTR ?? "",
        "lat" : self.latvalDouble?.string ?? "",
        "lng" : self.longvalDouble?.string ?? "",
        "appID" : "a6e3170384984816bf987ddd4aad3029",
        "appCertificate" : "caca5b8fe77145efb2acde599f2e7ae6",
        "channelName" : channelName12
    ]

    print("\n The parameters of LIVE : \(parameter)\n")
        
    let activityData = ActivityData()
        
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startSos, dataDict: parameter, { (json) in
                     //   print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary{
                                self.token  = data["token"]?.stringValue
                                print("cComplete Data",data)
                                print("PRINT TOKEN",self.token)
                                self.usersCount = data["usersInRangeArr"]?.stringValue ?? "0"
                                self.connectionInrangeStr = data["connectionsInRangeArr"]?.stringValue ?? "0"
                               print("USERCOUNT",self.usersCount ?? "0")
                                print("CONNECTIONINRANGE",self.connectionInrangeStr)
                                self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)

                                //self.StartAgoraRecordingApiCall()
                // let contrll = SosStartVC()
                //self.present(contrll, animated: true)
//let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
//                                    vc?.modalPresentationStyle = .fullScreen
//                                    self.present(vc!, animated: true, completion: nil)

                             //   DispatchQueue.main.async {
//                     let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
//                                    vc?.modalPresentationStyle = .fullScreen
//                                self.present(vc!, animated: true, completion: nil)

//                                    let livesteam = liveStreamViewController()
//                                    livesteam.modalPresentationStyle = .fullScreen
//                                    self.present(livesteam, animated: true, completion: nil)
//                               // }
                                
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
    

    func aquireApiCall(){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
        
   self.channelNameStr  = UserDefaults.standard.object(forKey: "username") as! String
        
        print("CHANNEL NAME",self.channelNameStr)
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
    
    let parameter:[String:String] = [
        "cname": self.channelNameStr ?? "",
        "uid" : useridtoagora,
    ]
    print("\nThe parameters of Auire : \(parameter)\n")
    let activityData = ActivityData()
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startAquireAgora, dataDict: parameter, { (json) in
                        print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary {
                                self.resourceIDstr  = data["resourceId"]?.stringValue
                                print("PRINT RESOURCEID",self.resourceIDstr)
                                self.SosStartApiCall()
                            }
                        }else{
                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                return
                            })
                        }
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
    }
    

    func StartAgoraRecordingApiCall(){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
            
    print("channelnameshowstr",self.channelNameStr)
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
    
    let parameter:[String:String] = [
        "cname" : self.channelNameStr ?? "",
        "uid" :  useridtoagora,
        "resourceId" : self.resourceIDstr ?? ""
    ]
        
    print("\nThe parameters of AgoraStart : \(parameter)\n")
    let activityData = ActivityData()
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startAgora, dataDict: parameter, { (json) in
                        print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary {
                                print("DATASHOWSTARTAGORA",data)
                                self.resourceIDstr  = data["resourceId"]?.stringValue
                                var stringID : String = data["sid"]?.stringValue ?? "nil"
                                print("PRINT SID",stringID)
                                var reasonStr : String = data["reason"]?.stringValue ?? ""
                            
                              //  let codeStr : Int = data["code"]!.intValue
                                print("PRINT RECORDING",self.resourceIDstr)
                               
                                var sidValueStr = UserDefaults.standard.setValue(self.sidStr, forKey: "sidString")
                                print("SIDSTRING",sidValueStr)
                                print("PRINT REASON",reasonStr)
                                let getsidvalue = UserDefaults.standard.object(forKey: "sidString")
                                print("PRINT SIDVALUE",getsidvalue)
                                let livesteam = liveStreamViewController()
                                livesteam.stoprecodingStr = getsidvalue as! String
                                as! String
                                print("PRINTSTOPRECORDING",livesteam.stoprecodingStr!)
                                livesteam.categoryStr = self.categoryIDSTring
                                livesteam.subCateStr = self.subCategorySTR
                                livesteam.modalPresentationStyle = .fullScreen
                                self.present(livesteam, animated: true, completion: nil)
                            }
                        }else{
                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                return
                            })
                        }
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
    
    }
    
}















