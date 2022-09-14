//
//  ElectedOfficalStateCell.swift
//  Eithes
//
//  Created by Shubham Tomar on 24/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
protocol MyCellDelegate2: AnyObject
{
    func onPressedForwardArrowBtn(cell: ElectedOfficalStateCell)
   
}

class ElectedOfficalStateCell: UITableViewCell {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var placeImage: UIImageView!    
    @IBOutlet weak var Statelbl: UILabel!
    weak var delegate: MyCellDelegate2?
    
    @IBOutlet weak var describedlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img1.layer.cornerRadius = 10
        self.img1.clipsToBounds = true
      
    }


  
    @IBAction func onPressedForwardArrowBtn( sender: AnyObject)
    {
          delegate?.onPressedForwardArrowBtn(cell: self)
    }
    
    
}
