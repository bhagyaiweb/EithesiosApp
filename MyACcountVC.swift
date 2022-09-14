
//  MyACcountVC.swift
//  Eithes
//  Created by Shubham Tomar on 27/03/20.
//  Copyright © 2020 Iws. All rights reserved.

import UIKit

protocol zipcodeSelectedDelegate{
    func userSelectedValueMyAccount(info : String)
}

class MyACcountVC: UIViewController,UITableViewDataSource,UITableViewDelegate,checking1delegate, passdataOnBackBtnDelegate,zipcodeSelectedDelegate {
    
    func userSelectedValueMyAccount(info: String) {
        print("INFOVALUEACCOUNT",info)
        self.ZipCodeLbl.text = info
    }
    
    
    func userSelectedValue12(info: String) {
        print("HHGGDD",info)
        self.ZipCodeLbl.text = info
        print("HHGGDD",self.ZipCodeLbl.text)
    }
    
    
    func navigateToDashboard(isclicked: String) {
        print("ISCLIKEDAccount",isclicked)
        self.ZipCodeLbl.text = isclicked
        print("ISCLIKED12",self.ZipCodeLbl.text!)
    }
    
    
      var delegatex : zipcodeSelectedDelegate? = nil
      var iconImageArray = ["group_4-1","directory_1"]
      var backGroundimgArray = ["1stbackgroundImgaccount","myaacounbckgroundt2img",""]
      var titlelabelArray = ["USER BENEFITS","MY DIRECTORY"]
    
    
    @IBOutlet weak var ZipCodeLbl: UILabel!
    var delegate : passdataOnBackBtnDelegate? = nil
    @IBOutlet weak var MyaccounttableView: UITableView!
    var newvar : String?
    var myaccountzipcode : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchIconbtN.isHidden = true
        self.MyaccounttableView.separatorStyle = .none
        reginib()
        print("CHECKING",self.ZipCodeLbl.text!)
        print("MYZIPCODE",myaccountzipcode!)
        self.ZipCodeLbl.text! = myaccountzipcode!
        print("HOWARE",self.ZipCodeLbl.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
     //   print("nullswsw",self.informationStr)
       // self.ZipCodeLbl.isHidden = true
      //  super.viewWillAppear(animated)
      //  self.ZipCodeLbl.text = self.newvar
       // print("ISCLIK",self.ZipCodeLbl.text!)
        self.ZipCodeLbl.isHidden = true
        print("ISCLIKED",self.ZipCodeLbl.text)
    }
    @IBOutlet weak var searchIconbtN: UIButton!
    
    @IBAction func BackArrowbtn(_ sender: UIButton){
        // if (delegate != nil) {
        let information1 : String = self.ZipCodeLbl.text ?? ""
        print("SECONDZIPCODE",information1)
        print("TTYYUUH",self.ZipCodeLbl.text  ?? "")
        delegate?.userSelectedValue12(info: self.ZipCodeLbl.text!)
        print("SECONDZIPCODEMyaccountlast",self.ZipCodeLbl.text ?? "")
        //}
        self.dismiss(animated: true)
    }
    
    @IBAction func sosButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ChooseCategoryVC")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func onPressedsearchBtn(_ sender: Any)
    {
        //let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        //self.present(vc!, animated: true, completion: nil)
    }
    
    func reginib()
    {
        let nib = UINib(nibName: "Myaccoutcell", bundle: nil)
        MyaccounttableView.register(nib, forCellReuseIdentifier: "Myaccoutcell")
    }
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        iconImageArray.count
       }
       
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Myaccoutcell", for: indexPath)
        as! Myaccoutcell
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white
        cell.BackgroundImage.image = UIImage(named: backGroundimgArray[indexPath.row])
        cell.iconimage.image = UIImage(named: iconImageArray[indexPath.row])
        cell.titlelbl.text = titlelabelArray[indexPath.row]
        return cell
       }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 200
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserBenifitVC") as! UserBenifitVC
            print("PASSZIP1",myaccountzipcode!)
            vc.delegatez = self
            print("PASSZI2",self.ZipCodeLbl.text!)
            print("PASSZIP3",myaccountzipcode!)
            vc.userZipcodeStr = myaccountzipcode!
            print("PASSZIP",vc.userZipcodeStr)
            print("PASSZIP1",myaccountzipcode!)
            self.present(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
            self.present(vc, animated: true)
           // self.dismiss(animated: true, completion: nil)
            //vc.userDirectory = true
           // self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
