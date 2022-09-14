//
//  SupportViewC.swift
//  Eithes
//  Created by Admin on 24/02/22.
//  Copyright © 2022 Iws. All rights reserved.


import UIKit
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import Toast_Swift
import TweeTextField

class SupportViewC: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet weak var visitview: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var subjectTF:UITextField!
    @IBOutlet weak var messageTF: TweeActiveTextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitview.dropShadowhome(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        secondView.dropShadowhome(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
       // messageTF.delegate = self
       // messageTV.text = "Placeholder text goes right here..."
      //  messageTV.textColor = UIColor.lightGray
    }
       
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBTnAction(_ sender: Any) {
        sendMessageApi()
        
    }
    
   
    func sendMessageApi(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
        
        if self.nameTF.text == "" {
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

        if self.emailTF.text == "" {
            self.view.makeToast("Please enter email!", duration: 3.0, position: .bottom)
            return

        }
        if !(emailTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(emailTF.text ?? "")
                } else{
                    print("text length",emailTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter email!", duration: 3.0, position: .bottom)
                return
                }
        if emailTF.text!.isEmail  {
            print("Valid EMAIL")
        }else{
            self.view.makeToast("Email is invalid!", duration: 3.0, position: .bottom)
          return
        }
        


        if self.subjectTF.text == "" {
            self.view.makeToast("Please enter subject!", duration: 3.0, position: .bottom)
            return
//            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter subject!", withError: nil, onClose: {
//                return
//            })
        }
        if !(subjectTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(subjectTF.text ?? "")
                } else{
                    print("text length",subjectTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter subject!", duration: 3.0, position: .bottom)
                return
                }

        if self.messageTF.text == "" {
            self.view.makeToast("Please enter message!", duration: 3.0, position: .bottom)
            return
            
//            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter message!", withError: nil, onClose: {
//                return
//            })
        }
        if !(messageTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(messageTF.text ?? "")
                } else{
                    print("text length",messageTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter message!", duration: 3.0, position: .bottom)
                return
                }
        
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

            let parameter:[String:String] = [
                "user_id": userid,
                "name": self.nameTF.text!,
                "email": self.emailTF.text!,
                "subject": self.subjectTF.text!,
                "msg": self.messageTF.text!
            ]
            print("\nThe parameters for Support screen : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.ContactSupportList, dataDict: parameter, { (json) in
    //                            print(json)
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

                                if json["status"].stringValue == "200" {
                                    self.view.makeToast(json["msg"].stringValue, duration: 10.0, position: .bottom)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                        self.dismiss(animated: true, completion: nil)
                                      
                                    })
                                    

//                                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                        return
//                                    })
                                    
                                   // self.dismiss(animated: true, completion: nil)


                                }
                            }) { (error) in
                                print(error)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
}


extension UIView {
        
        func dropShadowhome(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
          layer.masksToBounds = false
          layer.shadowColor = color.cgColor
          layer.shadowOpacity = opacity
          layer.shadowOffset = offSet
          layer.shadowRadius = radius
          layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
          layer.shouldRasterize = true
          layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }



extension String {
  var isEmail: Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z.-]+\\.[A-Za-z]{2,64}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}
