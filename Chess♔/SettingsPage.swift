//
//  SettingsPage.swift
//  Chess♔
//
//  Created by Alexander Panayotov on 08/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class SettingsPage: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var contentView = UIView()
    
    let notificationsButton = UILabel()
    let gameSoundsButton = UILabel()
    let darkModeButton = UILabel()
    
    let logOutButton = UIButton()
    
    let notificationsSwitch = UISwitch()
    let gameSoundsSwitch = UISwitch()
    let submitSwitch = UISwitch()
    let darkModeSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //setting scrollview
        view.frame.size.height = 1000
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.frame.size.height = screenHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.scrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        lightOrDarkMode()
    }
    
    override func viewWillAppear(animated: Bool) {
        setUpSettings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpSettings() {
        
        view.addSubview(scrollView)
        //creating the view
        //        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        //
        //        //creating the view
        //        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        //        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        //        else { contentView.backgroundColor = UIColor.whiteColor() }
        //        contentView.clipsToBounds = true
        //        scrollView.addSubview(contentView)
        
        let label = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25, screenWidth, 45*4))
        label.text = ""
        label.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label)
        
        //adding Receive notifications: label
        let label1 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25, screenWidth, 45))
        label1.textAlignment = NSTextAlignment.Left
        label1.text = "Receive notifications"
        label1.font = UIFont(name: "Didot", size: 16)
        if darkMode { label1.textColor = UIColor.lightTextColor() }
        else { label1.textColor = UIColor.grayColor() }
        scrollView.addSubview(label1)
        
        //adding Dark mode: label
        let label2 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25 + 45, screenWidth, 45))
        label2.textAlignment = NSTextAlignment.Left
        label2.text = "Dark mode"
        label2.font = UIFont(name: "Didot", size: 16)
        if darkMode { label2.textColor = UIColor.lightTextColor() }
        else { label2.textColor = UIColor.grayColor() }
        scrollView.addSubview(label2)
        
        //adding Submit button: label
        let label3 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25 + 45 + 45, screenWidth, 45))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Submit button"
        label3.font = UIFont(name: "Didot", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.grayColor() }
        scrollView.addSubview(label3)
        
        //logOutButton
        logOutButton.setTitle("Log Out", forState: .Normal)
        logOutButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        logOutButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        logOutButton.layer.borderColor = blue.CGColor
        //logOutButton.frame.origin.x = 10
        logOutButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25 + 45 + 45 + 45
        logOutButton.frame.size.height = 45
        logOutButton.frame.size.width = screenWidth
        logOutButton.userInteractionEnabled = true
        logOutButton.addTarget(self, action: "logOutPressed:", forControlEvents: .TouchUpInside)
        logOutButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        scrollView.addSubview(logOutButton)
        
        
        //adding seperator1: label
        let label4 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25 + 45, screenWidth, 0.5))
        if darkMode { label4.backgroundColor = UIColor.lightGrayColor() }
        else { label4.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label4)
        
        //adding seperator2: label
        let label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25 + 45 + 45, screenWidth, 0.5))
        if darkMode { label5.backgroundColor = UIColor.lightGrayColor() }
        else { label5.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label5)
        
        //adding seperator1: label
        let label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 25 + 45 + 45 + 45 , screenWidth, 0.5))
        if darkMode { label6.backgroundColor = UIColor.lightGrayColor() }
        else { label6.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label6)
        
        notificationsSwitch.setOn(true, animated: true)
        notificationsSwitch.onTintColor = UIColor(red: 44/225, green: 84/225, blue: 184/225, alpha: 1)
        notificationsSwitch.tintColor = UIColor(red: 44/225, green: 84/225, blue: 184/225, alpha: 1)
        notificationsSwitch.frame = CGRectMake(screenWidth - 65, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 35, 0, 0)
        notificationsSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        scrollView.addSubview(notificationsSwitch)
        
        darkModeSwitch.setOn(false, animated: true)
        darkModeSwitch.onTintColor = UIColor(red: 44/225, green: 84/225, blue: 184/225, alpha: 1)
        darkModeSwitch.tintColor = UIColor(red: 44/225, green: 84/225, blue: 184/225, alpha: 1)
        darkModeSwitch.frame = CGRectMake(screenWidth - 65, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 35 + 45, 0, 0)
        darkModeSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        scrollView.addSubview(darkModeSwitch)
        
        submitSwitch.setOn(true, animated: true)
        submitSwitch.onTintColor = UIColor(red: 44/225, green: 84/225, blue: 184/225, alpha: 1)
        submitSwitch.tintColor = UIColor(red: 44/225, green: 84/225, blue: 184/225, alpha: 1)
        submitSwitch.frame = CGRectMake(screenWidth - 65, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 25 + 35 + 45 + 45, 0, 0)
        submitSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        scrollView.addSubview(submitSwitch)
        
        
    }
    
    func logOutPressed(sender: UIButton!) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            
            let signInPage:SignUpMenu = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginMenu") as! SignUpMenu
            
            let signInPageNav = UINavigationController(rootViewController: signInPage)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = signInPageNav
        }
        
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
            self.scrollView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            
            
        }
        
        
    }
    
}
