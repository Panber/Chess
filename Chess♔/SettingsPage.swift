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
    let everyoneSwitch = UISwitch()
    let darkModeSwitch = UISwitch()
    
    
    var label = UILabel()
    var bc1 = UILabel()
    var bc2 = UILabel()
    
    
    
    var label1 = UILabel()
    var friendsOnlyText = UILabel()
    var label3 = UILabel()
    var label2 = UILabel()
    var comment1 = UILabel()
    var comment2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
self.title = "Settings"
        // Do any additional setup after loading the view.
        //setting scrollview
        view.frame.size.height = 1000
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.frame.size.height = screenHeight
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.scrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        
        lightOrDarkMode()
    }
    
    override func viewWillAppear(animated: Bool) {
        setUpSettings()
        
        if NSUserDefaults.standardUserDefaults().boolForKey("dark_mode") == true {
            darkModeSwitch.setOn(true, animated: false)
        
        }
        else {
            darkModeSwitch.setOn(false, animated: false)
        
        }
        
        if NSUserDefaults.standardUserDefaults().boolForKey("numbered_board") == true {
            submitSwitch.setOn(true, animated: false)
            
        }
        else {
            submitSwitch.setOn(false, animated: false)
            
        }

        
        if PFUser.currentUser()!.objectForKey("request_everyone") as? Bool == true {
            print(PFUser.currentUser()!.objectForKey("request_everyone") as? Bool)
            everyoneSwitch.setOn(true, animated: false)
        }
        else {
            everyoneSwitch.setOn(false, animated: false)
        }
        
        lightOrDarkMode()

        
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
        
        label = UILabel(frame: CGRectMake(0, 45, screenWidth, 45*2))
        label.text = ""
        label.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label)
        
        //adding Receive notifications: label
        label1 = UILabel(frame: CGRectMake(20, 45, screenWidth, 45))
        label1.textAlignment = NSTextAlignment.Left
        label1.text = "Receive notifications"
        label1.font = UIFont(name: "Times", size: 16)
        if darkMode { label1.textColor = UIColor.whiteColor() }
        else { label1.textColor = UIColor.blackColor() }
        scrollView.addSubview(label1)
        
        //adding freindsonly button: label
        friendsOnlyText = UILabel(frame: CGRectMake(20, 45 + 45, screenWidth, 45))
        friendsOnlyText.textAlignment = NSTextAlignment.Left
        friendsOnlyText.text = "Game Request From Everyone"
        friendsOnlyText.font = UIFont(name: "Times", size: 16)
        if darkMode { friendsOnlyText.textColor = UIColor.whiteColor() }
        else { friendsOnlyText.textColor = UIColor.blackColor() }
        scrollView.addSubview(friendsOnlyText)

        bc1 = UILabel(frame: CGRectMake(0, label.frame.origin.y + label.frame.size.height + 45, screenWidth, 45*2))
        bc1.text = ""
        bc1.backgroundColor = UIColor.whiteColor()
        bc1.userInteractionEnabled = true
        scrollView.addSubview(bc1)
        
        //adding Submit button: label
        label3 = UILabel(frame: CGRectMake(20, 45, screenWidth, 45))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Numbered Board"
        label3.font = UIFont(name: "Times", size: 16)
        if darkMode { label3.textColor = UIColor.whiteColor() }
        else { label3.textColor = UIColor.blackColor() }
        bc1.addSubview(label3)
        

        
        //adding Dark mode: label
        label2 = UILabel(frame: CGRectMake(20, 0, screenWidth, 45))
        label2.textAlignment = NSTextAlignment.Left
        label2.text = "Dark mode"
        label2.font = UIFont(name: "Times", size: 16)
        if darkMode { label2.textColor = UIColor.whiteColor() }
        else { label2.textColor = UIColor.blackColor() }
        bc1.addSubview(label2)
        

        

        
        bc2 = UILabel(frame: CGRectMake(0, bc1.frame.origin.y + bc1.frame.size.height + 60, screenWidth, 45))
        bc2.text = ""
        bc2.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(bc2)
        
        //logOutButton
        logOutButton.setTitle("Log Out", forState: .Normal)
        logOutButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        logOutButton.setTitleColor(red, forState: .Normal)
        logOutButton.layer.borderColor = blue.CGColor
        //logOutButton.frame.origin.x = 10
        logOutButton.frame.origin.y
            =  bc1.frame.origin.y + bc1.frame.size.height + 60
        logOutButton.frame.size.height = 45
        logOutButton.frame.size.width = screenWidth
        logOutButton.userInteractionEnabled = true
        logOutButton.addTarget(self, action: "logOutPressed:", forControlEvents: .TouchUpInside)
        logOutButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        scrollView.addSubview(logOutButton)
        
        
        //adding seperator1: label
        let label4 = UILabel(frame: CGRectMake(0, 45, screenWidth, 0.2))
        if darkMode { label4.backgroundColor = UIColor.lightGrayColor() }
        else { label4.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label4)
        
        //adding seperator2: label
        let label5 = UILabel(frame: CGRectMake(20, 45 + 45, screenWidth, 0.2))
        if darkMode { label5.backgroundColor = UIColor.lightGrayColor() }
        else { label5.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label5)
        
        //adding seperator1: label
        let label6 = UILabel(frame: CGRectMake(0, 45 + 45 + 45 , screenWidth, 0.2))
        if darkMode { label6.backgroundColor = UIColor.lightGrayColor() }
        else { label6.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label6)
        
        //adding seperator1: label
        let label7 = UILabel(frame: CGRectMake(0, 0, screenWidth, 0.2))
        if darkMode { label7.backgroundColor = UIColor.lightGrayColor() }
        else { label7.backgroundColor = UIColor.lightGrayColor() }
        bc1.addSubview(label7)
        
        //adding seperator1: label
        let label8 = UILabel(frame: CGRectMake(20, 45, screenWidth, 0.2))
        if darkMode { label8.backgroundColor = UIColor.lightGrayColor() }
        else { label8.backgroundColor = UIColor.lightGrayColor() }
        bc1.addSubview(label8)
        
        //adding seperator1: label
        let label9 = UILabel(frame: CGRectMake(0, 45 + 45, screenWidth, 0.2))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        bc1.addSubview(label9)
        
        //adding seperator1: label
        let label10 = UILabel(frame: CGRectMake(0, 0, screenWidth, 0.2))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        bc2.addSubview(label10)
        
        //adding seperator1: label
        let label11 = UILabel(frame: CGRectMake(0, 45, screenWidth, 0.2))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        bc2.addSubview(label11)
        
        notificationsSwitch.setOn(true, animated: false)
        notificationsSwitch.onTintColor = blue
        notificationsSwitch.tintColor = UIColor(red:0.93, green:0.92, blue:0.92, alpha:1.0)
        notificationsSwitch.frame = CGRectMake(screenWidth - 65, label1.frame.origin.y + 7, 0, 0)
        notificationsSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        notificationsSwitch.addTarget(self, action: "notificationsSwitchValueDidChange:", forControlEvents: .ValueChanged)
        scrollView.addSubview(notificationsSwitch)
        
        darkModeSwitch.setOn(false, animated: false)
        darkModeSwitch.onTintColor = blue
        darkModeSwitch.tintColor = UIColor(red:0.93, green:0.92, blue:0.92, alpha:1.0)
        darkModeSwitch.frame = CGRectMake(screenWidth - 65, label2.frame.origin.y + 7, 0, 0)
        darkModeSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        darkModeSwitch.addTarget(self, action: "darkmodeSwitchValueDidChange:", forControlEvents: .ValueChanged)
        bc1.addSubview(darkModeSwitch)
        
        submitSwitch.setOn(true, animated: false)
        submitSwitch.onTintColor = blue
        submitSwitch.tintColor = UIColor(red:0.93, green:0.92, blue:0.92, alpha:1.0)
        submitSwitch.frame = CGRectMake(screenWidth - 65,label3.frame.origin.y + 7, 0, 0)
        submitSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        submitSwitch.addTarget(self, action: "submitSwitchValueDidChange:", forControlEvents: .ValueChanged)
        bc1.addSubview(submitSwitch)
        
        everyoneSwitch.setOn(true, animated: false)
        everyoneSwitch.onTintColor = blue
        everyoneSwitch.tintColor = UIColor(red:0.93, green:0.92, blue:0.92, alpha:1.0)
        everyoneSwitch.frame = CGRectMake(screenWidth - 65, friendsOnlyText.frame.origin.y + 7, 0, 0)
        everyoneSwitch.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        everyoneSwitch.addTarget(self, action: "everyoneSwitchValueDidChange:", forControlEvents: .ValueChanged)
        scrollView.addSubview(everyoneSwitch)
        
        //adding comment: label
        comment1 = UILabel(frame: CGRectMake(10, 20, screenWidth, 25))
        comment1.textAlignment = NSTextAlignment.Left
        comment1.text = "General"
        comment1.font = UIFont(name: "Times-Italic", size: 16)
        if darkMode { comment1.textColor = UIColor.lightTextColor() }
        else { comment1.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(comment1)
        
        //adding comment: label
        comment2 = UILabel(frame: CGRectMake(10, bc1.frame.origin.y - 25, screenWidth, 25))
        comment2.textAlignment = NSTextAlignment.Left
        comment2.text = "User Interface"
        comment2.font = UIFont(name: "Times-Italic", size: 16)
        if darkMode { comment2.textColor = UIColor.lightTextColor() }
        else { comment2.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(comment2)
        
        
    }
    
    func notificationsSwitchValueDidChange(sender:UISwitch!)
    {
        if (sender.on == true){
        }
        else{
        }
    }
    
    func darkmodeSwitchValueDidChange(sender:UISwitch!)
    {
        if (sender.on == true){
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "dark_mode")
            darkMode = true
            lightOrDarkMode()
        }
        else{
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "dark_mode")
            darkMode = false
            lightOrDarkMode()

        }
    }
    
    func everyoneSwitchValueDidChange(sender:UISwitch!)
    {
        if (sender.on == true){
            PFUser.currentUser()?.setObject(true, forKey: "request_everyone")
            PFUser.currentUser()?.saveInBackground()
        }
        else{
            PFUser.currentUser()?.setObject(false, forKey: "request_everyone")
            PFUser.currentUser()?.saveInBackground()
        }
    }
    
    func submitSwitchValueDidChange(sender:UISwitch!)
    {
        if (sender.on == true){
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "numbered_board")
        }
        else{
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "numbered_board")

        }
    }
     
    func logOutPressed(sender: UIButton!) {
        

        
        PFUser.currentUser()?.setObject(false, forKey: "isLoggedIn")
        PFUser.currentUser()?.setObject(false, forKey: "isLoggedIn")
        PFUser.currentUser()!.save()
        
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            
            let signInPage:SignUpMenu = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginMenu") as! SignUpMenu
            
            let signInPageNav = UINavigationController(rootViewController: signInPage)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = signInPageNav
        }
        
    }
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        checkInternetConnection()

        if darkMode == true {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            
            self.view.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            
            
            visualEffectView.effect = UIBlurEffect(style: .Dark)
            
            
            label.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            bc1.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            bc2.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)


             label1.textColor = UIColor.whiteColor()
             friendsOnlyText.textColor = UIColor.whiteColor()
             label3.textColor = UIColor.whiteColor()
             label2.textColor = UIColor.whiteColor()
             comment1.textColor = UIColor.lightTextColor()
             comment2.textColor = UIColor.lightTextColor()
            
            
            self.scrollView.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
            

            UIApplication.sharedApplication().statusBarStyle = .LightContent

            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            
            
            label.backgroundColor = UIColor.whiteColor()
            bc1.backgroundColor = UIColor.whiteColor()
            bc2.backgroundColor = UIColor.whiteColor()
            
            
            label1.textColor = UIColor.blackColor()
            friendsOnlyText.textColor = UIColor.blackColor()
            label3.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            comment1.textColor = UIColor.lightGrayColor()
            comment2.textColor = UIColor.lightGrayColor()
            
            self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()

            UIApplication.sharedApplication().statusBarStyle = .Default

        }
        
        
    }
    
}
