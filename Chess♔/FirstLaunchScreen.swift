//
//  FirstLaunchScreen.swift
//  Chess♔
//
//  Created by Johannes Berge on 19/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var darkMode = Bool()


class FirstLaunchScreen: UIViewController {

    @IBOutlet weak var switchOutlet: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "dark_mode")
        darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchPressed(sender: AnyObject) {
        if switchOutlet.on {
            print("switch is on")
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dark_mode")
            darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
            
            setDarkMode()
            
        }
        else {
            print("switch is off")
            
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "dark_mode")
            darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
            
            setLightMode()
            
        }
        
    }
    
        func setDarkMode() {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.view.backgroundColor = UIColor.darkGrayColor()
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()

    
        }
    
        func setLightMode() {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.view.backgroundColor = UIColor.whiteColor()
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = UIColor.blueColor()

            
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
