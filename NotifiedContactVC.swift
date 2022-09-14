//
//  NotifiedContactVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 04/08/21.
//  Copyright © 2021 Iws. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import SDWebImage

class NotifiedContactVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addbuttonBtn: UIButton!
    var notifiedContactName = ["Allef Michel","Michael Dam","Daniel Xavier","Joelson Melo","Bruce Mars","Taiwili Kayan","Daniel Xavier","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich"]
    
    
    var contactNotiedArr = [JSON]()
    var categoryVal : String?
    var subcategoryVal : String?
    var latvalDouble : Double?
    var longvalDouble : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        addbuttonBtn.setTitle("", for: .normal)
        let nib1 = UINib(nibName: "NotifiedContactCell", bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: "NotifiedContactCell")
        self.latvalDouble  = UserDefaults.standard.object(forKey: "latitude") as? Double
        print("VALUESDGGHGFGFG : ", self.latvalDouble?.string)

        self.longvalDouble  = UserDefaults.standard.object(forKey: "longitude") as? Double
        print("VALUELONGDouble : ", self.longvalDouble?.string)
        // Do any additional setup after loading the view.
        SosStartApiCall1()
    }
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        let addconnectVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewConnectionVC") as! AddNewConnectionVC
        self.present(addconnectVC, animated: true, completion: nil)
    }
    
    
    func SosStartApiCall1(){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
    var channelName12 = UserDefaults.standard.object(forKey: "username") as! String
    print(channelName12)
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
        var catvalue : String = UserDefaults.standard.object(forKey: "catVal") as? String ?? ""
        print("CATVAL",catvalue)
        var subcatvalue : String = UserDefaults.standard.object(forKey: "subcatVal") as? String ?? ""
        print("SUBCATVAL",subcatvalue)

        
    let parameter:[String:String] = [
        "zipcode": "201301",
        "user_id": useridtoagora,
        "category_id" : categoryVal ?? "",
        "category_name" : subcategoryVal ?? "",
        "lat" : self.latvalDouble?.string ?? "",
        "lng" : self.longvalDouble?.string ?? "",
        "appID" :"a6e3170384984816bf987ddd4aad3029",
        "appCertificate" : "caca5b8fe77145efb2acde599f2e7ae6",
        "channelName" : channelName12
    ]
        
    print("\nThe parameters of Notified : \(parameter)\n")
        
    let activityData = ActivityData()
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startSos, dataDict: parameter, { (json) in
                    //    print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary{
                              //  self.token  = data["token"]?.stringValue
                              //  print("PRINT TOKEN",self.token)
                                self.contactNotiedArr = data["usersInRangeArr"]?.arrayValue ?? [0]
                                print("USERCOUNTcheck",self.contactNotiedArr)
                                self.collectionView.reloadData()
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
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactNotiedArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotifiedContactCell", for: indexPath) as! NotifiedContactCell
         cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.nameLbl.text = self.contactNotiedArr[indexPath.row]["name"].stringValue
        print("BHAGYADKAD",self.contactNotiedArr[indexPath.row]["name"].stringValue)
        print("SHOWTHENAME",cell.nameLbl.text)
        let url = URL(string: self.contactNotiedArr[indexPath.row]["profile_pic"].stringValue)
       cell.profileImgView.kf.setImage(with: url)
        if url == nil {
            cell.profileImgView.image = UIImage(named: "MenuProfile")
        }else{
           cell.profileImgView.kf.setImage(with: url)
        }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 334, height: 143)
    }
  //  (self.collectionView.frame.width/2)-30
    
}
