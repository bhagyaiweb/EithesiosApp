//
//  Feedscell.swift
//  Eithes
//
//  Created by Shubham Tomar on 19/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
protocol MyCellDelegate: AnyObject
{
    func onPressedArrowBtn(cell: Feedscell)
}

class Feedscell: UITableViewCell {
 
    @IBOutlet weak var newlbl: UILabel!
    
    
    @IBOutlet weak var backgroundImg: UIImageView!
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var feedCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var forwordArrowBtn: UIButton!
    
    @IBOutlet weak var Feedcollection: UICollectionView!

     weak var delegate: MyCellDelegate?
    override func awakeFromNib()
    {
        super.awakeFromNib()
//        Feedcollection.delegate = self
//        Feedcollection.dataSource = self
        reginib()
    }
   
// on preseed arrow btn
    @IBAction func onPressedArrowbtn( sender: AnyObject)
    {
        delegate?.onPressedArrowBtn(cell: self)
        
    }
    
    // working with collectionview  call
    func reginib()
    {
        let nib = UINib(nibName: "FeedsCollectionVC", bundle: nil)
        Feedcollection.register(nib, forCellWithReuseIdentifier: "FeedsCollectionVC")
    }
    
}

