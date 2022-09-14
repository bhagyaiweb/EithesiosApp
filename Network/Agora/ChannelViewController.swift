//
//  ChannelViewController.swift
//  Agora-iOS-Example
//
//  Created by Max Cobb on 12/10/2020.
//  Copyright © 2020 Max Cobb. All rights reserved.
//

import UIKit
import AgoraRtcKit

class ChannelViewController: UIViewController {

    static let channelName: String = "sumitTest"
    static let appId: String = "a6e3170384984816bf987ddd4aad3029"

    /// Static token here, but can be dynamic if calling `joinChannelWithFetch` instead of `joinChannel`
    /// `joinChannelWithFetch` is found in AgoraToken.swift
    /// Set to nil for no token required, or empty string to trigger a fetch from tokenBaseURL
    static var channelToken: String? = "0065d5dd39d0ce547a5a9a3278663b8457aIADlUYSd7Yl65bpTP9DlFhsvFEMutZbY6ZEl8zEulM1zZ9xPVlsAAAAAEAD7XOPUMwMBYQEAAQAzAwFh"

    static var tokenBaseURL: String? = ""

    /// Setting to zero will tell Agora to assign one for you
    lazy var userID: UInt = 174

    var userRole: AgoraClientRole = .audience

    lazy var agkit: AgoraRtcEngineKit = {
        let engine = AgoraRtcEngineKit.sharedEngine(
            withAppId: ChannelViewController.appId,
            delegate: self
        )
        engine.setChannelProfile(.liveBroadcasting)
        engine.setClientRole(self.userRole)
        return engine
    }()

    var hostButton: UIButton?
    var closeButton: UIButton?

    var controlContainer: UIView?
    var camButton: UIButton?
    var micButton: UIButton?
    var flipButton: UIButton?
    var beautyButton: UIButton?

    var beautyOptions: AgoraBeautyOptions = {
        let bOpt = AgoraBeautyOptions()
        bOpt.smoothnessLevel = 1
        bOpt.rednessLevel = 0.1
        return bOpt
    }()

    var agoraVideoHolder = UIView()

    var remoteUserIDs: Set<UInt> = []
    var userVideoLookup: [UInt: AgoraRtcVideoCanvas] = [:] {
        didSet {
            reorganiseVideos()
        }
    }

    /// Local video UIView, used only when broadcasting
    lazy var localVideoView: UIView = {
        let vview = UIView()
        return vview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.agoraVideoHolder)
        self.agoraVideoHolder.frame = self.view.bounds
        self.agoraVideoHolder.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if ChannelViewController.channelToken != nil {
            // Fetch token if our current one is empty
            //self.joinChannelWithFetch()
            self.joinChannel()

        } else {
            self.joinChannel()
        }
    }

    
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




















