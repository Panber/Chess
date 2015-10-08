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
                    self.tableView.reloadData()

                }
       
            })
            self.tableView.reloadData()
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UserTableViewCell

        cell.username.text = userArray[indexPath.row]
        
        
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
                }
                
            }
        }
        
        
        
        


        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userArray.count
        
    }
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell
        
        let user:PFUser = userss[indexPath.row] as! PFUser
        
        NSUserDefaults.standardUserDefaults().setObject(cell.username.text, forKey: "other_username")
        
        let profilePictureObject = user["profile_picture"] as? PFFile
        
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    NSUserDefaults.standardUserDefaults().setObject(imageData!, forKey: "other_userImage")
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
                    self.showViewController(vc as! UIViewController, sender: vc)
                }
                
            }
        }
    }
    */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
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
