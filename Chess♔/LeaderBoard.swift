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
    
    func checkForFriends() {
        if userArray.count == 0 {
            
            let alert = UIAlertController(title: "Oops!", message: "We can not load the leaderboard right now.", preferredStyle: UIAlertControllerStyle.Alert)
            
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
        lightOrDarkMode()

        findUsers()
        
    }
    override func viewDidDisappear(animated: Bool) {
        
        
        userArray = []
        ratingArray = []
        profilePicArray = []
        USER = []
        
        tableView.reloadData()

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
                    self.checkForFriends()

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
                    self.checkForFriends()

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
                    self.checkForFriends()

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
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None


        if darkMode {
            cell.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            cell.rating.textColor = UIColor.lightTextColor()
            cell.username.textColor =  UIColor.whiteColor()
            cell.position.textColor = UIColor.whiteColor()
        
        }
        else {
        
            cell.backgroundColor = UIColor.whiteColor()
            cell.rating.textColor = UIColor.darkGrayColor()
            cell.username.textColor =  UIColor.blackColor()
            cell.position.textColor = UIColor.blackColor()
        }
        
        
        
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
   
        //position
        cell.position.text = "\(indexPath.row + 1)" + "."
        
        if cell.username.text == userArray.last {
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero

        }

        if cell.username.text == PFUser.currentUser()?.username {
            cell.accessoryType = .None
            cell.userInteractionEnabled = false
        
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:UserTableViewCell4 = self.tableView.dequeueReusableCellWithIdentifier("cell4") as! UserTableViewCell4

        
        NSUserDefaults.standardUserDefaults().setObject(userArray[indexPath.row], forKey: "other_username")
        cell.username.text = userArray[indexPath.row]

        let data = profilePicArray[indexPath.row]
        PData = data
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "other_userImage")
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
        self.showViewController(vc as! UIViewController, sender: vc)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    

    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
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
