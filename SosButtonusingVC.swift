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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setNeedsLayout()

    }
    
    @IBAction func skipBtnAction(_ sender: Any) {
       // self.dismiss(animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as? DashboarethisVC
      // self.navigationController?.pushViewController(vc!, animated: true)
        self.present(vc!, animated: true, completion: nil)
       
    }
    
    
    

    @IBAction func onPressedSosBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as? DashboarethisVC
      // self.navigationController?.pushViewController(vc!, animated: true)
        self.present(vc!, animated: true, completion: nil)
        
    }
    

}
