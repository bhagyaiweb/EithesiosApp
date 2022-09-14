
//  CommunityRepresentativeElectedOffical.swift
//  Eithes
//  Created by Shubham Tomar on 24/03/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import NVActivityIndicatorView
import SwiftyJSON
import Alamofire
import Kingfisher
import MessageUI


class CommunityRepresentativeElectedOffical: UIViewController, UITableViewDataSource,UITableViewDelegate,CommuntyReprsentativeTablecellDelegate, MFMessageComposeViewControllerDelegate{
    
    
//     var nameArray = ["Felix Koutchinski","Daniel Tausis","Aidan Bartos","Andrew Gaines","Arny Mogensen","Felix Koutchinski","Daniel Tausis"]
   
    @IBOutlet weak var CommunityRepresentElectedOfficalTable: UITableView!
    var collection:Array<JSON>?
    var locationType:String?
    var urlEndPathType:String?
    @IBOutlet weak var cityImgView: UIImageView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var cityUnderLine: UILabel!
    @IBOutlet weak var townImgView: UIImageView!
    @IBOutlet weak var townLbl: UILabel!
    @IBOutlet weak var townUnderLine: UILabel!
    @IBOutlet weak var stateImgView: UIImageView!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var stateUnderLine: UILabel!
    
    @IBOutlet weak var nodataLbl: UILabel!
    
    var zipcodeStr : String?
    override func viewDidLoad()
    {
       super.viewDidLoad()
         reginib()
        self.CommunityRepresentElectedOfficalTable.separatorStyle = .none
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nodataLbl.isHidden = true
    }
    
    func setData(){
        if self.locationType! == "1"{
            self.cityImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.cityLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.cityUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.townImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.townLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.townUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.stateImgView.tintColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.stateLbl.textColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.stateUnderLine.backgroundColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.getData(urlEndPath: urlEndPathType!, type: "1")
        }
        else if self.locationType! == "2"{
            self.cityImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.cityLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.cityUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.townImgView.tintColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.townLbl.textColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.townUnderLine.backgroundColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.stateImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.stateLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.stateUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.getData(urlEndPath: urlEndPathType!, type: "2")
        }
        else if self.locationType! == "3"{
            self.cityImgView.tintColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.cityLbl.textColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.cityUnderLine.backgroundColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
            self.townImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.townLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.townUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.stateImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.stateLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.stateUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
            self.getData(urlEndPath: urlEndPathType!, type: "3")
        }
    }
    
    
    @IBAction func cityButtonTapped(_ sender: Any) {
        self.cityImgView.tintColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.cityLbl.textColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.cityUnderLine.backgroundColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.townImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.townLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.townUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.stateImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.stateLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.stateUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.getData(urlEndPath: urlEndPathType!, type: "3")
    }
    
    @IBAction func townButtonTapped(_ sender: Any) {
        self.cityImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.cityLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.cityUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.townImgView.tintColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.townLbl.textColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.townUnderLine.backgroundColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.stateImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.stateLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.stateUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.getData(urlEndPath: urlEndPathType!, type: "2")
    }
    
    @IBAction func stateButtonTapped(_ sender: Any) {
        self.cityImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.cityLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.cityUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.townImgView.tintColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.townLbl.textColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.townUnderLine.backgroundColor = #colorLiteral(red: 0.5290050507, green: 0.5446417332, blue: 0.5594229102, alpha: 0.9927986005)
        self.stateImgView.tintColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.stateLbl.textColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.stateUnderLine.backgroundColor = #colorLiteral(red: 0.07127828151, green: 0.3422953784, blue: 0.7866567969, alpha: 1)
        self.getData(urlEndPath: urlEndPathType!, type: "1")
    }
    
    @IBAction func onPressedSosBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyACcountVC") as? MyACcountVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func reginib()
    {
            let nib = UINib(nibName: "CommuntyReprsentativeTablecell", bundle: nil)
           CommunityRepresentElectedOfficalTable.register(nib, forCellReuseIdentifier: "CommuntyReprsentativeTablecell")
    }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.collection?.count ?? 0
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "CommuntyReprsentativeTablecell", for: indexPath) as! CommuntyReprsentativeTablecell
                cell.policeNameLbl.text = self.collection?[indexPath.row]["name"].stringValue
                cell.phoneNumberLbl.text = self.collection?[indexPath.row]["phone_number"].stringValue
                
                let ImgUrl = URL(string: (self.collection?[indexPath.row]["profile_pic"].stringValue)!)
                cell.userImgView.kf.setImage(with: ImgUrl)
            cell.delegate = self
            return cell
             
         }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
   
    @IBAction func onPressedClosedBtn(_ sender: Any)
    {
        self.dismiss(animated: true,completion: nil)
      //  self.navigationController?.popViewController(animated: true)
    }
    
    
    func callbtnTapped(cell: CommuntyReprsentativeTablecell) {
        let indexPath = self.CommunityRepresentElectedOfficalTable.indexPath(for: cell)
        let number = self.collection?[indexPath!.row]["phone_number"].stringValue
        self.dialNumber(number: number!)
    }
    
    func messagebtnTapped(cell: CommuntyReprsentativeTablecell) {
        let indexPath = self.CommunityRepresentElectedOfficalTable.indexPath(for: cell)
        let number = self.collection?[indexPath!.row]["name"].stringValue
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Enter a message details here";
        messageVC.recipients = [number!]
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
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
    
    func locationBtnTapped(cell: CommuntyReprsentativeTablecell) {
        print("location button tapped")
    }
    
    func deletebtnTapped(cell: CommuntyReprsentativeTablecell) {
        print("delete button tapped")
    }
    
}

extension CommunityRepresentativeElectedOffical{
    
    func getData(urlEndPath: String, type: String){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
        print("ZIPCODEPASS",self.zipcodeStr)
            
            let parameter:[String:String] = [
                "zipcode": "90001",
                "type":"\(type)"
            ]
            
            print("\nThe parameters for Dashboard : \(parameter)\n")
            self.collection?.removeAll()
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
        print(Defines.ServerUrl+urlEndPath)
        print(parameter)
        
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + urlEndPath, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    self.nodataLbl.isHidden = true

                                    if let data = json["data"].array{
                                        print(data)
                                        self.collection = data
                                        self.CommunityRepresentElectedOfficalTable.isHidden = false
                                        self.CommunityRepresentElectedOfficalTable.reloadData()
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.CommunityRepresentElectedOfficalTable.reloadData()
                                    }
                                }else {
//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                        return
//                                    })
                                    self.nodataLbl.isHidden = false
                                    let newmsg = json["msg"].stringValue
                                    self.nodataLbl.text = newmsg
                                    
                                }
                                
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
}
