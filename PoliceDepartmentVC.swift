//
//  PoliceDepartmentVC.swift
//  Eithes
//
//  Created by iws044 on 04/12/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import NVActivityIndicatorView


class PoliceDepartmentVC: UIViewController {

    var PDJson = Dictionary<String, JSON>()
    var BGImgArr = ["1stbackgroundImgaccount", "rectangle-2", "1stbackgroundImgaccount", "rectangle-2"]
    var PDJsonKeys = Array<String>()
    
    @IBOutlet weak var PDTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PDTable.delegate = self
        self.PDTable.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getPDList()
    }
    
    func getPDList(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "zipcode":UserData.ZipCode
            ]
            print("\nThe parameters for Dashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getPDList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    if let data = json["data"].dictionary{
                                        self.PDJson = data
                                        self.PDJsonKeys = Array(self.PDJson.keys)
                                        self.PDTable.reloadData()
                                    }
                                }else {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButtontapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.navigationController?.pushViewController(vc!, animated: true)
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
        
        let data = Array(self.PDJson.keys)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PoliceDepartmentTableCell", for: indexPath) as! PoliceDepartmentTableCell
        cell.bgImgView.image = UIImage(named: self.BGImgArr[indexPath.row])
        cell.titleLbl.text = PDJsonKeys[indexPath.row]
        cell.PDCollectionView.tag = 100+indexPath.row
        cell.PDCollectionView.delegate = self
        cell.PDCollectionView.dataSource = self
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
                // add error message here
       }
    }
}
