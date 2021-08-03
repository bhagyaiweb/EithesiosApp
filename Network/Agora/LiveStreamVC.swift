//
//  LiveStreamVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 16/07/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit
import AgoraRtcKit

class LiveStreamVC: UIViewController {

   // var agoraKit: AgoraRtcEngineKit?

    
    
    lazy var agoraKit: AgoraRtcEngineKit = {
        let engine = AgoraRtcEngineKit.sharedEngine(
            withAppId: "5d5dd39d0ce547a5a9a3278663b8457a",
            delegate: self
        )
        engine.setChannelProfile(.liveBroadcasting)
        engine.setClientRole(.audience)
        return engine
    }()
    
    // Defines localView
    var localView: UIView!
    // Defines remoteView
    var remoteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This function initializes the local and remote video views
        initView()
        // The following functions are used when calling Agora APIs
       // initializeAgoraEngine()
       // setChannelProfile()
       // setClientRole()
        setupLocalVideo()
        joinChannel()
        // Do any additional setup after loading the view.
    }

    // Sets the video view layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
        self.remoteView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }
    
//    func initializeAgoraEngine() {
//           agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "5d5dd39d0ce547a5a9a3278663b8457a", delegate: self)
//        }
    
//    func setChannelProfile(){
//    agoraKit?.setChannelProfile(.liveBroadcasting)
//    }
    
    
//    func setClientRole(){
//    // Set the client role as "host"
//    agoraKit?.setClientRole(.broadcaster)
//    // Set the client role as "audience"
//    agoraKit?.setClientRole(.audience)
////        let options: AgoraClientRoleOptions = AgoraClientRoleOptions()
////        options.audienceLatencyLevel = AgoraAudienceLatencyLevelType.lowLatency
////        agoraKit?.setClientRole(.audience, options: options)
//    }
   
    func setupLocalVideo() {
        // Enables the video module
        agoraKit.enableVideo()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        // Sets the local video view
        agoraKit.setupLocalVideo(videoCanvas)
        }
    
    func joinChannel(){
            // The uid of each user in the channel must be unique.
        
        self.agoraKit.enableVideo()
        agoraKit.joinChannel(byToken: "0065d5dd39d0ce547a5a9a3278663b8457aIAD8C1Jn5gpY8/p+HB2C9CpJ7hnXAUrYCyn3HZ3jHhLw+VzZdDsAAAAAEAAApPzouQX0YAEAAQC5BfRg", channelId: "bhardwaj", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
        })
    }
    
    
    
    func initView() {
        // Initializes the remote video view. This view displays video when a remote host joins the channel
        remoteView = UIView()
        remoteView.backgroundColor = .purple
        self.view.addSubview(remoteView)
        // Initializes the local video view. This view displays video when the local user is a host
        localView = UIView()
        localView.backgroundColor = .red
        self.view.addSubview(localView)
    }

}

extension LiveStreamVC: AgoraRtcEngineDelegate {
    // Monitors the didJoinedOfUid callback
    // The SDK triggers the callback when a remote host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        // Sets the remote video view
        agoraKit.setupRemoteVideo(videoCanvas)
    }
}
