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


var myWonProfile = "\(0)"
var myDrawnProfile = "\(0)"
var myLostProfile = "\(0)"

var myRatingProfile = 0

class ProfilePage: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var scrollView: UIScrollView!
    var profilePicBlur = UIImageView()
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    let friendsButton = UIButton()
    let friendRequestsButton = UIButton()
    let settingsButton = UIButton()
    let profilePic = UIImageView(frame: CGRectMake(20, 20, 75, 75))
    var editImageButton = UIImageView()

    var label0 = UILabel()
    var label2 = UILabel()
    var label12 = UILabel()
    var label13 = UILabel()
    var label14 = UILabel()
    var label15 = UILabel()
    
    
    var label3 = UILabel()
    var label4 = UILabel()
    var label5 = UILabel()
    var label6 = UILabel()
    var label7 = UILabel()
    var label8 = UILabel()
    
    var label16 = UILabel()
    
    var userRating = Int()
    var userWon = String()
    var userDrawn = String()
    var userLost = String()
    var userJoined = NSDate()
    
    var changeProfilePicture = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        //setting labels
        self.label12.text = myWonProfile
        self.label13.text = myDrawnProfile
        self.label14.text = myLostProfile
        self.label15.text = "\(myRatingProfile)"
        self.label2.text = "\(myRatingProfile)"
        
        
          setUpProfile()
        lightOrDarkMode()
        //loadUserInfoFromCloud()
    }
    override func viewDidDisappear(animated: Bool) {
        removeProfile()

    }
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        checkInternetConnection()

        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = PFUser.currentUser()?.username
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
        // Do any additional setup after loading the view.
        //setting scrollview
        view.frame.size.height = 650
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.frame.size.height = screenHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.scrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
    }
    
    func loadUserInfoFromCloud () {
        
        let usersQuery = PFQuery(className: "_User")
        usersQuery.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        usersQuery.findObjectsInBackgroundWithBlock { (users:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                
                for users in users as! [PFObject] {
                    //remember to assign them these values in advance!!!
                    self.userRating = users["rating"] as! Int
                    self.userWon = users["won"] as! String
                    self.userDrawn = users["drawn"] as! String
                    self.userLost = users["lost"] as! String
                    
                    
                    //setting labels
                    self.label12.text = self.userWon
                    self.label13.text = self.userDrawn
                    self.label14.text = self.userLost
                    self.label15.text = "\(self.userRating)"
                    self.label2.text = "\(self.userRating)"
                    
                    myWonProfile = self.userWon
                    myDrawnProfile = self.userDrawn
                    myLostProfile = self.userLost
                    myRatingProfile = self.userRating
                    myRatingProfile = self.userRating
                    
                    
                    
                }
            }
                
            else {}
        }
        
        
    }
    
    func setUpProfile () {
        
        view.addSubview(scrollView)

        

        
        
        loadUserInfoFromCloud()
        
        
        
        
        //creating the view
        contentView = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight/5))
        
        label0 = UILabel(frame: CGRectMake(0, -1 + contentView.frame.size.height - 9, screenWidth, 10))
        label0.layer.shadowColor = UIColor.blackColor().CGColor
        label0.layer.shadowOpacity = 0.2
        label0.backgroundColor = UIColor.whiteColor()
        label0.layer.shadowOffset = CGSizeZero
        
        //creating the view
        //contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        else { contentView.backgroundColor = UIColor.whiteColor() }
        contentView.clipsToBounds = true
        
        
        profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height+1))
        profilePicBlur.contentMode = .ScaleAspectFill
        profilePicBlur.clipsToBounds = true
        contentView.addSubview(profilePicBlur)
        


        
        //adding the profile pic
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 0
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        editImageButton = UIImageView(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width - 27, profilePic.frame.origin.y + profilePic.frame.size.height - 27, 35, 35))
        editImageButton.image = UIImage(named: "editimageButton.png")
        contentView.addSubview(editImageButton)
        
        // Button for changing profile pic
        changeProfilePicture = UIButton(frame: CGRectMake(20, 20, 75, 75))
        changeProfilePicture.setTitle("", forState: .Normal)
        changeProfilePicture.titleLabel?.font = UIFont(name: "Times", size: 18)
        changeProfilePicture.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changeProfilePicture.addTarget(self, action: "changeProfilePicButtonPressed:", forControlEvents: .TouchUpInside)
        contentView.addSubview(changeProfilePicture)
        
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile
        
        //self.userProfileImage.image = UIImage(data: (profilePictureObject?.getData())!)
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(error == nil)
                {
                    self.profilePic.image = UIImage(data: imageData!)
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
        let label = UILabel(frame: CGRectMake(profilePic.frame.origin.x + 95 , contentView.frame.size.height/8 + 13.5, 250, 30))
        label.textAlignment = NSTextAlignment.Left
        label.text = PFUser.currentUser()?.username
        label.font = UIFont(name: "Times", size: 22)
        label.sizeToFit()
        if darkMode { label.textColor = UIColor.whiteColor() }
        else { label.textColor = UIColor.blackColor() }
        contentView.addSubview(label)
        
        
        //adding rating label
        label2 = UILabel(frame: CGRectMake(label.frame.origin.x , label.frame.origin.y + 30 , 100, 16))
        label2.textAlignment = NSTextAlignment.Left
        label2.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        label2.numberOfLines = 0
        label2.font = UIFont(name: "Times-Italic", size: 14)
        if darkMode { label2.textColor = UIColor.whiteColor() }
        else { label2.textColor = UIColor.darkGrayColor() }
        contentView.addSubview(label2)
        

        
        //adding stats label
        label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + contentView.frame.origin.y + 25, 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statistics"
        label3.font = UIFont(name: "Times-Italic", size: 16)
        scrollView.addSubview(label3)
        
        //adding white bc to stats
        label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25, screenWidth, 45*4))
        label4.text = ""
        scrollView.addSubview(label4)
        
        //adding won: label
        label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25, screenWidth, 45))
        label5.textAlignment = NSTextAlignment.Left
        label5.text = "Won"
        label5.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label5)
        
        //adding drawn: label
        label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45, screenWidth, 45))
        label6.textAlignment = NSTextAlignment.Left
        label6.text = "Drawn"
        label6.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label6)
        
        //adding lost: label
        label7 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45, screenWidth, 45))
        label7.textAlignment = NSTextAlignment.Left
        label7.text = "Lost"
        label7.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label7)
        
        //adding rating: label
        label8 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45, screenWidth, 45))
        label8.textAlignment = NSTextAlignment.Left
        label8.text = "Rating"
        label8.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label8)
        
        //adding seperator: label
        let olabel9 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 , screenWidth, 0.2))
        if darkMode { olabel9.backgroundColor = UIColor.lightGrayColor() }
        else { olabel9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(olabel9)
        
        //adding seperator: label
        let label9 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45, screenWidth, 0.2))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label9)
        
        //adding seperator2: label
        let label10 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45, screenWidth, 0.2))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label10)
        
        //adding seperator3: label
        let label11 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45, screenWidth, 0.2))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label11)
        
        //adding seperator3: label
        let olabel11 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 45, screenWidth, 0.2))
        if darkMode { olabel11.backgroundColor = UIColor.lightGrayColor() }
        else { olabel11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(olabel11)
        
        
        //adding won from cloud: label
        label12 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25, screenWidth - 20, 45))
        label12.textAlignment = NSTextAlignment.Right
        label12.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label12)
        
        //adding drawn from cloud: label
        label13 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45, screenWidth - 20, 45))
        label13.textAlignment = NSTextAlignment.Right
        label13.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label13)
        
        //adding lost from cloud: label
        label14 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45, screenWidth - 20, 45))
        label14.textAlignment = NSTextAlignment.Right
        label14.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label14)
        
        //adding rating from cloud: label
        label15 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45, screenWidth - 20, 45))
        label15.textAlignment = NSTextAlignment.Right
        label15.font = UIFont(name: "Times", size: 16)
        scrollView.addSubview(label15)
        
        
        //adding white bc to friends button and friendsrequeust settingsbutton
        label16 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65, screenWidth, 45 + 45 + 45))
        scrollView.addSubview(label16)
        
        
        //freidnsbutton
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Times", size: 16)
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
        let olabel17 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 , screenWidth, 0.2))
        if darkMode { olabel17.backgroundColor = UIColor.lightGrayColor() }
        else { olabel17.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(olabel17)
        
        //seperator4: label
        let label17 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45, screenWidth, 0.2))
        if darkMode { label17.backgroundColor = UIColor.lightGrayColor() }
        else { label17.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label17)
        
        
        //friendRequestsbutton
        friendRequestsButton.setTitle("Friend Requests", forState: .Normal)
        if numberOfFriendRequests > 0 {
            friendRequestsButton.setTitle("Friend Requests (\(numberOfFriendRequests))", forState: .Normal)
            friendRequestsButton.setTitleColor(red, forState: .Normal)

        }
        self.tabBarController?.tabBar.items?.last?.badgeValue = "\(numberOfFriendRequests)"
        friendRequestsButton.titleLabel?.font = UIFont(name: "Times", size: 16)
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
        let label18 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45 + 45, screenWidth, 0.2))
        if darkMode { label18.backgroundColor = UIColor.lightGrayColor() }
        else { label18.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label18)
        
        //seperator5: label
        let olabel18 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 25 + 25 + 45 + 45 + 45 + 65 + 45 + 45 + 45, screenWidth, 0.2))
        if darkMode { olabel18.backgroundColor = UIColor.lightGrayColor() }
        else { olabel18.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(olabel18)
        
        //settingsbutton
        settingsButton.setTitle("Settings", forState: .Normal)
        settingsButton.titleLabel?.font = UIFont(name: "Times", size: 16)
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
        label19.text = "CHESS"
        label19.font = UIFont(name: "Times", size: 13)
        if darkMode { label19.textColor = UIColor.lightTextColor() }
        else { label19.textColor = UIColor.grayColor() }
        scrollView.addSubview(label19)
        
        scrollView.addSubview(label0)
        scrollView.addSubview(contentView)

        
        
        
        
    }
    
    func changeProfilePicButtonPressed(sender:UIButton!) {
        let myAlert = UIAlertController(title: "Profile Picture", message: "How do you wish to set your profile picture?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .CurrentContext
        imagePicker.delegate = self
        
        myAlert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: {
            action in
             self.tabBarController?.tabBar.hidden = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }))
        myAlert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: {
            action in
            self.tabBarController?.tabBar.hidden = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }))
        myAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            action in
            self.tabBarController?.tabBar.hidden = false
            }))
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    func friendRequestsPressed(sender: UIButton!) {
    
        
            let frequestsQuery = PFQuery(className: "FriendRequest")
            if let user = PFUser.currentUser()?.username {
                
                frequestsQuery.whereKey("toUserr", equalTo: (user))
                frequestsQuery.orderByDescending("updatedAt")
                frequestsQuery.whereKey("status", equalTo: "pending")
                
                frequestsQuery.findObjectsInBackgroundWithBlock({ (frequests:[AnyObject]?, error:NSError?) -> Void in
                    var users: Array<String> = []
                    if error == nil {
                        
                        if let frequests = frequests as! [PFObject]! {
                        for frequests in frequests {

                        users.append(frequests["fromUser"] as! String)
                            
                        }
                        }
                        NSUserDefaults.standardUserDefaults().setObject(users, forKey: "friend_requests_user")
                        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("FriendRequests")
                        self.showViewController(vc as! UIViewController, sender: vc)
                        
                    }
                    else {
                        print("å")
                        //  return
                        
                    }
                    
                })
                
            }

    }
    
    func settingsPressed(sender: UIButton!) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Settings")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    func friendsPressed(sender: UIButton!) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Friends")
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
        
        if yPos < 0 {
        
            contentView.frame.origin.y = 64 + scrollView.contentOffset.y
            label0.frame.origin.y = scrollView.contentOffset.y + 63 + contentView.frame.size.height - 9
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func lightOrDarkMode() {
        if darkMode == true {
            
           
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            
            self.view.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            self.scrollView.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
            
            
            label3.textColor = UIColor.lightTextColor()
            label4.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            label5.textColor = UIColor.lightTextColor()
            label6.textColor = UIColor.lightTextColor()
            label7.textColor = UIColor.lightTextColor()
            label8.textColor = UIColor.lightTextColor()
            label12.textColor = UIColor.whiteColor()
            label13.textColor = UIColor.whiteColor()
            label14.textColor = UIColor.whiteColor()
            label15.textColor = UIColor.whiteColor()
            label16.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            friendsButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            friendRequestsButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)

            settingsButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)

            
            
            
        }
        else if darkMode == false {
    
    //        contentView.frame.origin.y = 64 + scrollView.contentOffset.y

            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            self.scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            
            
            label3.textColor = UIColor.lightGrayColor()
            label4.backgroundColor = UIColor.whiteColor()
            label5.textColor = UIColor.lightGrayColor()
            label6.textColor = UIColor.lightGrayColor()
            label7.textColor = UIColor.lightGrayColor()
            label8.textColor = UIColor.lightGrayColor()
            label12.textColor = UIColor.blackColor()
            label13.textColor = UIColor.blackColor()
            label14.textColor = UIColor.blackColor()
            label15.textColor = UIColor.blackColor()
            label16.backgroundColor = UIColor.whiteColor()
            friendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            friendRequestsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            
            settingsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    

        }
        
        if numberOfFriendRequests > 0 {
            friendRequestsButton.setTitle("Friend Requests (\(numberOfFriendRequests))", forState: .Normal)
            friendRequestsButton.setTitleColor(red, forState: .Normal)
        }
        else {
            self.tabBarController?.tabBar.items?.last?.badgeValue = nil
        }
    }
    
    
    // Image delegate functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //use image here!
        
        self.tabBarController?.tabBar.hidden = false
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.tabBarController?.tabBar.hidden = false
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        profilePic.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        if let profileImageData = profilePic.image
        {
            
            
            let profileImageDataJPEG = UIImageJPEGRepresentation(profileImageData, 0)
            
            let profileImageFile = PFFile(data: profileImageDataJPEG!)
            PFUser.currentUser()?.setObject(profileImageFile, forKey: "profile_picture")
             //PFUser.currentUser()?.saveInBackground()
            PFUser.currentUser()?.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
        self.tabBarController?.tabBar.hidden = false
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }

}
