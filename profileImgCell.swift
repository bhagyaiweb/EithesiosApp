//
//  profileImgCell.swift
//  Eithes
//
//  Created by iws044 on 03/12/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

protocol profileImgCellDelegate: AnyObject
{
    func changeImageBttnTapped(cell: profileImgCell)
}

class profileImgCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    weak var delegate: profileImgCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeImageTapped(_ sender: Any) {
        delegate?.changeImageBttnTapped(cell: self)
    }
    
}
