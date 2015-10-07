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
    @IBOutlet weak var darkModeLabel: UILabel!
    
    @IBOutlet weak var darkModeCellLabel: UILabel!
    
    @IBOutlet weak var darkPreviewWindow: UIImageView!
    
    @IBOutlet weak var lightPreviewWindow: UIImageView!
    
    
    // MARK: -functions!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true

        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "dark_mode")
        darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
        
        uiLabels += [darkOrLightLabel,darkModeLabel]
        
        setLightMode()
        darkPreviewWindow.alpha = 0
        lightPreviewWindow.alpha = 0
        
        UIView.animateWithDuration(0.8, animations: {
            
            self.lightPreviewWindow.alpha = 1

        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //checking if switch was pressed
    @IBAction func switchPressed(sender: AnyObject) {
        
        if switchOutlet.on {
            
            print("switch is on")
            setDarkMode()
        }
            
        else {
            
            print("switch is off")
            setLightMode()
        }
    }

    //func to shake preview windows to indicate that it is not pressable
    @IBAction func shakeButton(sender: AnyObject) {

        //rememeber to add easter egg with darkside
        
        UIView.animateWithDuration(0.1, animations: {
            
            self.lightPreviewWindow.frame.origin.x -= 10
            self.darkPreviewWindow.frame.origin.x -= 10

            }, completion: { Void in
        
                UIView.animateWithDuration(0.1, animations: {
                    
                    self.lightPreviewWindow.frame.origin.x += 20
                    self.darkPreviewWindow.frame.origin.x += 20
                    
                    }, completion: { Void in
                        
                        UIView.animateWithDuration(0.1, animations: {
                        
                            self.lightPreviewWindow.frame.origin.x -= 10
                            self.darkPreviewWindow.frame.origin.x -= 10
                        
                        })
                })
        })
    }
    
       func setDarkMode() {

        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dark_mode")
        darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
        
            UIView.animateWithDuration(0.8, animations: {
                self.darkPreviewWindow.alpha = 1
                self.lightPreviewWindow.alpha = 0
                
                self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
                self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)

                self.view.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
                self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
                self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
                self.darkModeCellLabel.backgroundColor = UIColor.darkGrayColor()
                
                var i = 0
                for i; i < uiLabels.count; i++ {
                    uiLabels[i].textColor = UIColor.whiteColor()
                }
                var o = 0
                for o; i < uiButtons.count; o++ {
                    uiButtons[o].tintColor = UIColor.whiteColor()
                }
                var p = 0
                for p; i < uiTableViews.count; p++ {
                    uiTableViews[i].backgroundColor = UIColor.blackColor()
                }
                
                
            })

        

        }
    
        func setLightMode() {
            
            
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "dark_mode")
            darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
            
            UIView.animateWithDuration(0.8, animations: {
                self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
                self.tabBarController?.tabBar.tintColor = blue
                self.navigationController?.navigationBar.tintColor = blue
                self.darkModeCellLabel.backgroundColor = UIColor.whiteColor()
                
                self.lightPreviewWindow.alpha = 1
                self.darkPreviewWindow.alpha = 0
                
                var i = 0
                for i; i < uiLabels.count; i++ {
                    uiLabels[i].textColor = UIColor.blackColor()
                }
                var o = 0
                for o; i < uiButtons.count; o++ {
                    uiButtons[o].tintColor = blue
                }
                var p = 0
                for p; i < uiTableViews.count; p++ {
                    uiTableViews[i].backgroundColor = UIColor.whiteColor()
                }

            })

            
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
