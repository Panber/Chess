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


class FriendRequestsPage: UIViewController, UITableViewDelegate {

    var userss:NSMutableArray = NSMutableArray()
    var t = 0

    var scrollView = UIScrollView()
    var scrollViewView = UIView()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scrollView.userInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        view.addSubview(scrollView)
        
        scrollViewView = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scrollView.addSubview(scrollViewView)
    }
    
    
    func loadRequestToView( t:CGFloat) {
        
        let bcLabel = UILabel(frame: CGRectMake(0, 0 + (70 * t), screenWidth, 70))
        bcLabel.backgroundColor = UIColor.whiteColor()
        scrollViewView.addSubview(bcLabel)
        
        let seperator = UILabel(frame: CGRectMake(0, 0 + (70 * t), screenWidth, 0.5))
        seperator.backgroundColor = UIColor.lightGrayColor()
        scrollViewView.addSubview(seperator)
        
        let profilePic = UIImageView(frame: CGRectMake(10, 10 + (70 * t), 50, 50))
    }
    
    // MARK - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let frequestsQuery = PFQuery(className: "FriendRequest")
        
        if let user = PFUser.currentUser()?.username {
        frequestsQuery.whereKey("toUserr", equalTo: (user))
        frequestsQuery.orderByDescending("updatedAt")
        frequestsQuery.whereKey("status", equalTo: "pending")
        
            frequestsQuery.findObjectsInBackgroundWithBlock({ (frequests:[AnyObject]?, error:NSError?) -> Void in
                
                for frequests in frequests! {
                
    
                }
                
        })
            
            
        }
        
        
//        let users:PFObject = self.users.objectAtIndex(indexPath.row) as! PFObject
//        
//        var findUserName: PFQuery = PFQuery(className:"_User")
//        findUserName.whereKey("username", containsString: searchText.text)
//        
//        findUserName.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
//            if (error == nil) {
//                if let user:PFUser = users as? PFUser {
//                    cell.username.text = user.username
//                    
//                    if let profileImage:PFFile = user["profile_picture"] as? PFFile {
//                        profileImage.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
//                            
//                            if error == nil {
//                                let image:UIImage = UIImage(data: imageData!)!
//                                cell.userProfileImage.image = image as! UIImage
//                                
//                            }
//                            
//                        }
//                    }
//                    
//                }
//            }
//        }
        return cell
    }
    

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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
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
