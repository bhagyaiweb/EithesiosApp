
//  RegistrationVC.swift
//  Eithes
//  Created by Shubham Tomar on 18/03/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import  FacebookLogin
import TweeTextField
import NVActivityIndicatorView
import Toast_Swift


class RegistrationVC: UIViewController,UITextFieldDelegate {
  
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var nameTF: TweeActiveTextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cnfPasswordTF: TweeActiveTextField!
    
    
  //  @IBOutlet weak var glassbtn: UIButton!
    
    @IBOutlet var topViewConstrainNameLbl: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTF.delegate = self
        self.cnfPasswordTF.delegate = self

        FHSTwitterEngine.shared().permanentlySetConsumerKey("dy85rjHZQovZDsBnmg0E86mf9", andSecret: "79Cn7IFqBrcjK7Eay2sjiNfLCbRfuiGdsVU5ogs1VafvEXQUyq")
        signinBtn.layer.cornerRadius = 5
        signinBtn.clipsToBounds =  true
        
        let button = UIButton(type: .custom)
        button.tag = 101
        button.setImage(UIImage(named: "glass_unchecked"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.passwordTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        self.passwordTF.rightView = button
        self.passwordTF.rightViewMode = .always
        
        let button1 = UIButton(type: .custom)
        button1.tag = 102
        button1.setImage(UIImage(named: "glass_unchecked"), for: .normal)

        button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button1.frame = CGRect(x: CGFloat(self.cnfPasswordTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button1.addTarget(self, action: #selector(self.refreshbutton), for: .touchUpInside)

        self.cnfPasswordTF.rightView = button1
        self.cnfPasswordTF.rightViewMode = .always

        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        glassbtn.setImage(UIImage(named: "glass_unchecked"), for: .normal)
//        glassbtn.addTarget(self, action: #selector(self.refresh1), for: .touchUpInside)
//
//
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedcharachters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!+@$#&*"
        let allowedcharacterset = CharacterSet(charactersIn: allowedcharachters)
        let typedcharachetrset = CharacterSet(charactersIn: string)
        return allowedcharacterset.isSuperset(of: typedcharachetrset)
        
      //  if ((nameTF.text?.characters.count)! == 0 && range  != nil)
//        if ((mobileNoTF.text?.characters.count = 0) != nil)
//        || ((nameTF.text?.characters.count)! > 0 && nameTF.text?.characters.last  == " " && range != nil)  {
//            return false
//        }

    }
    
    @IBAction func refresh(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "glass_unchecked") {
            sender.setImage(UIImage(named: "glass_checked"), for: .normal)
                self.passwordTF.isSecureTextEntry = false
          //  self.cnfPasswordTF.isSecureTextEntry = false
        }
        else{
            sender.setImage(UIImage(named: "glass_unchecked"), for: .normal)
            self.passwordTF.isSecureTextEntry = true
           // self.cnfPasswordTF.isSecureTextEntry = true

        }
    }
    
    @IBAction func refreshbutton(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "glass_unchecked") {
            sender.setImage(UIImage(named: "glass_checked"), for: .normal)
            self.cnfPasswordTF.isSecureTextEntry = false
        }
        else{
            sender.setImage(UIImage(named: "glass_unchecked"), for: .normal)
            self.cnfPasswordTF.isSecureTextEntry = true

        }
    }
    
    
    @IBAction func onPressedSigninBtn(_ sender: Any)
    {
            
        if nameTF.text!.count == 0 {
                    self.view.makeToast("Please enter full name", duration: 3.0, position: .bottom)

//                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter full name.", withError: nil, onClose: {
                      //  })
       // self.nameTF.becomeFirstResponder()

                        return
                    }
        
        
        if !(nameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(nameTF.text ?? "")
        } else {
                    print("text length",nameTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter full name!", duration: 3.0, position: .bottom
                    )
                return
                }
        
        
        
                    if emailTF.text!.count == 0 {
                        self.view.makeToast("Please enter email id", duration: 3.0, position: .bottom)

                       // Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter email id")
                                                  //  Defines.blankUserName
                           // self.usernameText.becomeFirstResponder()
                            return
                    }
        
        
        if !(emailTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                    // string contains non-whitespace characters
                    print("text has no spaces")
                    print(emailTF.text ?? "")
        } else {
                    print("text length",emailTF.text?.count ?? 0)
                    print("text has spaces")
                    self.view.makeToast("Please enter email id!", duration: 3.0, position: .bottom
                    )
                return
                }
                    
        
        if emailTF.text!.isEmail  {
            print("Valid EMAIL")
        }else{
            self.view.makeToast("Please enter valid email id", duration: 3.0, position: .bottom)
          return
        }
        
//                if validateEmailWithString(emailID: emailTF.text!) == false {
//                    self.view.makeToast("Please enter valid email id", duration: 3.0, position: .bottom)
//                  //  self.emailTF.becomeFirstResponder()
//
////                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter valid email.", withError: nil, onClose: {
////                    })
//                    return
//                }
        
        if passwordTF.text!.count == 0 {
                        self.view.makeToast("Please enter password", duration: 3.0, position: .bottom)
                      //  self.passwordTF.becomeFirstResponder()
                        
//                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter password.", withError: nil, onClose: {
//                            self.passwordTF.becomeFirstResponder()
//                        })
                        return
                    }
      
//        if !(passwordTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
//                    // string contains non-whitespace characters
//                    print("text has no spaces")
//                    print(passwordTF.text ?? "")
//        } else {
//                    print("text length",passwordTF.text?.count ?? 0)
//                    print("text has spaces")
//                    self.view.makeToast("Please enter password", duration: 3.0, position: .bottom
//                    )
//                return
//                }
        
      
        
        
        if cnfPasswordTF.text!.count == 0 {
                     self.view.makeToast("Please enter confirm password", duration: 3.0, position: .bottom)
                   //  self.cnfPasswordTF.becomeFirstResponder()
           
            return
        }
        
        
                    if passwordTF.text! != cnfPasswordTF.text! {
                        self.view.makeToast("Password & confirm password must be same", duration: 3.0, position: .bottom)
                        
//                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Password & confirm password must be same.", withError: nil, onClose: {
//                            self.cnfPasswordTF.becomeFirstResponder()
//                        })
                        return
                    }
        
                    
                    if  !Reachability.isConnectedToNetwork() {
                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                            return
                    }
                    
                    let parameter:[String:String] = [
                        "name":self.nameTF.text!,
                        "email": emailTF.text!,
                        "password":passwordTF.text!,
                        "confirm_password":cnfPasswordTF.text!
                    ]

                    print("\nThe parameters for login : \(parameter)\n")

                    let activityData = ActivityData()
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                    
                    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.register, dataDict: parameter, { (json) in
                        print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                           
                                DispatchQueue.main.async {
                                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                                    self.present(vc!, animated: true)
                                   //  self.navigationController?.pushViewController(vc!, animated: true)
                                }
                    
                        }else {
                            
                            self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
//                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                return
//                            })

            //                let banner = NotificationBanner(title: "Alert", subtitle: json["msg"].stringValue , style: .danger)
            //                banner.show(queuePosition: .front)
                        }
                        
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
        }
    
    @IBAction func onpressedFacebookBtn(_ sender: Any)
    {
         
         let manger = LoginManager()
         manger.logIn(permissions: [.publicProfile,.email], viewController: self) { (result) in
             switch result
             {
     
             case .success( let token):
             
                 print("access token1 = \(token)")
                DispatchQueue.main.async {
                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as? SosButtonusingVC
                     self.navigationController?.pushViewController(vc!, animated: true)
                }
             case .cancelled:
                 print("User cancel the login process")
                 break
             case .failed(let error):
                 print("login failed due to error \(error.localizedDescription)")
                 break
                 
             }
             
         }
         
     }
    
    
    @IBAction func onPressedTwitterBtn(_ sender: Any)
    {
        let login =    FHSTwitterEngine.shared().loginController { (success) in
                              
                }
                    as UIViewController
    self.present(login, animated: true, completion: nil)
                     
    }
    
    
    
    @IBAction func onPressedLinkidBtn(_ sender: Any)
    
    {
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: {
            (Success) in
            _ = LISDKSessionManager.sharedInstance()?.session
            let url = "https://api.linked.com/v1/people~"
            if(LISDKSessionManager.hasValidSession())
            {
                LISDKAPIHelper.sharedInstance()?.getRequest(url, success: { (response) in
                    print(response?.data as Any)
                    
                }, error: { (error) in
                    print(error as Any)
                })
            }
         
        }) { (error) in
            print("error\(String(describing: error))")
        }
    }
    
    
    func validateEmailWithString(emailID:String)-> Bool
        {
            
    //        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z.-]+\\.[A-Za-z]{2,64}"

            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
            
            return emailTest.evaluate(with:emailID)
        }
}

