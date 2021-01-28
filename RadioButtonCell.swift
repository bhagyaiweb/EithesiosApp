//
//  RadioButtonCell.swift
//  Eithes
//
//  Created by iws044 on 03/12/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

protocol RadioButtonCellDelegate: AnyObject
{
    func radioButtonTapped(cell: RadioButtonCell)
}


class RadioButtonCell: UITableViewCell {

    weak var delegate: RadioButtonCellDelegate?
    @IBOutlet weak var radioBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func radioButton(_ sender: Any) {
        delegate?.radioButtonTapped(cell: self)
    }
    
}
