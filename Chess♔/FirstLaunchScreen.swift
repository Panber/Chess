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

var uiLabels: Array<UILabel> = []
var uiButtons: Array<UIButton> = []
var uiTableViews: Array<UITableView> = []

class FirstLaunchScreen: UIViewController {

    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var darkOrLightLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "dark_mode")
        darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
        
        uiLabels += [darkOrLightLabel]
        
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
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

            
            var i = 0
            for i; i < uiLabels.count; i++ {
                uiLabels[i].tintColor = UIColor.whiteColor()
            }
            var o = 0
            for o; i < uiButtons.count; o++ {
                uiButtons[o].tintColor = UIColor.whiteColor()
            }
            var p = 0
            for p; i < uiTableViews.count; p++ {
                uiTableViews[i].backgroundColor = UIColor.blackColor()
            }
    
        }
    
        func setLightMode() {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.view.backgroundColor = UIColor.whiteColor()
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
            self.navigationController?.navigationBar.tintColor = UIColor.blueColor()


            var i = 0
            for i; i < uiLabels.count; i++ {
                uiLabels[i].tintColor = UIColor.blackColor()
            }
            var o = 0
            for o; i < uiButtons.count; o++ {
                uiButtons[o].tintColor = UIColor.blueColor()
            }
            var p = 0
            for p; i < uiTableViews.count; p++ {
                uiTableViews[i].backgroundColor = UIColor.whiteColor()
            }
            
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
