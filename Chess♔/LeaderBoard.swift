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

    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()

       
    }
    
    var profilePicArray: Array<UIImage> = []
    
    var imageDataArray = NSMutableArray()
    var imageDataDict = [1 : NSData(),2:NSData(),3:NSData(),4 : NSData(),5 : NSData(),6 : NSData(),7 : NSData(),8 : NSData(),9 : NSData(),10 : NSData()]
    
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
        
        let count = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! Array<String>
        
        return count.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell4 = self.tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! UserTableViewCell4

        
        //username
        let userName = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! NSMutableArray
        cell.username.text = userName[indexPath.row] as? String


        
            let query = PFQuery(className: "_User")
            let usernamee = NSUserDefaults.standardUserDefaults().objectForKey("userArray") as! NSMutableArray
            
            query.whereKey("username", equalTo: usernamee[indexPath.row] as! String)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if (error == nil) {
                    
                    if let userArray = objects as? [PFUser] {
                        for user in userArray {
                            if let userPicture = user["profile_picture"] as? PFFile {
                                
                                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                    if (error == nil) {
                                        
                                    cell.userProfileImage.image = UIImage(data: imageData!)
                                    //self.imageDataArray.append(imageData!)
                                        self.imageDataDict[indexPath.row] = imageData!
                                        self.imageDataArray.addObject(imageData!)
                                        

                                    } else {
                                    }
                                }
                                
                            }
                        }
                        
                    }
                } else {
                    // Log details of the failure
                    print("query error: \(error) \(error!.userInfo)")
                }
                
            }
        
  
        //rating
        let rating = NSUserDefaults.standardUserDefaults().objectForKey("ratingArray") as! NSMutableArray
        cell.rating.text = "\(rating[indexPath.row] as! Int)"
        
        //position
        cell.position.text = "\(indexPath.row + 1)" + "."
        
        if cell.username.text == usernamee.lastObject as? String {
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
