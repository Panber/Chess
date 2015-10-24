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
        
        // Do any additional setup after loading the view.
        
        getFriends()
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
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.profilePicArray.append(UIImage(data: imageData!)!)
                    cell.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFill
                    cell.userProfileImage.image = self.profilePicArray[indexPath.row]
                    self.imageDataArray.append(imageData!)
                }
                
            }
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
        
        
    }
    
    
    
    
    
    
}
