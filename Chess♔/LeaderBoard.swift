//
//  LeaderBoard.swift
//  Chess♔
//
//  Created by Johannes Berge on 15/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit

class LeaderBoard: UIViewController,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var profilePicArray: Array<UIImage> = []
    
    var imageDataArray: Array<NSData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! Array<String>
        
        return count.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell4 = self.tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! UserTableViewCell4
        
        //username
        let userName = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! NSMutableArray
        cell.username.text = userName[indexPath.row] as? String

//        //image
//        let userQuery = PFQuery(className: "_User")
//        userQuery.whereKey("username", equalTo: userName[indexPath.row])
//        let  user = userQuery.getFirstObject() as! PFUser
//
//        
//        cell.username.text = user["username"] as? String
//        
//        let profilePictureObject = user["profile_picture"] as? PFFile
//        
//        if(profilePictureObject != nil)
//        {
//            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
//                
//                if(imageData != nil)
//                {
//                    
//                    let profileImageDataJPEG = UIImageJPEGRepresentation(UIImage(data: imageData!)!, 0)
//                    
//                    let profileImageFile = profileImageDataJPEG!
//                    cell.userProfileImage.image = UIImage(data: profileImageFile)
//                    self.imageDataArray.append(imageData!)
//                }
//                
//            }
//        }
        
        //image
        let p = NSUserDefaults.standardUserDefaults().objectForKey("profilePicArray") as! NSMutableArray
        cell.userProfileImage.image = UIImage(data: p[indexPath.row] as! NSData)

        //rating
        let rating = NSUserDefaults.standardUserDefaults().objectForKey("ratingArray") as! NSMutableArray
        cell.rating.text = "\(rating[indexPath.row] as! Int)"
        
        //position
        cell.position.text = "\(indexPath.row + 1)" + "."
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:UserTableViewCell4 = self.tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! UserTableViewCell4
        
        //username
        var userName = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! Array<String>
        
        NSUserDefaults.standardUserDefaults().setObject(userName[indexPath.row], forKey: "other_username")
        cell.username.text = userName[indexPath.row]
        
        //image
        NSUserDefaults.standardUserDefaults().setObject(imageDataArray[indexPath.row], forKey: "other_userImage")
        cell.userProfileImage.image = UIImage(data: imageDataArray[indexPath.row])
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
        self.showViewController(vc as! UIViewController, sender: vc)
        
        
        
    }
    
    

}
