//
//  FileAcomplaitView.swift
//  Eithes
//
//  Created by sumit bhardwaj on 30/07/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit

class FileAcomplaitView: UIViewController {

    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var policeDepartmentTxt: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var complaintForTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setPlaceholder()
        recordView.layer.cornerRadius = 23
        recordView.layer.borderWidth = 1
        recordView.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
    }
    
    func setPlaceholder(){
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Name",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        categoryTxt.attributedPlaceholder = NSAttributedString(string: "Category",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        titleTxt.attributedPlaceholder = NSAttributedString(string: "Title",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        policeDepartmentTxt.attributedPlaceholder = NSAttributedString(string: "Police Department",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        zipCode.attributedPlaceholder = NSAttributedString(string: "ZipCode",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        complaintForTxt.attributedPlaceholder = NSAttributedString(string: "Complaint for?",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
