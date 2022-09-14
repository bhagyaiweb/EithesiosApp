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
        //self.shopLiftingBtn.titleLabel?.font =  .systemFont(ofSize: 5)
       // self.shopLiftingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 2, weight: .medium)


       // self.shopLiftingBtn.titleLabel?.font = .systemFont(ofSize: 5, weight: .medium)
       // self.shopLiftingBtn.titleLabel?.font.withSize(5)

        
      self.shopLiftingBtn.backgroundColor = UIColor.gray
       // self.shopLiftingBtn.tag = 22

        
      //  self.shopLiftingBtn.allTargets.forEach { _ in ($0.tintColor = .red) in
            
      //  }
       // delegate?.onpressedShopliftingBtn(cell: self)

    }


    @IBAction func onpressedShopliftingBtn (sender: UIButton)
    {
        delegate?.onpressedShopliftingBtn(cell: self)


        if shopLiftingBtn.backgroundColor ==  UIColor.gray
        {
            self.shopLiftingBtn.backgroundColor = UIColor.blue
            print("FIRST1COLOR",UIColor.gray)
//            self.View1.backgroundColor = UIColor.blue
        }
        else
        {
            self.shopLiftingBtn.backgroundColor = UIColor.gray
            print("FIRST2COLOR",self.shopLiftingBtn.backgroundColor)

//            self.View1.backgroundColor = UIColor.gray
        }
//

        
//
//        let allButtonTags = [1, 2, 3, 4, 5]
//        let currentButtonTag = sender.tag
//
//        allButtonTags.filter { $0 != currentButtonTag }.forEach { tag in
//            if let button = self.viewWithTag(tag) as? UIButton {
//                // Deselect/Disable t
//                button.backgroundColor = UIColor.red
//              // button.setTitleColor(UIColor.darkGray, for: .normal)
//                button.isSelected = false
//            }
//        }
//        // Select/Enable clicked button
//        sender.backgroundColor = UIColor.blue
//        sender.setTitleColor(UIColor.white, for: .normal)
//        sender.isSelected = !sender.isSelected
//

       
//        if sender is UIButton {
//        // here I need to do selection highlights at a time only one button from four buttons
//        }
//
//        // To differentiate different buttons
//        switch (sender.tag) {
//        case 0:
//            print(sender.title(for: .normal)!)
//            print("0Index",sender.title(for: .normal))
//            if sender.tag == 0   {
//                self.shopLiftingBtn.isSelected = true
//                self.shopLiftingBtn.backgroundColor = UIColor.blue
//            }else if sender.tag == 1 && sender.tag == 2 && sender.tag == 3  {
//                self.shopLiftingBtn.isSelected = false
//
//                self.shopLiftingBtn.backgroundColor = UIColor.gray
//
//            }
//        case 1:
//            print(sender.title(for: .normal)!)
//            print("1Index")
//            if sender.tag == 1 {
//                self.shopLiftingBtn.isSelected = true
//
//                self.shopLiftingBtn.backgroundColor = UIColor.blue
//            }else if sender.tag == 0 && sender.tag == 2 && sender.tag == 3  {
//                self.shopLiftingBtn.isSelected = false
//
//                self.shopLiftingBtn.backgroundColor = UIColor.gray
//
//            }
//
//        case 2:
//            print(sender.title(for: .normal)!)
//            if sender.tag == 2 {
//                self.shopLiftingBtn.isSelected = true
//
//                self.shopLiftingBtn.backgroundColor = UIColor.blue
//            }else if sender.tag == 0 && sender.tag == 1 && sender.tag == 3  {
//                self.shopLiftingBtn.isSelected = false
//
//                self.shopLiftingBtn.backgroundColor = UIColor.gray
//
//            }
//
//        case 3:
//            print(sender.title(for: .normal)!)
//            if sender.tag == 3 {
//                self.shopLiftingBtn.isSelected = true
//
//                self.shopLiftingBtn.backgroundColor = UIColor.blue
//            }else if sender.tag == 0 && sender.tag == 1 && sender.tag == 2  {
//                self.shopLiftingBtn.isSelected = false
//
//                self.shopLiftingBtn.backgroundColor = UIColor.gray
//
//            }
//
//        default:
//            print(sender.title(for: .normal)!)
//        }

        
        
        
        
       // self.shopLiftingBtn.isSelected = true
      //  sender.tintColor = UIColor.red
//        if IndexPath.init(row: 0, section: 0) == [0,0] {
//            self.shopLiftingBtn.backgroundColor = UIColor.gray
//        }


//        if sender.tag == 0 {
//            self.shopLiftingBtn.backgroundColor = UIColor.gray
//
//        }
       //        if self.shopLiftingBtn.isSelected == true {
//            shopLiftingBtn.backgroundColor =  UIColor.blue
//            self.shopLiftingBtn.isSelected = false
//
//        }else{
//            shopLiftingBtn.backgroundColor =  UIColor.gray
//            shopLiftingBtn.isSelected = true
//
//        }
//
        
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected{
//          sender.backgroundColor = UIColor.gray
//          sender.setTitleColor(UIColor.blue, for: .normal)
//           }
//        else{
//          sender.backgroundColor = UIColor.blue
//          sender.setTitleColor(UIColor.white, for: .normal)
//         }


    }
   }
