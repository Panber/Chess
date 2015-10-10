//
//  FriendRequestsPage.swift
//  Chess♔
//
//  Created by Johannes Berge on 07/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var frequests = PFObject(className: "FriendRequest")



class FriendRequestsPage: UIViewController, UITableViewDelegate, UIScrollViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var userArray: Array<String> = []
    var profilePicArray: Array<UIImage> = []
    var i = 0

    var profilePic = UIImageView()
    var nameText = String()
    
    var checkmarkButton = UIButton()
    var crossButton = UIButton()
    var checkButtons:Array<UIButton> = []
    var crossButtons:Array<UIButton> = []
    var userFriends = NSMutableArray()
    var usersFrom = String()

    var friendRequestUsers: Array<String> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()

        
    }
    
    // MARK - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func getUsers() {
     
        let frequestsQuery = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser()?.username {
            frequestsQuery.whereKey("toUserr", equalTo: (user))
            frequestsQuery.orderByDescending("updatedAt")
            frequestsQuery.whereKey("status", equalTo: "pending")
            frequestsQuery.findObjectsInBackgroundWithBlock({ (frequests:[AnyObject]?, error:NSError?) -> Void in

                
                for frequests in frequests! {
                    let username:String? = frequests["fromUser"] as? String
                    self.userArray.append(username!)
                    print(username)
                    self.friendRequestUsers.append(username!)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                }
       
            })
            //self.tableView.reloadData()
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell2 = self.tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! UserTableViewCell2

        
        cell.checkmarkButton.tag = indexPath.row + 1
        cell.checkmarkButton.addTarget(self, action: "checkmarkButtonPressed:", forControlEvents: .TouchUpInside)
        
        cell.crossButton.tag = indexPath.row + 100_000
        cell.crossButton.addTarget(self, action: "crossButtonPressed:", forControlEvents: .TouchUpInside)

        cell.username.text = userArray[indexPath.row]
        cell.username.sizeToFit()
        
        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("username", equalTo: userArray[indexPath.row])
        let  _user = userQuery.getFirstObject() as! PFUser
        
        let profilePictureObject = _user["profile_picture"] as? PFFile
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.profilePicArray.append(UIImage(data: imageData!)!)
                    cell.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFill
                    cell.userProfileImage.image = self.profilePicArray[indexPath.row]
                    NSUserDefaults.standardUserDefaults().setObject(imageData!, forKey: "other_userImage")
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
                    self.showViewController(vc as! UIViewController, sender: vc)
                }
                
            }
        }
        

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userArray.count
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        NSUserDefaults.standardUserDefaults().setObject(userArray[indexPath.row], forKey: "other_username")
//        
//        let userQuery = PFQuery(className: "_User")
//        userQuery.whereKey("username", equalTo: userArray[indexPath.row])
//        let  _user = userQuery.getFirstObject() as! PFUser
//        
//        let profilePictureObject = _user["profile_picture"] as? PFFile
        
//        if(profilePictureObject != nil)
//        {
//            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
//                
//                if(imageData != nil)
//                {
////                    NSUserDefaults.standardUserDefaults().setObject(imageData!, forKey: "other_userImage")
////                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
////                    self.showViewController(vc as! UIViewController, sender: vc)
//                }
//                
//            }
//        }
       
        
        
        
    }
    

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    
    
    // MARK - funcs
    
    
    func checkmarkButtonPressed(sender:UIButton) {

        
        
        
        let buttonRow = sender.tag
        let tmpButton = self.view.viewWithTag(buttonRow) as? UIButton
        checkmarkButton = tmpButton!
        checkmarkButton.setBackgroundImage(UIImage(named: "checkmark12.png"), forState: .Normal)
        
        
        
        self.userFriends.addObject(friendRequestUsers[buttonRow-1])
        
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: userArray[buttonRow - 1])
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
                            
                            friends["friends"]?.addObject(self.userFriends[self.userFriends.count - 1])
                            friends.saveInBackground()
                        }
                    }
                }
                else {
                    print("annerror accured")
                }
            })
        }
        

        //end of accepting
        
        
        //editing the view
        let buttonRow2 = sender.tag + 99_999
        let tmpButton2 = self.view.viewWithTag(buttonRow2) as? UIButton
        crossButton = tmpButton2!
        
        checkmarkButton.userInteractionEnabled = false
        crossButton.userInteractionEnabled = false
        
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        let rightConstraint = NSLayoutConstraint(item: checkmarkButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: crossButton, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 1)
        
        UIButton.animateWithDuration(0.5) { () -> Void in
            self.crossButton.alpha = 0
            
            
            rightConstraint.constant = 0
            self.view.addConstraint(rightConstraint)
            self.view.layoutIfNeeded()
            
            
        }

    }
    
    func crossButtonPressed(sender:UIButton) {
        
        
        
        let buttonRow = sender.tag
        let tmpButton = self.view.viewWithTag(buttonRow) as? UIButton
        crossButton = tmpButton!
        self.crossButton.setBackgroundImage(UIImage(named: "close1.png"), forState: .Normal)

        let buttonRow2 = sender.tag - 99_999
        let tmpButton2 = self.view.viewWithTag(buttonRow2) as? UIButton
        checkmarkButton = tmpButton2!
        
        
        
        //handling cloud
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: userArray[buttonRow - 100_000])
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
        
        
        //end of cloud handling
        
        
        checkmarkButton.userInteractionEnabled = false
        crossButton.userInteractionEnabled = false
        
        
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false

        let rightConstraint = NSLayoutConstraint(item: checkmarkButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: crossButton, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 1)
        
        
        UIButton.animateWithDuration(0.5) { () -> Void in
            self.checkmarkButton.alpha = 0
            
            rightConstraint.constant = 0
            self.view.addConstraint(rightConstraint)
            self.view.layoutIfNeeded()
            
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
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            
        }
        
    }

    


}
