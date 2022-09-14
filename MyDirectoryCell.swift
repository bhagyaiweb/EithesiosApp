//
//  MyDirectoryCell.swift
//  Eithes
//
//  Created by Shubham Tomar on 03/04/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

protocol MyDirectoryCellDelegate: AnyObject
{
    func callbtnTapped(cell: MyDirectoryCell)
   func messagebtnTapped(cell: MyDirectoryCell)
//    func locationBtnTapped(cell: MyDirectoryCell)
    func deletebtnTapped(cell: MyDirectoryCell)
    
}





class MyDirectoryCell: UITableViewCell {
    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var picImgView: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var mapBtn: UIButton!
    
    @IBOutlet weak var msgbtn: UIButton!
    
    weak var delegate: MyDirectoryCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        delegate?.callbtnTapped(cell: self)
    }
    
    
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        delegate?.deletebtnTapped(cell: self)

    }
    
    @IBAction func msgBtnAction(_ sender: Any) {
        delegate?.messagebtnTapped(cell: self)
    }
    
    
}
