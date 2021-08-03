//
//  liveStreamViewController.swift
//  Eithes
//
//  Created by sumit bhardwaj on 27/07/21.
//  Copyright © 2021 Iws. All rights reserved.
//
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
class liveStreamViewController: UIViewController,DrawerViewDelegate {
   // let agoraDelegate = AgoraDelegateExample()
    lazy var list = [Message]()

    @IBOutlet weak var rightSideView: UIView!
    @IBOutlet weak var commentTxtField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var camBtn: UIButton!
    @IBOutlet weak var parallelStreamBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sendComplainBtn: UIButton!
    @IBOutlet weak var complainViewBtn: UIView!
    var drawerRef:  DrawerView!
    var parallelDrawerRef:  DrawerView!

    // Defines localView
    var localView: UIView!
    // Defines remoteView
    var remoteView: UIView!
    
    var agoraKit: AgoraRtcEngineKit?

   // var rtmKit = AgoraRtmKit()
    var rtmChannel : AgoraRtmChannel?
//      appId: "5d5dd39d0ce547a5a9a3278663b8457a",
//      delegate: self()
//    )
    
    
   // MapViewController
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stackView.isHidden = true

        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        // This function initializes the local and remote video views
        initView()
        // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
        setChannelProfile()
        setClientRole()
        setupLocalVideo()
        joinChannel()
        dropShadowToView(view: self.commentView)
        
        
        complainViewBtn.layer.cornerRadius = 18
        let mapDrawerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapDrawerVC.modalPresentationStyle = .fullScreen
        let mapDrawer = self.addDrawerView(withViewController: mapDrawerVC)
        self.view.bringSubviewToFront(mapDrawer)
        mapDrawer.snapPositions = [.collapsed, .open]
        mapDrawer.collapsedHeight = 50
        mapDrawer.topMargin = 170
        print(mapDrawer.topMargin)
        mapDrawer.insetAdjustmentBehavior = .automatic
        mapDrawer.delegate = self
        
        let DriverDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FileAcomplaitView") as! FileAcomplaitView
        DriverDetailsVC.modalPresentationStyle = .fullScreen
        let drawer = self.addDrawerView(withViewController: DriverDetailsVC)
        //drawer.delegate = drawerContentVC;
       // drawer.collapsedHeight = 300//268
        drawer.snapPositions = [.closed, .open]

        //drawer.collapsedHeight = 235
        drawer.topMargin = 170

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
        ParallelStream.topMargin = 170
        
        ParallelStream.setPosition(.closed, animated: true)
        print(mapDrawer.topMargin)
        ParallelStream.insetAdjustmentBehavior = .automatic
        ParallelStream.delegate = self
        parallelDrawerRef = ParallelStream

        
     }
    
    @IBAction func fileAcomplainBnt(_ sender: UIButton) {
        self.stackView.isHidden = true
        self.rightSideView.isHidden = true

        drawerRef.setPosition(.open, animated: true)
        
    }
    
    @IBAction func parallelStreamDidSelect(_ sender: Any) {
        self.stackView.isHidden = true
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
        //self.view.addSubview(viewShadow)
    }
    
    // Sets the video view layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
        self.view.bringSubviewToFront(self.tableView)
        self.view.bringSubviewToFront(self.stackView)
        self.view.bringSubviewToFront(self.camBtn)
        self.view.bringSubviewToFront(self.complainViewBtn)
        self.view.bringSubviewToFront(self.parallelStreamBtn)
        self.view.bringSubviewToFront(self.rightSideView)


 
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
           agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "5d5dd39d0ce547a5a9a3278663b8457a", delegate: self)
       // self.rtmKit = AgoraRtmKit(appId: "0d75d880cc134f51a07561b0aa8671fa", delegate: self)!

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
    
    
    func joinChannel(){
            // The uid of each user in the channel must be unique.
            agoraKit?.joinChannel(byToken: "0065d5dd39d0ce547a5a9a3278663b8457aIAD8dgO2lqGEnUr04YzUWV9FMQ9eJiLrGFFJppwYLYOwupLrkDMAAAAAEADK+JrRnu4DYQEAAQCe7gNh", channelId: "Sks@8171", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
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

            self.tableView.reloadData()
            self.tableView.scrollToRow(at: end, at: .bottom, animated: true)
        }
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
 extension liveStreamViewController {

}

extension liveStreamViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = list[indexPath.row]
       // let type: CellType = msg.userId == AgoraRtm.current ? .right : .left
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
       // cell.update(type: type, message: msg)
        cell.msg.text = msg.text
        cell.name.text = msg.userId

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
    
    //commet
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
//        
//        
//        
//                if targetPosition == .collapsed{
//        
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
