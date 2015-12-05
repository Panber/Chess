  //
//  AppDelegate.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let customFont = UIFont(name: "Didot", size: 18.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        
        let customFont2 = UIFont(name: "Didot", size: 11.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont2!], forState: UIControlState.Normal)
        
        let attr = NSDictionary(object: UIFont(name: "Didot", size: 10.0)!, forKey: NSFontAttributeName)
       // UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
        //
        
        return true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("2PsQGHMlwrvTSYb3rUS1kJGiISfjYAK0hzH9sDF8",
            clientKey: "uDXStFAvReKWOdzhcy4taikalkY12OQOaAkS2414")
        
        // Use this to initialize facebook
         PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
//        check if user has logged in before
   //     rememrber to delete at logout
        let userName:String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if userName != nil {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainPage = mainStoryboard.instantiateViewControllerWithIdentifier("Sett")
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainPage

        }
        
        //notifications
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        
        // Register for Push Notitications
        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.
            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let types = UIRemoteNotificationType.Badge.union(UIRemoteNotificationType.Alert).union(UIRemoteNotificationType.Sound)
            application.registerForRemoteNotificationTypes(types)
        }
        
//        // Extract the notification data
//        if let notificationPayload = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
//            
//            // Create a pointer to the Photo object
//            let photoId = notificationPayload["p"] as? NSString
//            let targetPhoto = PFObject(withoutDataWithClassName: "Photo", objectId: photoId)
//            
//            // Fetch photo object
//            targetPhoto.fetchIfNeededInBackgroundWithBlock {
//                (object: PFObject?, error:NSError?) -> Void in
//                if error == nil {
//                    // Show photo view controller
//                    let viewController = PhotoVC(photo: object);
//                    self.navController.pushViewController(viewController, animated: true);
//                }
//            }
//        }
        
        return true
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //notifications
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Store the deviceToken in the current Installation and save it to Parse
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        

        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func application(application: UIApplication,  didReceiveRemoteNotification userInfo: [NSObject : AnyObject],  fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//        
//        if let photoId: String = userInfo["p"] as? String {
//            
//            let targetPhoto = PFObject(withoutDataWithClassName: "Photo", objectId: photoId)
//            targetPhoto.fetchIfNeededInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
//                // Show photo view controller
//                if error != nil {
//                    completionHandler(UIBackgroundFetchResult.Failed)
//                } else if PFUser.currentUser() != nil {
//                    let viewController = PhotoVC(withPhoto: object)
//                    self.navController.pushViewController(viewController, animated: true)
//                    completionHandler(UIBackgroundFetchResult.NewData)
//                } else {
//                    completionHandler(UIBackgroundFetchResult.NoData)
//                }
//            }
//        }
//        handler(UIBackgroundFetchResult.NoData)
//        
//    }
    
    

}

