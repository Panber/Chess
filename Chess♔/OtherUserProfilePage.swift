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
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    let friendsButton = UIButton()
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
        //  setUpProfile()
    }
    override func viewDidAppear(animated: Bool) {
        setUpProfile()
    }
    override func viewWillDisappear(animated: Bool) {
        self.removeProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        loadUserInfoFromCloud()
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
        let profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 65, (contentView.frame.size.height) - 65))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(data: imageData)
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height - 20 , contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username")as? String
        label.font = UIFont(name: "Didot-Bold", size: 30)
        if darkMode { label.textColor = UIColor.whiteColor() }
        else { label.textColor = UIColor.blackColor() }
        contentView.addSubview(label)
        
        
        //adding rating label
        label2 = UILabel(frame: CGRectMake(contentView.frame.size.height - 20 , label.frame.origin.y + 30, 100, 40))
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
        
        
        
        //if not friend:
        friendRequestButton.setTitle("Add as Friend", forState: .Normal)
        friendRequestButton.titleLabel?.font = UIFont(name: "Didot-Bold", size: 18)
        friendRequestButton.setTitleColor(blue, forState: .Normal)
        friendRequestButton.layer.borderColor = blue.CGColor
        friendRequestButton.frame.origin.x = 0
        friendRequestButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y
        friendRequestButton.frame.size.height = 44
        friendRequestButton.frame.size.width = screenWidth
        friendRequestButton.backgroundColor = UIColor.whiteColor()
        friendRequestButton.userInteractionEnabled = true
        friendRequestButton.addTarget(self, action: "friendRequestPressed:", forControlEvents: .TouchUpInside)
        scrollView.addSubview(friendRequestButton)
        
        //adding stats label
        let label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + contentView.frame.origin.y + 65, 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statisitics"
        label3.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label3)
        
        //adding white bc to stats
        let label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25, screenWidth, 45*4))
        label4.text = ""
        label4.backgroundColor = UIColor.whiteColor()
            scrollView.addSubview(label4)
        
        //adding won: label
        let label5 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25, screenWidth, 45))
        label5.textAlignment = NSTextAlignment.Left
        label5.text = "Won"
        label5.font = UIFont(name: "Didot", size: 16)
        if darkMode { label5.textColor = UIColor.lightTextColor() }
        else { label5.textColor = UIColor.grayColor() }
        scrollView.addSubview(label5)

        //adding drawn: label
        let label6 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45, screenWidth, 45))
        label6.textAlignment = NSTextAlignment.Left
        label6.text = "Drawn"
        label6.font = UIFont(name: "Didot", size: 16)
        if darkMode { label6.textColor = UIColor.lightTextColor() }
        else { label6.textColor = UIColor.grayColor() }
        scrollView.addSubview(label6)
        
        //adding lost: label
        let label7 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45, screenWidth, 45))
        label7.textAlignment = NSTextAlignment.Left
        label7.text = "Lost"
        label7.font = UIFont(name: "Didot", size: 16)
        if darkMode { label7.textColor = UIColor.lightTextColor() }
        else { label7.textColor = UIColor.grayColor() }
        scrollView.addSubview(label7)
        
        //adding rating: label
        let label8 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45, screenWidth, 45))
        label8.textAlignment = NSTextAlignment.Left
        label8.text = "Rating"
        label8.font = UIFont(name: "Didot", size: 16)
        if darkMode { label8.textColor = UIColor.lightTextColor() }
        else { label8.textColor = UIColor.grayColor() }
        scrollView.addSubview(label8)
        
        //adding seperator: label
        let label9 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45, screenWidth, 0.5))
        if darkMode { label9.backgroundColor = UIColor.lightGrayColor() }
        else { label9.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label9)
        
        //adding seperator2: label
        let label10 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45, screenWidth, 0.5))
        if darkMode { label10.backgroundColor = UIColor.lightGrayColor() }
        else { label10.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label10)
        
        //adding seperator3: label
        let label11 = UILabel(frame: CGRectMake(20, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45, screenWidth, 0.5))
        if darkMode { label11.backgroundColor = UIColor.lightGrayColor() }
        else { label11.backgroundColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label11)
        
        
        //adding won from cloud: label
        label12 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25, screenWidth - 20, 45))
        label12.textAlignment = NSTextAlignment.Right
        label12.font = UIFont(name: "Didot", size: 16)
        if darkMode { label12.textColor = UIColor.whiteColor() }
        else { label12.textColor = UIColor.blackColor() }
        scrollView.addSubview(label12)
        
        //adding drawn from cloud: label
        label13 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45, screenWidth - 20, 45))
        label13.textAlignment = NSTextAlignment.Right
        label13.font = UIFont(name: "Didot", size: 16)
        if darkMode { label13.textColor = UIColor.whiteColor() }
        else { label13.textColor = UIColor.blackColor() }
        scrollView.addSubview(label13)
        
        //adding lost from cloud: label
        label14 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45, screenWidth - 20, 45))
        label14.textAlignment = NSTextAlignment.Right
        label14.font = UIFont(name: "Didot", size: 16)
        if darkMode { label14.textColor = UIColor.whiteColor() }
        else { label14.textColor = UIColor.blackColor() }
        scrollView.addSubview(label14)
        
        //adding rating from cloud: label
        label15 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45, screenWidth - 20, 45))
        label15.textAlignment = NSTextAlignment.Right
        label15.font = UIFont(name: "Didot", size: 16)
        if darkMode { label15.textColor = UIColor.whiteColor() }
        else { label15.textColor = UIColor.blackColor() }
        scrollView.addSubview(label15)

        
        //adding white bc to friends button
        let label16 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65, screenWidth, 45))
        label16.text = ""
        label16.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(label16)
        
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        friendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        friendsButton.layer.borderColor = blue.CGColor
        friendsButton.frame.origin.x = 20
        friendsButton.frame.origin.y
            = contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65
        friendsButton.frame.size.height = 44
        friendsButton.frame.size.width = screenWidth - 20
        friendsButton.userInteractionEnabled = true
        friendsButton.addTarget(self, action: "friendsPressed:", forControlEvents: .TouchUpInside)
        friendsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        scrollView.addSubview(friendsButton)
        
        let friendsArrowImage = UIImageView(frame: CGRectMake(screenWidth - 30, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65, 15, 45))
        friendsArrowImage.contentMode = .ScaleAspectFit
        if darkMode { friendsArrowImage.image = UIImage(named: "arrow_white.png"); friendsArrowImage.alpha = 1 }
        else { friendsArrowImage.image = UIImage(named: "arrow_black.png"); friendsArrowImage.alpha = 0.3  }
        scrollView.addSubview(friendsArrowImage)
        
        
        let label17 = UILabel(frame: CGRectMake(0, contentView.frame.height + contentView.frame.origin.y + 65 + 25 + 45 + 45 + 45 + 65 + 50, screenWidth, 50))
        label17.textAlignment = NSTextAlignment.Center
        label17.text = "Chess♔"
        label17.font = UIFont(name: "Didot", size: 13)
        if darkMode { label17.textColor = UIColor.lightTextColor() }
        else { label17.textColor = UIColor.grayColor() }
        scrollView.addSubview(label17)
        
        
        
        
    }
    
    func friendRequestPressed(sender: UIButton!) {
        
        
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
                self.friendRequestButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
                self.friendRequestButton.setTitle("Pending Friend Request", forState: UIControlState.Normal)
                print("request was saved in background")
            }
            else {
                self.friendRequestButton.userInteractionEnabled = true
                self.friendRequestButton.setTitleColor(blue, forState: .Normal)
}
        }
        
    }
    
    func removeProfile() {
        contentView.removeFromSuperview()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {

            
            contentView.frame.origin.y = scrollView.contentOffset.y + 64
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
            friendRequestButton.frame.origin.y = scrollView.contentOffset.y + 64 + contentView.frame.size.height
            
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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