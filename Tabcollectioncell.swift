//
//  Tabcollectioncell.swift
//  Eithes
//
//  Created by Shubham Tomar on 20/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
protocol MyCellDelegate1: AnyObject
{
    
    func onpressedShopliftingBtn(cell: Tabcollectioncell)
   
}


class Tabcollectioncell: UICollectionViewCell {
    weak var delegate: MyCellDelegate1?

    
    @IBOutlet weak var shopLiftingBtn: UIButton!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.shopLiftingBtn.titleLabel?.textAlignment = .center
         self.shopLiftingBtn.backgroundColor = UIColor.gray

       
    }
    
    @IBAction func onpressedShopliftingBtn (sender: AnyObject)
    {
        delegate?.onpressedShopliftingBtn(cell: self)
        if shopLiftingBtn.backgroundColor ==  UIColor.gray
        {
            self.shopLiftingBtn.backgroundColor = UIColor.blue  
//            self.View1.backgroundColor = UIColor.blue
        }
        else
        {
             self.shopLiftingBtn.backgroundColor = UIColor.gray
//            self.View1.backgroundColor = UIColor.gray
        }

    }
   }
