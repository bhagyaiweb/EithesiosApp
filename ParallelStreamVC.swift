//
//  ParallelStreamVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 03/08/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import AVKit
import AVFoundation

class ParallelStreamVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var collectionView: UICollectionView!
    var videosListdata = Array<JSON>()
    var newURL : URL!
    var latvalue : Double?
    var longValue : Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ParallelStreamCell", bundle: nil), forCellWithReuseIdentifier: "ParallelStreamCell")
        self.latvalue  = UserDefaults.standard.object(forKey: "latitude") as? Double
        print("PARALLELVALUELAT : ", self.latvalue?.string)

        self.longValue  = UserDefaults.standard.object(forKey: "longitude") as? Double
        print("PARALLELVALUELONG : ", self.longValue?.string)
        
        getparallelstreamApidata()
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosListdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParallelStreamCell", for: indexPath) as! ParallelStreamCell
        let data1 = self.videosListdata[indexPath.row].dictionaryValue

        cell.nameLbl.text = data1["category"]?.stringValue
        var image = data1["thumbnail"]?.stringValue
        self.newURL = URL(string: image!)
        cell.imagedisplayView.kf.setImage(with: self.newURL)



        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:180,  height: 235)
    }
   // (self.collectionView.frame.height/2)-30)
   // (self.collectionView.frame.width/2)-40,
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == self.collectionView{
//            let data = self.videosListdata[indexPath.row].dictionaryValue
//            let videoUrl = data["url"]?.stringValue
//            print(videoUrl!)
//            let videoURL = URL(string: videoUrl!)
//            let player = AVPlayer(url: videoURL!)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            self.present(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }
//
//        }
    }
    

    func getparallelstreamApidata(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }

            let parameter:[String:String] = [
                "lat": self.latvalue?.string ?? "",
                "lng": self.longValue?.string ?? "",
                "zipcode": "201301"
            ]
            print("\nThe parameters for ParallelStreamer : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getparallelStreamList, dataDict: parameter, { (json) in
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {

                                    if let data = json["data"].array{
                                        self.videosListdata = data
                                        
                                        self.collectionView.delegate = self
                                        self.collectionView.dataSource = self
                                        self.collectionView.reloadData()
                                    }
                                }else {
                                 
                                }
                            }) { (error) in
                                print(error)
                              
                            }
        }
    
     
}
