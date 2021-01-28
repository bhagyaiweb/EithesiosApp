//
//  SosButtonusingVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 19/03/20.
//  Copyright © 2020 Iws. All rights reserved.
import UIKit
class SosButtonusingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func onPressedSosBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as? DashboarethisVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    

}
