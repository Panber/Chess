//
//  UsersFriendsPage.swift
//  Chess♔
//
//  Created by Alexander Panayotov on 17/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit

class UsersFriendsPage: UIViewController, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var friendsArray: Array<String> = []
    
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
        if let user = NSUserDefaults.standardUserDefaults().objectForKey("other_username") as? String {
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
        
        let cell:UserTableViewCell5 = self.tableView.dequeueReusableCellWithIdentifier("cell5", forIndexPath: indexPath) as! UserTableViewCell5
        
        cell.username.text = friendsArray[indexPath.row] 
        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("username", equalTo: friendsArray[indexPath.row])
        let _user = userQuery.getFirstObject() as! PFUser
        
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
        let cell:UserTableViewCell5 = self.tableView.dequeueReusableCellWithIdentifier("cell5", forIndexPath: indexPath) as! UserTableViewCell5
        NSUserDefaults.standardUserDefaults().setObject(friendsArray[indexPath.row], forKey: "other_username_from_usersfriends")
        cell.username.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_usersfriends") as? String
        
        let p = imageDataArray[indexPath.row]
        NSUserDefaults.standardUserDefaults().setObject(p, forKey: "other_userImage_from_usersfriends")
        cell.userProfileImage.image = UIImage(data: p)
    }

}
