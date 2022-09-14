//
//  PoliceDepartmentVC.swift
//  Eithes
//
//  Created by iws044 on 04/12/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import NVActivityIndicatorView


protocol dataSelectedDelegate1{
    func userSelectedValue1(info : String)
}

class PoliceDepartmentVC: UIViewController,checking1delegate {
    
    func userSelectedValue(info: String) {
        self.userZipcodeStr =  info
        print("XIPCODEyy",info)
    }
    
    func navigateToDashboard(isclicked: String) {
        self.userZipcodeStr = isclicked
        print("newcode",isclicked)

    }
    
    var PDJson = Dictionary<String, JSON>()
    var BGImgArr = ["1stbackgroundImgaccount", "rectangle-2", "1stbackgroundImgaccount", "rectangle-2"]
    var PDJsonKeys = Array<String>()
    var userZipcodeStr : String?
    
    @IBOutlet weak var nodataLbl: UILabel!
    
    @IBOutlet weak var PDTable: UITableView!
    var delegate : dataSelectedDelegate1? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.PDTable.delegate = self
        self.PDTable.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nodataLbl.isHidden = true
        print("PINCODE",self.userZipcodeStr ?? "nil")
        self.getPDList()
    }

    
    func getPDList() {
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "zipcode": self.userZipcodeStr ?? ""
            ]
            print("\nThe parameters for policedepartmentDashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getPDList, dataDict: parameter, { (json) in
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    self.nodataLbl.isHidden = true

                                    if let data = json["data"].dictionary{
                                        self.PDJson = data
                                        print("DATA",data)
                                        self.PDJsonKeys = Array(self.PDJson.keys)
                                        self.PDTable.isHidden = false
                                    }
                                    self.PDTable.reloadData()
                                }else {
                                   // self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                   // Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                       // return
                                   // })
                                    let msg = json["msg"].stringValue
                                    self.nodataLbl.isHidden = false
                                    self.PDTable.isHidden = true
                                    self.nodataLbl.text = msg
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
//        if (delegate != nil) {
//            print("SECONDZIPCODEhhh",self.userZipcodeStr!)
//            delegate?.dataselected(info: self.userZipcodeStr ?? "")
//            print("SECONDZIPCODElast", self.userZipcodeStr)
//
//        }
        
       // if (delegate != nil) {
//            var information : String = self.userZipcodeStr ?? ""
//            print("SECONDZIPCODE",information)
//            print("SECONDZIPCODE",self.userZipcodeStr)
//            delegate?.userSelectedValue1(info: information)
//            print("SECONDZIPCODElast",information)
      //  }
        
       // if (delegate != nil) {
        
            let information : String = self.userZipcodeStr ?? ""
            print("GENARATION",information)
            print("SECONDZIPCODE",self.userZipcodeStr)
        delegate?.userSelectedValue1(info: information)
            print("RGHJKKK",information)
      //  }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func searchButtontapped(_ sender: Any) {
        let newvc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
      //  newvc?.isSerach = "PolicDepart"
        newvc?.delegate2 = self
        self.present(newvc!, animated: true, completion: nil)
    }
}

extension PoliceDepartmentVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return PDJsonKeys.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        _ = Array(self.PDJson.keys)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PoliceDepartmentTableCell", for: indexPath) as! PoliceDepartmentTableCell
        cell.bgImgView.image = UIImage(named: self.BGImgArr[indexPath.row])
        cell.titleLbl.text = PDJsonKeys[indexPath.row]
        cell.PDCollectionView.tag = 100+indexPath.row
        cell.PDCollectionView.delegate = self
        cell.PDCollectionView.dataSource = self
        
        if PDJsonKeys.count < 4 {
            self.PDTable.isScrollEnabled = true
        }else{
            self.PDTable.isScrollEnabled = false
        }
        
        return cell
    }
}


extension PoliceDepartmentVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView.tag == 100{
            return self.PDJson[self.PDJsonKeys[0]]!.count
        }
        else if collectionView.tag == 101{
            return self.PDJson[self.PDJsonKeys[1]]!.count
        }
        else if collectionView.tag == 102{
            return self.PDJson[self.PDJsonKeys[2]]!.count
        }
        else if collectionView.tag == 103{
            return self.PDJson[self.PDJsonKeys[3]]!.count
        }
        else{
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        if collectionView.tag == 100{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDCollectionCell", for: indexPath) as! PDCollectionCell
            print(self.PDJson[self.PDJsonKeys[0]]![0]["name"].stringValue)
            cell.userName.text = self.PDJson[self.PDJsonKeys[0]]![0]["name"].stringValue
            cell.userMobileNo.text = self.PDJson[self.PDJsonKeys[0]]![0]["phone_number"].stringValue
            let imgURL = URL(string: (self.PDJson[self.PDJsonKeys[0]]![0]["profile_pic"].stringValue))!
            cell.userImg.kf.setImage(with: imgURL)
            return cell
        }
        else if collectionView.tag == 101{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDCollectionCell", for: indexPath) as! PDCollectionCell
            cell.userName.text = self.PDJson[self.PDJsonKeys[1]]![0]["name"].stringValue
            cell.userMobileNo.text = self.PDJson[self.PDJsonKeys[1]]![0]["phone_number"].stringValue
            let imgURL = URL(string: (self.PDJson[self.PDJsonKeys[1]]![0]["profile_pic"].stringValue))!
            cell.userImg.kf.setImage(with: imgURL)
            return cell
        }
        else if collectionView.tag == 102{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDCollectionCell", for: indexPath) as! PDCollectionCell
            cell.userName.text = self.PDJson[self.PDJsonKeys[2]]![0]["name"].stringValue
            cell.userMobileNo.text = self.PDJson[self.PDJsonKeys[2]]![0]["phone_number"].stringValue
            let imgURL = URL(string: (self.PDJson[self.PDJsonKeys[2]]![0]["profile_pic"].stringValue))!
            cell.userImg.kf.setImage(with: imgURL)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PDCollectionCell", for: indexPath) as! PDCollectionCell

                cell.userName.text = self.PDJson[self.PDJsonKeys[3]]![0]["name"].stringValue
                cell.userMobileNo.text = self.PDJson[self.PDJsonKeys[3]]![0]["phone_number"].stringValue
                let imgURL = URL(string: (self.PDJson[self.PDJsonKeys[3]]![0]["profile_pic"].stringValue))!
                cell.userImg.kf.setImage(with: imgURL)
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PDCollectionCell
        self.dialNumber(number: cell.userMobileNo.text ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionwidth = collectionView.bounds.width
            return CGSize(width: collectionwidth/1.25, height:collectionView.bounds.height - 5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  3
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
       }
    }
}
