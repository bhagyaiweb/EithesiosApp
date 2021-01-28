//
//  TrackerListCell.swift
//  Eithes
//
//  Created by Shubham Tomar on 06/04/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class TrackerListCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    
    @IBOutlet weak var nameLbl: UILabel!
    
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
}
