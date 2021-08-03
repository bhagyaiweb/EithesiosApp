//
//  MessageCell.swift
//  Eithes
//
//  Created by sumit bhardwaj on 29/07/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
