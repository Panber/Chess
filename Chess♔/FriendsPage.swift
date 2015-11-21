//
//  FriendsPage.swift
//  Chess♔
//
//  Created by Alexander Panayotov on 10/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var friends = PFObject(className: "Friends")

class FriendsPage: UIViewController, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var friendsArray: Array<String> = []
    
    var profilePicArray: Array<UIImage> = []
    
    var imageDataArray: Array<NSData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()
        
        self.navigationItem.title = "Friends"
        
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
        
        let cell:UserTableViewCell3 = self.tableView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath) as! UserTableViewCell3
        
        cell.username.text = friendsArray[indexPath.row] as! String
        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("username", equalTo: friendsArray[indexPath.row])
        let _user = userQuery.getFirstObject() as! PFUser
        
        let rating = _user["rating"] as? Int
        cell.rating.text = "\(rating!)"
        
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
        
        if cell.username.text == friendsArray.last {
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UserTableViewCell3 = self.tableView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath) as! UserTableViewCell3
        NSUserDefaults.standardUserDefaults().setObject(friendsArray[indexPath.row], forKey: "other_username_profile")
        cell.username.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_profile") as! String
        
        var p = imageDataArray[indexPath.row]
        NSUserDefaults.standardUserDefaults().setObject(p, forKey: "other_userImage_profile")
        cell.userProfileImage.image = UIImage(data: p)
    }
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
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
