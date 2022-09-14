//
//  onboarding2VC.swift
//  Eithes
//
//  Created by Shubham Tomar on 18/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class onboarding2VC: UIViewController {

    @IBOutlet weak var signupBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // given radius to btn
        signupBtn.layer.cornerRadius = 5
        signupBtn.clipsToBounds = true

    }
    
    @IBAction func onPressedSignUpBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegistrationVC") as? RegistrationVC
           // self.navigationController?.pushViewController(vc!, animated: true)
        self.present(vc!, animated: true)
        
    }
    
   
    @IBAction func onPressedLoginBtn(_ sender: Any)
    {
        print("LOGIN")
//        let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        self.present(vc!, animated: true)
       
    }
    
}
