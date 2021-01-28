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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
