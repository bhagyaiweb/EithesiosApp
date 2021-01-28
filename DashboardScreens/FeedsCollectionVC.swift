//
//  FeedsCollectionVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 19/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class FeedsCollectionVC: UICollectionViewCell {

    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var descriptionImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgNameLbl: UILabel!
    @IBOutlet weak var bgPhoneLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.isHidden = true
       
    }
}
