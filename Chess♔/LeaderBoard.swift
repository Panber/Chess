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

    var userArray: Array<String> = []
    var ratingArray: Array<Int> = []
    var profilePicArray: Array<NSData> = []
    
    var imageDataArray = NSMutableArray()
    var imageDataDict = [1 : NSData(),2:NSData(),3:NSData(),4 : NSData(),5 : NSData(),6 : NSData(),7 : NSData(),8 : NSData(),9 : NSData(),10 : NSData()]
    
    var USER: Array<PFUser> = []
    
    var found = false
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
        findUsers()
        
    }
    
    
    func findUsers() {
    
        if NSUserDefaults.standardUserDefaults().objectForKey("leaderboard") as! String == "world" {
        
            self.title = "World"
            
            let query = PFQuery(className: "_User")
            query.limit = 10
            query.orderByDescending("rating")
            
            query.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error ==  nil {
                    if let result = result as? [PFUser] {
                        for result in result {
                        
                            self.userArray.append(result["username"] as! String)
                            self.ratingArray.append(result["rating"] as! Int)
                            
                            self.USER.append(result)
                            
                            
                        
                        }
                    
                    }
                self.tableView.reloadData()
                }
                
            })
        
        }
    
        if NSUserDefaults.standardUserDefaults().objectForKey("leaderboard") as! String == "friends" {
            self.title = "Friends"

            
            let friendsquery = PFQuery(className: "Friends")
            friendsquery.whereKey("username", equalTo:PFUser.currentUser()!.username!)
            friendsquery.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    if let result = result as? [PFObject] {
                        for result in result {
                            self.userArray = result["friends"] as! Array<String>
                        
                        }
                    }
                    
                    self.tableView.reloadData()
                    
                
                }
            })
            
        
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("leaderboard") as! String == "nearby" {
        
            self.title = "Nearby"

            
            let query = PFQuery(className: "_User")
            query.limit = 10
            query.orderByDescending("rating")
            query.whereKey("location", nearGeoPoint: location)
            
            query.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error ==  nil {
                    if let result = result as? [PFUser] {
                        for result in result {
                            
                            self.userArray.append(result["username"] as! String)
                            self.ratingArray.append(result["rating"] as! Int)
                            
                            self.USER.append(result)
                            
                            
                            
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                
            })
        
        
        }

    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell4 = self.tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! UserTableViewCell4

        


        if NSUserDefaults.standardUserDefaults().objectForKey("leaderboard") as! String == "world" {

            cell.username.text = userArray[indexPath.row]
            let r = ratingArray[indexPath.row]
            cell.rating.text = "\(r)"
        
        if let userPicture = USER[indexPath.row]["profile_picture"] as? PFFile {
            
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    
                    self.profilePicArray.append(imageData!)
                    cell.userProfileImage.image = UIImage(data: imageData!)
                    
                    
                } else {
                }
            }
            
        }
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("leaderboard") as! String == "nearby" {
            
            cell.username.text = userArray[indexPath.row]
            let r = ratingArray[indexPath.row]
            cell.rating.text = "\(r)"
            
            if let userPicture = USER[indexPath.row]["profile_picture"] as? PFFile {
                
                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        
                        self.profilePicArray.append(imageData!)
                        cell.userProfileImage.image = UIImage(data: imageData!)
                        
                        
                    } else {
                    }
                }
                
            }
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("leaderboard") as! String == "friends" {

        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: self.userArray[indexPath.row])
        query.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
            if error ==  nil {
                if let result = result as? [PFUser] {
                    for result in result {
     
                        self.ratingArray.append(result["rating"] as! Int)
                        
                            cell.username.text = result["username"] as? String
                        
                            let r = result["rating"] as! Int
                        cell.rating.text = "\(r)"
                        
                        self.USER.append(result)
                        
                        if let userPicture = result["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    
                                    self.profilePicArray.append(imageData!)
                                    cell.userProfileImage.image = UIImage(data: imageData!)
                                    
                                    
                                } else {
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
            else {
            self.navigationController?.popToRootViewControllerAnimated(true)
            }
            
        })
        
        }
        
//            let query = PFQuery(className: "_User")
//            let usernamee = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! NSMutableArray
//
//            query.whereKey("username", equalTo: usernamee[indexPath.row] as! String)
//            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
//                if (error == nil) {
//                    
//                    if let userArray = objects as? [PFUser] {
//                        for user in userArray {
//                            if let userPicture = user["profile_picture"] as? PFFile {
//                                
//                                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
//                                    if (error == nil) {
//                                        
//                                    cell.userProfileImage.image = UIImage(data: imageData!)
//                                    //self.imageDataArray.append(imageData!)
//                                        self.imageDataDict[indexPath.row] = imageData!
//                                        self.imageDataArray.addObject(imageData!)
//                                        
//
//                                    } else {
//                                    }
//                                }
//                                
//                            }
//                        }
//                        
//                    }
//                } else {
//                    // Log details of the failure
//                    print("query error: \(error) \(error!.userInfo)")
//                }
//                
//            }
//        
//  
//        //rating
//        let rating = NSUserDefaults.standardUserDefaults().objectForKey("ratingArray") as! NSMutableArray
//        cell.rating.text = "\(rating[indexPath.row] as! Int)"
        
        //position
        cell.position.text = "\(indexPath.row + 1)" + "."
        
        if cell.username.text == userArray.last {
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:UserTableViewCell4 = self.tableView.dequeueReusableCellWithIdentifier("cell4") as! UserTableViewCell4
        
        //username
        var userName = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! Array<String>
        
        NSUserDefaults.standardUserDefaults().setObject(userName[indexPath.row], forKey: "other_username")
        cell.username.text = userName[indexPath.row]
        
        //image
        
//        
//        let image = cell.userProfileImage.image
//        let imageData: NSData = UIImageJPEGRepresentation(image!, 1.0)!
        let data = imageDataDict[indexPath.row]!
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "other_userImage")
        
        //cell.userProfileImage.image = UIImage(data: imageDataArray[indexPath.row])
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
        self.showViewController(vc as! UIViewController, sender: vc)
        
        
        
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
