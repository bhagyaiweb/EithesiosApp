//
//  SerachingVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 23/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import TweeTextField

class SerachingVC: UIViewController {

    @IBOutlet weak var locationTF: TweeActiveTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func onPressclosedbtn(_ sender: Any)
    {
    self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func searchBttnAction(_ sender: Any) {
        if locationTF.text != ""{
              UserData.ZipCode = locationTF.text!
          }
        else{
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter correct zipcode!")
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
