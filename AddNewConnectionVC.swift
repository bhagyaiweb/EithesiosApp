
//  AddNewConnectionVC.swift
//  Eithes
//
//  Created by Admin on 10/05/22.
//  Copyright © 2022 Iws. All rights reserved.


import UIKit
import TweeTextField
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import Toast_Swift
import SDWebImage
import MessageUI
import AVKit
import Kingfisher
import FittedSheets
import AVFoundation
import SDWebImage

class AddNewConnectionVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var mobileNoTF: UITextField!
    
    @IBOutlet weak var emailTF: TweeActiveTextField!
    
    @IBOutlet weak var locationTF: TweeActiveTextField!
    
    @IBOutlet weak var profileimageView: UIImageView!
    var mydataArr = Array<JSON>()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mobileNoTF.delegate = self
        self.isValid(testStr: self.nameTF.text!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedcharachters = "+1234567890"
       
        let allowedcharacterset = CharacterSet(charactersIn: allowedcharachters)
        let typedcharachetrset = CharacterSet(charactersIn: string)
        return allowedcharacterset.isSuperset(of: typedcharachetrset)
        
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
//if (self.nameTF.text != "") && (self.mobileNoTF.text != "") && (self.emailTF.text != "") && (self.locationTF.text != "") {
//            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please click on Save")
//
//        }else{
//            self.dismiss(animated: true, completion: nil)
//
//        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var imgoutletBtn: UIButton!
    
    
    @IBAction func uploadPhotoBtnActn(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "", message: title, preferredStyle: .actionSheet)
                
                refreshAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction!) in
                    self.openCamera(type: "image")
                }))
                refreshAlert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action: UIAlertAction!) in
                    self.openLibrary(type: "image")
                }))
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func searchBtnction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.present(vc!, animated: true, completion: nil)
    }
    func isValid(testStr:String) -> Bool {
        guard testStr.count > 7, testStr.count < 18 else { return false }
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    
    @IBAction func nameTFActn(_ sender: UITextField) {
        
        //Trimming whitespaces at the end
//        let firstname = nameTF.text?.trimmingCharacters(in: .whitespaces)
//
//        let letters = NSCharacterSet.letters
//
//        let prefix = String((firstname?.first)!)
//        let suffix = String((firstname?.last)!)
//
//        //Checking if First Character is letter
//        if let _ = prefix.rangeOfCharacter(from: letters) {
//            print("letters found")
//        } else {
//            print("letters not found")
//        }
//
//        //Checking if Last Character is letter
//        if let _ = suffix.rangeOfCharacter(from: letters) {
//            print("letters found")
//        } else {
//            print("letters not found")
//        }
    }
    
    
    
    @IBAction func saveBtnActn(_ sender: UITextField) {
       
//        if  self.imgoutletBtn.isSelected == true{
//            uploadConnections()
//            //self.dismiss(animated: true, completion: nil)
//
//        }else{
//            self.view.makeToast("Select image first", duration: 3.0, position: .bottom)
//
//        }
        if nameTF.text == "" {
            self.view.makeToast("Please enter name!", duration: 3.0, position: .bottom)
           return
        }
        
        if !(nameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(nameTF.text ?? "")
        } else {
                    print("text length",nameTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter name!", duration: 3.0, position: .bottom
                    )
                return
                }
        
        
        if self.mobileNoTF.text == ""  {
                   // self.VehicalregistrationAddMoreView.isHidden = true

            self.view.makeToast("Please enter mobile number!!", duration: 3.0, position: .bottom)
               return
                       // self.usernameText.becomeFirstResponder()
                        
                }
       

        if self.emailTF.text == ""  {
            self.view.makeToast("Please enter email!", duration: 3.0, position: .bottom)
            return
                }
        let validEmail = self.emailTF.text!.isValidEmail()
            if validEmail == false{
                self.view.makeToast("email is invalid!", duration: 3.0, position: .bottom)
               return
                }
        
        if locationTF.text == "" {
            self.view.makeToast("please enter location!", duration: 3.0, position: .bottom)
            return

        }
        if !(locationTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(locationTF.text ?? "")
                } else{
                    print("text length",locationTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter location!", duration: 3.0, position: .bottom)
                return
                }
        
       
        if self.imgoutletBtn.isSelected == false {
            self.view.makeToast("Please select an image!", duration: 3.0, position: .bottom)
                        return
                }
        
        uploadConnections()
        nameTF.text = ""
        locationTF.text = ""
        emailTF.text = ""
        mobileNoTF.text = ""
       


    }
    let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

    
    func getConnectionList12(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
            let parameter:[String:String] = [
                "user_id": userid
        ]
        
        print("\nThe parameters of ConnectionList : \(parameter)\n")
        self.mydataArr.removeAll()
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getmyConnectionList, dataDict: parameter, { (json) in
            print("PARMASINDIRECTORY",parameter)
                            print(json)
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

                            if json["status"].stringValue == "200" {
                             //  self.nodataLbl.isHidden = true

                                if let data = json["data"].array{
                                    self.mydataArr = data
                                    print("DATALICST",data)
                                    let next = self.storyboard?.instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
                                    print("indexprint******34333")
                                    next.myConnections = self.mydataArr
//                                    print("FROM ADD",self.mydataArr)
//                                    print("TO ADD",next.myConnections)
                                   self.present(next, animated: true, completion: nil)
                                  //  self.myDirectorytableView.isHidden = false
                                   // self.myDirectorytableView.reloadData()
                                }
//                                DispatchQueue.main.async {
//                                   // self.myDirectorytableView.reloadData()
//                                }
//                                self.myDirectorytableView.reloadData()

                            }else {
                              //  self.myConnections.removeAll()
                              //  self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
//                                self.nodataLbl.isHidden = false
//                                let msg = json["msg"].stringValue
//                                self.nodataLbl.text = msg
                               
                            }
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }
    
    func uploadConnections() {
        if  !Reachability.isConnectedToNetwork() {
         //   self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
        
            var data:Data?
                let url:String = Defines.ServerUrl + Defines.uploadConnection
           data = self.profileimageView.image?.pngData()
                        //print(data)
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                var status = ""
        
//                if self.radioButtonPermission == false{
//                    status = "1"
//                }
//                else{
//                    status = "0"
//                }
        
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

                let parameter:[String:String] = [
                    "user_id": userid,
                    "name": self.nameTF.text!,
                    "phone_number": self.mobileNoTF.text!,
                    "location":self.locationTF.text!,
                    "email":self.emailTF.text!,
                    "status":status,
                    "location_access":"1"
                ]
        
        print("PARAMS",parameter)
                let timestamp = NSDate().timeIntervalSince1970
            
                Alamofire.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(data!, withName: "file" ,fileName: "\(timestamp).png", mimeType: "\(timestamp)/png")
        //            multipartFormData.append(imgData, withName: name ,fileName: "file.jpg", mimeType: "image/jpg")
                    for (key, value) in parameter {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    print("PARAMS88",parameter)

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
                           // print(response.result.value!)
                            let json = JSON(response.result.value!)
                            print(json)
                            if json["status"].stringValue == "200" {
                             //   self.radioButtonPermission = false
                              //  self.addMoreButton.isHidden = false
                              //  self.Savebtn.isHidden = true
                             //   self.formValues.removeAll()
                             //   self.formValues = self.formValues1
                       self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                                self.getConnectionList12()
//                                let next = self.storyboard?.instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
//                                print("indexprint******34333")
//                               self.present(next, animated: true, completion: nil)
                                

                            }else {
                                self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                            }
                        }
                    case .failure(let encodingError):
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        print(encodingError)
                    }
                }
            }
    
    

}
extension AddNewConnectionVC: UINavigationControllerDelegate ,UIImagePickerControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if (info[.mediaType] as? String) != nil {
                let profileImage = info[.originalImage] as! UIImage
                let updateImage = profileImage.updateImageOrientionUpSide()
                self.imgoutletBtn.isSelected = true
                self.profileimageView.image = updateImage!
            }
            dismiss(animated: true) {
                print("Photo Selected")
//                self.API_Calling_For_UpdateProfilePicture()
            }
        }
        
        // take phota using camera
        func openCamera(type:String) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
    //            self.isAvtar = false
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        // take photo from library
        func openLibrary(type:String) {
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let imagePicker = UIImagePickerController()
    //            self.isAvtar = false
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    
//    public func filterPhoneNumber() -> String {
//        return String(self.filterPhoneNumber() {!" ()._-\n\t\r".contains($0)})
//    }
    
    
    func isValidPhone() -> Bool {
        let inputRegEx = "^((\\+)|(00))[0-9]{6,14}$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:self)
    }
    
    
}



