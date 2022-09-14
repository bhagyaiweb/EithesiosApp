//
//  ShowImageFullscreenVC.swift
//  Eithes
//
//  Created by Admin on 05/08/22.
//  Copyright © 2022 Iws. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShowImageFullscreenVC: UIViewController {

    @IBOutlet weak var newImgview: UIImageView!
    
    @IBOutlet weak var ImgFullscreenView: UIView!
        
    @IBOutlet weak var closeBtnOutlet: UIButton!
    
    var drivingImageFullView : URL!
    var urlstring1 : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeBtnOutlet.setTitle("", for: .normal)
        print("IMAGESHOW",drivingImageFullView)
        print("IAMGESTRING",urlstring1!)
        self.newImgview.image = UIImage(named: urlstring1!)
        self.drivingImageFullView = URL(string: urlstring1!)
    }

    override func viewWillAppear(_ animated: Bool) {
     
        self.newImgview.kf.setImage(with: self.drivingImageFullView!)
    }
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
  
    

}
