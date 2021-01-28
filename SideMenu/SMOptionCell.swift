//
//  SMOptionCell.swift
//  Eithes
//
//  Created by iws044 on 30/10/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class SMOptionCell: UITableViewCell {

    @IBOutlet weak var optionImg: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
