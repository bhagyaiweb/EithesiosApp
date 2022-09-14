//
//  LogoutVC.swift
//  Eithes
//
//  Created by Admin on 25/02/22.
//  Copyright © 2022 Iws. All rights reserved.


import UIKit
import FBSDKLoginKit

class LogoutVC: UIViewController {

    @IBOutlet weak var logoutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutView.layer.cornerRadius = 8
        logoutView.layer.masksToBounds = true
      //  logoutView.dropShadowhome(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
    
    
    
    @IBAction func logoutBtnActn(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginVc, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelBTN(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
