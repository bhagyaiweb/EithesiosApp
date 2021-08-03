//
//  ChooseCategoryVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 30/07/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit

class ChooseCategoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var namesArray = ["Traffic Stop","Public Assault","Private Assault","Injury Blood Loss ","Car Accident","Police Brutality","Medical Alert","Abduction","Harassment"]
    
    var selectedIcndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ChooseCategoryCell", bundle: nil), forCellReuseIdentifier: "ChooseCategoryCell")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCategoryCell") as? ChooseCategoryCell
        
        if selectedIcndex == indexPath.row{
            
            cell?.lbl.backgroundColor = .blue

        }else{
            
            cell?.lbl.backgroundColor = .black

            
        }
        
        cell?.selectionStyle = .none
        
        cell?.lbl.text = namesArray[indexPath.row]
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedIcndex = indexPath.row
         tableView.reloadData()
    }

    
    
    @IBAction func closeBtn(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func sosButton(_ sender: Any) {
        
        let vc = liveStreamViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        
    }
}
