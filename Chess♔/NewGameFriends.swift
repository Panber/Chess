//
//  NewGameFriends.swift
//  Chess♔
//
//  Created by Johannes Berge on 24/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class NewGameFriends: UIViewController, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var friendsArray: Array<String> = []
    var ratingArray: Array<Int> = []
    
    var profilePicArray: Array<UIImage> = []
    
    var imageDataArray: Array<NSData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFriends() {
        
        let query = PFQuery(className: "Friends")
        if let user = PFUser.currentUser()?.username {
            query.whereKey("username", equalTo: (user))
            // pfQuery.orderByDescending("updatedAt")
            query.findObjectsInBackgroundWithBlock({ (friends:[AnyObject]?, error:NSError?) -> Void in
                for friends in friends! {
                    self.friendsArray = (friends["friends"] as? Array<String>)!
                    print(self.friendsArray)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                }
                self.checkForFriends()
            })
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if friendsArray.count == 0 {
            self.tableView.rowHeight = 70
        }
        
        return friendsArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:NewGameFriendsTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("newGameFriendsCell", forIndexPath: indexPath) as! NewGameFriendsTableViewCell
        
        

        
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
        
        cell.username.text = friendsArray[indexPath.row] 
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("username", equalTo: friendsArray[indexPath.row])
        
        let _user = userQuery.getFirstObject() as! PFUser
        
        cell.rating.text = String(_user["rating"] as! Int)
        ratingArray.append(_user["rating"] as! Int)
        
        let profilePictureObject = _user["profile_picture"] as? PFFile
        
    
 
        if(profilePictureObject != nil)
        {
            let imageData = profilePictureObject!.getData()
            if imageData != nil {
                self.profilePicArray.append(UIImage(data: imageData!)!)
                cell.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFill
                cell.userProfileImage.image = self.profilePicArray[indexPath.row]
                self.imageDataArray.append(imageData!)
            }
            
        }
        
        if cell.username.text == friendsArray.last {
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:NewGameFriendsTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("newGameFriendsCell", forIndexPath: indexPath) as! NewGameFriendsTableViewCell
        
        NSUserDefaults.standardUserDefaults().setObject(friendsArray[indexPath.row], forKey: "other_username_from_friends_gamemenu")
        cell.username.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends_gamemenu") as? String
        
        let p = imageDataArray[indexPath.row]
        NSUserDefaults.standardUserDefaults().setObject(p, forKey: "other_userImage_from_friends_gamemenu")
        cell.userProfileImage.image = UIImage(data: p)
        cell.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFill

        
        NSUserDefaults.standardUserDefaults().setObject(ratingArray[indexPath.row], forKey: "other_userrating_from_friends_gamemenu")
        cell.rating.text = String(NSUserDefaults.standardUserDefaults().objectForKey("other_userrating_from_friends_gamemenu") as! Int)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Friends"
        lightOrDarkMode()
        friendsArray = []
        ratingArray = []
        
        profilePicArray = []
        
        imageDataArray = []
        
        tableView.reloadData()
        getFriends()
        


    }
    
    func checkForFriends() {
        if friendsArray.count == 0 {
            
            let alert = UIAlertController(title: "Oops!", message: "It seems like you have no friends yet. Add friends by using the 'explore' tab.", preferredStyle: UIAlertControllerStyle.Alert)
            
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
    
    override func viewDidDisappear(animated: Bool) {
  
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
    let yPos = -tableView.contentOffset.y
        
        if yPos > 180 {
        
//            friendsArray = []
//            ratingArray = []
//            
//            profilePicArray = []
//            
//            imageDataArray = []
            
            getFriends()
        
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
