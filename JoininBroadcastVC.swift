//
//  JoininBroadcastVC.swift
//  Eithes
//
//  Created by Admin on 24/08/22.
//  Copyright © 2022 Iws. All rights reserved.
//

import UIKit

class JoininBroadcastVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OtherUserViewFeed") as? OtherUserViewFeed
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func noButtonActn(_ sender: Any) {
        self.dismiss(animated: true)
    }
       
}
