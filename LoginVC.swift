//
//  LoginVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 19/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import FacebookLogin
import TweeTextField
import Swifter
import NVActivityIndicatorView
import SafariServices



class LoginVC: UIViewController {

    @IBOutlet weak var Loginbtn: UIButton!
    @IBOutlet weak var emailTF: TweeActiveTextField!
    @IBOutlet weak var passwordTF: TweeActiveTextField!
    
    var twitterId = ""
    var twitterHandle = ""
    var twitterName = ""
    var twitterEmail = ""
    var twitterProfilePicURL = ""
    var twitterAccessToken = ""
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FHSTwitterEngine.shared().permanentlySetConsumerKey("dy85rjHZQovZDsBnmg0E86mf9", andSecret: "79Cn7IFqBrcjK7Eay2sjiNfLCbRfuiGdsVU5ogs1VafvEXQUyq")
        
        self.Loginbtn.layer.cornerRadius = 5
        self.Loginbtn.clipsToBounds = true
        
        
        let button = UIButton(type: .custom)
        button.tag = 101
        button.setImage(UIImage(named: "glass_unchecked"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.passwordTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        self.passwordTF.rightView = button
        self.passwordTF.rightViewMode = .always

    }
    
    @IBAction func refresh(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "glass_unchecked") {
            sender.setImage(UIImage(named: "glass_checked"), for: .normal)
                self.passwordTF.isSecureTextEntry = false
        }
        else{
            sender.setImage(UIImage(named: "glass_unchecked"), for: .normal)
            self.passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func onPressedloginbtn(_ sender: Any)
    {
        if emailTF.text!.count == 0 {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter registered email!")
            return
    }
                
        
        if validateEmailWithString(emailID: emailTF.text!) == false {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter valid email.", withError: nil, onClose: {
                self.emailTF.becomeFirstResponder()
            })
            return
        }
                if passwordTF.text!.count == 0 {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.password)
                        //self.passwordText.becomeFirstResponder()
                        return
                }
                
                if  !Reachability.isConnectedToNetwork() {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
                
                let parameter:[String:String] = [
                    "email": emailTF.text!,
                    "password":passwordTF.text!
                ]

                print("\nThe parameters for login : \(parameter)\n")

                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.signIn, dataDict: parameter, { (json) in
                    print(json)
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    if json["status"].stringValue == "200" {
        //                let banner = NotificationBanner(title: "Confirmation", subtitle: "Login successful." , style: .success)
        //                banner.show(queuePosition: .front)
                        
                        UserData._id = json["user_data"]["user_id"].stringValue
//                        UserData.city = json["data"]["city"].stringValue
                        UserData.token = json["user_data"]["token"].stringValue
//                        UserData.country = json["data"]["country"].stringValue
//                        UserData.dob = json["data"]["dob"].stringValue
                        UserData.email = json["user_data"]["email"].stringValue
//                        UserData.gender = json["data"]["gender"].stringValue
//                        UserData.mobile = json["data"]["mobile"].stringValue
//                        UserData.name = json["data"]["first_name"].stringValue
//                        UserData.lastName = json["data"]["last_name"].stringValue
                        UserData.name = json["user_data"]["username"].stringValue
                        UserData.userToken = json["token"].stringValue
//                        UserData.privacy = json["data"]["privacy"].stringValue
        //                UserData.geofence = json["data"]["geofence_value"].stringValue
//                        UserData.geofence = "0"
//                        UserData.profilePic = json["data"]["profile_pic"].stringValue

        //                self.performSegue(withIdentifier: "login", sender: nil)
//                        self.navigateToTabBar()
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        DispatchQueue.main.async {
                             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
                            self.navigationController?.pushViewController(vc, animated: true)
//                            self.present(vc, animated: true, completion: nil)
                        }
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
    
    
    @IBAction func onPressedFacebookBtn(_ sender: Any)
    {
        
        let manger = LoginManager()
        manger.logIn(permissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result
            {
   
            case .success( let token):
            
                print(result)
                print("access token1 = \(token)")
                DispatchQueue.main.async {
                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
                    self.navigationController?.pushViewController(vc, animated: true)
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
    //on press login twitter button
    
    @IBAction func onpressedTwiterButton(_ sender: Any)
    {
               
            self.swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY)
            self.swifter.authorize(withCallback: URL(string: TwitterConstants.CALLBACK_URL)!, presentingFrom: self, success: { accessToken, _ in
                self.accToken = accessToken
                self.getUserProfile()
            }, failure: { _ in
                print("ERROR: Trying to authorize")
            })
           }
    
    
    
    func getUserProfile() {
        self.swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { json in
            // Twitter Id
            if let twitterId = json["id_str"].string {
                print("Twitter Id: \(twitterId)")
                self.twitterId = twitterId
            } else {
                self.twitterId = "Not exists"
            }

            // Twitter Handle
            if let twitterHandle = json["screen_name"].string {
                print("Twitter Handle: \(twitterHandle)")
                self.twitterHandle = twitterHandle
            } else {
                self.twitterHandle = "Not exists"
            }

            // Twitter Name
            if let twitterName = json["name"].string {
                print("Twitter Name: \(twitterName)")
                self.twitterName = twitterName
                UserData.name = twitterName
            } else {
                self.twitterName = "Not exists"
            }

            // Twitter Email
            if let twitterEmail = json["email"].string {
                print("Twitter Email: \(twitterEmail)")
                self.twitterEmail = twitterEmail
            } else {
                self.twitterEmail = "Not exists"
            }

            // Twitter Profile Pic URL
            if let twitterProfilePic = json["profile_image_url_https"].string?.replacingOccurrences(of: "_normal", with: "", options: .literal, range: nil) {
                print("Twitter Profile URL: \(twitterProfilePic)")
                self.twitterProfilePicURL = twitterProfilePic
            } else {
                self.twitterProfilePicURL = "Not exists"
            }
            print("Twitter Access Token: \(self.accToken?.key ?? "Not exists")")
            self.twitterAccessToken = self.accToken?.key ?? "Not exists"

            // Save the Access Token (accToken.key) and Access Token Secret (accToken.secret) using UserDefaults
            // This will allow us to check user's logging state every time they open the app after cold start.
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.accToken?.key, forKey: "oauth_token")
            userDefaults.set(self.accToken?.secret, forKey: "oauth_token_secret")

            DispatchQueue.main.async {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }) { error in
            print("ERROR: \(error.localizedDescription)")
        }
    }
        
        
    @IBAction func onPressedLinkidinBtn(_ sender: Any)
    
    {
        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: {
            (Success) in
            let session = LISDKSessionManager.sharedInstance()?.session
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
            print("error\(error)")
        }
    }
    
        
    func validateEmailWithString(emailID:String)-> Bool
        {
            
    //        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
            
            return emailTest.evaluate(with:emailID)
        }
    
    }
    


extension LoginVC: SFSafariViewControllerDelegate {}
