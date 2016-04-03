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
    var userCount: Array<String> = []

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
    var imageDataArray: Array<NSData> = []

    var friendRequestUsers: Array<String> = []
    
    var imageDataDict = [1 : NSData(),2:NSData(),3:NSData(),4 : NSData(),5 : NSData(),6 : NSData(),7 : NSData(),8 : NSData(),9 : NSData(),10 : NSData()]
    
    var img : Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()

        
    }
    
    func checkForFriends() {
        if userArray.count == 0 {
            
            let alert = UIAlertController(title: "Oops!", message: "It does not seem like you have any friend requests at the moment.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    self.navigationController!.popViewControllerAnimated(true)
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
         userArray = []
         userCount = []
        
         profilePicArray = []
         i = 0
        
         profilePic = UIImageView()
         nameText = String()
        
         checkmarkButton = UIButton()
         crossButton = UIButton()
         checkButtons = []
         crossButtons = []
         userFriends = NSMutableArray()
         usersFrom = String()
         imageDataArray = []
        
         friendRequestUsers = []
        
         imageDataDict = [1 : NSData(),2:NSData(),3:NSData(),4 : NSData(),5 : NSData(),6 : NSData(),7 : NSData(),8 : NSData(),9 : NSData(),10 : NSData()]
        
         img = []
        
        lightOrDarkMode()

findRequests()

    }
    
    func findRequests() {
    
        let frequestsQuery = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser()?.username {
            frequestsQuery.whereKey("toUserr", equalTo: (user))
            frequestsQuery.orderByDescending("updatedAt")
            frequestsQuery.whereKey("status", equalTo: "pending")
            frequestsQuery.findObjectsInBackgroundWithBlock({ (frequests:[AnyObject]?, error:NSError?) -> Void in
                
                    for frequests in frequests! {
                        
                        let username:String? = frequests["fromUser"] as? String
                        self.userArray.append(username!)
                       
                        
                        
                        //                    print(username)
                        self.friendRequestUsers.append(username!)
                        
                        ///////
                        

                        self.tableView.reloadData()

                        
                        
                        
                    }

                    
                

                
            })
            
        }
    
    }
    
    // MARK - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return userArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell2 = self.tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! UserTableViewCell2

        cell.username.highlightedTextColor = UIColor.whiteColor()
        cell.rating.highlightedTextColor = UIColor.whiteColor()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        if darkMode {
            cell.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            cell.rating.textColor = UIColor.lightTextColor()
            cell.username.textColor =  UIColor.whiteColor()
            
        }
        else {
            
            cell.backgroundColor = UIColor.whiteColor()
            cell.rating.textColor = UIColor.darkGrayColor()
            cell.username.textColor =  UIColor.blackColor()
        }
        
        
        
        cell.checkmarkButton.tag = indexPath.row + 1
        cell.checkmarkButton.addTarget(self, action: "checkmarkButtonPressed:", forControlEvents: .TouchUpInside)
        
        cell.crossButton.tag = indexPath.row + 100_000
        cell.crossButton.addTarget(self, action: "crossButtonPressed:", forControlEvents: .TouchUpInside)

        
        var array:Array<String> = []
        
        var GlobalBackgroundQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
        }
        
        cell.username.text = self.userArray[indexPath.row]
        cell.username.sizeToFit()
        
        cell.userProfileImage.alpha = 0
        cell.userProfileImage.image = nil

        let query = PFQuery(className: "_User")
        let usernamee = self.userArray
        
        query.whereKey("username", equalTo: usernamee[indexPath.row])
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                
                
                if let userArray = objects as? [PFUser] {
                    for user in userArray {
                        
                        let r = user["rating"] as! Int
                        cell.rating.text = "\(r)"
                        if let userPicture = user["profile_picture"] as? PFFile {
                            
                            let imageData = userPicture.getData()
                            
                            cell.userProfileImage.contentMode = .ScaleAspectFill
                            cell.userProfileImage.image = UIImage(data: imageData!)
                            
                            self.imageDataArray.append(imageData!)
                            
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                cell.userProfileImage.alpha = 1
                                
                                
                            })

                        }
                    }
                    
                    
                }
            } else {
                // Log details of the failure
                print("query error: \(error) \(error!.userInfo)")
            }
            
        }
        
        


        return cell
    }
    

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("row selected")
        
        
        let indexPath = tableView.indexPathForSelectedRow!
        
      //  let cell = tableView.cellForRowAtIndexPath(indexPath)
        
     //   println(currentCell.textLabel!.text)
        
        //let cell:UserTableViewCell2 = self.tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! UserTableViewCell2
        
        NSUserDefaults.standardUserDefaults().setObject(userArray[indexPath.row], forKey: "other_username_profile")
       // cell.username.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_profile") as! String
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        var p = imageDataArray[indexPath.row]
        NSUserDefaults.standardUserDefaults().setObject(p, forKey: "other_userImage_profile")
      //  cell.userProfileImage.image = UIImage(data: p)
        
    }
    

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    
    
    // MARK - funcs
    
    
    func checkmarkButtonPressed(sender:UIButton) {

        
        
        
        let buttonRow = sender.tag
        let tmpButton = self.view.viewWithTag(buttonRow) as? UIButton
        checkmarkButton = tmpButton!
        
        
        
        self.userFriends.addObject(friendRequestUsers[buttonRow-1])
        
        let requestQuery2 = PFQuery(className: "FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery2.whereKey("toUserr", equalTo: user.username!)
            requestQuery2.whereKey("fromUser", equalTo: userArray[buttonRow - 1])
            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    
                    if let request = request as! [PFObject]! {
                    for request in request {
                        self.usersFrom = request["fromUser"] as! String
                        
                        request.deleteEventually()
                    }
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
                            if numberOfFriendRequests != 0 {
                            numberOfFriendRequests--
                            }
                            self.tabBarController?.tabBar.items?.last?.badgeValue = "\(numberOfFriendRequests)"
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
        
//        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        let rightConstraint = NSLayoutConstraint(item: checkmarkButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: crossButton, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 1)
        
        UIButton.animateWithDuration(0.5) { () -> Void in
            self.crossButton.alpha = 0
            self.checkmarkButton.setBackgroundImage(UIImage(named: "checkmark12.png"), forState: .Normal)

            
//            rightConstraint.constant = 0
//            self.view.addConstraint(rightConstraint)
//            self.view.layoutIfNeeded()
            
            
        }

    }
    
    func crossButtonPressed(sender:UIButton) {
        
        
        
        let buttonRow = sender.tag
        let tmpButton = self.view.viewWithTag(buttonRow) as? UIButton
        crossButton = tmpButton!

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
                        numberOfFriendRequests--
                        self.tabBarController?.tabBar.items?.last?.badgeValue = "\(numberOfFriendRequests)"
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
        
        
//        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
//
//        let rightConstraint = NSLayoutConstraint(item: checkmarkButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: crossButton, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 1)
        
        
        UIButton.animateWithDuration(0.5) { () -> Void in
            self.checkmarkButton.alpha = 0
            self.crossButton.setBackgroundImage(UIImage(named: "close1.png"), forState: .Normal)

//            
//            
//            rightConstraint.constant = 0
//            self.view.addConstraint(rightConstraint)
//            self.view.layoutIfNeeded()
            
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
            
            self.tableView.backgroundColor = UIColor(red: 0.20, green: 0.20 , blue: 0.20, alpha: 1)
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            self.tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)

            
        }
        
    }

    
    


}
