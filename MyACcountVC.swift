//
//  MyACcountVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 27/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class MyACcountVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
     var iconImageArray = ["group_4-1","directory_1"]
      var backGroundimgArray = ["1stbackgroundImgaccount","myaacounbckgroundt2img",""]
      var titlelabelArray = ["USER BENEFITS","MY DIRECTORY"]
    @IBOutlet weak var ZipCodeLbl: UILabel!
    
    @IBOutlet weak var MyaccounttableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.MyaccounttableView.separatorStyle = .none
        reginib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ZipCodeLbl.text = UserData.ZipCode
    }
    
    @IBAction func BackArrowbtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func onPressedsearchBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
               self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    func reginib()
    {
        let nib = UINib(nibName: "Myaccoutcell", bundle: nil)
        MyaccounttableView.register(nib, forCellReuseIdentifier: "Myaccoutcell")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        iconImageArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Myaccoutcell", for: indexPath)
        as! Myaccoutcell
        cell.BackgroundImage.image = UIImage(named: backGroundimgArray[indexPath.row])
        cell.iconimage.image = UIImage(named: iconImageArray[indexPath.row])
        cell.titlelbl.text = titlelabelArray[indexPath.row]
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserBenifitVC") as! UserBenifitVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserBenifitVC") as! UserBenifitVC
            vc.userDirectory = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
