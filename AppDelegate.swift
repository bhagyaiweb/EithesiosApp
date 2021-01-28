//  AppDelegate.swift
//  Eithes
//  Created by Shubham Tomar on 18/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//AIzaSyCnUk9KJ0UP0DK01PXDkmaLDcpz2ikH68Y
//Api key: for twiter
//dy85rjHZQovZDsBnmg0E86mf9
//Apisecreatkey
//79Cn7IFqBrcjK7Eay2sjiNfLCbRfuiGdsVU5ogs1VafvEXQUyq
//https://www.linkedin.com/developers/apps/verification/4967b4f6-9ae3-44f9-9beb-61a43b72bad7

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces 
import FacebookCore
import Swifter
@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
         IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enableDebugging = true

        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
        GMSServices.provideAPIKey("AIzaSyCnUk9KJ0UP0DK01PXDkmaLDcpz2ikH68Y")
        GMSPlacesClient.provideAPIKey("AIzaSyCnUk9KJ0UP0DK01PXDkmaLDcpz2ikH68Y")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let callbackUrl = URL(string: TwitterConstants.CALLBACK_URL){
            Swifter.handleOpenURL(url, callbackURL: callbackUrl)
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>)
    {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}

 
