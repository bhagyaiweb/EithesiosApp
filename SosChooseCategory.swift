
//  SosChooseCategory.swift
//  Eithes
//  Created by Shubham Tomar on 07/04/20.
//  Copyright © 2020 Iws. All rights reserved.

import UIKit

class SosChooseCategory: UIViewController,UITableViewDelegate,UITableViewDataSource,MyCellDelegate4{
    
   var buttonNameArray = ["Traffic Stop","Public Assault","Private Assault","Injury Blood Loss","Car Accident","Police Brutality","Medical Alert","Abduction","Harassment"]
    
    @IBOutlet weak var sosBtnTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sosBtnTableView.separatorStyle = .none
        reginib()
    }
    
    @IBAction func onPressedCloseBtn(_ sender: Any)
    {
       // self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true,completion: nil)
    }
    
    
    func reginib()
    {
    let nib = UINib(nibName: "ButtonTableCell", bundle: nil)
              sosBtnTableView.register(nib, forCellReuseIdentifier: "ButtonTableCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonNameArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"ButtonTableCell", for: indexPath) as! ButtonTableCell
           cell.delegate = self
        let title = buttonNameArray[indexPath.row]
        print("OTHERCATEGORY",title)
        cell.sosCategoryButton.setTitle(title, for: .normal)
        return cell
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func onPresssedCategoryButton(cell: ButtonTableCell)
    {
        
    }
    
}

    


