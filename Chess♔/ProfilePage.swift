//
//  ProfilePage.swift
//  Chess♔
//
//  Created by Johannes Berge on 07/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//
//mk

import UIKit
import Parse

class ProfilePage: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var profilePicBlur = UIImageView()
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    let friendsButton = UIButton()
    let friendRequestsButton = UIButton()
    let settingsButton = UIButton()
    var label0 = UILabel()
    var label2 = UILabel()
    var label12 = UILabel()
    var label13 = UILabel()
    var label14 = UILabel()
    var label15 = UILabel()
    
    
    
    
    var userRating = String()
    var userWon = String()
    var userDrawn = String()
    var userLost = String()
    var userJoined = NSDate()
    
    
    override func viewWillAppear(animated: Bool) {
          setUpProfile()
        //loadUserInfoFromCloud()
    }
    override func viewDidDisappear(animated: Bool) {
        removeProfile()

    }
    override func viewWillDisappear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = PFUser.currentUser()?.username
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
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
    
    func loadUserInfoFromCloud () {
        
        let usersQuery = PFQuery(className: "_User")
        usersQuery.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        usersQuery.findObjectsInBackgroundWithBlock { (users:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                
                for users in users as! [PFObject] {
                    //remember to assign them these values in advance!!!
                    self.userRating = users["rating"] as! String
                    self.userWon = users["won"] as! String
                    self.userDrawn = users["drawn"] as! String
                    self.userLost = users["lost"] as! String
                    
                    //setting labels
                    self.label12.text = self.userWon
                    self.label13.text = self.userDrawn
                    self.label14.text = self.userLost
                    self.label15.text = self.userRating
                    self.label2.text = "Rating: \(self.userRating)"
                    
                    
                    
                }
            }
                
            else {}
        }
        
        
    }
    
    func setUpProfile () {
        
        loadUserInfoFromCloud()
        
        
        
        
        view.addSubview(scrollView)
        //creating the view
        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        
        label0 = UILabel(frame: CGRectMake(0, 63 + contentView.frame.size.height - 9, screenWidth, 10))
        label0.layer.shadowColor = UIColor.blackColor().CGColor
        label0.layer.shadowOpacity = 0.2
        label0.backgroundColor = UIColor.whiteColor()
        label0.layer.shadowOffset = CGSizeZero
        scrollView.addSubview(label0)
        
        //creating the view
        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        else { contentView.backgroundColor = UIColor.whiteColor() }
        contentView.clipsToBounds = true
        scrollView.addSubview(contentView)
        
        
        profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height+1))
        profilePicBlur.contentMode = .ScaleAspectFill
        profilePicBlur.clipsToBounds = true
        contentView.addSubview(profilePicBlur)
        
        
        //adding the profile pic
        let profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 65, (contentView.frame.size.height) - 65))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile
        
        //self.userProfileImage.image = UIImage(data: (profilePictureObject?.getData())!)
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(error == nil)
                {
                    profilePic.image = UIImage(data: imageData!)
                    self.profilePicBlur.image = UIImage(data: imageData!)
                    //bluring bc of profile pic
                    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                    if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
                    else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
                    visualEffectView.frame = self.profilePicBlur.bounds
                    self.profilePicBlur.addSubview(visualEffectView)
                    
                    
                } else {
                    print(error?.localizedDescription)
                }
                
            }
        }
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height - 30 , contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = PFUser.currentUser()?.username
        label.font = UIFont(name: "Didot-Bold", size: 30)
        if darkMode { label.textColor = UIColor.whiteColor() }
        else { label.textColor = UIColor.blackColor() }
        contentView.addSubview(label)
        
        
        //adding rating label
        label2 = UILabel(frame: CGRectMake(contentView.frame.size.height - 30 , label.frame.origin.y + 30, 100, 40))
        label2.textAlignment = NSTextAlignment.Left
        label2.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        label2.numberOfLines = 0
        label2.font = UIFont(name: "Didot-Italic", size: 10)
        if darkMode { label2.textColor = UIColor.whiteColor() }
        else { label2.textColor = UIColor.blackColor() }
        contentView.addSubview(label2)
        

        
        //adding stats label
        let label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + contentView.frame.origin.y + 25, 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statisitics"
        label3.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label3)
        
        //adding white bc to stats
        let label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25, screenWidth, 45*4))
        label4.text = ""
        label4.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label4)
        
        //adding won: label
        let label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25, screenWidth, 45))
        label5.textAlignment = NSTextAlignment.Left
        label5.text = "Won"
        label5.font = UIFont(name: "Didot", size: 16)
        if darkMode { label5.textColor = UIColor.lightTextColor() }
        else { label5.textColor = UIColor.grayColor() }
        scrollView.addSubview(label5)
        
        //adding drawn: label
        let label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45, screenWidth, 45))
        label6.textAlignment = NSTextAlignment.Left
        label6.text = "Drawn"
        label6.font = UIFont(name: "Didot", size: 16)
        if darkMode { label6.textColor = UIColor.lightTextColor() }
        else { label6.textColor = UIColor.grayColor() }
        scrollView.addSubview(label6)
        
        //adding lost: label
        let label7 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45, screenWidth, 45))
        label7.textAlignment = NSTextAlignment.Left
        label7.text = "Lost"
        label7.font = UIFont(name: "Didot", size: 16)
        if darkMode { label7.textColor = UIColor.lightTextColor() }
        else { label7.textColor = UIColor.grayColor() }
        scrollView.addSubview(label7)
        
        //adding rating: label
        let label8 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45, screenWidth, 45))
        label8.textAlignment = NSTextAlignment.Left
        label8.text = "Rating"
        label8.font = UIFont(name: "Didot", size: 16)
        if darkMode { label8.textColor = UIColor.lightTextColor() }
        else { label8.textColor = UIColor.grayColor() }
        scrollView.addSubview(label8)
        
        //adding seperator: label
        let label9 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45, screenWidth, 0.5))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label9)
        
        //adding seperator2: label
        let label10 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45, screenWidth, 0.5))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label10)
        
        //adding seperator3: label
        let label11 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45, screenWidth, 0.5))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label11)
        
        
        //adding won from cloud: label
        label12 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25, screenWidth - 20, 45))
        label12.textAlignment = NSTextAlignment.Right
        label12.font = UIFont(name: "Didot", size: 16)
        if darkMode { label12.textColor = UIColor.whiteColor() }
        else { label12.textColor = UIColor.blackColor() }
        scrollView.addSubview(label12)
        
        //adding drawn from cloud: label
        label13 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45, screenWidth - 20, 45))
        label13.textAlignment = NSTextAlignment.Right
        label13.font = UIFont(name: "Didot", size: 16)
        if darkMode { label13.textColor = UIColor.whiteColor() }
        else { label13.textColor = UIColor.blackColor() }
        scrollView.addSubview(label13)
        
        //adding lost from cloud: label
        label14 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45, screenWidth - 20, 45))
        label14.textAlignment = NSTextAlignment.Right
        label14.font = UIFont(name: "Didot", size: 16)
        if darkMode { label14.textColor = UIColor.whiteColor() }
        else { label14.textColor = UIColor.blackColor() }
        scrollView.addSubview(label14)
        
        //adding rating from cloud: label
        label15 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45, screenWidth - 20, 45))
        label15.textAlignment = NSTextAlignment.Right
        label15.font = UIFont(name: "Didot", size: 16)
        if darkMode { label15.textColor = UIColor.whiteColor() }
        else { label15.textColor = UIColor.blackColor() }
        scrollView.addSubview(label15)
        
        
        //adding white bc to friends button and friendsrequeust settingsbutton
        let label16 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65, screenWidth, 45 + 45 + 45))
        label16.text = ""
        label16.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label16)
        
        
        //freidnsbutton
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        friendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        friendsButton.layer.borderColor = blue.CGColor
        friendsButton.frame.origin.x = 20
        friendsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65
        friendsButton.frame.size.height = 45
        friendsButton.frame.size.width = screenWidth - 20
        friendsButton.userInteractionEnabled = true
        friendsButton.addTarget(self, action: "friendsPressed:", forControlEvents: .TouchUpInside)
        friendsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(friendsButton)
        
        let friendsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65, 15, 45))
        friendsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { friendsArrowImage.image = UIImage(named: "arrow_white.png"); friendsArrowImage.alpha = 1 }
        else { friendsArrowImage.image = UIImage(named: "arrow_black.png"); friendsArrowImage.alpha = 0.3  }
        scrollView.addSubview(friendsArrowImage)
        
        //seperator4: label
        let label17 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45, screenWidth, 0.5))
        if darkMode { label17.backgroundColor = UIColor.lightGrayColor() }
        else { label17.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label17)
        
        
        //friendRequestsbutton
        friendRequestsButton.setTitle("Friend Requests", forState: .Normal)
        friendRequestsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        friendRequestsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        friendRequestsButton.layer.borderColor = blue.CGColor
        friendRequestsButton.frame.origin.x = 20
        friendRequestsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45
        friendRequestsButton.frame.size.height = 45
        friendRequestsButton.frame.size.width = screenWidth - 20
        friendRequestsButton.userInteractionEnabled = true
        friendRequestsButton.addTarget(self, action: "friendRequestsPressed:", forControlEvents: .TouchUpInside)
        friendRequestsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(friendRequestsButton)
        
        let friendRequestsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45, 15, 45))
        friendRequestsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { friendRequestsArrowImage.image = UIImage(named: "arrow_white.png"); friendRequestsArrowImage.alpha = 1 }
        else { friendRequestsArrowImage.image = UIImage(named: "arrow_black.png"); friendRequestsArrowImage.alpha = 0.3  }
        scrollView.addSubview(friendRequestsArrowImage)
        
        //seperator5: label
        let label18 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45 + 45, screenWidth, 0.5))
        if darkMode { label18.backgroundColor = UIColor.lightGrayColor() }
        else { label18.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label18)
        
        
        //settingsbutton
        settingsButton.setTitle("Settings", forState: .Normal)
        settingsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        settingsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        settingsButton.layer.borderColor = blue.CGColor
        settingsButton.frame.origin.x = 20
        settingsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45 + 45
        settingsButton.frame.size.height = 45
        settingsButton.frame.size.width = screenWidth - 20
        settingsButton.userInteractionEnabled = true
        settingsButton.addTarget(self, action: "settingsPressed:", forControlEvents: .TouchUpInside)
        settingsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(settingsButton)
        
        let settingsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45 + 45, 15, 45))
        settingsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { settingsArrowImage.image = UIImage(named: "arrow_white.png"); settingsArrowImage.alpha = 1 }
        else { settingsArrowImage.image = UIImage(named: "arrow_black.png"); settingsArrowImage.alpha = 0.3  }
        scrollView.addSubview(settingsArrowImage)
        
        let label19 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 50 + 45 + 45, screenWidth, 50))
        label19.textAlignment = NSTextAlignment.Center
        label19.text = "Chess♔"
        label19.font = UIFont(name: "Didot", size: 13)
        if darkMode { label19.textColor = UIColor.lightTextColor() }
        else { label19.textColor = UIColor.grayColor() }
        scrollView.addSubview(label19)
        
        
        
        
    }
    
    func friendRequestsPressed(sender: UIButton!) {
    
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("FriendRequests")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    func settingsPressed(sender: UIButton!) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Settings")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    
    func removeProfile() {
        contentView.removeFromSuperview()
        scrollView.removeFromSuperview()
        
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {
            
            
            contentView.frame.origin.y = scrollView.contentOffset.y + 64
            label0.frame.origin.y = scrollView.contentOffset.y + 63 + contentView.frame.size.height - 9

            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
