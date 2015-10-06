//
//  OtherUserProfilePage.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse


class OtherUserProfilePage: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var profilePicBlur = UIImageView()
    let friendRequestButton = UIButton()
    var contentView = UIView()
    var request = PFObject(className: "FriendRequest")
    
    
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
    
    func setUpProfile () {
        
        
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
        let profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 40, (contentView.frame.size.height) - 40))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(data: imageData)
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height  + 15, contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username")as? String
        label.font = UIFont(name: "Didot-Bold", size: 30)
        if darkMode { label.textColor = UIColor.whiteColor() }
        else { label.textColor = UIColor.blackColor() }
        contentView.addSubview(label)
        
        
        //adding updated since label
        let label2 = UILabel(frame: CGRectMake(contentView.frame.size.height  + 15, contentView.frame.size.height - contentView.frame.size.height/2.4, 100, 40))
        label2.textAlignment = NSTextAlignment.Left
        label2.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        label2.numberOfLines = 0
        label2.text = "Rating: "
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
        friendRequestButton.setTitle("Add as friend", forState: .Normal)
        friendRequestButton.titleLabel?.font = UIFont(name: "Didot-Bold", size: 18)
        friendRequestButton.layer.borderWidth = 0
        friendRequestButton.layer.cornerRadius = 0
        friendRequestButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        friendRequestButton.layer.borderColor = UIColor.blueColor().CGColor
        friendRequestButton.frame.origin.x = 0
        friendRequestButton.frame.origin.y
            = contentView.frame.height + 20 + contentView.frame.origin.y
        friendRequestButton.frame.size.height = 44
        friendRequestButton.frame.size.width = screenWidth
        friendRequestButton.backgroundColor = UIColor.whiteColor()
        friendRequestButton.userInteractionEnabled = true
        friendRequestButton.addTarget(self, action: "friendRequestPressed:", forControlEvents: .TouchUpInside)
        scrollView.addSubview(friendRequestButton)
        
        //adding stats label
        let label3 = UILabel(frame: CGRectMake(10, contentView.frame.height + 20 + contentView.frame.origin.y + 65, 150, 25))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Statisitics"
        label3.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label3.textColor = UIColor.lightTextColor() }
        else { label3.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label3)
        
        //adding won: label
        let label4 = UILabel(frame: CGRectMake(0, contentView.frame.height + 20 + contentView.frame.origin.y + 65 + 25, screenWidth, 45))
        label4.textAlignment = NSTextAlignment.Left
        label4.text = "Won"
        label4.backgroundColor = UIColor.whiteColor()
        label4.font = UIFont(name: "Didot-Italic", size: 16)
        if darkMode { label4.textColor = UIColor.lightTextColor() }
        else { label4.textColor = UIColor.lightGrayColor() }
        scrollView.addSubview(label4)
        
        
        
        
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
                self.friendRequestButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
            }
        }
        
    }
    
    func removeProfile() {
        contentView.removeFromSuperview()
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {
            //            CGRect imgRect = self.imageView.frame;
            //            imgRect.origin.y = scrollView.contentOffset.y;
            //            imgRect.size.height = HeaderHeight+yPos;
            //            self.imageView.frame = imgRect;
            
            contentView.frame.origin.y = scrollView.contentOffset.y + 64
            // contentView.frame.size.height =  screenHeight/5 + yPos
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
            
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