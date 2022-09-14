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
import FBSDKLoginKit
import TwitterKit
import Toast_Swift



class LoginVC: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var btnFacebook: FBLoginButton!
    
    @IBOutlet weak var btntwitterLogin: UIButton!
    
    @IBOutlet weak var Loginbtn: UIButton!
    @IBOutlet weak var emailTF: TweeActiveTextField!
    @IBOutlet weak var passwordTF: TweeActiveTextField!
    
    var twitterId = ""
    var twitterHandle = ""
    var twitterName = ""
    var twitterEmail = ""
    var twitterProfilePicURL = ""
    var twitterAccessToken = ""
    var window: UIWindow?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTF.delegate = self
        moveTextFeild()
        
//        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
//            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
//            window?.rootViewController = homeVc
//        }else{
//            let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingPagevVewVC") as! OnboardingPagevVewVC
//            window?.rootViewController = loginVc
//
//        }
        
        
//        self.isLoggedIn { loggedin in
//                    if loggedin {
//                        // Show the ViewController with the logged in user
//                        print("Logged In?: YES")
//                        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                        self.present(loginVc, animated: true)
//
////                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
////                   // self.navigationController?.pushViewController(vc, animated: true)
////                    self.present(vc, animated: true, completion: nil)
//                    } else {
//                        // Show the Home ViewController
//                        print("Logged In?: NO")
////                        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
////                        self.present(homeVc, animated: true)
//                      //  let homeVc = self.storyboard!.instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
//
//                      //  self.window?.rootViewController = homeVc
////                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
////                   // self.navigationController?.pushViewController(vc, animated: true)
//                 //  self.present(homeVc, animated: true, completion: nil)
//
//                    }
//                }
        
        
        
       // self.btnFacebook.setImage(nil, for: .normal)
        if let token = AccessToken.current,
              !token.isExpired {
            
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "id, first_name, last_name, picture, short_name, name, middle_name, email"], tokenString: token, version: nil, httpMethod: .get)
            
            request.start { (connection, result, error) in
                print("\(String(describing: result))")
                if let fbname = (result as AnyObject)["first_name"]! as? String
                {
                   print("FBNAME",fbname)
                    let  userDefaultsfb  = UserDefaults.standard
                    userDefaultsfb.setValue(fbname, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                }
                if let fbemail = (result as AnyObject)["email"]! as? String {
                    print("FBEMAIL",fbemail)
                    let  userDefaultsfbemail  = UserDefaults.standard

                    userDefaultsfbemail.setValue(fbemail, forKey: "email")
                    UserDefaults.standard.synchronize()

                }
                if let fbid = (result as AnyObject)["id"]! as? String {
                    print("FBid",fbid)
                    let  userDefaultsfbid  = UserDefaults.standard
                    userDefaultsfbid.setValue(fbid, forKey: "fbuserid")
                    UserDefaults.standard.synchronize()
                }
               print("EMAILTT",self.twitterEmail)
// UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
//   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
//     self.present(vc, animated: true, completion: nil)
            }
        }else{
            btnFacebook.permissions = ["public_profile", "email"]
            btnFacebook.delegate = self
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setNeedsLayout()

    }
    
    func isLoggedIn(completion: @escaping (Bool) -> ()) {
          let userDefaults = UserDefaults.standard
          let accessToken = userDefaults.object(forKey: "oauth_token") ?? ""
          let accessTokenSecret = userDefaults.object(forKey: "oauth_token_secret") ?? ""
          print("accetoken",accessToken)
        print("accetoken",accessTokenSecret)

        let swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY, oauthToken: accessToken as! String, oauthTokenSecret: accessTokenSecret as! String)
          swifter.verifyAccountCredentials(includeEntities: false, skipStatus: false, includeEmail: true, success: { _ in
              // Verify Succeed - Access Token is valid
              completion(true)
              UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true

          }) { _ in
              // Verify Failed - Access Token has expired
              completion(false)
          }
      }
    
    
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
    
    @IBAction func registerpushBtnAction(_ sender: Any) {
       // let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegistrationVC") as? RegistrationVC
//        let next = self.storyboard?.instantiateViewController(withIdentifier: "DashboarethisVC") as! RegistrationVC
//
//        self.present(next, animated: true, completion: nil)
//        self.present(replac, animated: <#T##Bool#>)
    }
    
    
    var swifter: Swifter!
    var accToken: Credential.OAuthAccessToken?
    
    @IBAction func twitterBtnLogin(_ sender: UIButton) {
        self.swifter = Swifter(consumerKey: TwitterConstants.CONSUMER_KEY, consumerSecret: TwitterConstants.CONSUMER_SECRET_KEY)
              self.swifter.authorize(withCallback: URL(string: TwitterConstants.CALLBACK_URL)!, presentingFrom: self, success: { accessToken, _ in
                  self.accToken = accessToken
                print("TOKEN:",accessToken!)
                print("NAME:", accessToken?.screenName!)
                print("USERID:", (accessToken?.userID!)!)
                 // print("userEMAIL",(accessToken?.email!)!)
               // print("EMAILID:", accessToken?.!)
                let userDefaults = UserDefaults.standard
                userDefaults.set(self.accToken?.key, forKey: "oauth_token")
                userDefaults.set(self.accToken?.secret, forKey: "oauth_token_secret")
                userDefaults.set(self.accToken?.userID!, forKey: "userid")
                userDefaults.set(self.accToken?.screenName!, forKey: "username")
               // userDefaults.set(self.accToken?.screenName!, forKey: "username")
                userDefaults.synchronize()
                  
                  let  userDefaultstwitter  = UserDefaults.standard
                  userDefaultstwitter.setValue((accessToken?.screenName!)!, forKey: "username")
                  UserDefaults.standard.synchronize()
                  
                  let  usertwitterName  = UserDefaults.standard
                  usertwitterName.setValue((accessToken?.userID!)!, forKey: "fbuserid")
                  
                  UserDefaults.standard.synchronize()
                  self.socialFBLogin()
                  //getUserProfile()
//                  client.requestEmail { email, error in
//                      if (email != nil) {
//                          let recivedEmailID = email ?? ""
//                          print(recivedEmailID)
//                      }else {
//                          print("error--: \(String(describing: error?.localizedDescription))");
//                      }
//
//                  }

//                  client.requestEmail { email, error in
//
//                      if (email != nil) {
//                          let recivedEmailID = email ?? ""
//                          print(recivedEmailID)
//                      }else {
//                          print("error--: \(String(describing: error?.localizedDescription))");
//                      }
//                  }


//                  client.session() { email, error in
//                                 if (email != nil) {
//                                     let recivedEmailID = email ?? ""
//                                     print(recivedEmailID)
//                                 }else {
//                                     print("error--: \(String(describing: error?.localizedDescription))");
//                                 }
//                             }
                 // self.getUserProfile()
                //  UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true
//                  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
//
//                   self.present(vc, animated: true, completion: nil)
                
              }, failure: { _ in
                  print("ERROR: Trying to authorize")
              })
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
    
    
    func moveTextFeild() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    
    @objc func keyboardwillshow(notification : NSNotification)  {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil{
            
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 10
            }
            
        }
    }
    
    @objc func keyboardwillHide(notification : NSNotification)  {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
            
    }
    
    
    @IBAction func onPressedloginbtn(_ sender: Any)
    {
        if emailTF.text!.count == 0 {
            self.view.makeToast("Please enter registered email!", duration: 3.0, position: .bottom)
           // Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter registered email!")
            return
    }
        if validateEmailWithString(emailID: emailTF.text!) == false {
            self.view.makeToast("Please enter valid email!", duration: 3.0, position: .bottom)
//            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter valid email.", withError: nil, onClose: {
//                self.emailTF.becomeFirstResponder()
//            })
           // self.emailTF.becomeFirstResponder()

            return
        }
        
      
                if passwordTF.text!.count == 0 {
                    self.view.makeToast("Please enter your password", duration: 3.0, position: .bottom)

                    //Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter your password" )
                   // Defines.password
                        //self.passwordText.becomeFirstResponder()
                        return
                }
        
        if passwordTF.text!.contains(" "){
            self.view.makeToast("Please enter your password", duration: 3.0, position: .bottom)
            return
        }
        
       
                if  !Reachability.isConnectedToNetwork() {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
                
                let parameter:[String:String] = [
                    "email": emailTF.text!,
                    "password": passwordTF.text!
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
                        print("LOGINID",UserData._id)
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
                        let  userDefaults3  = UserDefaults.standard
                        userDefaults3.setValue(UserData._id, forKey: "userid")
                        print("kEY*******",UserData._id)
                        let  userDefaults4  = UserDefaults.standard
                        userDefaults4.setValue(UserData.name, forKey: "username")
                        UserDefaults.standard.synchronize()
                        print("USERName",UserData.name)
//                        let str =  UserDefaults.standard.object(forKey: "islogin")
//                        print("get",str!)
//                        UserData.privacy = json["data"]["privacy"].stringValue
        //                UserData.geofence = json["data"]["geofence_value"].stringValue
//                        UserData.geofence = "0"
//                        UserData.profilePic = json["data"]["profile_pic"].stringValue

        //                self.performSegue(withIdentifier: "login", sender: nil)
//                        self.navigateToTabBar()
                        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        DispatchQueue.main.async {
                             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
                          //  vc.modalPresentationStyle = .fullScreen
                            //self.present(vc, animated: true, completion: nil)
                           // self.navigationController?.pushViewController(vc, animated: true)
                            self.present(vc, animated: true, completion: nil)
                        }
                    }else {
//                        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                            return
//                        })
                        
                        self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)

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
                DispatchQueue.main.async{
                     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
                  //  self.navigationController?.pushViewController(vc, animated: true)
                    self.present(vc, animated: true, completion: nil)
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
                print("TOKEN",accessToken!)
                self.getUserProfile()
            }, failure: { _ in
                print("ERROR: Trying to authorize")
            })
           }
    
   func socialFBLogin(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
        
        
        let username : String =  UserDefaults.standard.object(forKey: "username") as? String ?? "0"
       print("USERNAME12",username)
        
       let useremail : String =  UserDefaults.standard.object(forKey: "email") as? String ?? "0"
       
       let socialID : String = UserDefaults.standard.object(forKey: "fbuserid") as? String ?? "0"
       print("NAME",username)
       
        let parameter:[String:String] = [
            "name": username,
            "email": useremail,
            "social_id": socialID
        ]
        
        print("\nThe parameters for Dashboard : \(parameter)\n")
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.socialLogin, dataDict: parameter, { (json) in
            
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            if json["status"].stringValue == "200" {
                                if let data = json["user_data"].dictionary{
                                    print("DATASHOW",data)
                                    let fbusername = data["username"]?.string
                                    print("USERNAME",fbusername!)
                                    let fbuserId = data["user_id"]?.intValue
                                    print("USERID",fbuserId!)
                                    let fbemail = data["email"]?.string
                                    print("FBEMAIL",fbemail!)

                            
                                    let  userDefaultsfbid  = UserDefaults.standard
                                    userDefaultsfbid.setValue(String(fbuserId!), forKey: "userid")
                                    UserDefaults.standard.synchronize()
                                    UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")

                                    DispatchQueue.main.async{
                                         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
                                        vc.userid = String(fbuserId!)
                                        let  userDefaultsfbid  = UserDefaults.standard
                                        userDefaultsfbid.setValue(String(fbuserId!), forKey: "userid")
                                        UserDefaults.standard.synchronize()
                                        //vc.userid! = (UserDefaults.standard.object(forKey: "userid") as? String)!
                                        print("vkkkkk",vc.userid!)
                                      //  self.navigationController?.pushViewController(vc, animated: true)
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                    
                                }
                               
                               
                            }else {
//                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                    return
//                                })
                                
                                self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)

                            }
                            
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }
    
    
    
    func getUserProfile() {
        self.swifter.verifyAccountCredentials(includeEntities: true, skipStatus: true, includeEmail: true, success: { json in
            
//            // ...Getting Profile Data
//
//        // Save the Access Token (accToken.key) and Access Token Secret (accToken.secret) using UserDefaults
//// This will allow us to check user's logging state every time they open the app after cold start.
//            let userDefaults = UserDefaults.standard
//            userDefaults.set(self.accToken?.key, forKey: "oauth_token")
//            userDefaults.set(self.accToken?.secret, forKey: "oauth_token_secret")
            
            print("JSONTWITTERDATA",json)
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
         //   UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true
          //  userDefaults.bool(forKey: "ISUSERLOGGEDIN") = true
//            DispatchQueue.main.async {
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
//               // self.navigationController?.pushViewController(vc, animated: true)
//                self.present(vc, animated: true, completion: nil)
//            }
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
            print("error\(String(describing: error))")
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

extension LoginVC : LoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, picture, short_name, name, middle_name, email"], tokenString: token, version: nil, httpMethod: .get)
        
        request.start { (connection, result, error) in
            print("\(String(describing: result))")
            
            if result == nil{
                self.dismiss(animated: true)
            }else{
                if let fbname = (result as AnyObject)["first_name"]! as? String
                {
                   print("FBNAME",fbname)
                    let  userDefaultsfb  = UserDefaults.standard
                    userDefaultsfb.setValue(fbname, forKey: "username")
                    UserDefaults.standard.synchronize()
                    
                }
                if let fbemail = (result as AnyObject)["email"]! as? String {
                    print("FBEMAIL",fbemail)
                    let  userDefaultsfbemail  = UserDefaults.standard

                    userDefaultsfbemail.setValue(fbemail, forKey: "email")
                    UserDefaults.standard.synchronize()

                }
                if let fbid = (result as AnyObject)["id"]! as? String {
                    print("FBid",fbid)
                    let  userDefaultsfbid  = UserDefaults.standard
                    userDefaultsfbid.setValue(fbid, forKey: "fbuserid")
                    UserDefaults.standard.synchronize()
                }
            }
            
           
           
            self.socialFBLogin()
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SosButtonusingVC") as! SosButtonusingVC
////
//       self.present(vc, animated: true, completion: nil)
            
//            guard let resultNew = result as? [String:Any]
//
//           let email = resultNew["email"]  as! String

            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("LOGOUT...!")

        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginVc, animated: true, completion: nil)
    }
    
    
}

extension LoginVC {
func initializeHideKeyboard(){
//Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
let tap: UITapGestureRecognizer = UITapGestureRecognizer(
target: self,
action: #selector(dismissMyKeyboard))
//Add this tap gesture recognizer to the parent view
view.addGestureRecognizer(tap)
}
@objc func dismissMyKeyboard(){
//endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
//In short- Dismiss the active keyboard.
view.endEditing(true)
}
}

