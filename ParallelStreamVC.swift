//
//  ParallelStreamVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 03/08/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit

class ParallelStreamVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        collectionView.register(UINib(nibName: "ParallelStreamCell", bundle: nil), forCellWithReuseIdentifier: "ParallelStreamCell")
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParallelStreamCell", for: indexPath)
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2)-20, height: (self.collectionView.frame.height/2)-20)
    }
    
    
}
