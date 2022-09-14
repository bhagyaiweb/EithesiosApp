//
//  ButtonTableCell.swift
//  Eithes
//
//  Created by Shubham Tomar on 07/04/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
protocol MyCellDelegate4: AnyObject
{
    func onPresssedCategoryButton(cell: ButtonTableCell)
   
}

class ButtonTableCell: UITableViewCell {
    weak var delegate: MyCellDelegate4?

    @IBOutlet weak var sosCategoryButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        sosCategoryButton.layer.cornerRadius = 5
        sosCategoryButton.clipsToBounds = true
        sosCategoryButton.backgroundColor =  UIColor.gray
        
        
    }
    
    @IBAction func onPresssedCategoryButton(sender: AnyObject)
    {
         delegate?.onPresssedCategoryButton(cell: self)
         if sosCategoryButton.backgroundColor ==  UIColor.gray
                {
                    self.sosCategoryButton.backgroundColor = UIColor.blue
                   
                }
                else
                {
                     self.sosCategoryButton.backgroundColor = UIColor.gray
        //            self.View1.backgroundColor = UIColor.gray
                }
        
    }
    
    
}
