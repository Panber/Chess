//
//  OtherUserProfilePage.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

let users = PFObject(className: "_User")

class OtherUserProfilePage: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var profilePicBlur = UIImageView()
    
    var popOverView = UIView()
    var dismissButton = UIButton()
    var unfriendButton = UIButton()
    var bcView = UIButton()
    
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    let friendsButton = UIButton()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    var label5 = UILabel()
    
    var label6 = UILabel()
    var label7 = UILabel()
    var label8 = UILabel()
    
    var label9 = UILabel()
    
    var label10 = UILabel()
    var label11 = UILabel()
    
    var label12 = UILabel()
    var label13 = UILabel()
    var label14 = UILabel()
    var label15 = UILabel()
    var label16 = UILabel()
    var label17 = UILabel()
    var usersFrom = String()
    
    var label18 = UILabel()
    
    var label19 = UILabel()
    var label20 = UILabel()
    
    var sep = UILabel()
    
    var profilePic = UIImageView()
    
    var settingsButton = UIButton()
    
    var friendsArrowImage = UIImageView()
    
    var friendStatusLabel = UILabel()
    
    var t:CGFloat = 0
    var pendingOrRecievedFQ = false
    var friendRequestbuttonAlereadyLoadedOnce = false
    
    var underElements:Array<UILabel> = []
    
    var ifFriend = UIImageView()
    var label2o5 = UILabel()
    
    var userRating = String()
    var userWon = String()
    var userDrawn = String()
    var userLost = String()
    var userJoined = NSDate()
    
    
    var acceptRequest = UIButton()
    var denyRequest = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        //  setUpProfile()
        lightOrDarkMode()
    }
    override func viewDidAppear(animated: Bool) {
        setUpProfile()
    }
    override func viewWillDisappear(animated: Bool) {
        self.removeProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underElements = [label3,label4,label5,label6,label7,label8,label9,label10,label11,label12,label13,label14,label15,label16,label17]
        
        
        
        self.title = NSUserDefaults.standardUserDefaults().objectForKey("other_username") as? String
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
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
    }
    
    func loadUserInfoFromCloud () {
        
        let usersQuery = PFQuery(className: "_User")
        usersQuery.whereKey("username", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username") as! String)
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
        
        
        popOverView = UIView(frame: CGRectMake(0, screenHeight - 155, screenWidth, 200))
        bcView = UIButton(frame: CGRectMake(0, 0, screenWidth, view.frame.size.height))
        
        
        navigationController?.navigationBar.topItem?.title = NSUserDefaults.standardUserDefaults().objectForKey("other_username") as? String
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        //creating the view
        //  var contentView: UIView = UIView(frame: CGRectMake(0, 0, screenWidth - 20 , screenHeight/7))
        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        //contentView.layer.cornerRadius = cornerRadius
        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        else { contentView.backgroundColor = UIColor.whiteColor() }
        contentView.clipsToBounds = true
        scrollView.addSubview(contentView)
        
        
        
        //setting up bc image of profile pic
        if NSUserDefaults.standardUserDefaults().objectForKey("other_userImage") == nil {
            sleep(5)
        }
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("other_userImage") as! NSData
        
        profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height+1))
        profilePicBlur.contentMode = .ScaleAspectFill
        profilePicBlur.image = UIImage(data: imageData)
        profilePicBlur.clipsToBounds = true
        contentView.addSubview(profilePicBlur)
        
        //bluring bc of profile pic
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = profilePicBlur.bounds
        profilePicBlur.addSubview(visualEffectView)
        
        //adding the profile pic
        profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 65, (contentView.frame.size.height) - 65))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(data: imageData)
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height - 30 , contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username")as? String
        label.font = UIFont(name: "Didot-Bold", size: 30)
        label.sizeToFit()
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
        
        
        
        //adding freinds request button
        let friends = PFQuery(className: "friends")
        if let user = PFUser.currentUser() {
            friends.whereKey("user", equalTo: user)
            friends.whereKey("friends", containsString: NSUserDefaults.standardUserDefaults().objectForKey("other_username") as? String)
        }
        
        //adding white bc to fridnrequest
        label2o5 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y, screenWidth, 45))
        label2o5.text = ""
        label2o5.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label2o5)
        
        
        
        //adding the checmark or cross
        ifFriend = UIImageView(frame: CGRectMake(profilePic.frame.origin.x , contentView.frame.height + contentView.frame.origin.y + 7.5, profilePic.frame.size.width, 30))
        ifFriend.layer.cornerRadius = ifFriend.frame.size.height / 2
        ifFriend.clipsToBounds = true
        ifFriend.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(ifFriend)
        
        //setting up frienStatusLabel
        friendStatusLabel = UILabel(frame: CGRectMake(label.frame.origin.x, contentView.frame.height + contentView.frame.origin.y, screenWidth - label.frame.origin.x, 45))
        friendStatusLabel.textAlignment = .Left
        friendStatusLabel.font = UIFont(name: "Didot", size: 16)
        friendStatusLabel.textColor = UIColor.lightGrayColor()
        scrollView.addSubview(friendStatusLabel)
        
        //adding settingsbutton
        settingsButton = UIButton(frame: CGRectMake(screenWidth - 40, ifFriend.frame.origin.y, 30, 30))
        settingsButton.setBackgroundImage(UIImage(named: "equalization2.png"), forState: .Normal)
        settingsButton.addTarget(self, action: "settingsPressed:", forControlEvents: .TouchUpInside)
        settingsButton.alpha = 0
        
        func loadFriendRequestButton() {
            if self.pendingOrRecievedFQ == false {
                
                self.t = 1
                
                self.ifFriend.image = UIImage(named: "close1.png")
                self.friendStatusLabel.text = "You are not friends"
                
                //if not friend:
                self.friendRequestButton.setTitle("Add as Friend", forState: .Normal)
                self.friendRequestButton.titleLabel?.font = UIFont(name: "Didot-Bold", size: 18)
                self.friendRequestButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
                self.friendRequestButton.layer.borderColor = blue.CGColor
                self.friendRequestButton.frame.origin.x = 0
                self.friendRequestButton.frame.origin.y
                    = self.contentView.frame.height + self.contentView.frame.origin.y + 45
                self.friendRequestButton.frame.size.height = 45
                self.friendRequestButton.frame.size.width = screenWidth
                self.friendRequestButton.backgroundColor = UIColor.whiteColor()
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.addTarget(self, action: "friendRequestPressed:", forControlEvents: .TouchUpInside)
                self.friendRequestButton.alpha = 0
                self.scrollView.addSubview(self.friendRequestButton)
                
                
                self.sep = UILabel(frame: CGRectMake(0, self.contentView.frame.height + self.contentView.frame.origin.y + 45 , screenWidth, 0.5))
                if darkMode { self.sep.backgroundColor = UIColor.lightGrayColor() }
                else { self.sep.backgroundColor = UIColor.lightGrayColor() }
                self.scrollView.addSubview(self.sep)
                
                
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.friendRequestButton.alpha = 1
                })
            }
            self.elementSetup()
            self.loadUserInfoFromCloud()
        }
        
        let friendsQuery = PFQuery(className: "Friends")
        if let username = PFUser.currentUser()?.username {
            friendsQuery.whereKey("username", equalTo: username)
            friendsQuery.whereKey("friends", equalTo: label.text!)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friendss:[AnyObject]?, error:NSError?) -> Void in
                
                
                if "\(friendss)" == "Optional([])" {
                    
                    let friendRequestQuery = PFQuery(className: "FriendRequest")
                    if let username = PFUser.currentUser()?.username {
                        friendRequestQuery.whereKey("toUserr", equalTo: username)
                        friendRequestQuery.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username")!)
                        friendRequestQuery.whereKey("status", equalTo: "pending")
                        
                        friendRequestQuery.findObjectsInBackgroundWithBlock({ (requests:[AnyObject]?, error:NSError?) -> Void in
                            
                            if "\(requests)" != "Optional([])" {
                                print("you have a friend request from him")
                                
                                self.pendingOrRecievedFQ = true
                                self.loadUserInfoFromCloud()
                                self.elementSetup()
                                self.friendStatusLabel.text = "Recieved Friend Request"
                                
                                self.acceptRequest = UIButton(frame: CGRectMake(self.friendStatusLabel.frame.origin.x - 80, self.ifFriend.frame.origin.y, 30, 30))
                                self.acceptRequest.setBackgroundImage(UIImage(named: "checkmark11.png"), forState: .Normal)
                                self.acceptRequest.addTarget(self, action: "acceptFriendRequestPressed:", forControlEvents: .TouchUpInside)
                                self.scrollView.addSubview(self.acceptRequest)
                                
                                self.denyRequest = UIButton(frame: CGRectMake(self.friendStatusLabel.frame.origin.x - 40, self.ifFriend.frame.origin.y, 30, 30))
                                self.denyRequest.setBackgroundImage(UIImage(named: "close38.png"), forState: .Normal)
                                self.denyRequest.addTarget(self, action: "denyFriendRequestPressed:", forControlEvents: .TouchUpInside)
                                self.scrollView.addSubview(self.denyRequest)
                                
                                
                                
                            }
                            else {
                                
                                let friendRequestQuery2 = PFQuery(className: "FriendRequest")
                                if let username = PFUser.currentUser()?.username {
                                    friendRequestQuery2.whereKey("fromUser", equalTo: username)
                                    friendRequestQuery2.whereKey("toUserr", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username")!)
                                    friendRequestQuery2.whereKey("status", equalTo: "pending")
                                    
                                    friendRequestQuery2.findObjectsInBackgroundWithBlock({ (requests:[AnyObject]?, error:NSError?) -> Void in
                                        
                                        if "\(requests)" != "Optional([])" {
                                            print("you have a sent a friend request")
                                            
                                            self.ifFriend.image = UIImage(named: "pending.png")
                                            self.friendStatusLabel.text = "Pending Friend Request"
                                            self.friendRequestButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                                            self.pendingOrRecievedFQ = true
                                            self.loadUserInfoFromCloud()
                                            self.elementSetup()
                                            
                                        }
                                        else {
                                            
                                            loadFriendRequestButton()
                                            
                                        }
                                        
                                    })
                                }
                            }
                            
                        })
                    }
                    
                    
                    
                    
                    
                }
                else {
                    
                    print("\(friendss)")
                    
                    self.ifFriend.image = UIImage(named: "checkmark13.png")
                    self.friendStatusLabel.text = "You are Friends"
                    self.scrollView.addSubview(self.settingsButton)
                    
                    self.elementSetup()
                    self.loadUserInfoFromCloud()
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.settingsButton.alpha = 1
                    })
                }
            })
            //end of add friend
        }
        
        
    }
    
    func elementSetup() {
        
        
        
        
        
        
        
        //adding stats label
        label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + contentView.frame.origin.y + 65 + (45*t), 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statisitics"
        label3.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label3)
        
        //adding white bc to stats
        label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth, 45*4))
        label4.text = ""
        label4.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label4)
        
        //adding won: label
        label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth, 45))
        label5.textAlignment = NSTextAlignment.Left
        label5.text = "Won"
        label5.font = UIFont(name: "Didot", size: 16)
        if darkMode { label5.textColor = UIColor.lightTextColor() }
        else { label5.textColor = UIColor.grayColor() }
        scrollView.addSubview(label5)
        
        //adding drawn: label
        label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth, 45))
        label6.textAlignment = NSTextAlignment.Left
        label6.text = "Drawn"
        label6.font = UIFont(name: "Didot", size: 16)
        if darkMode { label6.textColor = UIColor.lightTextColor() }
        else { label6.textColor = UIColor.grayColor() }
        scrollView.addSubview(label6)
        
        //adding lost: label
        label7 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth, 45))
        label7.textAlignment = NSTextAlignment.Left
        label7.text = "Lost"
        label7.font = UIFont(name: "Didot", size: 16)
        if darkMode { label7.textColor = UIColor.lightTextColor() }
        else { label7.textColor = UIColor.grayColor() }
        scrollView.addSubview(label7)
        
        //adding rating: label
        label8 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth, 45))
        label8.textAlignment = NSTextAlignment.Left
        label8.text = "Rating"
        label8.font = UIFont(name: "Didot", size: 16)
        if darkMode { label8.textColor = UIColor.lightTextColor() }
        else { label8.textColor = UIColor.grayColor() }
        scrollView.addSubview(label8)
        
        //adding seperator: label
        label9 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label9)
        
        //adding seperator2: label
        label10 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label10)
        
        //adding seperator3: label
        label11 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label11)
        
        
        //adding won from cloud: label
        label12 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth - 20, 45))
        label12.textAlignment = NSTextAlignment.Right
        label12.font = UIFont(name: "Didot", size: 16)
        if darkMode { label12.textColor = UIColor.whiteColor() }
        else { label12.textColor = UIColor.blackColor() }
        scrollView.addSubview(label12)
        
        //adding drawn from cloud: label
        label13 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth - 20, 45))
        label13.textAlignment = NSTextAlignment.Right
        label13.font = UIFont(name: "Didot", size: 16)
        if darkMode { label13.textColor = UIColor.whiteColor() }
        else { label13.textColor = UIColor.blackColor() }
        scrollView.addSubview(label13)
        
        //adding lost from cloud: label
        label14 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth - 20, 45))
        label14.textAlignment = NSTextAlignment.Right
        label14.font = UIFont(name: "Didot", size: 16)
        if darkMode { label14.textColor = UIColor.whiteColor() }
        else { label14.textColor = UIColor.blackColor() }
        scrollView.addSubview(label14)
        
        //adding rating from cloud: label
        label15 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth - 20, 45))
        label15.textAlignment = NSTextAlignment.Right
        label15.font = UIFont(name: "Didot", size: 16)
        if darkMode { label15.textColor = UIColor.whiteColor() }
        else { label15.textColor = UIColor.blackColor() }
        scrollView.addSubview(label15)
        
        
        //adding white bc to friends button
        label16 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + (45*t), screenWidth, 45))
        label16.text = ""
        label16.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label16)
        
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        friendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        friendsButton.layer.borderColor = blue.CGColor
        friendsButton.frame.origin.x = 20
        friendsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65  + (45*t)
        friendsButton.frame.size.height = 44
        friendsButton.frame.size.width = screenWidth - 20
        friendsButton.userInteractionEnabled = true
        friendsButton.addTarget(self, action: "friendsPressed:", forControlEvents: .TouchUpInside)
        friendsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(friendsButton)
        
        friendsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + (45*t), 15, 45))
        friendsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { friendsArrowImage.image = UIImage(named: "arrow_white.png"); friendsArrowImage.alpha = 1 }
        else { friendsArrowImage.image = UIImage(named: "arrow_black.png"); friendsArrowImage.alpha = 0.3  }
        scrollView.addSubview(friendsArrowImage)
        
        
        label17 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + 50 + (45*t), screenWidth , 50))
        label17.textAlignment = NSTextAlignment.Center
        label17.text = "Chess♔"
        label17.font = UIFont(name: "Didot", size: 13)
        if darkMode { label17.textColor = UIColor.lightTextColor() }
        else { label17.textColor = UIColor.grayColor() }
        scrollView.addSubview(label17)
        
    }
    
    func friendRequestPressed(sender: UIButton!) {
        
        for var i = 0; i < self.underElements.count; i++ {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.underElements[i].frame.origin.y -= 45
            })
            
        }
        request["fromUser"] = PFUser.currentUser()?.username
        request["toUserr"] = NSUserDefaults.standardUserDefaults().objectForKey("other_username")
        request["status"] = "pending"
        
        let toUserQuery = PFQuery(className: "FriendRequest")
        toUserQuery.findObjectsInBackgroundWithBlock { (request:[AnyObject]?, error:NSError?) -> Void in
            
        }
        self.friendRequestButton.userInteractionEnabled = false
        request.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                self.friendRequestButton.userInteractionEnabled = false
                self.friendRequestButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.ifFriend.image = UIImage(named: "pending.png")
                self.friendStatusLabel.text = "Pending Friend Request"
                print("request was saved in background")
                self.t = 0
                
            }
            else {
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
                
            }
        }
        
    }
    
    func settingsPressed(sender: UIButton!) {
        
        
        scrollView.scrollEnabled = false
        
        
        bcView.backgroundColor = UIColor.blackColor()
        bcView.alpha = 0
        scrollView.addSubview(bcView)
        
        popOverView.userInteractionEnabled = true
        scrollView.addSubview(popOverView)
        
        
        unfriendButton = UIButton(frame: CGRectMake(screenWidth + 120, 5, screenWidth - 10, 45))
        unfriendButton.setTitle("Unfriend", forState: .Normal)
        unfriendButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        unfriendButton.titleLabel?.font = UIFont(name: "Didot", size: 20)
        unfriendButton.backgroundColor = UIColor.whiteColor()
        unfriendButton.layer.cornerRadius = cornerRadius
        unfriendButton.userInteractionEnabled = true
        popOverView.addSubview(unfriendButton)
        
        dismissButton = UIButton(frame: CGRectMake(screenWidth + 60, 55, screenWidth - 10, 45))
        dismissButton.setTitle("Dismiss", forState: .Normal)
        dismissButton.setTitleColor(blue, forState: .Normal)
        dismissButton.titleLabel?.font = UIFont(name: "Didot", size: 20)
        dismissButton.backgroundColor = UIColor.whiteColor()
        dismissButton.layer.cornerRadius = cornerRadius
        dismissButton.alpha = 0.9
        dismissButton.userInteractionEnabled = true
        popOverView.addSubview(dismissButton)
        
        unfriendButton.addTarget(self, action: "unfriendPressed:", forControlEvents: .TouchUpInside)
        dismissButton.addTarget(self, action: "dismissPressed:", forControlEvents: .TouchUpInside)
        bcView.addTarget(self, action: "bcviewPressed:", forControlEvents: .TouchUpInside)
        
        self.acceptRequest.userInteractionEnabled = false
        self.friendsButton.userInteractionEnabled = false
        self.settingsButton.userInteractionEnabled = false
        self.denyRequest.userInteractionEnabled = false
        self.friendRequestButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.8, delay: 0.2, usingSpringWithDamping: 50, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.dismissButton.frame.origin.x = 5
            self.unfriendButton.frame.origin.x = 5
            self.bcView.alpha = 0.3
            
            
            }, completion: {Void in
                
                
        })
        
        
    }
    
    func unfriendPressed(sender: UIButton!) {
        print("pressed")
        
        var ff = NSMutableArray()
        
        //adding friends
        let friendsQuery2 = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery2.whereKey("username", equalTo: user.username!)
            friendsQuery2.whereKey("friends", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username")!)
            
            friendsQuery2.findObjectsInBackgroundWithBlock({ (friends:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    for friends in friends! {
                        
                        ff = friends["friends"] as! NSMutableArray
                        print(ff)
                        
                    }
                    for var i = 0; i < ff.count; i++ {
                        
                        if ff[i] as! String == NSUserDefaults.standardUserDefaults().objectForKey("other_username") as! String {
                            ff.removeObjectAtIndex(i)
                            print(ff)
                            
                        }
                    }
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            friends["friends"] = ff
                            friends.saveInBackground()
                        }
                    }
                }
            })
        }
        
        
        var off = NSMutableArray()
        
        let userFriendsQuery = PFQuery(className: "Friends")
        userFriendsQuery.whereKey("username", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username") as! String)
        userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for friends in friends! {
                    off = friends["friends"] as! NSMutableArray
                }
                
                for var i = 0; i < off.count; i++ {
                    if off[i] as? String == PFUser.currentUser()?.username {
                        off.removeObjectAtIndex(i)
                    }
                    
                }
                
                if let friends = friends as? [PFObject]{
                    for friends in friends {
                        friends["friends"] = off
                        friends.saveInBackground()
                    }
                }
                
                UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    //   self.scrollView.userInteractionEnabled = false
                    self.dismissButton.frame.origin.x = screenWidth + 60
                    self.unfriendButton.frame.origin.x = screenWidth + 60
                    
                    self.bcView.alpha = 0
                    
                    self.ifFriend.image = UIImage(named: "close1.png")
                    self.friendStatusLabel.text = "Removed Friend"
                    self.settingsButton.alpha = 0
                    
                    }, completion: { Void in
                        self.bcView.removeFromSuperview()
                        self.scrollView.scrollEnabled = true
                        //self.scrollView.userInteractionEnabled = true
                        
                        self.acceptRequest.userInteractionEnabled = true
                        self.friendsButton.userInteractionEnabled = true
                        self.denyRequest.userInteractionEnabled = true
                        self.friendRequestButton.userInteractionEnabled = true
                        self.settingsButton.hidden = true

                        
                })
                
            }
            else {
                print("annerror accured")
            }
        })
        
        
        //edn of adding friends
        
        

        
        
    }
    func dismissPressed(sender: UIButton!) {
        
        print("pressed")
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //   self.scrollView.userInteractionEnabled = false
            self.dismissButton.frame.origin.x = screenWidth + 60
            self.unfriendButton.frame.origin.x = screenWidth + 60
            
            self.bcView.alpha = 0
            
            
            }, completion: { Void in
                self.bcView.removeFromSuperview()
                self.scrollView.scrollEnabled = true
                //self.scrollView.userInteractionEnabled = true
                
                self.acceptRequest.userInteractionEnabled = true
                self.friendsButton.userInteractionEnabled = true
                self.settingsButton.userInteractionEnabled = true
                self.denyRequest.userInteractionEnabled = true
                self.friendRequestButton.userInteractionEnabled = true
                
                
        })
        
    }
    func bcviewPressed(sender: UIButton!) {
        print("pressed")
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //   self.scrollView.userInteractionEnabled = false
            self.dismissButton.frame.origin.x = screenWidth + 60
            self.unfriendButton.frame.origin.x = screenWidth + 60
            
            self.bcView.alpha = 0
            
            
            }, completion: { Void in
                self.bcView.removeFromSuperview()
                self.scrollView.scrollEnabled = true
                //self.scrollView.userInteractionEnabled = true
                
                self.acceptRequest.userInteractionEnabled = true
                self.friendsButton.userInteractionEnabled = true
                self.settingsButton.userInteractionEnabled = true
                self.denyRequest.userInteractionEnabled = true
                self.friendRequestButton.userInteractionEnabled = true
                
                
        })
        
    }
    
    func acceptFriendRequestPressed(sender: UIButton!) {
        
        //adding friends
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username")!)
            
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    for request in request! {
                        self.usersFrom = request["fromUser"] as! String
                        
                        request.deleteEventually()
                    }
                    
                    let userFriendsQuery = PFQuery(className: "Friends")
                    userFriendsQuery.whereKey("username", equalTo: self.usersFrom)
                    userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let friends = friends as? [PFObject]{
                                for friends in friends {
                                    
                                    friends["friends"]?.addObject((PFUser.currentUser()?.username)!)
                                    let r = friends["friends"]
                                    print("his friends are \(r)")
                                    friends.saveInBackground()
                                    self.usersFrom = ""
                                }
                            }
                        }
                        else {
                            print("annerror accured")
                        }
                    })
                }
            })
        }
        
        //adding friends to self
        let friendsQuery = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery.whereKey("user", equalTo: user)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            friends["friends"]?.addObject(NSUserDefaults.standardUserDefaults().objectForKey("other_username")!)
                            friends.saveInBackground()
                        }
                    }
                }
                else {
                    print("annerror accured")
                }
            })
        }
        //edn of adding friends
        
        
        acceptRequest.userInteractionEnabled = false
        denyRequest.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.acceptRequest.setBackgroundImage(UIImage(named: "checkmark13.png"), forState: .Normal)
            self.acceptRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            
            self.denyRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            self.denyRequest.alpha = 0
            self.friendStatusLabel.text = "Friend Request Accepted"
            
            
        }
        
        
    }
    
    func denyFriendRequestPressed(sender: UIButton!) {
        
        //handling cloud
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username")!)
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    for request in request! {
                        request.deleteEventually()
                    }
                }
                else {
                    print("annerror accured")
                }
                
            })
        }
        
        acceptRequest.userInteractionEnabled = false
        denyRequest.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.acceptRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            self.acceptRequest.alpha = 0
            
            
            self.denyRequest.setBackgroundImage(UIImage(named: "close1.png"), forState: .Normal)
            self.denyRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            
            self.friendStatusLabel.text = "Friend Request Denied"
            
            
        }
        
    }
    
    func removeProfile() {
        contentView.removeFromSuperview()
        
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {
            
            
            contentView.frame.origin.y = scrollView.contentOffset.y + 64
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
            friendRequestButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 45
            ifFriend.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            settingsButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            label2o5.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            friendStatusLabel.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            sep.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 45
            acceptRequest.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            denyRequest.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            
        }
        if yPos < 0 {
            
            popOverView.frame.origin.y = scrollView.contentOffset.y + (screenHeight - 155)
            bcView.frame.origin.y = scrollView.contentOffset.y
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

            //
            //            //setting top logo
            //            logo = UIImage(named: "ChessIconSmallTextAndLogoDarkMode.png")
            //            logoView = UIImageView(image:logo)
            //            logoView.contentMode = UIViewContentMode.ScaleAspectFit
            //            logoView.frame.size.height = 50
            //            self.navigationItem.titleView = logoView
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
          
            
            //            //setting top logo
            //            logo = UIImage(named: "ChessIconSmallTextAndLogo.png")
            //            logoView = UIImageView(image:logo)
            //            logoView.contentMode = UIViewContentMode.ScaleAspectFit
            //            logoView.frame.size.height = 50
            //            self.navigationItem.titleView = logoView
            //            
            
            
            
        }
        
        
    }
    
}
class OtherUserProfilePageFromFriendRequest: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var profilePicBlur = UIImageView()
    
    var popOverView = UIView()
    var dismissButton = UIButton()
    var unfriendButton = UIButton()
    var bcView = UIButton()
    
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    let friendsButton = UIButton()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    var label5 = UILabel()
    
    var label6 = UILabel()
    var label7 = UILabel()
    var label8 = UILabel()
    
    var label9 = UILabel()
    
    var label10 = UILabel()
    var label11 = UILabel()
    
    var label12 = UILabel()
    var label13 = UILabel()
    var label14 = UILabel()
    var label15 = UILabel()
    var label16 = UILabel()
    var label17 = UILabel()
    var usersFrom = String()
    
    var label18 = UILabel()
    
    var label19 = UILabel()
    var label20 = UILabel()
    
    var sep = UILabel()
    
    var profilePic = UIImageView()
    
    var settingsButton = UIButton()
    
    var friendsArrowImage = UIImageView()
    
    var friendStatusLabel = UILabel()
    
    var t:CGFloat = 0
    var pendingOrRecievedFQ = false
    var friendRequestbuttonAlereadyLoadedOnce = false
    
    var underElements:Array<UILabel> = []
    
    var ifFriend = UIImageView()
    var label2o5 = UILabel()
    
    var userRating = String()
    var userWon = String()
    var userDrawn = String()
    var userLost = String()
    var userJoined = NSDate()
    
    
    var acceptRequest = UIButton()
    var denyRequest = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        //  setUpProfile()
        lightOrDarkMode()

    }
    override func viewDidAppear(animated: Bool) {
        setUpProfile()
    }
    override func viewWillDisappear(animated: Bool) {
        self.removeProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underElements = [label3,label4,label5,label6,label7,label8,label9,label10,label11,label12,label13,label14,label15,label16,label17]

        
        
        self.title = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest") as? String
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
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
    }
    
    func loadUserInfoFromCloud () {
        
        let usersQuery = PFQuery(className: "_User")
        usersQuery.whereKey("username", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest") as! String)
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
        
        
        popOverView = UIView(frame: CGRectMake(0, screenHeight - 155, screenWidth, 200))
        bcView = UIButton(frame: CGRectMake(0, 0, screenWidth, view.frame.size.height))
        
        
        navigationController?.navigationBar.topItem?.title = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest") as? String
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        //creating the view
        //  var contentView: UIView = UIView(frame: CGRectMake(0, 0, screenWidth - 20 , screenHeight/7))
        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        //contentView.layer.cornerRadius = cornerRadius
        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        else { contentView.backgroundColor = UIColor.whiteColor() }
        contentView.clipsToBounds = true
        scrollView.addSubview(contentView)
        
        
        
        //setting up bc image of profile pic
        if NSUserDefaults.standardUserDefaults().objectForKey("other_userImage_from_friendrequest") == nil {
            sleep(5)
        }
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("other_userImage_from_friendrequest") as! NSData
        
        profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height+1))
        profilePicBlur.contentMode = .ScaleAspectFill
        profilePicBlur.image = UIImage(data: imageData)
        profilePicBlur.clipsToBounds = true
        contentView.addSubview(profilePicBlur)
        
        //bluring bc of profile pic
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = profilePicBlur.bounds
        profilePicBlur.addSubview(visualEffectView)
        
        //adding the profile pic
        profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 65, (contentView.frame.size.height) - 65))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(data: imageData)
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height - 30 , contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")as? String
        label.font = UIFont(name: "Didot-Bold", size: 30)
        label.sizeToFit()
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
        
        
        
        //adding freinds request button
        let friends = PFQuery(className: "friends")
        if let user = PFUser.currentUser() {
            friends.whereKey("user", equalTo: user)
            friends.whereKey("friends", containsString: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest") as? String)
        }
        
        //adding white bc to fridnrequest
        label2o5 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y, screenWidth, 45))
        label2o5.text = ""
        label2o5.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label2o5)
        
        
        
        //adding the checmark or cross
        ifFriend = UIImageView(frame: CGRectMake(profilePic.frame.origin.x , contentView.frame.height + contentView.frame.origin.y + 7.5, profilePic.frame.size.width, 30))
        ifFriend.layer.cornerRadius = ifFriend.frame.size.height / 2
        ifFriend.clipsToBounds = true
        ifFriend.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(ifFriend)
        
        //setting up frienStatusLabel
        friendStatusLabel = UILabel(frame: CGRectMake(label.frame.origin.x, contentView.frame.height + contentView.frame.origin.y, screenWidth - label.frame.origin.x, 45))
        friendStatusLabel.textAlignment = .Left
        friendStatusLabel.font = UIFont(name: "Didot", size: 16)
        friendStatusLabel.textColor = UIColor.lightGrayColor()
        scrollView.addSubview(friendStatusLabel)
        
        //adding settingsbutton
        settingsButton = UIButton(frame: CGRectMake(screenWidth - 40, ifFriend.frame.origin.y, 30, 30))
        settingsButton.setBackgroundImage(UIImage(named: "equalization2.png"), forState: .Normal)
        settingsButton.addTarget(self, action: "settingsPressed:", forControlEvents: .TouchUpInside)
        settingsButton.alpha = 0
        
        func loadFriendRequestButton() {
            if self.pendingOrRecievedFQ == false {
                
                self.t = 1
                
                self.ifFriend.image = UIImage(named: "close1.png")
                self.friendStatusLabel.text = "You are not friends"
                
                //if not friend:
                self.friendRequestButton.setTitle("Add as Friend", forState: .Normal)
                self.friendRequestButton.titleLabel?.font = UIFont(name: "Didot-Bold", size: 18)
                self.friendRequestButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
                self.friendRequestButton.layer.borderColor = blue.CGColor
                self.friendRequestButton.frame.origin.x = 0
                self.friendRequestButton.frame.origin.y
                    = self.contentView.frame.height + self.contentView.frame.origin.y + 45
                self.friendRequestButton.frame.size.height = 45
                self.friendRequestButton.frame.size.width = screenWidth
                self.friendRequestButton.backgroundColor = UIColor.whiteColor()
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.addTarget(self, action: "friendRequestPressed:", forControlEvents: .TouchUpInside)
                self.friendRequestButton.alpha = 0
                self.scrollView.addSubview(self.friendRequestButton)
                
                
                self.sep = UILabel(frame: CGRectMake(0, self.contentView.frame.height + self.contentView.frame.origin.y + 45 , screenWidth, 0.5))
                if darkMode { self.sep.backgroundColor = UIColor.lightGrayColor() }
                else { self.sep.backgroundColor = UIColor.lightGrayColor() }
                self.scrollView.addSubview(self.sep)
                
                
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.friendRequestButton.alpha = 1
                })
            }
            self.elementSetup()
            self.loadUserInfoFromCloud()
        }
        
        let friendsQuery = PFQuery(className: "Friends")
        if let username = PFUser.currentUser()?.username {
            friendsQuery.whereKey("username", equalTo: username)
            friendsQuery.whereKey("friends", equalTo: label.text!)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friendss:[AnyObject]?, error:NSError?) -> Void in
                
                
                if "\(friendss)" == "Optional([])" {
                    
                    let friendRequestQuery = PFQuery(className: "FriendRequest")
                    if let username = PFUser.currentUser()?.username {
                        friendRequestQuery.whereKey("toUserr", equalTo: username)
                        friendRequestQuery.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")!)
                        friendRequestQuery.whereKey("status", equalTo: "pending")
                        
                        friendRequestQuery.findObjectsInBackgroundWithBlock({ (requests:[AnyObject]?, error:NSError?) -> Void in
                            
                            if "\(requests)" != "Optional([])" {
                                print("you have a friend request from him")
                                
                                self.pendingOrRecievedFQ = true
                                self.loadUserInfoFromCloud()
                                self.elementSetup()
                                self.friendStatusLabel.text = "Recieved Friend Request"
                                
                                self.acceptRequest = UIButton(frame: CGRectMake(self.friendStatusLabel.frame.origin.x - 80, self.ifFriend.frame.origin.y, 30, 30))
                                self.acceptRequest.setBackgroundImage(UIImage(named: "checkmark11.png"), forState: .Normal)
                                self.acceptRequest.addTarget(self, action: "acceptFriendRequestPressed:", forControlEvents: .TouchUpInside)
                                self.scrollView.addSubview(self.acceptRequest)
                                
                                self.denyRequest = UIButton(frame: CGRectMake(self.friendStatusLabel.frame.origin.x - 40, self.ifFriend.frame.origin.y, 30, 30))
                                self.denyRequest.setBackgroundImage(UIImage(named: "close38.png"), forState: .Normal)
                                self.denyRequest.addTarget(self, action: "denyFriendRequestPressed:", forControlEvents: .TouchUpInside)
                                self.scrollView.addSubview(self.denyRequest)
                                
                                
                                
                            }
                            else {
                                
                                let friendRequestQuery2 = PFQuery(className: "FriendRequest")
                                if let username = PFUser.currentUser()?.username {
                                    friendRequestQuery2.whereKey("fromUser", equalTo: username)
                                    friendRequestQuery2.whereKey("toUserr", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")!)
                                    friendRequestQuery2.whereKey("status", equalTo: "pending")
                                    
                                    friendRequestQuery2.findObjectsInBackgroundWithBlock({ (requests:[AnyObject]?, error:NSError?) -> Void in
                                        
                                        if "\(requests)" != "Optional([])" {
                                            print("you have a sent a friend request")
                                            
                                            self.ifFriend.image = UIImage(named: "pending.png")
                                            self.friendStatusLabel.text = "Pending Friend Request"
                                            self.friendRequestButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                                            self.pendingOrRecievedFQ = true
                                            self.loadUserInfoFromCloud()
                                            self.elementSetup()
                                            
                                        }
                                        else {
                                            
                                            loadFriendRequestButton()
                                            
                                        }
                                        
                                    })
                                }
                            }
                            
                        })
                    }
                    
                    
                    
                    
                    
                }
                else {
                    
                    print("\(friendss)")
                    
                    self.ifFriend.image = UIImage(named: "checkmark13.png")
                    self.friendStatusLabel.text = "You are Friends"
                    self.scrollView.addSubview(self.settingsButton)
                    
                    self.elementSetup()
                    self.loadUserInfoFromCloud()
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.settingsButton.alpha = 1
                    })
                }
            })
            //end of add friend
        }
        
        
    }
    
    func elementSetup() {
        
        
        
        
        
        
        
        //adding stats label
        label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + contentView.frame.origin.y + 65 + (45*t), 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statisitics"
        label3.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label3)
        
        //adding white bc to stats
        label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth, 45*4))
        label4.text = ""
        label4.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label4)
        
        //adding won: label
        label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth, 45))
        label5.textAlignment = NSTextAlignment.Left
        label5.text = "Won"
        label5.font = UIFont(name: "Didot", size: 16)
        if darkMode { label5.textColor = UIColor.lightTextColor() }
        else { label5.textColor = UIColor.grayColor() }
        scrollView.addSubview(label5)
        
        //adding drawn: label
        label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth, 45))
        label6.textAlignment = NSTextAlignment.Left
        label6.text = "Drawn"
        label6.font = UIFont(name: "Didot", size: 16)
        if darkMode { label6.textColor = UIColor.lightTextColor() }
        else { label6.textColor = UIColor.grayColor() }
        scrollView.addSubview(label6)
        
        //adding lost: label
        label7 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth, 45))
        label7.textAlignment = NSTextAlignment.Left
        label7.text = "Lost"
        label7.font = UIFont(name: "Didot", size: 16)
        if darkMode { label7.textColor = UIColor.lightTextColor() }
        else { label7.textColor = UIColor.grayColor() }
        scrollView.addSubview(label7)
        
        //adding rating: label
        label8 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth, 45))
        label8.textAlignment = NSTextAlignment.Left
        label8.text = "Rating"
        label8.font = UIFont(name: "Didot", size: 16)
        if darkMode { label8.textColor = UIColor.lightTextColor() }
        else { label8.textColor = UIColor.grayColor() }
        scrollView.addSubview(label8)
        
        //adding seperator: label
        label9 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label9)
        
        //adding seperator2: label
        label10 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label10)
        
        //adding seperator3: label
        label11 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label11)
        
        
        //adding won from cloud: label
        label12 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth - 20, 45))
        label12.textAlignment = NSTextAlignment.Right
        label12.font = UIFont(name: "Didot", size: 16)
        if darkMode { label12.textColor = UIColor.whiteColor() }
        else { label12.textColor = UIColor.blackColor() }
        scrollView.addSubview(label12)
        
        //adding drawn from cloud: label
        label13 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth - 20, 45))
        label13.textAlignment = NSTextAlignment.Right
        label13.font = UIFont(name: "Didot", size: 16)
        if darkMode { label13.textColor = UIColor.whiteColor() }
        else { label13.textColor = UIColor.blackColor() }
        scrollView.addSubview(label13)
        
        //adding lost from cloud: label
        label14 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth - 20, 45))
        label14.textAlignment = NSTextAlignment.Right
        label14.font = UIFont(name: "Didot", size: 16)
        if darkMode { label14.textColor = UIColor.whiteColor() }
        else { label14.textColor = UIColor.blackColor() }
        scrollView.addSubview(label14)
        
        //adding rating from cloud: label
        label15 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth - 20, 45))
        label15.textAlignment = NSTextAlignment.Right
        label15.font = UIFont(name: "Didot", size: 16)
        if darkMode { label15.textColor = UIColor.whiteColor() }
        else { label15.textColor = UIColor.blackColor() }
        scrollView.addSubview(label15)
        
        
        //adding white bc to friends button
        label16 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + (45*t), screenWidth, 45))
        label16.text = ""
        label16.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label16)
        
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        friendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        friendsButton.layer.borderColor = blue.CGColor
        friendsButton.frame.origin.x = 20
        friendsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65  + (45*t)
        friendsButton.frame.size.height = 44
        friendsButton.frame.size.width = screenWidth - 20
        friendsButton.userInteractionEnabled = true
        friendsButton.addTarget(self, action: "friendsPressed:", forControlEvents: .TouchUpInside)
        friendsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(friendsButton)
        
        friendsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + (45*t), 15, 45))
        friendsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { friendsArrowImage.image = UIImage(named: "arrow_white.png"); friendsArrowImage.alpha = 1 }
        else { friendsArrowImage.image = UIImage(named: "arrow_black.png"); friendsArrowImage.alpha = 0.3  }
        scrollView.addSubview(friendsArrowImage)
        
        
        label17 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + 50 + (45*t), screenWidth , 50))
        label17.textAlignment = NSTextAlignment.Center
        label17.text = "Chess♔"
        label17.font = UIFont(name: "Didot", size: 13)
        if darkMode { label17.textColor = UIColor.lightTextColor() }
        else { label17.textColor = UIColor.grayColor() }
        scrollView.addSubview(label17)
        
    }
    
    func friendRequestPressed(sender: UIButton!) {
        
        for var i = 0; i < self.underElements.count; i++ {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.underElements[i].frame.origin.y -= 45
            })
            
        }
        request["fromUser"] = PFUser.currentUser()?.username
        request["toUserr"] = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")
        request["status"] = "pending"
        
        let toUserQuery = PFQuery(className: "FriendRequest")
        toUserQuery.findObjectsInBackgroundWithBlock { (request:[AnyObject]?, error:NSError?) -> Void in
            
        }
        self.friendRequestButton.userInteractionEnabled = false
        request.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                self.friendRequestButton.userInteractionEnabled = false
                self.friendRequestButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.ifFriend.image = UIImage(named: "pending.png")
                self.friendStatusLabel.text = "Pending Friend Request"
                print("request was saved in background")
                self.t = 0
                
            }
            else {
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
                
            }
        }
        
    }
    
    func settingsPressed(sender: UIButton!) {
        
        
        scrollView.scrollEnabled = false
        
        
        bcView.backgroundColor = UIColor.blackColor()
        bcView.alpha = 0
        scrollView.addSubview(bcView)
        
        popOverView.userInteractionEnabled = true
        scrollView.addSubview(popOverView)
        
        
        unfriendButton = UIButton(frame: CGRectMake(screenWidth + 120, 5, screenWidth - 10, 45))
        unfriendButton.setTitle("Unfriend", forState: .Normal)
        unfriendButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        unfriendButton.titleLabel?.font = UIFont(name: "Didot", size: 20)
        unfriendButton.backgroundColor = UIColor.whiteColor()
        unfriendButton.layer.cornerRadius = cornerRadius
        unfriendButton.userInteractionEnabled = true
        popOverView.addSubview(unfriendButton)
        
        dismissButton = UIButton(frame: CGRectMake(screenWidth + 60, 55, screenWidth - 10, 45))
        dismissButton.setTitle("Dismiss", forState: .Normal)
        dismissButton.setTitleColor(blue, forState: .Normal)
        dismissButton.titleLabel?.font = UIFont(name: "Didot", size: 20)
        dismissButton.backgroundColor = UIColor.whiteColor()
        dismissButton.layer.cornerRadius = cornerRadius
        dismissButton.alpha = 0.9
        dismissButton.userInteractionEnabled = true
        popOverView.addSubview(dismissButton)
        
        unfriendButton.addTarget(self, action: "unfriendPressed:", forControlEvents: .TouchUpInside)
        dismissButton.addTarget(self, action: "dismissPressed:", forControlEvents: .TouchUpInside)
        bcView.addTarget(self, action: "bcviewPressed:", forControlEvents: .TouchUpInside)
        
        self.acceptRequest.userInteractionEnabled = false
        self.friendsButton.userInteractionEnabled = false
        self.settingsButton.userInteractionEnabled = false
        self.denyRequest.userInteractionEnabled = false
        self.friendRequestButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.8, delay: 0.2, usingSpringWithDamping: 50, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.dismissButton.frame.origin.x = 5
            self.unfriendButton.frame.origin.x = 5
            self.bcView.alpha = 0.3
            
            
            }, completion: {Void in
                
                
        })
        
        
    }
    
    func unfriendPressed(sender: UIButton!) {
        print("pressed")
        
        var ff = NSMutableArray()
        
        //adding friends
        let friendsQuery2 = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery2.whereKey("username", equalTo: user.username!)
            friendsQuery2.whereKey("friends", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")!)
            
            friendsQuery2.findObjectsInBackgroundWithBlock({ (friends:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    for friends in friends! {
                        
                        ff = friends["friends"] as! NSMutableArray
                        print(ff)
                        
                    }
                    for var i = 0; i < ff.count; i++ {
                        
                        if ff[i] as! String == NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest") as! String {
                            ff.removeObjectAtIndex(i)
                            print(ff)
                            
                        }
                    }
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            friends["friends"] = ff
                            friends.saveInBackground()
                        }
                    }
                }
            })
        }
        
        
        var off = NSMutableArray()
        
        let userFriendsQuery = PFQuery(className: "Friends")
        userFriendsQuery.whereKey("username", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest") as! String)
        userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for friends in friends! {
                    off = friends["friends"] as! NSMutableArray
                }
                
                for var i = 0; i < off.count; i++ {
                    if off[i] as? String == PFUser.currentUser()?.username {
                        off.removeObjectAtIndex(i)
                    }
                    
                }
                
                if let friends = friends as? [PFObject]{
                    for friends in friends {
                        friends["friends"] = off
                        friends.saveInBackground()
                    }
                }
                
                UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    //   self.scrollView.userInteractionEnabled = false
                    self.dismissButton.frame.origin.x = screenWidth + 60
                    self.unfriendButton.frame.origin.x = screenWidth + 60
                    
                    self.bcView.alpha = 0
                    
                    self.ifFriend.image = UIImage(named: "close1.png")
                    self.friendStatusLabel.text = "Removed Friend"
                    self.settingsButton.alpha = 0
                    
                    }, completion: { Void in
                        self.bcView.removeFromSuperview()
                        self.scrollView.scrollEnabled = true
                        //self.scrollView.userInteractionEnabled = true
                        
                        self.acceptRequest.userInteractionEnabled = true
                        self.friendsButton.userInteractionEnabled = true
                        self.denyRequest.userInteractionEnabled = true
                        self.friendRequestButton.userInteractionEnabled = true
                        self.settingsButton.hidden = true
                        
                        
                })
                
            }
            else {
                print("annerror accured")
            }
        })
        
        
        //edn of adding friends
        
        
        
        
        
    }
    func dismissPressed(sender: UIButton!) {
        
        print("pressed")
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //   self.scrollView.userInteractionEnabled = false
            self.dismissButton.frame.origin.x = screenWidth + 60
            self.unfriendButton.frame.origin.x = screenWidth + 60
            
            self.bcView.alpha = 0
            
            
            }, completion: { Void in
                self.bcView.removeFromSuperview()
                self.scrollView.scrollEnabled = true
                //self.scrollView.userInteractionEnabled = true
                
                self.acceptRequest.userInteractionEnabled = true
                self.friendsButton.userInteractionEnabled = true
                self.settingsButton.userInteractionEnabled = true
                self.denyRequest.userInteractionEnabled = true
                self.friendRequestButton.userInteractionEnabled = true
                
                
        })
        
    }
    func bcviewPressed(sender: UIButton!) {
        print("pressed")
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //   self.scrollView.userInteractionEnabled = false
            self.dismissButton.frame.origin.x = screenWidth + 60
            self.unfriendButton.frame.origin.x = screenWidth + 60
            
            self.bcView.alpha = 0
            
            
            }, completion: { Void in
                self.bcView.removeFromSuperview()
                self.scrollView.scrollEnabled = true
                //self.scrollView.userInteractionEnabled = true
                
                self.acceptRequest.userInteractionEnabled = true
                self.friendsButton.userInteractionEnabled = true
                self.settingsButton.userInteractionEnabled = true
                self.denyRequest.userInteractionEnabled = true
                self.friendRequestButton.userInteractionEnabled = true
                
                
        })
        
    }
    
    func acceptFriendRequestPressed(sender: UIButton!) {
        
        //adding friends
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")!)
            
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    for request in request! {
                        self.usersFrom = request["fromUser"] as! String
                        
                        request.deleteEventually()
                    }
                    
                    let userFriendsQuery = PFQuery(className: "Friends")
                    userFriendsQuery.whereKey("username", equalTo: self.usersFrom)
                    userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let friends = friends as? [PFObject]{
                                for friends in friends {
                                    
                                    friends["friends"]?.addObject((PFUser.currentUser()?.username)!)
                                    let r = friends["friends"]
                                    print("his friends are \(r)")
                                    friends.saveInBackground()
                                    self.usersFrom = ""
                                }
                            }
                        }
                        else {
                            print("annerror accured")
                        }
                    })
                }
            })
        }
        
        //adding friends to self
        let friendsQuery = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery.whereKey("user", equalTo: user)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            friends["friends"]?.addObject(NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")!)
                            friends.saveInBackground()
                        }
                    }
                }
                else {
                    print("annerror accured")
                }
            })
        }
        //edn of adding friends
        
        
        acceptRequest.userInteractionEnabled = false
        denyRequest.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.acceptRequest.setBackgroundImage(UIImage(named: "checkmark13.png"), forState: .Normal)
            self.acceptRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            
            self.denyRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            self.denyRequest.alpha = 0
            self.friendStatusLabel.text = "Friend Request Accepted"
            
            
        }
        
        
    }
    
    func denyFriendRequestPressed(sender: UIButton!) {
        
        //handling cloud
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friendrequest")!)
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    for request in request! {
                        request.deleteEventually()
                    }
                }
                else {
                    print("annerror accured")
                }
                
            })
        }
        
        acceptRequest.userInteractionEnabled = false
        denyRequest.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.acceptRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            self.acceptRequest.alpha = 0
            
            
            self.denyRequest.setBackgroundImage(UIImage(named: "close1.png"), forState: .Normal)
            self.denyRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            
            self.friendStatusLabel.text = "Friend Request Denied"
            
            
        }
        
    }
    
    func removeProfile() {
        contentView.removeFromSuperview()
        
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {
            
            
            contentView.frame.origin.y = scrollView.contentOffset.y + 64
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
            friendRequestButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 45
            ifFriend.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            settingsButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            label2o5.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            friendStatusLabel.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            sep.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 45
            acceptRequest.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            denyRequest.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            
        }
        if yPos < 0 {
            
            popOverView.frame.origin.y = scrollView.contentOffset.y + (screenHeight - 155)
            bcView.frame.origin.y = scrollView.contentOffset.y
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            //
            //            //setting top logo
            //            logo = UIImage(named: "ChessIconSmallTextAndLogoDarkMode.png")
            //            logoView = UIImageView(image:logo)
            //            logoView.contentMode = UIViewContentMode.ScaleAspectFit
            //            logoView.frame.size.height = 50
            //            self.navigationItem.titleView = logoView
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            
            //            //setting top logo
            //            logo = UIImage(named: "ChessIconSmallTextAndLogo.png")
            //            logoView = UIImageView(image:logo)
            //            logoView.contentMode = UIViewContentMode.ScaleAspectFit
            //            logoView.frame.size.height = 50
            //            self.navigationItem.titleView = logoView
            //
            
            
            
        }
        
        
    }
    
}

class OtherUserProfilePageFromFriends: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var profilePicBlur = UIImageView()
    
    var popOverView = UIView()
    var dismissButton = UIButton()
    var unfriendButton = UIButton()
    var bcView = UIButton()
    
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    let friendsButton = UIButton()
    var label2 = UILabel()
    var label3 = UILabel()
    var label4 = UILabel()
    var label5 = UILabel()
    
    var label6 = UILabel()
    var label7 = UILabel()
    var label8 = UILabel()
    
    var label9 = UILabel()
    
    var label10 = UILabel()
    var label11 = UILabel()
    
    var label12 = UILabel()
    var label13 = UILabel()
    var label14 = UILabel()
    var label15 = UILabel()
    var label16 = UILabel()
    var label17 = UILabel()
    var usersFrom = String()
    
    var label18 = UILabel()
    
    var label19 = UILabel()
    var label20 = UILabel()
    
    var sep = UILabel()
    
    var profilePic = UIImageView()
    
    var settingsButton = UIButton()
    
    var friendsArrowImage = UIImageView()
    
    var friendStatusLabel = UILabel()
    
    var t:CGFloat = 0
    var pendingOrRecievedFQ = false
    var friendRequestbuttonAlereadyLoadedOnce = false
    
    var underElements:Array<UILabel> = []
    
    var ifFriend = UIImageView()
    var label2o5 = UILabel()
    
    var userRating = String()
    var userWon = String()
    var userDrawn = String()
    var userLost = String()
    var userJoined = NSDate()
    
    
    var acceptRequest = UIButton()
    var denyRequest = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        //  setUpProfile()
        lightOrDarkMode()
        
    }
    override func viewDidAppear(animated: Bool) {
        setUpProfile()
    }
    override func viewWillDisappear(animated: Bool) {
        self.removeProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underElements = [label3,label4,label5,label6,label7,label8,label9,label10,label11,label12,label13,label14,label15,label16,label17]
        
        
        
        self.title = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends") as? String
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
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
    }
    
    func loadUserInfoFromCloud () {
        
        let usersQuery = PFQuery(className: "_User")
        usersQuery.whereKey("username", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends") as! String)
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
        
        
        popOverView = UIView(frame: CGRectMake(0, screenHeight - 155, screenWidth, 200))
        bcView = UIButton(frame: CGRectMake(0, 0, screenWidth, view.frame.size.height))
        
        
        navigationController?.navigationBar.topItem?.title = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends") as? String
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        //creating the view
        //  var contentView: UIView = UIView(frame: CGRectMake(0, 0, screenWidth - 20 , screenHeight/7))
        contentView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight/5))
        //contentView.layer.cornerRadius = cornerRadius
        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        else { contentView.backgroundColor = UIColor.whiteColor() }
        contentView.clipsToBounds = true
        scrollView.addSubview(contentView)
        
        
        
        //setting up bc image of profile pic
        if NSUserDefaults.standardUserDefaults().objectForKey("other_userImage_from_friends") == nil {
            sleep(5)
        }
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("other_userImage_from_friends") as! NSData
        
        profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height+1))
        profilePicBlur.contentMode = .ScaleAspectFill
        profilePicBlur.image = UIImage(data: imageData)
        profilePicBlur.clipsToBounds = true
        contentView.addSubview(profilePicBlur)
        
        //bluring bc of profile pic
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = profilePicBlur.bounds
        profilePicBlur.addSubview(visualEffectView)
        
        //adding the profile pic
        profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 65, (contentView.frame.size.height) - 65))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(data: imageData)
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height - 30 , contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")as? String
        label.font = UIFont(name: "Didot-Bold", size: 30)
        label.sizeToFit()
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
        
        
        
        //adding freinds request button
        let friends = PFQuery(className: "friends")
        if let user = PFUser.currentUser() {
            friends.whereKey("user", equalTo: user)
            friends.whereKey("friends", containsString: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends") as? String)
        }
        
        //adding white bc to fridnrequest
        label2o5 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y, screenWidth, 45))
        label2o5.text = ""
        label2o5.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label2o5)
        
        
        
        //adding the checmark or cross
        ifFriend = UIImageView(frame: CGRectMake(profilePic.frame.origin.x , contentView.frame.height + contentView.frame.origin.y + 7.5, profilePic.frame.size.width, 30))
        ifFriend.layer.cornerRadius = ifFriend.frame.size.height / 2
        ifFriend.clipsToBounds = true
        ifFriend.contentMode = UIViewContentMode.ScaleAspectFit
        scrollView.addSubview(ifFriend)
        
        //setting up frienStatusLabel
        friendStatusLabel = UILabel(frame: CGRectMake(label.frame.origin.x, contentView.frame.height + contentView.frame.origin.y, screenWidth - label.frame.origin.x, 45))
        friendStatusLabel.textAlignment = .Left
        friendStatusLabel.font = UIFont(name: "Didot", size: 16)
        friendStatusLabel.textColor = UIColor.lightGrayColor()
        scrollView.addSubview(friendStatusLabel)
        
        //adding settingsbutton
        settingsButton = UIButton(frame: CGRectMake(screenWidth - 40, ifFriend.frame.origin.y, 30, 30))
        settingsButton.setBackgroundImage(UIImage(named: "equalization2.png"), forState: .Normal)
        settingsButton.addTarget(self, action: "settingsPressed:", forControlEvents: .TouchUpInside)
        settingsButton.alpha = 0
        
        func loadFriendRequestButton() {
            if self.pendingOrRecievedFQ == false {
                
                self.t = 1
                
                self.ifFriend.image = UIImage(named: "close1.png")
                self.friendStatusLabel.text = "You are not friends"
                
                //if not friend:
                self.friendRequestButton.setTitle("Add as Friend", forState: .Normal)
                self.friendRequestButton.titleLabel?.font = UIFont(name: "Didot-Bold", size: 18)
                self.friendRequestButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
                self.friendRequestButton.layer.borderColor = blue.CGColor
                self.friendRequestButton.frame.origin.x = 0
                self.friendRequestButton.frame.origin.y
                    = self.contentView.frame.height + self.contentView.frame.origin.y + 45
                self.friendRequestButton.frame.size.height = 45
                self.friendRequestButton.frame.size.width = screenWidth
                self.friendRequestButton.backgroundColor = UIColor.whiteColor()
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.addTarget(self, action: "friendRequestPressed:", forControlEvents: .TouchUpInside)
                self.friendRequestButton.alpha = 0
                self.scrollView.addSubview(self.friendRequestButton)
                
                
                self.sep = UILabel(frame: CGRectMake(0, self.contentView.frame.height + self.contentView.frame.origin.y + 45 , screenWidth, 0.5))
                if darkMode { self.sep.backgroundColor = UIColor.lightGrayColor() }
                else { self.sep.backgroundColor = UIColor.lightGrayColor() }
                self.scrollView.addSubview(self.sep)
                
                
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.friendRequestButton.alpha = 1
                })
            }
            self.elementSetup()
            self.loadUserInfoFromCloud()
        }
        
        let friendsQuery = PFQuery(className: "Friends")
        if let username = PFUser.currentUser()?.username {
            friendsQuery.whereKey("username", equalTo: username)
            friendsQuery.whereKey("friends", equalTo: label.text!)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friendss:[AnyObject]?, error:NSError?) -> Void in
                
                
                if "\(friendss)" == "Optional([])" {
                    
                    let friendRequestQuery = PFQuery(className: "FriendRequest")
                    if let username = PFUser.currentUser()?.username {
                        friendRequestQuery.whereKey("toUserr", equalTo: username)
                        friendRequestQuery.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")!)
                        friendRequestQuery.whereKey("status", equalTo: "pending")
                        
                        friendRequestQuery.findObjectsInBackgroundWithBlock({ (requests:[AnyObject]?, error:NSError?) -> Void in
                            
                            if "\(requests)" != "Optional([])" {
                                print("you have a friend request from him")
                                
                                self.pendingOrRecievedFQ = true
                                self.loadUserInfoFromCloud()
                                self.elementSetup()
                                self.friendStatusLabel.text = "Recieved Friend Request"
                                
                                self.acceptRequest = UIButton(frame: CGRectMake(self.friendStatusLabel.frame.origin.x - 80, self.ifFriend.frame.origin.y, 30, 30))
                                self.acceptRequest.setBackgroundImage(UIImage(named: "checkmark11.png"), forState: .Normal)
                                self.acceptRequest.addTarget(self, action: "acceptFriendRequestPressed:", forControlEvents: .TouchUpInside)
                                self.scrollView.addSubview(self.acceptRequest)
                                
                                self.denyRequest = UIButton(frame: CGRectMake(self.friendStatusLabel.frame.origin.x - 40, self.ifFriend.frame.origin.y, 30, 30))
                                self.denyRequest.setBackgroundImage(UIImage(named: "close38.png"), forState: .Normal)
                                self.denyRequest.addTarget(self, action: "denyFriendRequestPressed:", forControlEvents: .TouchUpInside)
                                self.scrollView.addSubview(self.denyRequest)
                                
                                
                                
                            }
                            else {
                                
                                let friendRequestQuery2 = PFQuery(className: "FriendRequest")
                                if let username = PFUser.currentUser()?.username {
                                    friendRequestQuery2.whereKey("fromUser", equalTo: username)
                                    friendRequestQuery2.whereKey("toUserr", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")!)
                                    friendRequestQuery2.whereKey("status", equalTo: "pending")
                                    
                                    friendRequestQuery2.findObjectsInBackgroundWithBlock({ (requests:[AnyObject]?, error:NSError?) -> Void in
                                        
                                        if "\(requests)" != "Optional([])" {
                                            print("you have a sent a friend request")
                                            
                                            self.ifFriend.image = UIImage(named: "pending.png")
                                            self.friendStatusLabel.text = "Pending Friend Request"
                                            self.friendRequestButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                                            self.pendingOrRecievedFQ = true
                                            self.loadUserInfoFromCloud()
                                            self.elementSetup()
                                            
                                        }
                                        else {
                                            
                                            loadFriendRequestButton()
                                            
                                        }
                                        
                                    })
                                }
                            }
                            
                        })
                    }
                    
                    
                    
                    
                    
                }
                else {
                    
                    print("\(friendss)")
                    
                    self.ifFriend.image = UIImage(named: "checkmark13.png")
                    self.friendStatusLabel.text = "You are Friends"
                    self.scrollView.addSubview(self.settingsButton)
                    
                    self.elementSetup()
                    self.loadUserInfoFromCloud()
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.settingsButton.alpha = 1
                    })
                }
            })
            //end of add friend
        }
        
        
    }
    
    func elementSetup() {
        
        
        
        
        
        
        
        //adding stats label
        label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + contentView.frame.origin.y + 65 + (45*t), 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statisitics"
        label3.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label3)
        
        //adding white bc to stats
        label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth, 45*4))
        label4.text = ""
        label4.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label4)
        
        //adding won: label
        label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth, 45))
        label5.textAlignment = NSTextAlignment.Left
        label5.text = "Won"
        label5.font = UIFont(name: "Didot", size: 16)
        if darkMode { label5.textColor = UIColor.lightTextColor() }
        else { label5.textColor = UIColor.grayColor() }
        scrollView.addSubview(label5)
        
        //adding drawn: label
        label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth, 45))
        label6.textAlignment = NSTextAlignment.Left
        label6.text = "Drawn"
        label6.font = UIFont(name: "Didot", size: 16)
        if darkMode { label6.textColor = UIColor.lightTextColor() }
        else { label6.textColor = UIColor.grayColor() }
        scrollView.addSubview(label6)
        
        //adding lost: label
        label7 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth, 45))
        label7.textAlignment = NSTextAlignment.Left
        label7.text = "Lost"
        label7.font = UIFont(name: "Didot", size: 16)
        if darkMode { label7.textColor = UIColor.lightTextColor() }
        else { label7.textColor = UIColor.grayColor() }
        scrollView.addSubview(label7)
        
        //adding rating: label
        label8 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth, 45))
        label8.textAlignment = NSTextAlignment.Left
        label8.text = "Rating"
        label8.font = UIFont(name: "Didot", size: 16)
        if darkMode { label8.textColor = UIColor.lightTextColor() }
        else { label8.textColor = UIColor.grayColor() }
        scrollView.addSubview(label8)
        
        //adding seperator: label
        label9 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label9)
        
        //adding seperator2: label
        label10 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label10)
        
        //adding seperator3: label
        label11 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth, 0.5))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label11)
        
        
        //adding won from cloud: label
        label12 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + (45*t), screenWidth - 20, 45))
        label12.textAlignment = NSTextAlignment.Right
        label12.font = UIFont(name: "Didot", size: 16)
        if darkMode { label12.textColor = UIColor.whiteColor() }
        else { label12.textColor = UIColor.blackColor() }
        scrollView.addSubview(label12)
        
        //adding drawn from cloud: label
        label13 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + (45*t), screenWidth - 20, 45))
        label13.textAlignment = NSTextAlignment.Right
        label13.font = UIFont(name: "Didot", size: 16)
        if darkMode { label13.textColor = UIColor.whiteColor() }
        else { label13.textColor = UIColor.blackColor() }
        scrollView.addSubview(label13)
        
        //adding lost from cloud: label
        label14 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + (45*t), screenWidth - 20, 45))
        label14.textAlignment = NSTextAlignment.Right
        label14.font = UIFont(name: "Didot", size: 16)
        if darkMode { label14.textColor = UIColor.whiteColor() }
        else { label14.textColor = UIColor.blackColor() }
        scrollView.addSubview(label14)
        
        //adding rating from cloud: label
        label15 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + (45*t), screenWidth - 20, 45))
        label15.textAlignment = NSTextAlignment.Right
        label15.font = UIFont(name: "Didot", size: 16)
        if darkMode { label15.textColor = UIColor.whiteColor() }
        else { label15.textColor = UIColor.blackColor() }
        scrollView.addSubview(label15)
        
        
        //adding white bc to friends button
        label16 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + (45*t), screenWidth, 45))
        label16.text = ""
        label16.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label16)
        
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        friendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        friendsButton.layer.borderColor = blue.CGColor
        friendsButton.frame.origin.x = 20
        friendsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65  + (45*t)
        friendsButton.frame.size.height = 44
        friendsButton.frame.size.width = screenWidth - 20
        friendsButton.userInteractionEnabled = true
        friendsButton.addTarget(self, action: "friendsPressed:", forControlEvents: .TouchUpInside)
        friendsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(friendsButton)
        
        friendsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + (45*t), 15, 45))
        friendsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { friendsArrowImage.image = UIImage(named: "arrow_white.png"); friendsArrowImage.alpha = 1 }
        else { friendsArrowImage.image = UIImage(named: "arrow_black.png"); friendsArrowImage.alpha = 0.3  }
        scrollView.addSubview(friendsArrowImage)
        
        
        label17 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + 50 + (45*t), screenWidth , 50))
        label17.textAlignment = NSTextAlignment.Center
        label17.text = "Chess♔"
        label17.font = UIFont(name: "Didot", size: 13)
        if darkMode { label17.textColor = UIColor.lightTextColor() }
        else { label17.textColor = UIColor.grayColor() }
        scrollView.addSubview(label17)
        
    }
    
    func friendRequestPressed(sender: UIButton!) {
        
        for var i = 0; i < self.underElements.count; i++ {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.underElements[i].frame.origin.y -= 45
            })
            
        }
        request["fromUser"] = PFUser.currentUser()?.username
        request["toUserr"] = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")
        request["status"] = "pending"
        
        let toUserQuery = PFQuery(className: "FriendRequest")
        toUserQuery.findObjectsInBackgroundWithBlock { (request:[AnyObject]?, error:NSError?) -> Void in
            
        }
        self.friendRequestButton.userInteractionEnabled = false
        request.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                self.friendRequestButton.userInteractionEnabled = false
                self.friendRequestButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.ifFriend.image = UIImage(named: "pending.png")
                self.friendStatusLabel.text = "Pending Friend Request"
                print("request was saved in background")
                self.t = 0
                
            }
            else {
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
                
            }
        }
        
    }
    
    func settingsPressed(sender: UIButton!) {
        
        
        scrollView.scrollEnabled = false
        
        
        bcView.backgroundColor = UIColor.blackColor()
        bcView.alpha = 0
        scrollView.addSubview(bcView)
        
        popOverView.userInteractionEnabled = true
        scrollView.addSubview(popOverView)
        
        
        unfriendButton = UIButton(frame: CGRectMake(screenWidth + 120, 5, screenWidth - 10, 45))
        unfriendButton.setTitle("Unfriend", forState: .Normal)
        unfriendButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        unfriendButton.titleLabel?.font = UIFont(name: "Didot", size: 20)
        unfriendButton.backgroundColor = UIColor.whiteColor()
        unfriendButton.layer.cornerRadius = cornerRadius
        unfriendButton.userInteractionEnabled = true
        popOverView.addSubview(unfriendButton)
        
        dismissButton = UIButton(frame: CGRectMake(screenWidth + 60, 55, screenWidth - 10, 45))
        dismissButton.setTitle("Dismiss", forState: .Normal)
        dismissButton.setTitleColor(blue, forState: .Normal)
        dismissButton.titleLabel?.font = UIFont(name: "Didot", size: 20)
        dismissButton.backgroundColor = UIColor.whiteColor()
        dismissButton.layer.cornerRadius = cornerRadius
        dismissButton.alpha = 0.9
        dismissButton.userInteractionEnabled = true
        popOverView.addSubview(dismissButton)
        
        unfriendButton.addTarget(self, action: "unfriendPressed:", forControlEvents: .TouchUpInside)
        dismissButton.addTarget(self, action: "dismissPressed:", forControlEvents: .TouchUpInside)
        bcView.addTarget(self, action: "bcviewPressed:", forControlEvents: .TouchUpInside)
        
        self.acceptRequest.userInteractionEnabled = false
        self.friendsButton.userInteractionEnabled = false
        self.settingsButton.userInteractionEnabled = false
        self.denyRequest.userInteractionEnabled = false
        self.friendRequestButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.8, delay: 0.2, usingSpringWithDamping: 50, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.dismissButton.frame.origin.x = 5
            self.unfriendButton.frame.origin.x = 5
            self.bcView.alpha = 0.3
            
            
            }, completion: {Void in
                
                
        })
        
        
    }
    
    func unfriendPressed(sender: UIButton!) {
        print("pressed")
        
        var ff = NSMutableArray()
        
        //adding friends
        let friendsQuery2 = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery2.whereKey("username", equalTo: user.username!)
            friendsQuery2.whereKey("friends", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")!)
            
            friendsQuery2.findObjectsInBackgroundWithBlock({ (friends:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    for friends in friends! {
                        
                        ff = friends["friends"] as! NSMutableArray
                        print(ff)
                        
                    }
                    for var i = 0; i < ff.count; i++ {
                        
                        if ff[i] as! String == NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends") as! String {
                            ff.removeObjectAtIndex(i)
                            print(ff)
                            
                        }
                    }
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            friends["friends"] = ff
                            friends.saveInBackground()
                        }
                    }
                }
            })
        }
        
        
        var off = NSMutableArray()
        
        let userFriendsQuery = PFQuery(className: "Friends")
        userFriendsQuery.whereKey("username", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends") as! String)
        userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                for friends in friends! {
                    off = friends["friends"] as! NSMutableArray
                }
                
                for var i = 0; i < off.count; i++ {
                    if off[i] as? String == PFUser.currentUser()?.username {
                        off.removeObjectAtIndex(i)
                    }
                    
                }
                
                if let friends = friends as? [PFObject]{
                    for friends in friends {
                        friends["friends"] = off
                        friends.saveInBackground()
                    }
                }
                
                UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    //   self.scrollView.userInteractionEnabled = false
                    self.dismissButton.frame.origin.x = screenWidth + 60
                    self.unfriendButton.frame.origin.x = screenWidth + 60
                    
                    self.bcView.alpha = 0
                    
                    self.ifFriend.image = UIImage(named: "close1.png")
                    self.friendStatusLabel.text = "Removed Friend"
                    self.settingsButton.alpha = 0
                    
                    }, completion: { Void in
                        self.bcView.removeFromSuperview()
                        self.scrollView.scrollEnabled = true
                        //self.scrollView.userInteractionEnabled = true
                        
                        self.acceptRequest.userInteractionEnabled = true
                        self.friendsButton.userInteractionEnabled = true
                        self.denyRequest.userInteractionEnabled = true
                        self.friendRequestButton.userInteractionEnabled = true
                        self.settingsButton.hidden = true
                        
                        
                })
                
            }
            else {
                print("annerror accured")
            }
        })
        
        
        //edn of adding friends
        
        
        
        
        
    }
    func dismissPressed(sender: UIButton!) {
        
        print("pressed")
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //   self.scrollView.userInteractionEnabled = false
            self.dismissButton.frame.origin.x = screenWidth + 60
            self.unfriendButton.frame.origin.x = screenWidth + 60
            
            self.bcView.alpha = 0
            
            
            }, completion: { Void in
                self.bcView.removeFromSuperview()
                self.scrollView.scrollEnabled = true
                //self.scrollView.userInteractionEnabled = true
                
                self.acceptRequest.userInteractionEnabled = true
                self.friendsButton.userInteractionEnabled = true
                self.settingsButton.userInteractionEnabled = true
                self.denyRequest.userInteractionEnabled = true
                self.friendRequestButton.userInteractionEnabled = true
                
                
        })
        
    }
    func bcviewPressed(sender: UIButton!) {
        print("pressed")
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 50, initialSpringVelocity: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            //   self.scrollView.userInteractionEnabled = false
            self.dismissButton.frame.origin.x = screenWidth + 60
            self.unfriendButton.frame.origin.x = screenWidth + 60
            
            self.bcView.alpha = 0
            
            
            }, completion: { Void in
                self.bcView.removeFromSuperview()
                self.scrollView.scrollEnabled = true
                //self.scrollView.userInteractionEnabled = true
                
                self.acceptRequest.userInteractionEnabled = true
                self.friendsButton.userInteractionEnabled = true
                self.settingsButton.userInteractionEnabled = true
                self.denyRequest.userInteractionEnabled = true
                self.friendRequestButton.userInteractionEnabled = true
                
                
        })
        
    }
    
    func acceptFriendRequestPressed(sender: UIButton!) {
        
        //adding friends
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")!)
            
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    
                    for request in request! {
                        self.usersFrom = request["fromUser"] as! String
                        
                        request.deleteEventually()
                    }
                    
                    let userFriendsQuery = PFQuery(className: "Friends")
                    userFriendsQuery.whereKey("username", equalTo: self.usersFrom)
                    userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            if let friends = friends as? [PFObject]{
                                for friends in friends {
                                    
                                    friends["friends"]?.addObject((PFUser.currentUser()?.username)!)
                                    let r = friends["friends"]
                                    print("his friends are \(r)")
                                    friends.saveInBackground()
                                    self.usersFrom = ""
                                }
                            }
                        }
                        else {
                            print("annerror accured")
                        }
                    })
                }
            })
        }
        
        //adding friends to self
        let friendsQuery = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery.whereKey("user", equalTo: user)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            friends["friends"]?.addObject(NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")!)
                            friends.saveInBackground()
                        }
                    }
                }
                else {
                    print("annerror accured")
                }
            })
        }
        //edn of adding friends
        
        
        acceptRequest.userInteractionEnabled = false
        denyRequest.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.acceptRequest.setBackgroundImage(UIImage(named: "checkmark13.png"), forState: .Normal)
            self.acceptRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            
            self.denyRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            self.denyRequest.alpha = 0
            self.friendStatusLabel.text = "Friend Request Accepted"
            
            
        }
        
        
    }
    
    func denyFriendRequestPressed(sender: UIButton!) {
        
        //handling cloud
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends")!)
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    for request in request! {
                        request.deleteEventually()
                    }
                }
                else {
                    print("annerror accured")
                }
                
            })
        }
        
        acceptRequest.userInteractionEnabled = false
        denyRequest.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.acceptRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            self.acceptRequest.alpha = 0
            
            
            self.denyRequest.setBackgroundImage(UIImage(named: "close1.png"), forState: .Normal)
            self.denyRequest.frame.origin.x = self.profilePic.frame.origin.x + (self.profilePic.frame.size.width / 2) - 15
            
            self.friendStatusLabel.text = "Friend Request Denied"
            
            
        }
        
    }
    
    func removeProfile() {
        contentView.removeFromSuperview()
        
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {
            
            
            contentView.frame.origin.y = scrollView.contentOffset.y + 64
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
            friendRequestButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 45
            ifFriend.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            settingsButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            label2o5.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            friendStatusLabel.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            sep.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 45
            acceptRequest.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            denyRequest.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height + 7.5
            
        }
        if yPos < 0 {
            
            popOverView.frame.origin.y = scrollView.contentOffset.y + (screenHeight - 155)
            bcView.frame.origin.y = scrollView.contentOffset.y
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            //
            //            //setting top logo
            //            logo = UIImage(named: "ChessIconSmallTextAndLogoDarkMode.png")
            //            logoView = UIImageView(image:logo)
            //            logoView.contentMode = UIViewContentMode.ScaleAspectFit
            //            logoView.frame.size.height = 50
            //            self.navigationItem.titleView = logoView
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            
            //            //setting top logo
            //            logo = UIImage(named: "ChessIconSmallTextAndLogo.png")
            //            logoView = UIImageView(image:logo)
            //            logoView.contentMode = UIViewContentMode.ScaleAspectFit
            //            logoView.frame.size.height = 50
            //            self.navigationItem.titleView = logoView
            //
            
            
            
        }
        
        
    }
    
}