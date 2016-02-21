//
//  GameInvitesPage.swift
//  Chess♔
//
//  Created by Johannes Berge on 10/11/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse
import Firebase


class GameInvitesPage: UIViewController,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var invites: Array<String> = []
    
    var inviteName: Array<String> = []
    var ratedArray: Array<String> = []
    var colorArray: Array<String> = []
    var speedmodeArray: Array<String> = []
    
    var imageDataArray: Array<NSData> = []


    var checkmarkButton = UIButton()
    var crossButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()  // it's just 1 line, awesome!

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        inviteName = []
        ratedArray = []
        colorArray = []
        speedmodeArray = []
        imageDataArray = []
        invites = []
        tableView.reloadData()
        self.title = "Invites"
        findRequests()
        lightOrDarkMode()
    }
    
    
    
    func findRequests() {
    
        let requestQuery = PFQuery(className: "Games")
        requestQuery.whereKey("inviteTo", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("players", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("confirmed", equalTo: false)
        requestQuery.orderByDescending("createdAt")
        requestQuery.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                if let result = result as! [PFObject]! {
                    for result in result {
                        
                        if result["blackPlayer"] as? String == PFUser.currentUser()!.username {
                            
                            self.inviteName.append((result["whitePlayer"] as? String)!)
                             self.ratedArray.append((result["mode"] as? String)!)
                             self.colorArray.append("Black")
                             self.speedmodeArray.append((result["speed"] as? String)!)
                        
                        }
                            
                        else {
                        
                            self.inviteName.append((result["blackPlayer"] as? String)!)
                            self.ratedArray.append((result["mode"] as? String)!)
                            self.colorArray.append("White")
                            self.speedmodeArray.append((result["speed"] as? String)!)

                        }
                    
                    }
                
                
                }
            
            
            }
            self.tableView.reloadData()

        }
    
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inviteName.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:GameInvitesTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("GameInviteCell", forIndexPath: indexPath) as! GameInvitesTableViewCell
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if darkMode {
            cell.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            cell.rating.textColor = UIColor.lightTextColor()
            cell.username.textColor =  UIColor.whiteColor()
            cell.ratedOrUnrated.textColor = UIColor.lightTextColor()
            cell.whichColorText.textColor = UIColor.lightTextColor()
            cell.speedmodeText.textColor = UIColor.lightTextColor()


            
        }
        else {
            
            cell.backgroundColor = UIColor.whiteColor()
            cell.rating.textColor = UIColor.darkGrayColor()
            cell.username.textColor =  UIColor.blackColor()
            cell.ratedOrUnrated.textColor = UIColor.lightGrayColor()
            cell.whichColorText.textColor = UIColor.lightGrayColor()
            cell.speedmodeText.textColor = UIColor.lightGrayColor()
        }
        
        
        cell.username.text = inviteName[indexPath.row]
        cell.ratedOrUnrated.text = ratedArray[indexPath.row]
        cell.whichColorText.text = "You Play as " + colorArray[indexPath.row]
        cell.speedmodeText.text = speedmodeArray[indexPath.row] + " Speedmode"
        
        
        if colorArray[indexPath.row] == "Black" {
        
            cell.pieceIndicator.backgroundColor = UIColor.blackColor()
        }
        else {
            cell.pieceIndicator.backgroundColor = UIColor.whiteColor()
        }
        
        if speedmodeArray[indexPath.row] == "Normal" {
            cell.speedIndicator.image = UIImage(named: "normalIndicator2.png")
        }
        else if speedmodeArray[indexPath.row] == "Fast" {
            cell.speedIndicator.image = UIImage(named: "flash31.png")
        }
        else if speedmodeArray[indexPath.row] == "Slow" {
            cell.speedIndicator.image = UIImage(named: "clock108.png")
        }
        
        
        
        let query = PFQuery(className: "_User")
        
        query.whereKey("username", equalTo: cell.username.text!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                
                if let userArray = objects as? [PFUser] {
                    for user in userArray {
                        
                        cell.rating.text = String(user["rating"] as! Int)
                        
                        if let userPicture = user["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    cell.username.text = user["username"] as? String
                                    cell.userProfileImage.image = UIImage(data: imageData!)
                                    cell.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFill
                                    self.imageDataArray.append(imageData!)
                                    
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
        
        
        cell.checkmarkButton.tag = indexPath.row + 1
        cell.checkmarkButton.addTarget(self, action: "checkmarkButtonPressed:", forControlEvents: .TouchUpInside)
        
        cell.crossButton.tag = indexPath.row + 100_000
        cell.crossButton.addTarget(self, action: "crossButtonPressed:", forControlEvents: .TouchUpInside)
        
        
        return cell
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
    
    }
    
    func checkmarkButtonPressed(sender:UIButton) {
        
        
        let buttonRow = sender.tag
        let tmpButton = self.view.viewWithTag(buttonRow) as? UIButton
        checkmarkButton = tmpButton!
        checkmarkButton.setBackgroundImage(UIImage(named: "checkmark12.png"), forState: .Normal)
        
        //editing the view
        let buttonRow2 = sender.tag + 99_999
        let tmpButton2 = self.view.viewWithTag(buttonRow2) as? UIButton
        crossButton = tmpButton2!
        
        UIView.animateWithDuration(0.2) { () -> Void in
            
            self.crossButton.alpha = 0
        }
        
        checkmarkButton.userInteractionEnabled = false
        crossButton.userInteractionEnabled = false
        
        
        let requestQuery = PFQuery(className: "Games")
        requestQuery.whereKey("inviteTo", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("players", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("confirmed", equalTo: false)
        requestQuery.whereKey("inviteFrom", equalTo: inviteName[sender.tag - 1])
        
        requestQuery.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                
                if let result = result as! [PFObject]! {
                    for result in result {
                        
                        result["confirmed"] = true
                        
                        
                        //firebaseeeee
                        //add who's turn it is
                        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                        var status = ["turn": "black"]
                        if result["whitePlayer"] as? String == PFUser.currentUser()?.username {
                            status = ["turn": "black"]
                        }
                        else if result["blackPlayer"] as? String == PFUser.currentUser()?.username {
                            status = ["turn": "white"]
                        }
                        let statusRef = checkstatus.childByAppendingPath("\(result.objectId!)")
                        statusRef.setValue(status)
                        /////firebase
                        
                        if result["whitePlayer"] as? String == PFUser.currentUser()?.username {
                        
                            result["status_white"] = "move"
                            result["status_black"] = "notmove"
                            
                            result["whiteRating"] = PFUser.currentUser()!.objectForKey("rating") as! Int

                            
                        }
                        else if result["blackPlayer"] as? String == PFUser.currentUser()?.username {

                        
                            result["status_white"] = "move"
                            result["status_black"] = "notmove"
                            
                            result["blackRating"] = PFUser.currentUser()!.objectForKey("rating") as! Int

                        
                        }
                        
                        let now = NSDate()
                        var newDate = now.dateByAddingTimeInterval(60 * 60 * 24)
                        var daysToAdd = Double()
                        
                        if result["speed"] as? String == "Normal" {
                            
                             daysToAdd = 0.16666667
                            newDate = now.dateByAddingTimeInterval(60 * 60 * 24 * daysToAdd)
                        }
                        else if result["speed"] as? String == "Fast" {
                            
                             daysToAdd = 0.003475
                            newDate = now.dateByAddingTimeInterval(60 * 60 * 24 * daysToAdd)
                        }
                            
                        else if result["speed"] as? String == "Slow" {
                            
                             daysToAdd = 2
                            newDate = now.dateByAddingTimeInterval(60 * 60 * 24 * daysToAdd)
                        }
                        
                        result["whiteDate"] = newDate
                        result["blackDate"] = newDate

                        result["whiteTime"] = (60 * 60 * 24 * daysToAdd)
                        result["blackTime"] = (60 * 60 * 24 * daysToAdd)


                        
                        
                        result["timeLeftToMove"] = newDate
                        result.save()
                        
                        // Create our Installation query
                        let pushQuery = PFInstallation.query()
                        pushQuery!.whereKey("username", equalTo: [sender.tag - 1])
                        
                        // Send push notification to query
                        let push = PFPush()
                        push.setQuery(pushQuery) // Set our Installation query
                        push.setMessage("\(PFUser.currentUser()!.username!) accepted your invitation. Let's begin!")
                        push.sendPushInBackground()
                        
                        
                    }
                    
                }
                
                
            }
        }
        
        
        
    }

    func crossButtonPressed(sender:UIButton) {
        
        
        
        let buttonRow = sender.tag
        let tmpButton = self.view.viewWithTag(buttonRow) as? UIButton
        crossButton = tmpButton!
        self.crossButton.setBackgroundImage(UIImage(named: "close.png"), forState: .Normal)

        
        
        
        let buttonRow2 = sender.tag - 99_999
        let tmpButton2 = self.view.viewWithTag(buttonRow2) as? UIButton
        checkmarkButton = tmpButton2!
        UIView.animateWithDuration(0.2) { () -> Void in

        self.checkmarkButton.alpha = 0
        }
        
        checkmarkButton.userInteractionEnabled = false
        crossButton.userInteractionEnabled = false
        
        
        let requestQuery = PFQuery(className: "Games")
        requestQuery.whereKey("inviteTo", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("players", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("confirmed", equalTo: false)
        requestQuery.whereKey("inviteFrom", equalTo: inviteName[sender.tag - 99_999 - 1
])
        
        requestQuery.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
            
                if let result = result as! [PFObject]! {
                    for result in result {
                    
                    result.deleteEventually()
                    
                    }
                
                }
            
            
            }
        }
        
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
