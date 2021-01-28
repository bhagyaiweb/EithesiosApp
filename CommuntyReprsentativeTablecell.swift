//
//  CommuntyReprsentativeTablecell.swift
//  Eithes
//
//  Created by Shubham Tomar on 23/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

protocol CommuntyReprsentativeTablecellDelegate: AnyObject
{
    func callbtnTapped(cell: CommuntyReprsentativeTablecell)
    func messagebtnTapped(cell: CommuntyReprsentativeTablecell)
    func locationBtnTapped(cell: CommuntyReprsentativeTablecell)
    func deletebtnTapped(cell: CommuntyReprsentativeTablecell)
    
}



class CommuntyReprsentativeTablecell: UITableViewCell {
    
    @IBOutlet weak var policeNameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var locationbttn: UIButton!
    @IBOutlet weak var callCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var userImgView: UIImageView!
    
    
    
    weak var delegate: CommuntyReprsentativeTablecellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.locationImg.isHidden = true
        self.locationbttn.isHidden = true
        self.deleteBtn.isHidden = true
        self.deleteImg.isHidden = true
        
    }

    @IBAction func callButton(_ sender: UIButton) {
        delegate?.callbtnTapped(cell: self)
    }
    
    
    @IBAction func messageButton(_ sender: UIButton) {
        delegate?.messagebtnTapped(cell: self)
    }
    
    @IBAction func locationBttn(_ sender: Any) {
        delegate?.locationBtnTapped(cell: self)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.deletebtnTapped(cell: self)
    }
    
}
