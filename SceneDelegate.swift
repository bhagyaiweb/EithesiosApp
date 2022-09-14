//
//  SceneDelegate.swift
//  Eithes
//
//  Created by Shubham Tomar on 18/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//

import UIKit
import Swifter
import FBSDKCoreKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging


class SceneDelegate: UIResponder, UIWindowSceneDelegate, MessagingDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let gcmMessageIDKey = "gcm.Message_ID"
  //  let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate).window
    
    // SceneDelegate.swift
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
        
        let callbackUrl = URL(string: TwitterConstants.CALLBACK_URL)!
        Swifter.handleOpenURL(url, callbackURL: callbackUrl)
    }
    
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = vc
        // add animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)

    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
      //  _ = UIStoryboard(name: "Main", bundle: nil)
       // _ = liveStreamViewController()
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            //user is already logged in just navigate him to home screen
                                         print("Login")
            let homeVc = self.storyboard.instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
            window?.rootViewController = homeVc
          //  self.present(homeVc, animated: true, completion: nil)
           // self.navigationController?.pushViewController(homeVc, animated: false)
        }else{
            let loginVc = self.storyboard.instantiateViewController(withIdentifier: "OnboardingPagevVewVC") as! OnboardingPagevVewVC
            window?.rootViewController = loginVc
           // self.present(loginVc, animated: true, completion: nil)
       // self.navigationController?.pushViewController(loginVc, animated: false)
            
        }
        //let vc = storyBord.instantiateViewController(identifier: "SumbitVideoVC")
        //UIApplication.shared.windows.first?.rootViewController = vc
       // UIApplication.shared.windows.first?.makeKeyAndVisible()
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
//    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//        guard let context = URLContexts.first else { return }
//        let callbackUrl = URL(string: TwitterConstants.CALLBACK_URL)!
//        Swifter.handleOpenURL(context.url, callbackURL: callbackUrl)
//    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
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
extension SceneDelegate: UNUserNotificationCenterDelegate {
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
    print("USERINFOSCENE",userInfo)
      
      // Redirecting to another scrreen once click on  notification //
    //  let JoinVc = self.storyboard.instantiateViewController(withIdentifier: "JoininBroadcastVC") as! JoininBroadcastVC
     // window?.rootViewController = JoinVc
      let presentViewController = storyboard.instantiateViewController(withIdentifier: "JoininBroadcastVC") as? JoininBroadcastVC
      print("JOINNOTIFY")
      self.window?.rootViewController = presentViewController
      window?.makeKeyAndVisible()
      //presentViewController?.present(presentViewController!, animated: true, completion: nil)
      completionHandler()

  }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
       Messaging.messaging().appDidReceiveMessage(userInfo)
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


