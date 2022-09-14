//
//  PoliceDepartmentTableCell.swift
//  Eithes
//
//  Created by iws044 on 04/12/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class PoliceDepartmentTableCell: UITableViewCell {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var PDCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
