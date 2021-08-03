
//  UserBenifitVC.swift
//  Eithes
//  Created by Shubham Tomar on 27/03/20.
//  Copyright © 2020 Iws. All rights reserved.
import UIKit
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import Toast_Swift
import TweeTextField
import MessageUI
import AVKit
import Kingfisher
import FittedSheets


class UserBenifitVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,MyCellDelegate1,CommuntyReprsentativeTablecellDelegate, MFMessageComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RegisteredVehicleCellDelegate,drivingLicenceCellDelegate,profileImgCellDelegate,RadioButtonCellDelegate{
        
        
    var nameArrayCell = ["Ali Morshedlou","Bram Naus","Ellyot"]
    var buttonNAmeArray = ["Self Help Videos","Attorneys","Bail Bonds","Vehicle Registration","Vehicle Insurance","Driver License"]
    var DirectoryButtonArray = ["My Connections","Tracker"]
    var vehicleREgistrationArray = ["Vehicle Name","Model Number","Vehicle Number","Model Year","Registration Number","VIN Number","License Plate Number"]
    var vehicleInsuranceArray = ["Insurance Name","Start Date","Expire Date","Policy Number","Liability Coverage","Comp and Collission"]
    var connectionListArray = ["","Name","Mobile Number","Email","Location",""]
    var formValues = ["Vehicle Name":"","Model Number":"","Vehicle Number":"","Model Year":"","Registration Number":"","VIN Number":"","License Plate Number":"","Insurance Name":"","Start Date":"","Expire Date":"","Policy Number":"","Liability Coverage ":"","Comp and Collission Coverage":"","Name":"","Mobile Number":"","Email":"","Location":""]
    var formValues1 = ["Vehicle Name":"","Model Number":"","Vehicle Number":"","Model Year":"","Registration Number":"","VIN Number":"","License Plate Number":"","Insurance Name":"","Start Date":"","Expire Date":"","Policy Number":"","Liability Coverage ":"","Comp and Collission Coverage":"","Name":"","Mobile Number":"","Email":"","Location":""]
    
    var registeredVehicles = Array<JSON>()
    var insuredVehicles = Array<JSON>()
    var atorneyList = Array<JSON>()
    var bailBondList = Array<JSON>()
    var videosList = Array<JSON>()
    var trackerList = Array<JSON>()
    var drivingLicenseImage = Array<JSON>()
    var myConnections = Array<JSON>()
    var buttonName = ""
    var nameTitle = ""
    var indexpath:IndexPath?
    var startDateIndexpath:IndexPath?
    var expireDateIndexpath:IndexPath?
    let datePicker = UIDatePicker()
    var startDate = true
    var VideoUrl: URL?
    var drivingLicenseImg: UIImage?
    var radioButtonPermission: Bool?
    var userDirectory:Bool? 
    
    @IBOutlet weak var videouploadBtn: UIButton!
    @IBOutlet weak var SosBtn: UIButton!
    @IBOutlet weak var uploadVideoBtn: UIButton!
    @IBOutlet weak var uploadDrivingLicenseBtn: UIButton!
    @IBOutlet weak var videoTitlelbl: UILabel!
    @IBOutlet weak var DrivinglicenseUploadView: UIView!
    @IBOutlet weak var selfVideoCollecionView: UICollectionView!
    @IBOutlet weak var Savebtn: UIButton!
    @IBOutlet weak var VehicalregistrationAddMoreView: UIView!
    @IBOutlet weak var trackerButtonView: UIView!
    @IBOutlet weak var uploadVideoView2: UIView!
    @IBOutlet weak var uploadVideoNoVideoView1: UIView!
    @IBOutlet weak var buttonCollection: UICollectionView!
    @IBOutlet weak var atteorneysTable: UITableView!
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var ZipCodeLbl: UILabel!
    @IBOutlet weak var openVideoGalleryBttn: UIButton!
    @IBOutlet weak var videosCOllection: UICollectionView!
    @IBOutlet weak var addVideosButton: UIButton!
    @IBOutlet weak var uploadVideoLbl: UILabel!
    @IBOutlet weak var uploadVideoBGImageView: UIImageView!
    @IBOutlet weak var uploadVideoIcon: UIImageView!
    
    @IBOutlet weak var videoTitleTF: UITextField!
    //    @IBOutlet weak var VRView: UIView!
    @IBOutlet weak var videoUploadCollectionView: UIView!
    override func viewDidLoad()
    {
        self.Savebtn.isHidden = true
        self.trackerButtonView.isHidden = true
        super.viewDidLoad()
        atteorneysTable.delegate = self as UITableViewDelegate
        atteorneysTable.dataSource = (self as UITableViewDataSource)
        selfVideoCollecionView.delegate = self
        selfVideoCollecionView.dataSource = self
        selfVideoCollecionView.layoutIfNeeded()
        self.atteorneysTable.separatorStyle = .none
        self.atteorneysTable.isHidden = true
        self.VehicalregistrationAddMoreView.isHidden = true
        self.uploadVideoNoVideoView1.isHidden = true
        self.uploadVideoView2.isHidden = true
        self.addVideosButton.isHidden = true
        videoUploadCollectionView.isHidden = true
        DrivinglicenseUploadView.isHidden = true
        Savebtn.isHidden = true
        reginib()
        //given btn radius
        Savebtn.layer.cornerRadius = 5
        Savebtn.clipsToBounds = true
        videouploadBtn.layer.cornerRadius = 5
        videouploadBtn.clipsToBounds = true
        uploadVideoBtn.layer.cornerRadius = 5
        uploadVideoBtn.clipsToBounds = true
        uploadDrivingLicenseBtn.layer.cornerRadius = 5
        uploadDrivingLicenseBtn.clipsToBounds = true
        self.atteorneysTable.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ZipCodeLbl.text = UserData.ZipCode
        self.registeredVehicles.removeAll()
        self.insuredVehicles.removeAll()
        self.atorneyList.removeAll()
        self.bailBondList.removeAll()
        self.indexpath = nil
        self.buttonCollection.reloadData()
        self.atteorneysTable.reloadData()
        self.atteorneysTable.isHidden = true
    }
    
    @IBAction func mapViewButtonTapped(_ sender: Any) {
        let controller1 = self.storyboard?.instantiateViewController(identifier: "TrackerMapVC") as! TrackerMapVC
        
        let controller = SheetViewController(controller: controller1, sizes: [.fixed(600)])
        controller.topCornersRadius = 15
        controller.blurBottomSafeArea = true
        controller.adjustForBottomSafeArea = true
        controller.extendBackgroundBehindHandle = false
        controller.handleColor = UIColor.clear
        self.present(controller, animated: false, completion: nil)
    }
    
    
    
    func setDatePicker(textfield: UITextField) {
        //Format Date
        datePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        if self.formValues["Start Date"] != nil && self.formValues["Start Date"]?.count != 0{
            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "dd MMM yyyy"
            let date = dateFormatter.date(from:self.formValues["Start Date"]!)!
            datePicker.minimumDate = date
        }
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker
    }

    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        if self.startDate == true{
            print(formatter.string(from: datePicker.date))
            self.formValues["Start Date"] = formatter.string(from: datePicker.date)
            print(self.formValues["Start Date"])
            self.atteorneysTable.reloadRows(at: [self.startDateIndexpath!], with: .automatic)
        }
        else{
            print(formatter.string(from: datePicker.date))
            self.formValues["Expire Date"] = formatter.string(from: datePicker.date)
            print(self.formValues["Expire Date"])
            self.atteorneysTable.reloadRows(at: [self.expireDateIndexpath!], with: .automatic)
        }
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func openVideoGalleryBttn(_ sender: Any) {
        self.openVideoGallery()
    }
    
    func openVideoGallery() {
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        if self.buttonName == "Self Help Videos"{
            picker.mediaTypes = ["public.movie"]
        }
        else{
            picker.mediaTypes = ["public.image"]
        }
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if self.buttonName == "Self Help Videos"{
            if let url = info[.mediaURL] as? URL {
                print(url)
                self.VideoUrl = url
            }
        }
        else{
            if self.buttonName != "My Connections"{
                self.uploadVideoIcon.isHidden = true
                self.uploadVideoLbl.isHidden = true
                self.uploadVideoBGImageView.image = info[.originalImage] as? UIImage
                self.drivingLicenseImg = info[.originalImage] as? UIImage
            }
            else{
                self.drivingLicenseImg = info[.originalImage] as? UIImage
                self.atteorneysTable.reloadData()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func uploadSelfHelpVideo() {
        var data:Data?
            var url:String = Defines.ServerUrl + Defines.selfHelpVideo
            do {
                data = try Data(contentsOf: self.VideoUrl!, options: .mappedIfSafe)
//                    print(data)
                } catch  {
                    self.view.makeToast("Error in selecting Video", duration: 3.0, position: .top)
                    return
                }

            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            let parameter:[String:String] = [
                "user_id":UserData._id,
                "title": self.videoTitleTF.text! ?? ""
            ]
            let timestamp = NSDate().timeIntervalSince1970
        
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data!, withName: "file" ,fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
    //            multipartFormData.append(imgData, withName: name ,fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in parameter {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to: url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        let activityData = ActivityData()
                        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        print(response.result.value!)
                        let json = JSON(response.result.value!)
                        print(json)
                        if json["status"].stringValue == "200" {
                            self.VideoUrl = nil
                            self.videoTitleTF.text = nil
                            self.view.makeToast("Video uploaded successfully", duration: 3.0, position: .top)
                            self.getVideosList()
                        }else {
                            self.view.makeToast("Video upload failed", duration: 3.0, position: .top)
                        }
                    }
                    
                case .failure(let encodingError):
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    print(encodingError)
                }
            }
        }
    
    func uploadConnections() {
        if  !Reachability.isConnectedToNetwork() {
            self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
        
                if self.formValues["Name"]!.count == 0 {
                    self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter name!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Mobile Number"]!.count == 0 {
                    self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter mobile number!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Mobile Number"]!.count <= 5 || self.formValues["Mobile Number"]!.count >= 11{
                    self.VehicalregistrationAddMoreView.isHidden = true
                   Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "moblie number is invalid!")
                      // self.usernameText.becomeFirstResponder()
                       return
               }

                if self.formValues["Email"]!.count == 0 {
                    self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "email!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
            let validEmail = self.formValues["Email"]!.isValidEmail()
            if validEmail == false{
                self.VehicalregistrationAddMoreView.isHidden = true
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "email is invalid!")
                return
            }
                if self.formValues["Location"]!.count == 0 {
                    self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter current location!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.drivingLicenseImg == nil {
                    self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please select an image!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                
//                if self.drivingLicenseImg == nil {
//                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please select an image!")
//                       // self.usernameText.becomeFirstResponder()
//                        return
//                }
//
        
            var data:Data?
                let url:String = Defines.ServerUrl + Defines.uploadConnection
                
                data = self.drivingLicenseImg?.pngData()
    //                    print(data)
                    

                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                var status = ""
                if self.radioButtonPermission == false{
                    status = "1"
                }
                else{
                    status = "0"
                }
        
                let parameter:[String:String] = [
                    "user_id":UserData._id,
                    "name":self.formValues["Name"]!,
                    "phone_number":self.formValues["Mobile Number"]!,
                    "location":self.formValues["Location"]!,
                    "email":self.formValues["Email"]!,
                    "status":status,
                ]
                let timestamp = NSDate().timeIntervalSince1970
            
                Alamofire.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(data!, withName: "file" ,fileName: "\(timestamp).png", mimeType: "\(timestamp)/png")
        //            multipartFormData.append(imgData, withName: name ,fileName: "file.jpg", mimeType: "image/jpg")
                    for (key, value) in parameter {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }, to: url)
                { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            let activityData = ActivityData()
                            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                            print("Upload Progress: \(progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            print(response)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            print(response.result.value!)
                            let json = JSON(response.result.value!)
                            print(json)
                            if json["status"].stringValue == "200" {
                                self.drivingLicenseImg = nil
                                self.radioButtonPermission = false
                                self.addMoreButton.isHidden = false
                                self.Savebtn.isHidden = true
                                self.formValues.removeAll()
                                self.formValues = self.formValues1
                                self.view.makeToast("Connection added successfully", duration: 3.0, position: .top)
                                self.myConnections.removeAll()
                                self.getConnectionList()
                            }else {
                                self.view.makeToast("Video upload failed", duration: 3.0, position: .top)
                            }
                        }
                    case .failure(let encodingError):
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        print(encodingError)
                    }
                }
            }
    
    
    
    func uploadDrivingLicense() {
            var data:Data?
            self.view.endEditing(true)
                var url:String = Defines.ServerUrl + Defines.uploadDL
                    
                data =  self.drivingLicenseImg!.pngData()

                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                let parameter:[String:String] = [
                    "user_id":UserData._id
                ]
                let timestamp = NSDate().timeIntervalSince1970
            
                Alamofire.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(data!, withName: "files" ,fileName: "\(timestamp).png", mimeType: "\(timestamp)/png")
        //            multipartFormData.append(imgData, withName: name ,fileName: "file.jpg", mimeType: "image/jpg")
                    for (key, value) in parameter {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }, to: url)
                { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            let activityData = ActivityData()
                            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                            print("Upload Progress: \(progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            print(response)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            print(response.result.value!)
                            let json = JSON(response.result.value!)
                            print(json)
                            if json["status"].stringValue == "200" {
                                self.drivingLicenseImg = nil
                                self.videoTitleTF.text = nil
                                self.uploadVideoIcon.isHidden = false
                                self.uploadVideoLbl.isHidden = false
                                self.uploadVideoBGImageView.image = UIImage(named: "myaacounbckgroundt2img")
                                self.view.makeToast("Driving License uploaded successfully", duration: 3.0, position: .top)
                                self.getDrivingLicenseList()
                            }else {
                                self.view.makeToast("Task failed", duration: 3.0, position: .top)
                            }
                        }
                        
                    case .failure(let encodingError):
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        print(encodingError)
                    }
                }
                
                
                
            }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getRegisteredVehicles(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "user_id":UserData._id
            ]
            print("\nThe parameters for Dashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getVehicleList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    
                                    if let data = json["data"].array{
                                        self.registeredVehicles = data
//                                        self.addVideosButton.isHidden = false
                                        self.addMoreButton.isHidden = false
                                        self.atteorneysTable.isHidden = false
                                        self.atteorneysTable.reloadData()
                                    }
                                }else {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                    self.atteorneysTable.isHidden = false
                                    self.registeredVehicles.removeAll()
                                    self.atteorneysTable.reloadData()
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    func getTrackerLists(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "user_id":UserData._id
            ]
            print("\nThe parameters for Dashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getTrackerList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    
                                    if let data = json["data"].array{
                                        self.trackerList = data
                                        self.addVideosButton.isHidden = true
                                        self.atteorneysTable.isHidden = false
                                        self.atteorneysTable.reloadData()
                                    }
                                }else {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                    self.atteorneysTable.isHidden = false
                                    self.registeredVehicles.removeAll()
                                    self.atteorneysTable.reloadData()
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    func getVideosList(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "user_id":UserData._id
            ]
            print("\nThe parameters for Dashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getVideoList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    if let data = json["data"].array{
                                        self.videosList = data
                                        self.videosCOllection.delegate = self
                                        self.videosCOllection.dataSource = self
                                        self.uploadVideoNoVideoView1.isHidden = true
                                        self.uploadVideoView2.isHidden = true
                                        self.atteorneysTable.isHidden = true
                                        self.videosCOllection.isHidden = false
                                        self.addVideosButton.isHidden = false
                                        self.videosCOllection.reloadData()
                                    }
                                }else {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                    self.uploadVideoNoVideoView1.isHidden = false
                                    self.uploadVideoBtn.isHidden = false
                                    self.atteorneysTable.isHidden = true
                                    self.addVideosButton.isHidden = true
                                    self.videosCOllection.isHidden = true
                                    self.videosList.removeAll()
                                    self.videosCOllection.reloadData()
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    func getDrivingLicenseList(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "user_id":UserData._id
            ]
            print("\nThe parameters for Dashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getDrivingLicenceList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    if let data = json["data"].array{
                                        self.drivingLicenseImage = data
//                                        self.atteorneysTable.delegate = self
//                                        self.atteorneysTable.dataSource = self
                                        self.uploadVideoNoVideoView1.isHidden = true
                                        self.uploadVideoView2.isHidden = true
                                        self.uploadDrivingLicenseBtn.isHidden = true
                                        self.atteorneysTable.isHidden = false
                                        self.videouploadBtn.isHidden = true
                                        self.videosCOllection.isHidden = true
                                        self.addVideosButton.isHidden = true
                                        self.atteorneysTable.reloadData()
                                    }
                                }else {
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                    self.uploadVideoNoVideoView1.isHidden = true
                                    self.uploadVideoBtn.isHidden = true
                                    self.videoTitleTF.placeholder = "Image Name"
                                    self.uploadVideoView2.isHidden = false
                                    self.uploadDrivingLicenseBtn.isHidden = false
                                    self.atteorneysTable.isHidden = true
                                    self.videouploadBtn.isHidden = true
                                    self.addVideosButton.isHidden = true
                                    self.videosCOllection.isHidden = true
                                    self.drivingLicenseImage.removeAll()
                                    self.atteorneysTable.reloadData()
                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    
    
    func updateRegisteredVehicles(){

                    if  !Reachability.isConnectedToNetwork() {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                            return
                    }
            
                    if self.formValues["Vehicle Name"]!.count == 0 {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter Vehicle name!")
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
                    if self.formValues["Model Number"]!.count == 0 {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter model number!")
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
                    if self.formValues["Vehicle Number"]!.count == 0 {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter vehicle number!")
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
                    if self.formValues["Model Year"]!.count == 0 {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter model year!")
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
                    if self.formValues["Registration Number"]!.count == 0 {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter registration number!")
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
                    if self.formValues["License Plate Number"]!.count == 0 {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter license plate number!")
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
                    let parameter:[String:String] = [
                        "user_id": UserData._id,
                        "vehicle_name":self.formValues["Vehicle Name"]!,
                        "model_number":self.formValues["Model Number"]!,
                        "vehicle_number":self.formValues["Vehicle Number"]!,
                        "year":self.formValues["Model Year"]!,
                        "registration_number":self.formValues["Registration Number"]!,
                        "vin_number":self.formValues["VIN Number"]!,
                        "plate_number":self.formValues["License Plate Number"]!
                    ]
                    print("\nThe parameters for login : \(parameter)\n")
                    let activityData = ActivityData()
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.UploadVehicleRegistration, dataDict: parameter, { (json) in
                        print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            self.formValues.removeAll()
                            self.formValues = self.formValues1
//                            json["msg"].stringValue
                            self.view.makeToast("successfully uploaded vehicle registration!", duration: 3.0, position: .top)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                self.atteorneysTable.isHidden = true
                                self.getRegisteredVehicles()
                            })
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
    
    
    func getAttorneyList(){
                if  !Reachability.isConnectedToNetwork() {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
                    let parameter:[String:String] = [
                    "zipcode": UserData.ZipCode
    //                "user_id":"2"
                ]
                
                print("\nThe parameters for Dashboard : \(parameter)\n")
                self.atorneyList.removeAll()
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.GetAttorneyList, dataDict: parameter, { (json) in
        //                            print(json)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    if json["status"].stringValue == "200" {
                                        
                                        if let data = json["data"].array{
                                            self.atorneyList = data
                                            self.atteorneysTable.isHidden = false
                                            self.atteorneysTable.reloadData()
                                        }
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                        DispatchQueue.main.async {
                                            self.atteorneysTable.reloadData()
                                        }
                                    }else {
                                        self.atorneyList.removeAll()
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                            return
                                        })
                                    }
                                }) { (error) in
                                    print(error)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                }
            }
            func getConnectionList(){
                if  !Reachability.isConnectedToNetwork() {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
                    let parameter:[String:String] = [
                        "user_id": UserData._id
    //                "user_id":"2"
                ]
                
                print("\nThe parameters for Dashboard : \(parameter)\n")
                self.atorneyList.removeAll()
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getmyConnectionList, dataDict: parameter, { (json) in
        //                            print(json)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    if json["status"].stringValue == "200" {
                                        
                                        if let data = json["data"].array{
                                            self.myConnections = data
                                            self.atteorneysTable.isHidden = false
                                            self.atteorneysTable.reloadData()
                                        }
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                        DispatchQueue.main.async {
                                            self.atteorneysTable.reloadData()
                                        }
                                    }else {
                                        self.myConnections.removeAll()
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                            return
                                        })
                                    }
                                }) { (error) in
                                    print(error)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                }
            }
        func getBailBondList(){
                    if  !Reachability.isConnectedToNetwork() {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                            return
                    }
                    
                    let parameter:[String:String] = [
                        "zipcode": UserData.ZipCode
        //                "user_id":"2"
                    ]
                    
                    print("\nThe parameters for Dashboard : \(parameter)\n")
                    self.bailBondList.removeAll()
                    let activityData = ActivityData()
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                    
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.GetBailBondList, dataDict: parameter, { (json) in
            //                            print(json)
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                        if json["status"].stringValue == "200" {
                                            
                                            if let data = json["data"].array{
                                                self.atorneyList = data
                                                self.atteorneysTable.isHidden = false
                                                self.atteorneysTable.reloadData()
                                            }
                                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                            DispatchQueue.main.async {
                                                self.atteorneysTable.reloadData()
                                            }
                                        }else {
                                            self.atorneyList.removeAll()
                                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                                return
                                            })
                                        }
                                        
                                    }) { (error) in
                                        print(error)
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    }
                }
    
    
    
    func getinsuredVehicles(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            let parameter:[String:String] = [
                "user_id":UserData._id
            ]
            print("\nThe parameters for Dashboard : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getInsuredVehicles, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            if json["status"].stringValue == "200" {
                                    
                if let data = json["data"].array{
                    self.insuredVehicles = data
                    self.addMoreButton.isHidden = false
                    self.atteorneysTable.isHidden = false
                    self.atteorneysTable.reloadData()
                }
            }else {
                self.insuredVehicles.removeAll()
                self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                self.atteorneysTable.isHidden = false
                self.atteorneysTable.reloadData()
            }
        }) { (error) in
            print(error)
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    func updateVehicleInsurance(){

                if  !Reachability.isConnectedToNetwork() {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
                if self.formValues["Insurance Name"]!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter insurance name!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Start Date"]!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter start date!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Expire Date"]!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter expire date!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Policy Number"]!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter policy number!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Liability Coverage "]!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter liability coverage amount!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                if self.formValues["Comp and Collission Coverage"]!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter Comp and Collission Coverage amount!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                let parameter:[String:String] = [
                    "user_id": UserData._id,
                    "insurance_name":self.formValues["Insurance Name"]!,
                    "start_date":self.formValues["Start Date"]!,
                    "expire_date":self.formValues["Expire Date"]!,
                    "policy_number":self.formValues["Policy Number"]!,
                    "liability_coverage_amount":self.formValues["Liability Coverage "]!,
                    "comp_coverage_amount":self.formValues["Comp and Collission Coverage"]!
                ]
                print("\nThe parameters for login : \(parameter)\n")
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.UploadVehicleInsurance, dataDict: parameter, { (json) in
                    print(json)
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    if json["status"].stringValue == "200" {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                        self.formValues.removeAll()
                        self.formValues = self.formValues1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            self.atteorneysTable.isHidden = true
                            self.getinsuredVehicles()
                        })
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
    
    @IBAction func addMoreButton(_ sender: Any) {
        if buttonName == "Vehicle Registration"{
        self.VehicalregistrationAddMoreView.isHidden = true
        self.registeredVehicles.removeAll()
        print(self.registeredVehicles.count)
        self.atteorneysTable.reloadData()
        self.addMoreButton.isHidden = true
        }
        else if buttonName == "Vehicle Insurance"
        {
            self.VehicalregistrationAddMoreView.isHidden = true
            self.insuredVehicles.removeAll()
            print(self.insuredVehicles.count)
            self.atteorneysTable.reloadData()
            self.addMoreButton.isHidden = true
        }
        else if buttonName == "My Connections"
        {
            self.VehicalregistrationAddMoreView.isHidden = true
            self.myConnections.removeAll()
            print(self.myConnections.count)
            self.atteorneysTable.reloadData()
            self.addMoreButton.isHidden = true
        }
    }
    
    @IBAction func onPressedSosBtn(_ sender: Any)
    {
        
    }
     
    @IBAction func addVideosBttnTapped(_ sender: Any) {
        self.uploadVideoNoVideoView1.isHidden = true
        self.uploadVideoView2.isHidden = false
        self.videouploadBtn.isHidden = false
        self.uploadVideoBtn.isHidden = false
        self.atteorneysTable.isHidden = true
        self.addVideosButton.isHidden = true
        self.videosCOllection.isHidden = true
        self.videosList.removeAll()
        self.videosCOllection.reloadData()
    }
    
    @IBAction func onpressedUploadDrivingLicesenseBtn(_ sender: Any)
    {
        if self.drivingLicenseImg != nil{
            self.uploadDrivingLicense()
            self.uploadVideoBtn.isHidden = true
            self.DrivinglicenseUploadView.isHidden = true
            self.uploadVideoView2.isHidden = true
            self.videouploadBtn.isHidden = true
            SosBtn.isHidden = false
            Savebtn.isHidden = true
        }
        else{
            self.view.makeToast("Select image first", duration: 3.0, position: .top)
        }
        
    }
    
    @IBAction func onpressedVideoUploadBtn(_ sender: Any)
    {
        if self.VideoUrl != nil {
            if self.videoTitleTF.text != ""{
                self.uploadSelfHelpVideo()
            }
            else{
                self.view.makeToast("Please add a title.", duration: 3.0, position: .top)
            }
            
        }
        else{
            self.view.makeToast("Select video first", duration: 3.0, position: .top)
        }
    } 
    
    
    @IBAction func onpresssedSearchBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func onPressedUploadVideobtn2(_ sender: Any)
    {
        videoUploadCollectionView.isHidden = false
    }
    
    
    @IBAction func onPressedUploadVideoBtn(_ sender: Any)
    {
        videoUploadCollectionView.isHidden = true
        self.uploadVideoNoVideoView1.isHidden = true
        self.uploadVideoView2.isHidden = false
        
        if self.VideoUrl != nil{
            if self.videoTitleTF.text != ""{
                self.uploadSelfHelpVideo()
            }
            else{
                self.view.makeToast("Please add a title.", duration: 3.0, position: .top)
            }
        }
        else{
            self.view.makeToast("Select video first", duration: 3.0, position: .top)
        }
    }
    
    @IBAction func onpressedSaveBtn(_ sender: Any)
    {
        self.VehicalregistrationAddMoreView.isHidden = false
//        self.atteorneysTable.isHidden = true
        self.SosBtn.isHidden = true
        if buttonName == "Vehicle Registration"{
            self.addMoreButton.isHidden = false
            self.Savebtn.isHidden = true
            updateRegisteredVehicles()
        }
        else if buttonName == "Vehicle Insurance"{
            self.addMoreButton.isHidden = false
            self.Savebtn.isHidden = true
            updateVehicleInsurance()
        }
        else if buttonName == "My Connections"{
            uploadConnections()
        }
    }
    
    @IBAction func onPressedBackarrowBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func reginib()
    {
        let nib = UINib(nibName: "Tabcollectioncell", bundle: nil)
        buttonCollection.register(nib, forCellWithReuseIdentifier: "Tabcollectioncell")

        let nib2 = UINib(nibName: "CommuntyReprsentativeTablecell", bundle: nil)
        atteorneysTable.register(nib2, forCellReuseIdentifier: "CommuntyReprsentativeTablecell")
         let nib3 = UINib(nibName: "VehicalRegistrationCell", bundle: nil)
         atteorneysTable.register(nib3, forCellReuseIdentifier: "VehicalRegistrationCell")
        let nib4 = UINib(nibName: "VehicalInsuranceCell", bundle: nil)
        atteorneysTable.register(nib4, forCellReuseIdentifier: "VehicalInsuranceCell")
        
        let nib5 = UINib(nibName: "RegisteredVehicleCell", bundle: nil)
        atteorneysTable.register(nib5, forCellReuseIdentifier: "RegisteredVehicleCell")
        
        let nib6 = UINib(nibName: "drivingLicenceCell", bundle: nil)
        atteorneysTable.register(nib6, forCellReuseIdentifier: "drivingLicenceCell")
        
        let nib7 = UINib(nibName: "profileImgCell", bundle: nil)
        atteorneysTable.register(nib7, forCellReuseIdentifier: "profileImgCell")
        
        let nib8 = UINib(nibName: "RadioButtonCell", bundle: nil)
        atteorneysTable.register(nib8, forCellReuseIdentifier: "RadioButtonCell")
        
        let nib9 = UINib(nibName: "TrackersCell", bundle: nil)
        atteorneysTable.register(nib9, forCellReuseIdentifier: "TrackersCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if  collectionView == self.buttonCollection
            {
                if self.userDirectory == true{
                    return self.DirectoryButtonArray.count
                }
                else{
                    return buttonNAmeArray.count
                }
            
            }
            else if  collectionView == self.videosCOllection{
                return self.videosList.count
            }
            return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
       {
        if collectionView == self.buttonCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
            cell.delegate = self
            cell.shopLiftingBtn.layer.cornerRadius = 5
            if self.userDirectory == true{
                self.nameTitle = self.DirectoryButtonArray[indexPath.row]
            }
            else{
                self.nameTitle = buttonNAmeArray[indexPath.row]
            }
            cell.shopLiftingBtn.setTitle(self.nameTitle, for: .normal)
            if indexpath != nil && indexPath == indexpath {
                cell.shopLiftingBtn.backgroundColor = UIColor.blue
            }else{
                cell.shopLiftingBtn.backgroundColor = UIColor.gray
            }
             return cell
       }
        else if collectionView == self.videosCOllection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selfHelpVideosCell", for: indexPath) as! selfHelpVideosCell
             let data = self.videosList[indexPath.row].dictionaryValue
             cell.videotitleLbl.text = data["title"]?.stringValue
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) 
                return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.videosCOllection{
            let data = self.videosList[indexPath.row].dictionaryValue
            let videoUrl = data["url"]?.stringValue
            print(videoUrl!)
            let videoURL = URL(string: videoUrl!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        let numberOfItemsPerRow: CGFloat = 2.0; print("")

        let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        
        
            if collectionView == buttonCollection{
//                return CGSize(width: itemWidthtop/2, height: 30)
                let layout = collectionViewLayout as! UICollectionViewFlowLayout
                layout.minimumLineSpacing = 5.0
                layout.minimumInteritemSpacing = 2.5
                let numberOfItemsPerRow: CGFloat = 2; print("")
                let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
//
                return CGSize(width: itemWidthtop/1.5, height: 30)
            }
           if collectionView == videosCOllection
           {
            return CGSize(width: itemWidthdown, height: 280)
           }
           else{
                return CGSize(width: itemWidthdown, height: itemWidthdown)
            }
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            if collectionView == videosCOllection
//            {
//                return  2.5
//            }
//            else{
//                return 2.5
//            }
//       }
//       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            if collectionView == videosCOllection
//            {
//                return 5
//            }else{
//                return 5
//            }
//       }
    
    
    
     func onpressedShopliftingBtn(cell:Tabcollectioncell){
            if cell.shopLiftingBtn.backgroundColor == UIColor.gray
            {
                if cell.shopLiftingBtn.titleLabel?.text == "Vehicle Registration"
                {
                    self.getRegisteredVehicles()
                    self.trackerButtonView.isHidden = true
                    buttonName = cell.shopLiftingBtn.titleLabel!.text!
                     Savebtn.isHidden = false
                    self.addVideosButton.isHidden = true
                    self.videosCOllection.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.DrivinglicenseUploadView.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.uploadVideoNoVideoView1.isHidden = true
                    self.uploadVideoView2.isHidden = true
                    self.addMoreButton.setTitle("Add More", for: .normal)
                    
                    videoUploadCollectionView.isHidden = true
                    SosBtn.isHidden = true
                }
                else if cell.shopLiftingBtn.titleLabel?.text == "My Connections"{
                    self.getConnectionList()
                    self.trackerButtonView.isHidden = true
                    self.drivingLicenseImg = UIImage(named: "bitmap-2")
                    buttonName = cell.shopLiftingBtn.titleLabel!.text!
                    self.atteorneysTable.isHidden = false
                    self.addVideosButton.isHidden = true
                    self.videosCOllection.isHidden = true
                    self.atteorneysTable.reloadData()
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.selfVideoCollecionView.isHidden = true
                    self.DrivinglicenseUploadView.isHidden = true
                    selfVideoCollecionView.isHidden = true
                    self.uploadVideoView2.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.DrivinglicenseUploadView.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.uploadVideoNoVideoView1.isHidden = true
                    Savebtn.isHidden = true
                    SosBtn.isHidden = true
                    self.addMoreButton.isHidden = false
                    self.addMoreButton.setTitle("Add New", for: .normal)
                }
                    else if cell.shopLiftingBtn.titleLabel?.text == "Tracker"{
                        self.getTrackerLists()
                    self.trackerButtonView.isHidden = false
                    self.trackerList.removeAll()
                    self.buttonName = cell.shopLiftingBtn.titleLabel!.text!
                    self.atteorneysTable.isHidden = false
                    self.addVideosButton.isHidden = true
                    self.videosCOllection.isHidden = true
                    self.atteorneysTable.reloadData()
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.selfVideoCollecionView.isHidden = true
                    self.DrivinglicenseUploadView.isHidden = true
                    selfVideoCollecionView.isHidden = true
                    self.uploadVideoView2.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.DrivinglicenseUploadView.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.uploadVideoNoVideoView1.isHidden = true
                    Savebtn.isHidden = true
                    SosBtn.isHidden = true
            }
            else if cell.shopLiftingBtn.titleLabel?.text == "Attorneys"
            {
                self.getAttorneyList()
                self.trackerButtonView.isHidden = true
                buttonName = cell.shopLiftingBtn.titleLabel!.text!
                self.atteorneysTable.isHidden = false
                self.addVideosButton.isHidden = true
                self.videosCOllection.isHidden = true
                self.atteorneysTable.reloadData()
                self.VehicalregistrationAddMoreView.isHidden = true
                self.selfVideoCollecionView.isHidden = true
                self.DrivinglicenseUploadView.isHidden = true
                selfVideoCollecionView.isHidden = true
                self.uploadVideoView2.isHidden = true
                self.VehicalregistrationAddMoreView.isHidden = true
                self.DrivinglicenseUploadView.isHidden = true
                self.VehicalregistrationAddMoreView.isHidden = true
                self.uploadVideoNoVideoView1.isHidden = true
                Savebtn.isHidden = true
                                
            }
            else if cell.shopLiftingBtn.titleLabel?.text == "Bail Bonds"
                    {
                        self.getBailBondList()
                        self.trackerButtonView.isHidden = true
                        buttonName = cell.shopLiftingBtn.titleLabel!.text!
                        self.videosCOllection.isHidden = true
                        self.atteorneysTable.isHidden = false
                        self.addVideosButton.isHidden = true
                        self.atteorneysTable.reloadData()
                        self.VehicalregistrationAddMoreView.isHidden = true
                        self.selfVideoCollecionView.isHidden = true
                        self.DrivinglicenseUploadView.isHidden = true
                        selfVideoCollecionView.isHidden = true
                        self.uploadVideoView2.isHidden = true
                        self.VehicalregistrationAddMoreView.isHidden = true
                        self.DrivinglicenseUploadView.isHidden = true
                        self.VehicalregistrationAddMoreView.isHidden = true
                        self.uploadVideoNoVideoView1.isHidden = true
                        Savebtn.isHidden = true
                }
                else if cell.shopLiftingBtn.titleLabel?.text == "Self Help Videos"
                {
                    self.getVideosList()
                    self.trackerButtonView.isHidden = true
                    buttonName = cell.shopLiftingBtn.titleLabel!.text!
                    self.atteorneysTable.isHidden = true
                    self.uploadVideoLbl.text = "Browse and Upload Self Help Video"
                    self.videoTitleTF.placeholder = "Video Title"
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.uploadDrivingLicenseBtn.isHidden = true
                    self.uploadVideoNoVideoView1.isHidden = true
                    self.uploadVideoBtn.isHidden = true
                    self.SosBtn.isHidden = true
                    
                }
                else if cell.shopLiftingBtn.titleLabel?.text == "Vehicle Insurance"
                {
                    self.videosCOllection.isHidden = true
                    self.trackerButtonView.isHidden = true
                    self.buttonName = cell.shopLiftingBtn.titleLabel!.text!
                    self.atteorneysTable.isHidden = false
                    self.uploadVideoView2.isHidden = true
                    self.uploadDrivingLicenseBtn.isHidden = true
                    self.addVideosButton.isHidden = true
                    self.Savebtn.isHidden = false
                    self.atteorneysTable.reloadData()
                    self.VehicalregistrationAddMoreView.isHidden = true
                    self.SosBtn.isHidden = true
                    self.DrivinglicenseUploadView.isHidden = true
                    self.addMoreButton.setTitle("Add More", for: .normal)
                    SosBtn.isHidden = true
                    self.getinsuredVehicles()
                }
                else if cell.shopLiftingBtn.titleLabel?.text == "Driver License"
                {
                    self.videosCOllection.isHidden = true
                    self.trackerButtonView.isHidden = true
                    self.uploadVideoLbl.text = "Browse and Upload Your Driving License"
                    self.videoTitleTF.placeholder = "Image Name"
                    self.drivingLicenseImg = nil
                    self.videoTitleTF.text = nil
                    self.uploadVideoIcon.isHidden = false
                    self.uploadVideoLbl.isHidden = false
                    self.uploadVideoBGImageView.image = UIImage(named: "myaacounbckgroundt2img")
                    buttonName = cell.shopLiftingBtn.titleLabel!.text!
                    self.addVideosButton.isHidden = true
//                    self.uploadVideoView2.isHidden = false
                    self.uploadVideoView2.isHidden = true
                    self.uploadVideoBtn.isHidden =  true
                    self.DrivinglicenseUploadView.isHidden = true
                    self.uploadVideoBtn.isHidden = true
                    self.uploadDrivingLicenseBtn.isHidden = true
                    selfVideoCollecionView.isHidden = true
                    VehicalregistrationAddMoreView.isHidden = true
                    self.atteorneysTable.isHidden = true
                    self.addMoreButton.setTitle("Add More", for: .normal)
                    SosBtn.isHidden = true
                    self.getDrivingLicenseList()
                }
            }
            else
            {
                self.videosCOllection.isHidden = true
                SosBtn.isHidden = true
                self.trackerButtonView.isHidden = true
                selfVideoCollecionView.isHidden = true
                self.addVideosButton.isHidden = true
                VehicalregistrationAddMoreView.isHidden = true
                self.DrivinglicenseUploadView.isHidden = true
                self.atteorneysTable.isHidden = true
                Savebtn.isHidden = true
                self.uploadVideoNoVideoView1.isHidden = true
                self.addMoreButton.setTitle("Add More", for: .normal)
                self.uploadVideoView2.isHidden = true
                VehicalregistrationAddMoreView.isHidden = true
            }
            if cell.shopLiftingBtn.backgroundColor == .gray{
                self.indexpath = self.buttonCollection.indexPath(for: cell)
                self.buttonCollection.reloadData()
            }
            else{
                self.indexpath = nil
                self.buttonCollection.reloadData()
            }
    }
    
    // working with tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
              if buttonName == "Attorneys"
              {
                return atorneyList.count
              }
              else if buttonName == "Bail Bonds"
              {
                  return atorneyList.count
              }
              else if buttonName == "My Connections"
              {
                  if self.myConnections.count == 0{
                      self.Savebtn.isHidden = false
                      return connectionListArray.count
                  }
                  else{
                      self.Savebtn.isHidden = true
                      self.VehicalregistrationAddMoreView.isHidden = false
                      return myConnections.count
                  }
              }
              else if buttonName == "Tracker"
              {
                  return trackerList.count
              }
              else if buttonName == "Vehicle Registration"
              {
                if self.registeredVehicles.count == 0{
                    self.Savebtn.isHidden = false
                    return vehicleREgistrationArray.count
                }
                else{
                    self.Savebtn.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = false
                    return registeredVehicles.count
                }
             }
             else if buttonName == "Vehicle Insurance"
             {
                if self.insuredVehicles.count == 0{
                    self.Savebtn.isHidden = false
                    return vehicleInsuranceArray.count
                }
                else{
                    self.Savebtn.isHidden = true
                    self.VehicalregistrationAddMoreView.isHidden = false
                    return insuredVehicles.count
                }
            }
            else if buttonName == "Driver License"{
                self.Savebtn.isHidden = true
                return drivingLicenseImage.count
            }
            return vehicleREgistrationArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {

           if buttonName == "Attorneys"
           {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommuntyReprsentativeTablecell", for: indexPath) as! CommuntyReprsentativeTablecell
            
            let data = self.atorneyList[indexPath.row].dictionaryValue
            cell.policeNameLbl.text = data["name"]?.stringValue
            cell.phoneNumberLbl.text = data["phone_number"]?.stringValue
            cell.delegate = self
           return cell
            }
            else if buttonName == "Bail Bonds"
               {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommuntyReprsentativeTablecell", for: indexPath) as! CommuntyReprsentativeTablecell
                
                let data = self.atorneyList[indexPath.row].dictionaryValue
                cell.policeNameLbl.text = data["name"]?.stringValue
                cell.phoneNumberLbl.text = data["phone_number"]?.stringValue
                cell.delegate = self
               return cell
                }
            
            else if buttonName == "My Connections"
               {
                
                    if myConnections.count == 0{
//                        let cell = UITableViewCell()
//                        return cell
                        
                        self.Savebtn.isHidden = false
                        
                        
                        if indexPath.row == 0 {
                            let cell2 = tableView.dequeueReusableCell(withIdentifier: "profileImgCell", for: indexPath) as! profileImgCell
                            if self.drivingLicenseImg != nil{
                                cell2.profileImg.image = self.drivingLicenseImg
                            }
                            cell2.delegate = self
                            return cell2
                        }
                        else if indexPath.row == 5{
                            let cell3 = tableView.dequeueReusableCell(withIdentifier: "RadioButtonCell", for: indexPath) as! RadioButtonCell
                            cell3.delegate = self
                            return cell3
                        }
                        else{
                            let cell1 = tableView.dequeueReusableCell(withIdentifier: "VehicalInsuranceCell", for: indexPath) as! VehicalInsuranceCell

                                                   
                                                   
                                                   cell1.insuranceTextfd.tweePlaceholder =  self.connectionListArray[indexPath.row]
                                                   cell1.insuranceTextfd.placeholderColor =  .clear
                                                   cell1.insuranceTextfd.placeholder = connectionListArray[indexPath.row]
                                                   print(vehicleInsuranceArray[indexPath.row])
                                                   print(self.formValues[self.connectionListArray[indexPath.row]])
                                                   cell1.insuranceTextfd.text = self.formValues[self.connectionListArray[indexPath.row]]
                                                   cell1.insuranceTextfd.delegate = self
                            return cell1
                        }
                    }
                    else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CommuntyReprsentativeTablecell", for: indexPath) as! CommuntyReprsentativeTablecell
                        
                        let data = self.myConnections[indexPath.row].dictionaryValue
                        cell.policeNameLbl.text = data["name"]?.stringValue
                        cell.phoneNumberLbl.text = data["phone_number"]?.stringValue
                        
                        if data["profile_pic"]?.stringValue != ""{
                            let imgURL = URL(string: data["profile_pic"]!.stringValue)!
                            cell.userImgView.kf.setImage(with: imgURL)
                        }
                        cell.callCenterConstraint.constant = -10
                        cell.locationImg.isHidden = false
                        cell.locationbttn.isHidden = false
                        cell.deleteBtn.isHidden = false
                        cell.deleteImg.isHidden = false
                        cell.delegate = self
                       return cell
                    }
                }
           else if buttonName == "Vehicle Insurance"
            {
                if self.insuredVehicles.count != 0{
                    self.VehicalregistrationAddMoreView.isHidden = false
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "RegisteredVehicleCell", for: indexPath) as! RegisteredVehicleCell
                                    print(self.insuredVehicles)
                print(indexPath.row)
                let data = self.insuredVehicles[indexPath.row].dictionaryValue
                                print(data)
                    
                    cell1.vehicleName.isHidden = true
                    
                    cell1.modelLbl.text = self.vehicleInsuranceArray[0]
                    cell1.vehicleNumberLbl.text = self.vehicleInsuranceArray[1]
                    cell1.ModelYearLbl.text = self.vehicleInsuranceArray[2]
                    cell1.RegNumberLbl.text = self.vehicleInsuranceArray[3]
                    cell1.VINnumberLbl.text = self.vehicleInsuranceArray[4]
                    cell1.LicencePlatLbl.text = self.vehicleInsuranceArray[5]
                    cell1.delegate = self
                    
                cell1.vehicleModel.text = data["insurance_name"]?.stringValue
                cell1.vehicleNumber.text = data["start_date"]?.stringValue
                cell1.vehicleModelYear.text = data["expire_date"]?.stringValue
                cell1.vehicleRegNumber.text = data["policy_number"]?.stringValue
                cell1.vehicleVINNumber.text = data["liability_coverage_amount"]?.stringValue
                cell1.vehiclePlateNumber.text = data["comp_coverage_amount"]?.stringValue
                return cell1
                }
                else{
//                    self.Savebtn.isHidden = false
                    let cell1 = tableView.dequeueReusableCell(withIdentifier: "VehicalInsuranceCell", for: indexPath) as! VehicalInsuranceCell
                    cell1.insuranceTextfd.tweePlaceholder =  vehicleInsuranceArray[indexPath.row]
                    cell1.insuranceTextfd.placeholderColor =  .clear
                    cell1.insuranceTextfd.placeholder = vehicleInsuranceArray[indexPath.row]
                    print(vehicleInsuranceArray[indexPath.row])
                    print(self.formValues[self.vehicleInsuranceArray[indexPath.row]])
                    cell1.insuranceTextfd.text = self.formValues[self.vehicleInsuranceArray[indexPath.row]]
                    if indexPath.row == 1 {
                        self.startDateIndexpath = indexPath
                    }
                    else if indexPath.row == 2{
                        self.expireDateIndexpath = indexPath
                    }
                    cell1.insuranceTextfd.delegate = self
                    return cell1
                }
            }
            
            else if buttonName == "Driver License"
            {
                    if self.drivingLicenseImage.count != 0{
                        self.VehicalregistrationAddMoreView.isHidden = true
                    let cell1 = tableView.dequeueReusableCell(withIdentifier: "drivingLicenceCell", for: indexPath) as! drivingLicenceCell
                    print(self.drivingLicenseImage)
                    print(indexPath.row)
                        let data = self.drivingLicenseImage[indexPath.row].dictionaryValue
                                    print(data)
                        let urlString = data["url"]!.stringValue.replacingOccurrences(of: " ", with: "%20")
                        
                        let imgUrl = URL(string: urlString)!
                        
                        cell1.licenseImageView.kf.setImage(with: imgUrl)
                        cell1.delegate = self
                        
                    return cell1
                    }
                    else{
    //                    self.Savebtn.isHidden = false
                        let cell = UITableViewCell()
                       return cell
                    }
            }
           else if buttonName == "Tracker"{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackersCell", for: indexPath) as! TrackersCell
                
                let data = self.trackerList[indexPath.row].dictionaryValue
                cell.userNameLbl.text = data["name"]?.stringValue
                cell.loactionLbl.text = data["location"]?.stringValue

            cell.dateLbl.text = data["at_date"]?.stringValue
            cell.timeLbl.text = data["at_time"]?.stringValue
            let imgURL = URL(string: data["profile_pic"]?.stringValue ?? "")
            cell.userImgView.kf.setImage(with: imgURL!)
               return cell
           }
           else
           {
            print(self.registeredVehicles.count)
            
            if self.registeredVehicles.count != 0{
                self.VehicalregistrationAddMoreView.isHidden = false
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "RegisteredVehicleCell", for: indexPath) as! RegisteredVehicleCell
                                    print(self.registeredVehicles)
                print(indexPath.row)
                let data = self.registeredVehicles[indexPath.row].dictionaryValue
                                print(data)
                cell1.vehicleName.isHidden = false
                cell1.delegate = self
                
                cell1.modelLbl.text = self.vehicleREgistrationArray[1]
                cell1.vehicleNumberLbl.text = self.vehicleREgistrationArray[2]
                cell1.ModelYearLbl.text = self.vehicleREgistrationArray[3]
                cell1.RegNumberLbl.text = self.vehicleREgistrationArray[4]
                cell1.VINnumberLbl.text = self.vehicleREgistrationArray[5]
                cell1.LicencePlatLbl.text = self.vehicleREgistrationArray[6]
                
                cell1.vehicleName.text = data["vehicle_name"]?.stringValue
                
                cell1.vehicleModel.text = data["model_number"]?.stringValue
                cell1.vehicleNumber.text = data["vehicle_number"]?.stringValue
                cell1.vehicleModelYear.text = data["year"]?.stringValue
                cell1.vehicleRegNumber.text = data["registration_number"]?.stringValue
                cell1.vehicleVINNumber.text = data["vin_number"]?.stringValue
                cell1.vehiclePlateNumber.text = data["plate_number"]?.stringValue
                return cell1
                }
                else{
//                    self.Savebtn.isHidden = false
                    let cell1 = tableView.dequeueReusableCell(withIdentifier: "VehicalRegistrationCell", for: indexPath) as! VehicalRegistrationCell
                    cell1.vehicalRegistrationTextfield.tweePlaceholder = vehicleREgistrationArray[indexPath.row]
                cell1.vehicalRegistrationTextfield.placeholderColor =  .clear
                cell1.vehicalRegistrationTextfield.placeholder = vehicleREgistrationArray[indexPath.row]
                cell1.vehicalRegistrationTextfield.text = self.formValues[self.vehicleREgistrationArray[indexPath.row]]
                    cell1.vehicalRegistrationTextfield.delegate = self
                    return cell1

                }
        }
    }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

         return convertDateFormatter.string(from: oldDate!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if buttonName == "Attorneys"
        {
            return 80
        }
        if buttonName == "Tracker"
        {
            return 80
        }
         else if buttonName == "Bail Bonds"
        {
            return 80
        }
        else if buttonName == "My Connections"
        {
            if self.myConnections.count != 0{
                return 90
            }
            else{
                if indexPath.row == 0{
                    return 117
                }
                else if indexPath.row == 5{
                    return 27
                }
                else{
                    return 80
                }
            }
        }
        else if buttonName == "Vehicle Registration"
        {
            if self.registeredVehicles.count == 0{
                return 80
            }
            else{
                return 210
            }
            
        }
        else if buttonName == "Vehicle Insurance"
        {
            if self.insuredVehicles.count == 0{
                return 80
            }
            else{
                return 210
            }
        }
        else if buttonName == "Driver License"{
            return 200
        }
        else
        {
            return 80
        }
    }
    
    
    func deleteBttnTapped(cell: RegisteredVehicleCell) {
        
        if self.buttonName == "Vehicle Registration"{
            
            let alert = UIAlertController(title: "Remove this vehicle", message: "Are you sure to remove this vehicle from registered vehicle list.", preferredStyle: .alert)

           
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                let indexpath1 = self.atteorneysTable.indexPath(for: cell)
                            let insurance = self.registeredVehicles[indexpath1!.row].stringValue
                //            let insuranceId = ins
                            let parameter:[String:String] = [
                                        "user_id": UserData._id,
                                        "vehicle_id":self.registeredVehicles[indexpath1!.row]["vehicle_id"].stringValue
                                    ]

                                    print("\nThe parameters for delete : \(parameter)\n")
                    self.registeredVehicles.removeAll()
                                    let activityData = ActivityData()
                                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                                    
                                    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.deleteVehicle, dataDict: parameter, { (json) in
                                        print(json)
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                        if json["status"].stringValue == "200" {
                                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                            self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                                self.atteorneysTable.isHidden = true
                                                self.getRegisteredVehicles()
                                            })
                                        }else {
                                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                                return
                                            })
                                        }
                                        
                                    }) { (error) in
                                        print(error)
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    }
            }))

            self.present(alert, animated: true)
            
            
            
            
                    
                    
                }
        else if self.buttonName == "Vehicle Insurance"{
            
            
            let alert = UIAlertController(title: "Remove this vehicle", message: "Are you sure to remove this vehicle from insured vehicle list.", preferredStyle: .alert)

            
             alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
             alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    let indexpath1 = self.atteorneysTable.indexPath(for: cell)
                                let insurance = self.insuredVehicles[indexpath1!.row].stringValue
                    //            let insuranceId = ins
                                let parameter:[String:String] = [
                                            "user_id": UserData._id,
                                            "insurance_id":self.insuredVehicles[indexpath1!.row]["insurance_id"].stringValue
                                        ]

                                        print("\nThe parameters for delete : \(parameter)\n")

                                        let activityData = ActivityData()
                                        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                                        
                                        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.deleteVehicleInsurance, dataDict: parameter, { (json) in
                                            print(json)
                                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                            if json["status"].stringValue == "200" {
                                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                                self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                                    self.atteorneysTable.isHidden = true
                                                    self.getinsuredVehicles()
                                                })
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
                        }))
                    self.present(alert, animated: true)
                }
    }
    
    func deleteBttnTapped(cell: drivingLicenceCell) {
        
        let alert = UIAlertController(title: "Remove Driving License", message: "Are you sure to remove this driving license.", preferredStyle: .alert)

        
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
         alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let indexpath1 = self.atteorneysTable.indexPath(for: cell)
            let insurance = self.drivingLicenseImage[indexpath1!.row].stringValue
            //            let insuranceId = ins
                        let parameter:[String:String] = [
                                    "user_id": UserData._id,
                                    "license_id":self.drivingLicenseImage[indexpath1!.row]["license_id"].stringValue
                                ]

                                print("\nThe parameters for delete : \(parameter)\n")
                                self.drivingLicenseImage.removeAll()
                                let activityData = ActivityData()
                                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                                
                                DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.deleteDrivingList, dataDict: parameter, { (json) in
                                    print(json)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    if json["status"].stringValue == "200" {
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                        self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                            self.atteorneysTable.isHidden = true
                                            self.getDrivingLicenseList()
                                        })
                                    }else {
                                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                            return
                                        })
                                    }
                                    
                                }) { (error) in
                                    print(error)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                }
        }))
        
        self.present(alert, animated: true)
        
        
    }
    
    
    
    func changeImageBttnTapped(cell: profileImgCell) {
        self.openVideoGallery()
    }
    
    func radioButtonTapped(cell: RadioButtonCell) {
        if cell.radioBtn.currentImage == UIImage(named: "radioCheck"){
            cell.radioBtn.setImage(UIImage(named: "radioUncheck"), for: .normal)
            self.radioButtonPermission = false
        }
        else{
            cell.radioBtn.setImage(UIImage(named: "radioCheck"), for: .normal)
            self.radioButtonPermission = true
        }
    }
    
    
    func callbtnTapped(cell: CommuntyReprsentativeTablecell) {
        if self.buttonName != "My Connections"{
            let indexPath = self.atteorneysTable.indexPath(for: cell)
            let number = self.atorneyList[indexPath!.row]["phone_number"].stringValue
            self.dialNumber(number: number)
        }
        else{
            let indexPath = self.atteorneysTable.indexPath(for: cell)
            let number = self.myConnections[indexPath!.row]["phone_number"].stringValue
            self.dialNumber(number: number)
        }
        
    }
    
    func messagebtnTapped(cell: CommuntyReprsentativeTablecell) {
        
        if self.buttonName != "My Connections"{
            let indexPath = self.atteorneysTable.indexPath(for: cell)
            let number = self.atorneyList[indexPath!.row]["phone_number"].stringValue
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "Enter a message details here";
            messageVC.recipients = [number]
            messageVC.messageComposeDelegate = self
            self.present(messageVC, animated: true, completion: nil)
        }
        else{
            
            let indexPath = self.atteorneysTable.indexPath(for: cell)
            let number = self.myConnections[indexPath!.row]["phone_number"].stringValue
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "Enter a message details here";
            messageVC.recipients = [number]
            messageVC.messageComposeDelegate = self
            self.present(messageVC, animated: true, completion: nil)
        }
        
    }
    
    
    func locationBtnTapped(cell: CommuntyReprsentativeTablecell) {
        print("location tapped")
    }
    
    func deletebtnTapped(cell: CommuntyReprsentativeTablecell) {
        
        
        let alert = UIAlertController(title: "Remove this connection", message: "Are you sure to remove this connection.", preferredStyle: .alert)

        
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let indexPath = self.atteorneysTable.indexPath(for: cell)
            print(self.myConnections[indexPath!.row]["connection_id"].stringValue)
            let parameter:[String:String] = [
                                "user_id": UserData._id,
                                "connection_id":self.myConnections[indexPath!.row]["connection_id"].stringValue
                            ]

                            print("\nThe parameters for delete : \(parameter)\n")
                            let activityData = ActivityData()
                            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                            
                            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.deleteConnection, dataDict: parameter, { (json) in
                                print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                        self.atteorneysTable.isHidden = true
                                        self.myConnections.removeAll()
                                        self.getConnectionList()
                                    })
                                }else {
                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                        return
                                    })
                                }
                                
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }))
        self.present(alert, animated: true, completion: nil)
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
}


extension UserBenifitVC: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        if textField.placeholder! == "Vehicle Name"{
            self.formValues["Vehicle Name"] = textField.text!
        }
        else if textField.placeholder! == "Model Number"{
            self.formValues["Model Number"] = textField.text!
        }
        else if textField.placeholder! == "Vehicle Number"{
            self.formValues["Vehicle Number"] = textField.text!
        }
        else if textField.placeholder! == "Model Year"{
            if textField.text?.count != 0{
                let year = Calendar.current.component(.year, from: Date())
                
                if Int(textField.text!)! > 1900 && Int(textField.text!)! <= year{
                    self.formValues["Model Year"] = textField.text!
                }
                else{
                    self.view.makeToast("Please enter a valid year.", duration: 3.0, position: .top)
                }
            }
        }
        else if textField.placeholder! == "Registration Number"{
            self.formValues["Registration Number"] = textField.text!
        }
        else if textField.placeholder! == "VIN Number"{
            self.formValues["VIN Number"] = textField.text!
        }
        else if textField.placeholder! == "License Plate Number"{
            self.formValues["License Plate Number"] = textField.text!
        }
        else if textField.placeholder! == "Insurance Name"{
            self.formValues["Insurance Name"] = textField.text!
        }
//        else if textField.placeholder! == "Start Date"{
//            self.formValues["Start Date"] = textField.text!
//        }
//        else if textField.placeholder! == "Expire Date"{
//            self.formValues["Expire Date"] = textField.text!
//        }
        else if textField.placeholder! == "Policy Number"{
            self.formValues["Policy Number"] = textField.text!
        }
        else if textField.placeholder! == "Liability Coverage"{
            self.formValues["Liability Coverage "] = textField.text!
        }
        else if textField.placeholder! == "Comp and Collission"{
            self.formValues["Comp and Collission Coverage"] = textField.text!
        }
        else if textField.placeholder! == "Name"{
            self.formValues["Name"] = textField.text!
        }
        else if textField.placeholder! == "Mobile Number"{
            self.formValues["Mobile Number"] = textField.text!
        }
        else if textField.placeholder! == "Email"{
            self.formValues["Email"] = textField.text!
        }
        else if textField.placeholder! == "Location"{
            self.formValues["Location"] = textField.text!
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         if textField.placeholder! == "Vehicle Name"{
            textField.keyboardType = .alphabet
             return true
         }
         else if textField.placeholder! == "Model Number"{
             return true
         }
         else if textField.placeholder! == "Vehicle Number"{
            textField.keyboardType = .numbersAndPunctuation
             return true
         }
         else if textField.placeholder! == "Model Year"{
            textField.keyboardType = .numberPad
             return true
         }
         else if textField.placeholder! == "Registration Number"{
             textField.keyboardType = .numberPad
             return true
         }
         else if textField.placeholder! == "VIN Number"{
            textField.keyboardType = .numberPad
             return true
         }
         else if textField.placeholder! == "License Plate Number"{
            textField.keyboardType = .asciiCapable
             return true
         }
         else if textField.placeholder! == "Insurance Name"{
            textField.keyboardType = .alphabet
             return true
         }
         else if textField.placeholder! == "Start Date"{
            self.startDate = true
            self.setDatePicker(textfield: textField)
             return true
         }
         else if textField.placeholder! == "Expire Date"{
            if self.formValues["Start Date"] != nil && self.formValues["Start Date"]?.count != 0{
                self.startDate = false
                self.setDatePicker(textfield: textField)
                 return true
            }
            else{
                self.view.makeToast("Please select start date first.", duration: 3.0, position: .top)
                return false
            }
         }
         else if textField.placeholder! == "Policy Number"{
            textField.keyboardType = .asciiCapable
             return true
         }
         else if textField.placeholder! == "Liability Coverage"{
            textField.keyboardType = .numberPad
             return true
         }
         else if textField.placeholder! == "Comp and Collission"{
             textField.keyboardType = .numberPad
             return true
         }
            else if textField.placeholder! == "Name"{
                textField.keyboardType = .alphabet
                return true
            }
            else if textField.placeholder! == "Mobile Number"{
                textField.keyboardType = .numberPad
                return true
            }
            else if textField.placeholder! == "Email"{
            textField.keyboardType = .emailAddress
                return true
            }
            else if textField.placeholder! == "Location"{
                textField.keyboardType = .asciiCapable
                return true
            }
         else{
            return true
        }
    }
}


extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
