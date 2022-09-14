//
//  selfHelpVideosCell.swift
//  Eithes
//
//  Created by iws044 on 26/11/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class selfHelpVideosCell: UICollectionViewCell {
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var editImg: UIImageView!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var videotitleLbl: UILabel!
    
var editBtn1 : (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func editBtnActn(_ sender: Any) {
        if let newBtnaction = self.editBtn1 {
            
            newBtnaction()
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
