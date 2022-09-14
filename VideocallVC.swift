//
//  VideocallVC.swift
//  Eithes
//
//  Created by Admin on 14/03/22.
//  Copyright © 2022 Iws. All rights reserved.
//

import UIKit
import AgoraRtcKit


class VideocallVC: UIViewController {
    
    var localView: UIView!
      var remoteView: UIView!
      // Add this linke to add the agoraKit variable
      var agoraKit: AgoraRtcEngineKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       initView()
       initializeAndJoinChannel()
    }
    
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           remoteView.frame = self.view.bounds
           localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
       }
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           agoraKit?.leaveChannel(nil)
           AgoraRtcEngineKit.destroy()
     }

       func initView() {
           remoteView = UIView()
           self.view.addSubview(remoteView)
           localView = UIView()
           self.view.addSubview(localView)
       }
    
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
      agoraKit?.joinChannel(byToken: "Your token", channelId: "Channel name", info: nil, uid: 0, joinSuccess: { (channel, uid, elapsed) in
        print("UID",uid)
           })
       }
}
extension VideocallVC: AgoraRtcEngineDelegate {
    // This callback is triggered when a remote user joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}
