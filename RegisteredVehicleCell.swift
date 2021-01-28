//
//  RegisteredVehicleCell.swift
//  Eithes
//
//  Created by iws044 on 13/11/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

protocol RegisteredVehicleCellDelegate: AnyObject
{
    func deleteBttnTapped(cell:RegisteredVehicleCell)
}

class RegisteredVehicleCell: UITableViewCell {

    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var vehicleModel: UILabel!
    @IBOutlet weak var vehicleNumber: UILabel!
    @IBOutlet weak var vehicleModelYear: UILabel!
    @IBOutlet weak var vehicleRegNumber: UILabel!
    @IBOutlet weak var vehicleVINNumber: UILabel!
    @IBOutlet weak var vehiclePlateNumber: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var vehicleNumberLbl: UILabel!
    @IBOutlet weak var ModelYearLbl: UILabel!
    @IBOutlet weak var RegNumberLbl: UILabel!
    @IBOutlet weak var VINnumberLbl: UILabel!
    @IBOutlet weak var LicencePlatLbl: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
     weak var delegate: RegisteredVehicleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteBttnTapped(_ sender: Any) {
        delegate?.deleteBttnTapped(cell: self)
    }
    
}
