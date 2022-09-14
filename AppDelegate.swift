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
import FBSDKCoreKit
import Swifter
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    let gcmMessageIDKey = "gcm.Message_ID"
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        self.registerForFirebaseNotification(application: application)
        Messaging.messaging().delegate = self
        if #available(iOS 12.3, *) {
             UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            }
         application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        Thread.sleep(forTimeInterval: 2.0)
         IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enableDebugging = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        GMSServices.provideAPIKey("AIzaSyCnUk9KJ0UP0DK01PXDkmaLDcpz2ikH68Y")
        GMSPlacesClient.provideAPIKey("AIzaSyCnUk9KJ0UP0DK01PXDkmaLDcpz2ikH68Y")
        if (launchOptions?[.remoteNotification]) != nil {
            let presentViewController = storyboard.instantiateViewController(withIdentifier: "JoininBroadcastVC") as! JoininBroadcastVC
            self.window?.rootViewController = presentViewController
            presentViewController.present(presentViewController, animated: true, completion: nil)
        }
        
        // presentViewController.present(presentViewController, animated: true, completion: nil)
               // Use this data to present a view controller based
               // on the type of notification received
//        if #available(iOS 12.3, *) {
//          // For iOS 10 display notification (sent via APNS)
//          UNUserNotificationCenter.current().delegate = self
//
//          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//          UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: { _, _ in }
//          )
//        } else {
//          let settings: UIUserNotificationSettings =
//            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//          application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()
    //    Messaging.messaging().delegate = self
       
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }
        
//        func application(
//             _ app: UIApplication,
//             open url: URL,
//             options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//         ) -> Bool {
//             ApplicationDelegate.shared.application(
//                 app,
//                 open: url,
//                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                 annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//             )
//
//            let callbackUrl = URL(string: TwitterConstants.CALLBACK_URL)!
//                    Swifter.handleOpenURL(url, callbackURL: callbackUrl)
//            return true
//         }
        
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        
//        if let callbackUrl = URL(string: TwitterConstants.CALLBACK_URL){
//            Swifter.handleOpenURL(url, callbackURL: callbackUrl)
//        }
//        return true
//    }

    
    
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
    
    func registerForFirebaseNotification(application: UIApplication) {
            if #available(iOS 10.0, *) {
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self

                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }

            application.registerForRemoteNotifications()
        }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print full message.
    print(userInfo)
    // Change this to your preferred presentation option
    return [.alert, .sound]
  }

    
func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
     Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print("USERINFO",userInfo)
      
      // Redirecting to another scrreen once click on  notification //
      let JoinVc = self.storyboard.instantiateViewController(withIdentifier: "JoininBroadcastVC") as! JoininBroadcastVC
     window?.rootViewController = JoinVc
//            print("JOINNOTIFY")
      UIApplication.shared.windows.first?.rootViewController?.present(JoinVc, animated: false, completion: nil)
      completionHandler()
  }
    
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
          print("APNs received with: \(userInfo)")
      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }

}


extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}


