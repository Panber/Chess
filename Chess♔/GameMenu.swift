//
//  GameMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class GameMenu: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make tab-bar and navigation bar black
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
        self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
        self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)

        


        
//        //Checking if first launch
//        let notFirstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
//        if notFirstLaunch  {
//            print("Not first launch.")
//        }
//        else {
//            print("First launch, setting NSUserDefault.")
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
//            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("firstLaunchVC")
//            self.showViewController(vc as! UIViewController, sender: vc)
//            
//        }
        
        //remove this after a while
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("firstLaunchVC")
                    self.showViewController(vc as! UIViewController, sender: vc)
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        lightOrDarkMode()


    }
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        if darkMode == true {
        

                self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
                self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
                
                self.view.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
                self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
                self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
                
            
        }
        else if darkMode == false {
            
                self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
                self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
                self.navigationController?.navigationBar.tintColor = UIColor.blueColor()


                
        
        }
    
    
    }

}
