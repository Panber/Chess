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
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("hadtED3WDzRnxyboadNlGaBCQQjx569EhHzLs5Fm",
            clientKey: "iMCLxq9tBCaXHkCYBts5xn94qAgobzDY0Gk68iNr")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        let userName:String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if userName != nil {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainPage = mainStoryboard.instantiateViewControllerWithIdentifier("Sett")
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainPage
        
//            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Sett")
//            self.showViewController(vc as! UIViewController, sender: vc)
            
            
        }
        
        
        return true
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

