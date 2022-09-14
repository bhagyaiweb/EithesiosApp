//
//  SMProfileCell.swift
//  Eithes
//
//  Created by iws044 on 30/10/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class SMProfileCell: UITableViewCell {
  
   
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var closeview: UIView!
    
    
    @IBOutlet weak var backclosebtn: UIButton!
    
    
    //    @IBOutlet weak var newfirstbtn: UIButton!
   var section1 : (() -> Void)? = nil

//   // @IBOutlet weak var cancelBtn: UIButton!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    @IBAction func closBtnAction(_ sender: UIButton) {
        if let sec1 = self.section1 {
            sec1()
        }
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    

   
}
