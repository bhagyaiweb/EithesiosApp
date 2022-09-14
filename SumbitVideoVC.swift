//
//  SumbitVideoVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 10/04/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class SumbitVideoVC: UIViewController {

    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.layer.cornerRadius = 10
        saveBtn.clipsToBounds = true
    }
    
    @IBAction func onPressedCloseBtn(_ sender: Any){
        
        self.dismiss(animated: true)
        
     //   self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onPressedSaveBtn(_ sender: Any)
    {
        
    }
    

}
