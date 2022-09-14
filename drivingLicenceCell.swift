//
//  drivingLicenceCell.swift
//  Eithes
//
//  Created by iws044 on 02/12/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

protocol drivingLicenceCellDelegate: AnyObject
{
    func deleteBttnTapped(cell:drivingLicenceCell)
}

class drivingLicenceCell: UITableViewCell {

    @IBOutlet weak var licenseImageView: UIImageView!
    @IBOutlet weak var deleteBttn: UIButton!
    
    weak var delegate: drivingLicenceCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.deleteBttn.setTitle("", for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.deleteBttnTapped(cell: self)
    }
    
}
