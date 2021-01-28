//
//  ViewFeedVC1.swift
//  Eithes
//  Created by Shubham Tomar on 20/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit

class ViewFeedVC1: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCellDelegate1 {
   
    
   
    @IBOutlet weak var feedDatacollectionView: UICollectionView!
    @IBOutlet weak var tabCollectionView: UICollectionView!
    
    var btnArray = ["Shoplifting","Child Abuse","Adventure","Sports"]
    var indexpath:IndexPath?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        feedDatacollectionView.layoutIfNeeded()
        feedDatacollectionView.reloadData()
        self.feedDatacollectionView.isHidden = true
         reginib()
    }
    
    @IBAction func onPressedsearchBtn(_ sender: Any)
    
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    
    
    @IBAction func onPressedSosbtn(_ sender: Any)
    {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityrepersentativeVC") as? CommunityrepersentativeVC
             self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func OnpressedBackArrowBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
       func reginib()
       {
       
   
           let nib = UINib(nibName: "Tabcollectioncell", bundle: nil)
           tabCollectionView.register(nib, forCellWithReuseIdentifier: "Tabcollectioncell")

       }

      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.tabCollectionView {
            return btnArray.count
        }
                
        return  9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        if collectionView ==  self.tabCollectionView
        {
                 
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
            cell.delegate = self
            cell.shopLiftingBtn.layer.cornerRadius = 5
            let title = btnArray[indexPath.row]
            print(title)
            cell.shopLiftingBtn.setTitle(title, for: .normal)
         if indexpath != nil && indexPath == indexpath {
             cell.shopLiftingBtn.backgroundColor = UIColor.blue
         }else{
             cell.shopLiftingBtn.backgroundColor = UIColor.gray
         }

            return cell
       }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

            return cell
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        let numberOfItemsPerRow: CGFloat = 2.0; print("")

        let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        if collectionView == tabCollectionView{
            return CGSize(width: itemWidthtop/2, height: 30)
        }
        if collectionView == feedDatacollectionView
        {
            return CGSize(width: itemWidthdown, height: 300)

        }
        return CGSize(width: itemWidthdown, height: itemWidthdown)
    }
    func onpressedShopliftingBtn(cell: Tabcollectioncell)
    {
        if cell.shopLiftingBtn.backgroundColor ==  UIColor.gray
        {
            self.feedDatacollectionView.isHidden = false
        }
        else
        {
              self.feedDatacollectionView.isHidden = true
        }
        
        if cell.shopLiftingBtn.backgroundColor == .gray{
            self.indexpath = self.tabCollectionView.indexPath(for: cell)
            self.tabCollectionView.reloadData()
        }
        else{
            self.indexpath = nil
            self.tabCollectionView.reloadData()
        }
        
        
}
    
    
}


