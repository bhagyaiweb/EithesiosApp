//
//  UpdateProfileVC.swift
//  Eithes
//
//  Created by iws044 on 03/11/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import TweeTextField
import Toast_Swift
import SwiftyJSON
import NVActivityIndicatorView

protocol profilePicDelegate{
    func userprofilePic(info : String)
}


class UpdateProfileVC: UIViewController,profilePicDelegate {
    
    func userprofilePic(info: String) {
        var urlString: String = self.url.absoluteString
        print("PROFILEIMAGE",urlString)
        print("INFORMATION",info)
    }

    
    @IBOutlet weak var profilePictureImgView: UIImageView!
    @IBOutlet weak var fullNameTF: TweeActiveTextField!
    @IBOutlet weak var emailTF: TweeActiveTextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var addressTF: TweeActiveTextField!
    var delegatepic : profilePicDelegate? = nil
    var url: URL!
        
      override func viewDidLoad() {
        super.viewDidLoad()
         
        getProfile()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedcharachters = "+1234567890"
        let allowedcharacterset = CharacterSet(charactersIn: allowedcharachters)
        let typedcharachetrset = CharacterSet(charactersIn: string)
        return allowedcharacterset.isSuperset(of: typedcharachetrset)
 
    }
    
    let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
    
          func getProfile(){
                    
                    let parameter:[String:String] = [
                        "user_id": userid
                    ]
                    print("\nThe parameters for login : \(parameter)\n")

                    let activityData = ActivityData()
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.view_profile, dataDict: parameter, { (json) in
                      //  print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            self.fullNameTF.text = json["data"]["name"].stringValue
                            self.emailTF.text = json["data"]["email"].stringValue
                            self.addressTF.text = json["data"]["address"].stringValue
                            self.phoneNumberTF.text = json["data"]["phone_number"].stringValue
                            self.url = URL(string: json["data"]["profile_pic"].stringValue)
                        
                           // print("IMAGEDATAshow12",url)
                            let imgData = UserDefaults.standard.set(self.url, forKey: "pimg")
                            print("IMAGEDATAshow",imgData)
                            UserDefaults.standard.synchronize()

                            let newstr =  UserDefaults.standard.object(forKey: "pimg")
                            print("IMAGEDATA1",newstr)

                            if self.url != nil{
                                self.profilePictureImgView.kf.setImage(with: self.url)
                            }
                            else{
                                self.profilePictureImgView.image = UIImage(named: "bitmap-2")
                                print("BHAGYA12",newstr)
                            }
                        }else {
//                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                return
//                            })
                            
                            self.view.makeToast(json["msg"].stringValue, duration: 2.0, position: .bottom)


            //                let banner = NotificationBanner(title: "Alert", subtitle: json["msg"].stringValue , style: .danger)
            //                banner.show(queuePosition: .front)
                        }
                        
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
        }
    
    
    
    @IBAction func updateBttnAction(_ sender: Any) {
        
        if fullNameTF.text == "" {
            self.view.makeToast("Please enter name", duration: 3.0, position: .bottom)
           return
        }
        
        if !(fullNameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(fullNameTF.text ?? "")
        } else {
                    print("text length",fullNameTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter name!", duration: 3.0, position: .bottom
                    )
                return
                }
        
        if emailTF.text == ""{
            self.view.makeToast("Please enter email.", duration: 2.0, position: .bottom)
            return
        }
        if validateEmailWithString(emailID: self.emailTF.text!) == false {
            self.view.makeToast("Email Address is invalid", duration: 2.0, position: .bottom)

           // Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Email Address is invalid.", withError: nil, onClose: {
          //  })
            return
        }
        if phoneNumberTF.text == ""{
            self.view.makeToast("Please enter phone number.", duration: 2.0, position: .bottom)
            return
        }else{
            
        }
        
        
        let text = phoneNumberTF.text ?? " "
        if text.filterPhoneNumber().isValidPhone() {
            text.count <= 10
            self.view.makeToast("", duration: 2.0, position: .bottom)
        } else {
            
      return   self.view.makeToast("Phone number should be 10-12 digits", duration: 2.0, position: .bottom)
        }
        
        
        if addressTF.text == ""{
            self.view.makeToast("Please enter address.", duration: 2.0, position: .bottom)
            return
        }
        
        if !(addressTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(addressTF.text ?? "")
        } else {
                    print("text length",addressTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter address", duration: 3.0, position: .bottom
                    )
                return
                }
        
         let activityData = ActivityData()
                        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let parameters =  ["user_id": userid,
                          "name":self.fullNameTF.text!,
                          "email":self.emailTF.text!,
                           "phone_number": self.phoneNumberTF.text!,
                           "address" :self.addressTF.text!] as [String : Any]
        
        let imgData = (self.profilePictureImgView.image?.pngData() as Data?)!
        
                    DataProvider.sharedInstance.callAPIForUpload(parameters, sUrl: Defines.ServerUrl + Defines.update_profile, imgData: imgData, imageKey: "file") { (response) in
            //            _ = ASProgressHud.hideHUDForView(self.view, animated: true)
                        print(response)
                        do{
                            let json = try JSON(data:response!)
                            print(json)
                        let status = json["status"].stringValue
                        let msg = json["msg"].stringValue
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if status == "200"{
                            UserData.name = json["data"]["name"].stringValue
                            UserData.email = json["data"]["email"].stringValue
                            UserData.address = json["data"]["address"].stringValue
                            UserData.mobile = json["data"]["phone_number"].stringValue
                            self.view.makeToast(msg, duration: 2.0, position: .bottom)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                self.dismiss(animated: true)
                            })
                        }
                         
                        else{
                            self.view.makeToast(msg, duration: 2.0, position: .bottom)
                        }
                        }
                        catch{error.localizedDescription}
                    }
    }
    
    
    func validateEmailWithString(emailID:String)-> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with:emailID)
    }
    
    
    @IBAction func backbttnAction(_ sender: Any) {
        if (delegatepic != nil) {
            let information = self.url
            print("SECONDZIPCODE",information)
            var urlString: String = information?.absoluteString ?? "nil"
            print("STRINGIMAGE1",urlString)
            delegatepic!.userprofilePic(info: urlString)
            print("STRINGIMAGE",urlString)
        }else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func profilePicUpdateButton(_ sender: Any) {
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
    
}

extension UpdateProfileVC: UINavigationControllerDelegate ,UIImagePickerControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if (info[.mediaType] as? String) != nil {
                let profileImage = info[.originalImage] as! UIImage
                let updateImage = profileImage.updateImageOrientionUpSide()
                self.profilePictureImgView.image = updateImage!
            }
            dismiss(animated: true) {
                print("Photo Selected")
          //self.API_Calling_For_UpdateProfilePicture()
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
}


extension UIImage {

    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

extension UpdateProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    func isValidPhone() -> Bool {
        let inputRegEx = "[0-9]{10,12}$"
        let inputpred = NSPredicate(format: "SELF MATCHES %@", inputRegEx)
        return inputpred.evaluate(with:self)
    }
    public func filterPhoneNumber() -> String {
        return String(filter {!" ()._-\n\t\r".contains($0)})
    }
}




