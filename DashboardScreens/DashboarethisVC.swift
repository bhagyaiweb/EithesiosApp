//
//  DashboarethisVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 19/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import AVKit
import AVFoundation
import Kingfisher

class DashboarethisVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MyCellDelegate {
    var backgroundImgArray = ["group_2","group_5","group_7","group_9"]
    var titleLblArray = ["Feeds","Police Department","My Accounts","Community Representative"]
    
    var feeds:Array<JSON>?
    var policeDepartment:Array<JSON>?
    var community:Array<JSON>?
    var myCollection:Array<JSON>?
    var collection:[String:JSON]?
    var index:IndexPath?
    var sideMenuOption = ["Dashboard","My Videos","My Contacts","My Profile","Support","Logout"]
  
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
    
    override func viewDidLoad() {
        self.dashboardtableview.separatorStyle = .none
        super.viewDidLoad()
        self.sideMenu.delegate = self
        self.sideMenu.dataSource = self
        reginib()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pinCodeLbl.text = UserData.ZipCode
        self.feeds?.removeAll()
        self.policeDepartment?.removeAll()
        self.community?.removeAll()
        self.myCollection?.removeAll()
        self.collection?.removeAll()
        getDashBoardData()
        self.dashboardtableview.delegate = self
        self.dashboardtableview.dataSource = self
        
    }
    
    func getDashBoardData(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
        
        let parameter:[String:String] = [
            "zipcode": UserData.ZipCode,
            "user_id":"2"
        ]
        
        print("\nThe parameters for Dashboard : \(parameter)\n")
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.dashboard_Data, dataDict: parameter, { (json) in
//                            print(json)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            if json["status"].stringValue == "200" {
                                
                                if let data = json["data"].dictionary{
                                    self.collection = data
                                    if let feed = data["feeds"]?.array{
                                        self.feeds = feed
                                    
                                    }
                                    if let communities = data["community"]?.array{
                                        self.community = communities
                                    }
                                    if let policeDepart = data["police_department"]?.array{
                                        self.policeDepartment = policeDepart
                                    }
                                }
                                print("/n \(self.feeds!)")
                                print("/n \(self.policeDepartment!)")
                                print("/n \(self.community!)")
                                
//                                if self.
                                let url = self.feeds![0]["url"].stringValue
                                let videoURL = URL(string: url)
                                
                                let player = AVPlayer(url: videoURL!)
                                let playerController = AVPlayerViewController()
                                playerController.player = player

                                playerController.view.frame = self.topView.bounds
                                self.topView.addSubview(playerController.view)
                                self.addChild(playerController)

                                player.play()
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                DispatchQueue.main.async {
                                    self.dashboardtableview.reloadData()
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
    
    @IBAction func sidemenuBttn(_ sender: Any) {
        if self.sideMenuLeading.constant == -200{
//            self.sideMenuLeading.constant = 0
            UIView.animateKeyframes(withDuration: 5, delay: 0, options: .repeat, animations: {
                self.currntLbl.isHidden = true
                self.pinCodeLbl.isHidden = true
                self.dropdownBttn.isHidden = true
                self.searchBttn.isHidden = true
                self.sideMenuLeading.constant = 0
                
            }, completion: nil)
        }
        else{
            UIView.animateKeyframes(withDuration: 5, delay: 0, options: .repeat, animations: {
                self.sideMenuLeading.constant = -200
                self.currntLbl.isHidden = false
                self.pinCodeLbl.isHidden = false
                self.dropdownBttn.isHidden = false
                self.searchBttn.isHidden = false
            }, completion: nil)
        }
    }
    
    @IBAction func onPressedSearchBtn(_ sender: Any)
    {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func reginib()
    {
          let nib1 = UINib(nibName: "Feedscell", bundle: nil)
          dashboardtableview.register(nib1, forCellReuseIdentifier: "Feedscell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.dashboardtableview{
            return backgroundImgArray.count
        }
        else{
            return 7
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
                if self.feeds?.count == 0{
                    cell.feedCollectionHeight.constant = 0.0
                }
                else{
                    cell.Feedcollection.reloadData()
                }
            }
            else if indexPath.row == 1{
                cell.Feedcollection.tag = 201
                if self.policeDepartment?.count == 0{
                    cell.feedCollectionHeight.constant = 0.0
                }
                else{
                    cell.Feedcollection.reloadData()
                }
            }
            else if indexPath.row == 2{
                cell.Feedcollection.tag = 301
                if self.myCollection?.count == 0{
                    cell.feedCollectionHeight.constant = 0.0
                }
                else{
                    cell.Feedcollection.reloadData()
                }
            }
            else{
                cell.Feedcollection.tag = 401
                if self.community?.count == 0{
                    cell.feedCollectionHeight.constant = 0.0
                }
                else{
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
                cell.userNameLbl.text = UserData.name
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SMOptionCell", for: indexPath) as! SMOptionCell
                cell.optionName.text = self.sideMenuOption[indexPath.row - 1]
                return cell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.sideMenu{
            if indexPath.row == 4{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 6{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 260
//    }
    
    func onPressedArrowBtn(cell: Feedscell)
    {
       let indexPath = self.dashboardtableview.indexPath(for: cell)
        if indexPath?.row == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyACcountVC") as? MyACcountVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
            if indexPath?.row == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PoliceDepartmentVC") as? PoliceDepartmentVC
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        else if indexPath?.row == 3{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityrepersentativeVC") as? CommunityrepersentativeVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewFeedVC1") as? ViewFeedVC1
         self.navigationController?.pushViewController(vc!, animated: true)
        }
     }

}


extension DashboarethisVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.index!.row == 0{
            return self.feeds?.count ?? 0
        }
        else if self.index!.row == 1{
            return self.policeDepartment?.count ?? 0
        }
        else if self.index!.row == 2{
            return 0
        }
        else{
            return self.community?.count ?? 0
        }
    }
         
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCollectionVC", for: indexPath) as! FeedsCollectionVC
            if collectionView.tag == 101{
                        
                cell.postTitleLbl.text = self.feeds?[indexPath.row]["category"].stringValue
                    }
                    else if collectionView.tag == 201{
                        cell.postTitleLbl.isHidden = true
                        cell.userProfileImg.isHidden = true
                        cell.bgView.isHidden = false
                        let url = URL(string: self.policeDepartment![indexPath.row]["profile_pic"].stringValue)
                        cell.descriptionImg.kf.setImage(with: url)
                        cell.bgNameLbl.text = self.policeDepartment![indexPath.row]["name"].stringValue
                        cell.bgPhoneLbl.text = self.policeDepartment![indexPath.row]["phone_number"].stringValue
                    }
                    else if collectionView.tag == 301{
            //            return 0
                    }
                    else if collectionView.tag == 401{
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
            let videoURL = URL(string: url)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
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
//            return 0
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
