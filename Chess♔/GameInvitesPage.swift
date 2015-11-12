//
//  GameInvitesPage.swift
//  Chess♔
//
//  Created by Johannes Berge on 10/11/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class GameInvitesPage: UIViewController,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var invites: Array<String> = []
    
    var inviteName: Array<String> = []
    var ratedArray: Array<String> = []
    var colorArray: Array<String> = []
    var speedmodeArray: Array<String> = []
    
    var imageDataArray: Array<NSData> = []


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Invites"
        findRequests()
    }
    
    
    func findRequests() {
    
        let requestQuery = PFQuery(className: "Games")
        requestQuery.whereKey("inviteTo", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("players", equalTo: (PFUser.currentUser()?.username)!)
        requestQuery.whereKey("confirmed", equalTo: false)
        
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
            cell.speedIndicator.image = UIImage(named: "normalIndicator.png")
        }
        else if speedmodeArray[indexPath.row] == "Fast" {
            cell.speedIndicator.image = UIImage(named: "flash31.png")
        }
        else if speedmodeArray[indexPath.row] == "Slow" {
            cell.speedIndicator.image = UIImage(named: "clock104.png")
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
        
        
        return cell
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
    
    }

}
