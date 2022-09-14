
//  liveStreamViewController.swift
//  Eithes
//  Created by sumit bhardwaj on 27/07/21.
//  Copyright © 2021 Iws. All rights reserved.

enum ChatType {
    case peer(String), group(String)
    
    var description: String {
        switch self {
        case .peer:  return "peer"
        case .group: return "channel"
        }
    }
}

struct Message {
    var userId: String
    var text: String
}


import UIKit
import AgoraRtcKit
import AgoraRtmKit
import DrawerView
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView


class liveStreamViewController: UIViewController,DrawerViewDelegate,CLLocationManagerDelegate {
    
   // let agoraDelegate = AgoraDelegateExample()
    
    lazy var list = [Message]()
    
    @IBOutlet weak var contactsNotifiedLbl: UILabel!
    
    @IBOutlet weak var notifiedLbl: UIButton!
    
    @IBOutlet weak var commentView12: UIView!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var rightSideView: UIView!
    @IBOutlet weak var commentTxtField: UITextField!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var camBtn: UIButton!
    @IBOutlet weak var parallelStreamBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sendComplainBtn: UIButton!
    @IBOutlet weak var complainViewBtn: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var sosMap: GMSMapView!
    @IBOutlet weak var notifiedBtnOutlet: UIButton!
    @IBOutlet weak var parallelBtnOutlet: UIButton!
    @IBOutlet weak var notifiedLblnew: UILabel!
    
    @IBOutlet weak var fullmapview: GMSMapView!
    
    @IBOutlet weak var parallelcountLbl: UILabel!
    
    
    @IBOutlet weak var contactBtn: UIButton!
    
    
    var drawerRef:  DrawerView!
    var parallelDrawerRef:  DrawerView!
    var notifiedContactDrawerRef : DrawerView!
    // Defines localView
    var localView: UIView!
    // Defines remoteView
    var remoteView: UIView!
    var agoraKit: AgoraRtcEngineKit?
   // var rtmKit = AgoraRtmKit()
    var rtmChannel : AgoraRtmChannel?
    var darkBlur:UIBlurEffect = UIBlurEffect()
    var locationManager = CLLocationManager()
    var categoryStr : String?
    var subCateStr : String?
    var token : String?
    var channelName : String?
    var usersCount : String?
    var connectionInrangeStr : String?
    var latString : String?
    var longString : String?
    var latvalDouble: Double?
    var longvalDouble: Double?
    var isTimerRunning = false
    var timer = Timer()
    var seconds = 60
    var timeCount:TimeInterval = 7200.0
   var counter = 0
    var resourceIDstr : String?
    var stoprecodingStr : String?
    var contactnotifiedArr = [JSON]()
    var notifiedArr = [JSON]()
    var parallelListdata = Array<JSON>()
    var timeMin = 0
    var timeSec = 0
    weak var timer1: Timer?
    var sidvalueStr : String?
    
    @IBOutlet weak var topview: UIView!
    
    @IBOutlet weak var newview: UIView!
    @IBOutlet weak var sendchatBtnOutlet: UIButton!
    
    //      appId: "5d5dd39d0ce547a5a9a3278663b8457a",
//      delegate: self()B
//    )
    
    
    var nameArray = ["Dorothy Powers","Yoandra Sans","Sarah Xandre"]
    var  commentArray = ["Stay safe buddy!","We’re reaching at your destination.","Just called the police, they are reaching."]
  
   // MapViewController
     override func viewDidLoad() {
        super.viewDidLoad()
         timerBtn.titleLabel?.text = String(format: "%02d:%02d", timeMin, timeSec)
         
         self.contactBtn.setTitle(" ", for: .normal)
         self.latvalDouble  = UserDefaults.standard.object(forKey: "latitude") as? Double
         print("VALUESDGGHGFGFG : ", self.latvalDouble?.string)

         self.longvalDouble  = UserDefaults.standard.object(forKey: "longitude") as? Double
         print("VALUELONGDouble : ", self.longvalDouble?.string)
         self.channelName  = UserDefaults.standard.object(forKey: "username") as! String
         print("CNAME",self.channelName)
         self.listTableView.isHidden = false
        self.stackView.isHidden = true
        timerBtn.layer.cornerRadius = 10
         listTableView.delegate = self
         listTableView.dataSource = self
         listTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        // This function initializes the local and remote video views
        initView()
         initializeAndJoinChannel()
        // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
        setChannelProfile()
        setClientRole()
        setupLocalVideo()
        joinChannel()
        dropShadowToView(view: self.commentView)
        dropShadowToView(view: self.listView)
         dropShadowToView(view: self.commentView12)
         dropShadowToView(view: self.topview)

         fullmapview.layer.cornerRadius = 20
         fullmapview.clipsToBounds = true
        complainViewBtn.layer.cornerRadius = 18
        setDrawers()
         SosStartApiCall()
         
//         if isTimerRunning == false {
//                  runTimer()
//             }
//         aquireApiCall()
//
//         if counter > 0 {
//
//                let hours = counter / 3600
//
//                let minutes = counter / 60
//
//                let seconds = counter % 60
//
//                counter = counter - 1
//
//             timerBtn.setTitle("\(hours):\(minutes):\(seconds)", for: .normal)
//            }
       //  mapview()
        // let mapView = GMSMapView.map(withFrame: CGRectZero, camera: camBtn)
       //  self.view = mapView
       //  stopBtn.addTarget(self, action: Selector(("clickMe")), for: UIControl.Event.touchUpInside)
     }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        agoraKit?.leaveChannel(nil)
        agoraKit?.stopPreview()
        AgoraRtcEngineKit.destroy()
        resetTimerToZero()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer()
      //  movieFileOutput.startRecording(to: videoUrl, recordingDelegate: self)
        getparallelstreamApidata()
        self.fullmapview.isHidden = true
        self.topview.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap")))
        sosMap.addGestureRecognizer(tap)
        self.listTableView.isHidden = false
        self.listTableView.reloadData()
       // commentTxtField.placeholder
       // commentView.alpha = 4.0
        commentView.backgroundColor = UIColor.white.withAlphaComponent(0.09)
        commentTxtField.attributedPlaceholder = NSAttributedString(
            string: "Write a comment",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        commentView12.backgroundColor = UIColor.white.withAlphaComponent(0.09)
        topview.backgroundColor = UIColor.white.withAlphaComponent(0.09)
    }
    
    
    // MARK:- Timer Functions
    fileprivate func startTimer() {
        
        // if you want the timer to reset to 0 every time the user presses record you can uncomment out either of these 2 lines

        // timeSec = 0
        // timeMin = 0

        // If you don't use the 2 lines above then the timer will continue from whatever time it was stopped at
        let timeNow = String(format: "%02d:%02d", timeMin, timeSec)
        timerBtn.setTitle(String(format: "%02d:%02d", timeMin, timeSec), for: .normal)
        //timerLbl.text = timeNow

        stopTimer() // stop it at it's current time before starting it again
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                    self?.timerTick()
                }
    }
    
    
    // resets both vars back to 0 and when the timer starts again it will start at 0
    @objc fileprivate func resetTimerToZero(){
         timeSec = 0
         timeMin = 0
         stopTimer()
    }
    
    
    @objc fileprivate func resetTimerAndLabel(){
         resetTimerToZero()
        timerBtn.setTitle(String(format: "%02d:%02d", timeMin, timeSec), for: .normal)
    }
    
    
    @objc fileprivate func stopTimer(){
        timer.invalidate()
    }
    
    @objc fileprivate func timerTick(){
         timeSec += 1
         if timeSec == 60{
             timeSec = 0
             timeMin += 1
         }
         let timeNow = String(format: "%02d:%02d", timeMin, timeSec)
        timerBtn.setTitle(String(format: "%02d:%02d", timeMin, timeSec), for: .normal)
    }

    
    func handleTap(sender: UITapGestureRecognizer) {
      // handling code
        print("HANDLE CHECK")
//        let profilevc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        print("indexprint******34333")
//        self.present(profilevc, animated: true, completion: nil)
       // bckArrowBtn.isHidden = false
       // fullmapview.isHidden = false
      //  popupView.isHidden = true
       //  distanceView.isHidden = false
      // joinFeedImageView.isHidden = true
     //  iconImage.isHidden = false
    }
    
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.sosMap?.animate(to: camera)
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let location1 = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location1.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = locValue
            print("locations12 = \(locValue.latitude) \(locValue.longitude)")
          //  sosMap.addAnnotation(annotation)
            annotation.title = placemark.name! + "," + placemark.locality!
            print(placemark.postalCode ?? "")
            print(placemark.country ?? "")
            print("NAMEFIRST",placemark.name)
            //print("SUBLOCALITY",placemark.subLocality)
            print("LOCALITYfIRST",placemark.locality)
          //  print("REGION",placemark.region)
        }
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }

    
    func setDrawers()  {
        let mapDrawerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapDrawerVC.modalPresentationStyle = .fullScreen
        let mapDrawer = self.addDrawerView(withViewController: mapDrawerVC)
        self.view.bringSubviewToFront(mapDrawer)
        mapDrawer.snapPositions = [.collapsed, .open]
        mapDrawer.collapsedHeight = 50
        mapDrawer.topMargin = 200
        print(mapDrawer.topMargin)
        mapDrawer.insetAdjustmentBehavior = .automatic
        mapDrawer.delegate = self
     
        let DriverDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FileAcomplaitView") as! FileAcomplaitView
       // DriverDetailsVC.modalPresentationStyle = .fullScreen
        let drawer = self.addDrawerView(withViewController: DriverDetailsVC)
        //drawer.delegate = drawerContentVC;
       // drawer.collapsedHeight = 300//268
        drawer.snapPositions = [.closed, .open]

        //drawer.collapsedHeight = 235
        drawer.topMargin = 300

        drawer.setPosition(.closed, animated: true)
        
        print(drawer.topMargin)
//        drawer.topMargin = UIApplication.shared.statusBarFrame.height
        drawer.insetAdjustmentBehavior = .automatic
       // drawer.backgroundColor = UIColor(named: "WhiteBlack")
        //DriverDetailsVC.drawerRef = drawer
       // DriverDetailsVC.drawerRef.delegate = self
        
        drawer.delegate = self
        drawerRef = drawer
        
        let ParallelStreamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ParallelStreamVC") as! ParallelStreamVC
        ParallelStreamVC.modalPresentationStyle = .fullScreen
        let ParallelStream = self.addDrawerView(withViewController: ParallelStreamVC)
        self.view.bringSubviewToFront(ParallelStream)
        ParallelStream.snapPositions = [.closed, .open]
        
        //ParallelStream.collapsedHeight = 50
        ParallelStream.topMargin = 300
        ParallelStream.setPosition(.closed, animated: true)
        print(mapDrawer.topMargin)
        ParallelStream.insetAdjustmentBehavior = .automatic
        ParallelStream.delegate = self
        parallelDrawerRef = ParallelStream

        let NotifiedContactVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotifiedContactVC") as! NotifiedContactVC
        
        NotifiedContactVC.categoryVal = categoryStr
        NotifiedContactVC.subcategoryVal = subCateStr
        NotifiedContactVC.modalPresentationStyle = .fullScreen
        let notifiedContact = self.addDrawerView(withViewController: NotifiedContactVC)
        self.view.bringSubviewToFront(notifiedContact)
        notifiedContact.snapPositions = [.closed, .open]
        
        //ParallelStream.collapsedHeight = 50
        notifiedContact.topMargin = 300
        notifiedContact.setPosition(.closed, animated: true)
        print(notifiedContact.topMargin)
        notifiedContact.insetAdjustmentBehavior = .automatic
        notifiedContact.delegate = self
        notifiedContactDrawerRef = notifiedContact
       // stopBtn.addTarget(self, action: Selector(("clickMe")), for: UIControl.Event.touchUpInside)
    }
    
    
    func getparallelstreamApidata(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }

            let parameter:[String:String] = [
                "lat": self.latvalDouble?.string ?? "",
                "lng": self.longvalDouble?.string ?? "",
                "zipcode": "201301"
            ]
            print("\nThe parameters for ParallelStreamer : \(parameter)\n")
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getparallelStreamList, dataDict: parameter, { (json) in
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    if let data = json["data"].array{
                                        print("COSDOSDOJS",data.count)
                                        self.parallelListdata = data
                                        print("PARALLELCOUNT",self.parallelListdata.count)
                                        self.parallelcountLbl.text = String(self.parallelListdata.count)
                                    }
                                }else {
                                  
                                }
                            }) { (error) in
                                print(error)
                              //  NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            }
        }
    
    let  userid1  =  UserDefaults.standard.object(forKey: "userid") as? String ?? "0"
    func initializeAndJoinChannel() {
      // Pass in your App ID here
      agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "a6e3170384984816bf987ddd4aad3029", delegate: self)
      // Video is disabled by default. You need to call enableVideo to start a video stream.
      agoraKit?.enableVideo()
           // Create a videoCanvas to render the local video
           let videoCanvas = AgoraRtcVideoCanvas()
           videoCanvas.uid = 0
           videoCanvas.renderMode = .hidden
           videoCanvas.view = localView
           agoraKit?.setupLocalVideo(videoCanvas)

      // Join the channel with a token. Pass in your token and channel name here
        agoraKit?.joinChannel(byToken: "Your token", channelId: "Channel", info: nil, uid: UInt(userid1)!, joinSuccess: { (channel, uid, elapsed) in
        print("UID",uid)
           })
       }
    
    
    @IBAction func mapBtnAction(_ sender: UIButton) {
        print("Mapbutton")
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
//          self.present(vc!, animated: true, completion: nil)

    }
    
    @IBAction func newbTNACTN(_ sender: Any) {
        print("ACTION")
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SumbitVideoVC") as? SumbitVideoVCNotifiedContactVC
      //  self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func btnactionmap(_ sender: Any) {
        self.topview.isHidden = false
        self.fullmapview.isHidden = false
        self.listTableView.isHidden = true
        self.rightSideView.isHidden = true
        self.stackView.isHidden = true
        self.commentView.isHidden = true
        print("BUTTON12")
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.fullmapview.isHidden = true
        self.topview.isHidden = true
        self.listTableView.isHidden = false
        self.rightSideView.isHidden = false
        self.stackView.isHidden = false
        self.commentView.isHidden = false
    }
     
    
     func runTimer(){
        print("TIMERACTION")
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(liveStreamViewController.updateTimer)), userInfo: nil, repeats: true)
            isTimerRunning = true
       }

  @objc  func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
           // timerBtn.titleLabel?.text = timeString(time: TimeInterval(seconds))
            timerBtn.setTitle(timeString(time: TimeInterval(seconds)), for: .normal)
            //timerBtn.titleLabel?.text = timeString(time: timeCount)
//            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    
    @IBAction func timerBtnAction(_ sender: UIButton) {
            // Swift >=3 selector syntax
//            let timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
   
    }
    
    
    func StopAgoraRecordingApiCall(sidVal:String){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
        
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

        //let getsidvalue = UserDefaults.standard.object(forKey: "sidString")as! String ?? "nil"
//print("PRINT GETSID",getsidvalue)
        
    let parameter:[String:String] = [
        "cname": self.channelName ?? "",
        "uid" : useridtoagora,
        "resourceId" : self.resourceIDstr ?? "",
        "sid" : self.sidvalueStr ?? "nil"
    ]

    print("\nThe parameters of StopAgora : \(parameter)\n")
        
    let activityData = ActivityData()
        
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.stopAgora, dataDict: parameter, { (json) in
                       // print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary {
                                print("stopagrarESPONSE",data)
                                self.resourceIDstr  = data["resourceId"]?.stringValue
                                var reasonStr : String = data["reason"]?.stringValue ?? ""
                              //  let codeStr : Int = data["code"]!.intValue
                                print("PRINT RECORDING",self.resourceIDstr)
                                print("PRINT REASON",reasonStr)
                               
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SumbitVideoVC") as? SumbitVideoVC
                               self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                return
                            })
                        }

                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
    }
    
    
    func aquireApiCall() {
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }

    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

    let parameter:[String:String] = [
        "cname": self.channelName ?? "",
        "uid" : useridtoagora,
    ]
    print("\nThe parameters of Auire : \(parameter)\n")

    let activityData = ActivityData()
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startAquireAgora, dataDict: parameter, { (json) in
                       // print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary{
                                self.resourceIDstr  = data["resourceId"]?.stringValue
                                print("PRINT RESOURCEID",self.resourceIDstr)
                                self.StartAgoraRecordingApiCall()
                            }
                        }else{
                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                return
                            })
                        }
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
    }
    
    
    
//    func StartAgoraRecordingApiCall(){
//    if  !Reachability.isConnectedToNetwork() {
//        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
//            return
//    }
//
//    var channelName = randomAlphaNumericString(length: 8)
//
//    print("",channelName)
//    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
//
//    let parameter:[String:String] = [
//        "cname": channelName,
//        "uid" : useridtoagora,
//        "resourceId" : self.resourceIDstr ?? ""
//    ]
//
//    print("\nThe parameters of AgoraStart : \(parameter)\n")
//
//    let activityData = ActivityData()
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//
//    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startAgora, dataDict: parameter, { (json) in
//                        print(json)
//                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//
//                        if json["status"].stringValue == "200" {
//                            if let data = json["data"].dictionary{
//                                self.resourceIDstr  = data["resourceId"]?.stringValue
//                                var reasonStr : String = data["reason"]!.stringValue
//                                var codeStr : Int = data["code"]!.intValue
//                                print("PRINT RECORDING",self.resourceIDstr)
//                                print("PRINT REASON",reasonStr)
//                                print("PRINT RESOURCEID",codeStr)
//                            }
//                        }else{
//                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                return
//                            })
//                        }
//
//                    }) { (error) in
//                        print(error)
//                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//                    }
//    }
    
    func SosStartApiCall(){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
    var channelName12 = UserDefaults.standard.object(forKey: "username") as! String
    print(channelName12)
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

    let parameter:[String:String] = [
        "zipcode": "201301",
        "user_id": useridtoagora,
        "category_id" : categoryStr ?? "",
        "category_name" : subCateStr ?? "",
        "lat" : self.latvalDouble?.string ?? "",
        "lng" : self.longvalDouble?.string ?? "",
        "appID" :"a6e3170384984816bf987ddd4aad3029",
        "appCertificate" : "caca5b8fe77145efb2acde599f2e7ae6",
        "channelName" : channelName12
    ]
        
    print("\nThe parameters of LIVE : \(parameter)\n")
        
    let activityData = ActivityData()
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startSos, dataDict: parameter, { (json) in
                    //    print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary{
                                self.token  = data["token"]?.stringValue
                                print("PRINT TOKEN",self.token)
                                self.contactnotifiedArr = data["usersInRangeArr"]?.arrayValue ?? [0]
                                self.notifiedArr = data["connectionsInRangeArr"]?.arrayValue ?? [0]
                                print("USERCOUNT", String(self.contactnotifiedArr.count))
                                print("NOTIFIEDCOUNT",self.notifiedArr.count)
                                self.contactsNotifiedLbl.text = String(self.contactnotifiedArr.count)
                                self.notifiedLblnew.text = String(self.notifiedArr.count)
                                print("CONNECTIONINRANGE",self.connectionInrangeStr)
                                self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .bottom)
                                self.aquireApiCall()

                                
                                // let contrll = SosStartVC()
                               //self.present(contrll, animated: true)
//                                    let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
//                                    vc?.modalPresentationStyle = .fullScreen
//                                    self.present(vc!, animated: true, completion: nil)

                             //   DispatchQueue.main.async {
//                                        let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")                                //                                    vc?.modalPresentationStyle = .fullScreen
//                                self.present(vc!, animated: true, completion: nil)

//                                    let livesteam = liveStreamViewController()
//                                    livesteam.modalPresentationStyle = .fullScreen
//                                    self.present(livesteam, animated: true, completion: nil)
//                               // }
                            }
                        }else {
                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                return
                            })
                        }
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
    }
    
    
//    func SosStartAgoraRecordingApi(){
//    if  !Reachability.isConnectedToNetwork() {
//        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
//            return
//    }
//
//    var channelName = randomAlphaNumericString(length: 8)
//
//    print(channelName)
//    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
//
//    let parameter:[String:String] = [
//
//        "uid": useridtoagora,
//        "resourceId" : categoryStr ?? "",
//        "cname" : channelName
//    ]
//
//    print("\nThe parameters of LIVE : \(parameter)\n")
//
//    let activityData = ActivityData()
//    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//
//    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startAgora, dataDict: parameter, { (json) in
//                        print(json)
//                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//
//                        if json["status"].stringValue == "200" {
//
//                            if let data = json["data"].dictionary{
//                                self.token  = data["token"]?.stringValue
//                                self.channelName  = data["token"]?.stringValue
//
//                                print("PRINT TOKEN",self.token)
//                                self.usersCount = data["usersInRangeArr"]?.stringValue
//                                self.connectionInrangeStr = data["connectionsInRangeArr"]?.stringValue
//                                print("USERCOUNT",self.usersCount)
//                                print("CONNECTIONINRANGE",self.connectionInrangeStr)
//
//                // let contrll = SosStartVC()
//                               //self.present(contrll, animated: true)
////                                    let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
////                                    vc?.modalPresentationStyle = .fullScreen
////                                    self.present(vc!, animated: true, completion: nil)
//
//                             //   DispatchQueue.main.async {
//
////                                        let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
////                                    vc?.modalPresentationStyle = .fullScreen
////                                self.present(vc!, animated: true, completion: nil)
//
////                                    let livesteam = liveStreamViewController()
////                                    livesteam.modalPresentationStyle = .fullScreen
////                                    self.present(livesteam, animated: true, completion: nil)
////                               // }
//
//                            }
//
//                        }else {
//                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
//                                return
//                            })
//                        }
//
//                    }) { (error) in
//                        print(error)
//                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//                    }
//
//    }
    
    
    @IBAction func fileAcomplainBnt(_ sender: UIButton) {
       // self.listTableView.isHidden = true
       // self.stackView.isHidden = false
       // self.rightSideView.isHidden = true
       // drawerRef.setPosition(.open, animated: true)
       // let next = self.storyboard?.instantiateViewController(withIdentifier: "SumbitVideoVC") as! SumbitVideoVC
        let DriverDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FileAcomplaitView") as! FileAcomplaitView
       // DriverDetailsVC.modalPresentationStyle = .fullScreen
        self.present(DriverDetailsVC, animated: true, completion: nil)
    
    }
    
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBAction func stopBTNAction(_ sender: UIButton) {
        print("SIDNUMBER",self.sidvalueStr!)
        StopAgoraRecordingApiCall(sidVal: self.sidvalueStr!)
    }
    
   
    
    func clickMe(sender:UIButton!) {
         print("CALL")
       // let next = self.storyboard?.instantiateViewController(withIdentifier: "SumbitVideoVC") as! SumbitVideoVC
        let submit = self.storyboard?.instantiateViewController(withIdentifier: "SumbitVideoVC") as! SumbitVideoVC
                self.present(submit, animated: true, completion: nil)
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SumbitVideoVC") as? SumbitVideoVC
//        self.present(vc!, animated: true, completion: nil)
       }
       
    
    @IBAction func parallelStreamDidSelect(_ sender: Any) {
       // self.listTableView.isHidden = true
        sendchatBtnOutlet.isHidden = true
        self.stackView.isHidden = false
        self.rightSideView.isHidden = false
        parallelDrawerRef.setPosition(.open, animated: true)
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        print("BACKBUTTONDISMISS")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func notifiedContactDidSelect(_ sender: UIButton) {
     //  self.listTableView.isHidden = true
        sendchatBtnOutlet.isHidden = true
        self.stackView.isHidden = false
        self.rightSideView.isHidden = true
        var catvalue = UserDefaults.standard.setValue(categoryStr, forKey: "catVal")
        print("CATVAL",catvalue)
        var subcatvalue = UserDefaults.standard.setValue(subCateStr, forKey: "subcatVal")
        print("SUBCATVAL",subcatvalue)
        
        notifiedContactDrawerRef.setPosition(.open, animated: true)
        
    }
    
    @IBAction func parallelstreamButonAction(_ sender: UIButton) {
       // self.listTableView.isHidden = true
        self.stackView.isHidden = false
        self.rightSideView.isHidden = true
        parallelDrawerRef.setPosition(.open, animated: true)
    }
    
    
    func dropShadowToView(view : UIView){
        //view.center = self.view.center
        //view.backgroundColor = UIColor.yellow
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        self.view.addSubview(view)
    }

    
    // Sets the video view layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
        self.view.bringSubviewToFront(self.listTableView)
        self.view.bringSubviewToFront(self.stackView)
        self.view.bringSubviewToFront(self.camBtn)
        self.view.bringSubviewToFront(self.timerBtn)
        self.view.bringSubviewToFront(self.stopBtn)
        self.view.bringSubviewToFront(self.complainViewBtn)
        self.view.bringSubviewToFront(self.newview)
        self.view.bringSubviewToFront(self.parallelStreamBtn)
        self.view.bringSubviewToFront(self.rightSideView)
    }
    
    
    @IBAction func cameraTouchUpBtnAcion(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "OtherUserViewFeed") as? OtherUserViewFeed
        self.present(vc!, animated: true, completion: nil)
    }
        
    @IBAction func sendChatButton(_ sender: Any) {
        if pressedReturnToSendText(commentTxtField.text) {
            commentTxtField.text = nil
        } else {
            view.endEditing(true)
        }
    }
    
    func pressedReturnToSendText(_ text: String?) -> Bool {
        guard let text = text, text.count > 0 else {
            return false
        }
        self.send(message: text, type: .group(""))
        return true
    }
    
    func initView() {
        // Initializes the remote video view. This view displays video when a remote host joins the channel
        remoteView = UIView()
        self.view.addSubview(remoteView)
        // Initializes the local video view. This view displays video when the local user is a host
        localView = UIView()
        self.view.addSubview(localView)
    }
    func initializeAgoraEngine() {
           agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "a6e3170384984816bf987ddd4aad3029", delegate: self)
//        self.rtmKit = AgoraRtmKit(appId: "a6e3170384984816bf987ddd4aad3029", delegate: self)!
        }
    
    
    func mapview(){
        print("HANDLE TAP")
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
//          self.present(vc!, animated: true, completion: nil)
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        sosMap.camera = camera
//        sosMapView.delegate = (self as! GMSMapViewDelegate)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.sosMap.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func locatonmap(){
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
            sosMap.camera = camera
    //        sosMapView.delegate = (self as! GMSMapViewDelegate)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.sosMap.addSubview(mapView)

            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
        }
    
    
    func setChannelProfile(){
    agoraKit?.setChannelProfile(.liveBroadcasting)
    }
    
    func setClientRole(){
    // Set the client role as "host"
    agoraKit?.setClientRole(.broadcaster)
    // Set the client role as "audience"
   // agoraKit?.setClientRole(.audience)
    }
    
    
    func setupLocalVideo() {
        // Enables the video module
        agoraKit?.enableVideo()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        // Sets the local video view
        agoraKit?.setupLocalVideo(videoCanvas)
        }
    
    @IBAction func switchCamera(_ sender: Any) {
        agoraKit?.switchCamera()
    }
    
    func StartAgoraRecordingApiCall(){
    if  !Reachability.isConnectedToNetwork() {
        Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
            return
    }
        
    let useridtoagora : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
    
    let parameter:[String:String] = [
        "cname": self.channelName ?? "",
        "uid" : useridtoagora,
        "resourceId" : self.resourceIDstr ?? ""
    ]
        
    print("\nThe parameters of AgoraStart : \(parameter)\n")
        
    let activityData = ActivityData()
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

    DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startAgora, dataDict: parameter, { (json) in
                        print(json)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        if json["status"].stringValue == "200" {
                            if let data = json["data"].dictionary{
                                self.resourceIDstr  = data["resourceId"]?.stringValue
                                var reasonStr : String = data["reason"]?.stringValue ?? ""
                                self.sidvalueStr = data["sid"]?.stringValue ?? ""
                              //  let codeStr : Int = data["code"]!.intValue
                                print("PRINT RECORDING",self.resourceIDstr)
                                print("PRINT REASON",reasonStr)
                                print("SIDVALUESHOW",self.sidvalueStr)
                              //  print("PRINT RESOURCEID",codeStr)
//                                let livesteam = liveStreamViewController()
//                                livesteam.modalPresentationStyle = .fullScreen
//                                self.present(livesteam, animated: true, completion: nil)
                            }
                        }else{
                            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                return
                            })
                        }
                    }) { (error) in
                        print(error)
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
    
    }
    
    
    
    let  userid12  =  UserDefaults.standard.object(forKey: "userid") as? Int ?? 0
    func joinChannel(){
            // The uid of each user in the channel must be unique.
        agoraKit?.joinChannel(byToken: "0065d5dd39d0ce547a5a9a3278663b8457aIAD8dgO2lqGEnUr04YzUWV9FMQ9eJiLrGFFJppwYLYOwupLrkDMAAAAAEADK+JrRnu4DYQEAAQCe7gNh", channelId: "Sks@8171", info: nil, uid: UInt(userid12), joinSuccess: { (channel, uid, elapsed) in
                 print("video channel join")
        })
        
        AgoraRtm.kit?.login(
          byToken: nil, user: UserData.name,
          completion: { loginCode in
            if loginCode == .ok {
                
                print(loginCode.rawValue)
                self.createChannel("Sks@8171")
//                self.rtmChannel?.join(
//                completion: self.createChannel("Sks@8171")
//              )
            }else{
                print(loginCode.rawValue)
            }
          }
        )

    }
    

    
    // MARK: Chanel

    func createChannel(_ channel: String) {
        let errorHandle = { [weak self] (action: UIAlertAction) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        guard let rtmChannel = AgoraRtm.kit?.createChannel(withId: channel, delegate: self) else {
            print("join channel fail")
            return
        }
        
        rtmChannel.join { [weak self] (error) in
            if error != .channelErrorOk, let strongSelf = self {
                
                print("join channel error: \(error.rawValue)")
                //strongSelf.showAlert("join channel error: \(error.rawValue)", handler: errorHandle)
            }
        }
        self.rtmChannel = rtmChannel
        self.rtmChannel!.channelDelegate = self
    }
    
    
    func leaveChannel() {
        rtmChannel?.leave { (error) in
            print("leave channel error: \(error.rawValue)")
        }
    }
    
    
    func appendMessage(user: String, content: String) {
        DispatchQueue.main.async { [unowned self] in
            let msg = Message(userId: user, text: content)
            self.list.append(msg)
            if self.list.count > 100 {
                self.list.removeFirst()
            }
            let end = IndexPath(row: self.list.count - 1, section: 0)

            self.listTableView.reloadData()
            self.listTableView.scrollToRow(at: end, at: .bottom, animated: true)
        }
    }
}


extension Double {
    var string: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.roundingMode = .floor
        return formatter.string(for: self) ?? description
    }
}


extension liveStreamViewController: AgoraRtcEngineDelegate{
    // Monitors the didJoinedOfUid callback
    // The SDK triggers the callback when a remote host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        // Sets the remote video view
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}


extension liveStreamViewController: AgoraRtmDelegate,AgoraRtmChannelDelegate{
    
    // MARK: AgoraRtmDelegate
    func channel(_ channel: AgoraRtmChannel, memberJoined member: AgoraRtmMember) {
        DispatchQueue.main.async { [unowned self] in
            //self.showAlert("\(member.userId) join")
        }
    }
    
    func channel(_ channel: AgoraRtmChannel, memberLeft member: AgoraRtmMember) {
        DispatchQueue.main.async { [unowned self] in
           // self.showAlert("\(member.userId) left")
        }
    }
    
    func channel(_ channel: AgoraRtmChannel, messageReceived message: AgoraRtmMessage, from member: AgoraRtmMember) {
        appendMessage(user: member.userId, content: message.text)
    }
}


extension liveStreamViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = nameArray[indexPath.row]
       // let type: CellType = msg.userId == AgoraRtm.current ? .right : .left
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
       // cell.update(type: type, message: msg)
       // cell.msg.text = msg.text
       // cell.name.text = msg.userId
        cell.msg.text = commentArray[indexPath.row]
        cell.name.text = msg

        return cell
    }
}


// MARK: Send Message
private extension liveStreamViewController {
    func send(message: String, type: ChatType) {
        
        print("this is username \(UserData.name)")
        
        let sent = { [unowned self] (state: Int) in
            guard state == 0 else {
                
//                self.showAlert("send \(type.description) message error: \(state)", handler: { (_) in
//                    self.view.endEditing(true)
//                })
                
                print("send \(type.description) message error: \(state)")
                return
            }
            
            guard let current = AgoraRtm.current else {
                self.appendMessage(user: UserData.name, content: message)

                return
            }
            self.appendMessage(user: current, content: message)
        }
        
        let rtmMessage = AgoraRtmMessage(text: message)
        
        switch type {
        case .peer(let name):
            let option = AgoraRtmSendMessageOptions()
            option.enableOfflineMessaging = (AgoraRtm.oneToOneMessageType == .offline ? true : false)
            
            AgoraRtm.kit?.send(rtmMessage, toPeer: name, sendMessageOptions: option, completion: { (error) in
                sent(error.rawValue)
            })
        case .group(_):
            rtmChannel?.send(rtmMessage) { (error) in
                sent(error.rawValue)
            }
        }
    }
}

// drawer view delegate
 extension liveStreamViewController {
    func drawer(_ drawerView: DrawerView, didTransitionTo position: DrawerPosition) {
        if position == .open{
            self.stackView.isHidden = true
            self.rightSideView.isHidden = true

        }else{
            self.stackView.isHidden = false
            self.rightSideView.isHidden = false
        }
    }
    
    //comment
//    func drawerWillBeginDragging(_ drawerView: DrawerView) {
//
//
//        if drawerView.position == .closed{
//            self.stackView.isHidden = true
//            self.rightSideView.isHidden = true
//        }
////        else{
////            self.stackView.isHidden = false
////            self.rightSideView.isHidden = false
////        }
//
//    }
        
//    func drawer(_ drawerView: DrawerView, willTransitionFrom startPosition: DrawerPosition, to targetPosition: DrawerPosition) {
//        print(startPosition.rawValue)
//        
//        if drawerView == ma
//                if targetPosition == .collapsed{
//        
//                    self.stackView.isHidden = false
//                    self.rightSideView.isHidden = false
//        
//                }else{
//                    self.stackView.isHidden = true
//                    self.rightSideView.isHidden = true
//        
//                }
//    }
 }

func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    
}


func randomAlphaNumericString(length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.count)
    var randomString = ""
    
    for _ in 0 ..< length {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
        let newCharacter = allowedChars[randomIndex]
        randomString += String(newCharacter)
    }
    return randomString
}

