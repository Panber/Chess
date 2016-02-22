//
//  NewGameSettingsPage_Analyze.swift
//  Chess♔
//
//  Created by Johannes Berge on 21/11/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class NewGameSettingsPage_Analyze: UIViewController {
    
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var useruserName: UILabel!
    @IBOutlet weak var bc1: UIView!
    
    @IBOutlet weak var bc2: UILabel!
    @IBOutlet weak var whiteOrBlack: UISegmentedControl!
    
    @IBOutlet weak var gameSpeedSegemnt: UISegmentedControl!
    
    @IBOutlet weak var modeSegment: UISegmentedControl!
    
    var color = "White"
    var speed = "Normal"
    var mode = "Rated"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Invite"
        
        userProfilePic.layer.cornerRadius = userProfilePic.frame.size.width/2
        let p = NSUserDefaults.standardUserDefaults().objectForKey("other_userImage_from_analyze") as! NSData
        userProfilePic.image = UIImage(data: p)
        
        useruserName.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_analyze") as? String
        
        userRating.text = String(NSUserDefaults.standardUserDefaults().objectForKey("other_userrating_analyze")!)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
        
        
    }
    
    
    @IBAction func blackOrWhiteChanged(sender: UISegmentedControl) {
        
        switch whiteOrBlack.selectedSegmentIndex
        {
        case 0:
            color = "White"
        case 1:
            color = "Black"
        default:
            break;
        }
        
    }
    
    
    @IBAction func speedChanged(sender: UISegmentedControl) {
        switch gameSpeedSegemnt.selectedSegmentIndex {
        case 0:
            speed = "Fast"
        case 1:
            speed = "Normal"
        case 2:
            speed = "Slow"
        default:
            break;
        }
    }
    
    @IBAction func modeChanged(sender: UISegmentedControl) {
        
        switch whiteOrBlack.selectedSegmentIndex
        {
        case 0:
            mode = "Rated"
        case 1:
            mode = "Unrated"
        default:
            break;
        }
        
    }
    
    @IBAction func sendButton(sender: AnyObject) {
        
        var white = ""
        var black = ""
        var pushto = ""
        
        let game = PFObject(className: "Games")

        
        if color == "White" {
            white = (PFUser.currentUser()?.username)!
            black = useruserName.text!
            pushto = black
            
            game["whiteRating"] = PFUser.currentUser()!.objectForKey("rating") as! Int

        }
        else {
            black = (PFUser.currentUser()?.username)!
            white = useruserName.text!
            pushto = white
            
            game["blackRating"] = PFUser.currentUser()!.objectForKey("rating") as! Int

        }
        
        game["whitePlayer"] = white
        game["blackPlayer"] = black
        game["players"] = [white,black]
        game["speed"] = speed
        game["mode"] = mode
        game["confirmed"] = false
        game["piecePosition"] = NSMutableArray()
        game["status_white"] = "request"
        game["status_black"] = "request"
        game["inviteTo"] = pushto
        game["inviteFrom"] = PFUser.currentUser()?.username
        game["whitePromotionType"] = NSMutableArray()
        game["blackPromotionType"] = NSMutableArray()
        game["passantArray"] = NSMutableArray()
        game["whiteTime"] = Int()
        game["blackTime"] = Int()
        game["whiteRatedComplete"] = false
        game["blackRatedComplete"] = false
        game["draw_black"] = ""
        game["draw_white"] = ""
        
        game["timeLeftToMove"] = NSDate()
        
        if speed == "Normal" {
            
            game["timePerMove"] = 1
            
            //                        let now = NSDate()
            //                        let daysToAdd: Double = 1
            //                        let newDate = now.dateByAddingTimeInterval(60 * 60 * 24 * daysToAdd)
            //
            //                        game["gameEnds"] = newDate
            
        }
        else if speed == "Slow" {
            game["timePerMove"] = 3
        }
        else if speed == "Fast" {
            game["timePerMove"] = 0.25
        }
        
        game.saveInBackgroundWithBlock { (bool:Bool, error:NSError?) -> Void in
            if error == nil {
                print("game Made!!")
                //self.tabBarController?.selectedIndex = 0
                //  navigationController.popViewControllerAnimated = true
                
                let completeSignal = UIImageView(frame: CGRectMake((screenWidth/2) - 30, (screenHeight/2) - 50, 60, 60))
                completeSignal.image = UIImage(named: "checkmark12.png")
                
                let completeText = UILabel(frame: CGRectMake((screenWidth/2) - 40,completeSignal.frame.size.height + completeSignal.frame.origin.y, 80, 40))
                completeText.text = "Sent!"
                completeText.font = UIFont(name: "Times", size: 16)
                completeText.textAlignment = .Center
                completeText.textColor = UIColor.lightGrayColor()
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    visualEffectView.addSubview(completeSignal)
                    visualEffectView.addSubview(completeText)
                    visualEffectView.alpha = 1
                    visualEffectView.userInteractionEnabled = true
                    
                    }, completion: {finish in
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                        
                        UIView.animateWithDuration(0.3, delay: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            
                            visualEffectView.alpha = 0
                            visualEffectView.userInteractionEnabled = false
                            
                            
                            }, completion: { finish in
                                
                                completeSignal.removeFromSuperview()
                                completeText.removeFromSuperview()
                                
                                
                        })
                        
                })
                
                
                
                // Create our Installation query
                let pushQuery = PFInstallation.query()
                pushQuery!.whereKey("username", equalTo: pushto)
                
                // Send push notification to query
                let push = PFPush()
                push.setQuery(pushQuery) // Set our Installation query
                push.setMessage("\(PFUser.currentUser()!.username!) invited you to play Chess!")
                push.sendPushInBackground()
                
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
            
            useruserName.textColor = UIColor.whiteColor()
            userRating.textColor = UIColor.lightTextColor()
            bc1.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            bc2.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            
            
            
            
            
        }
        else if darkMode == false {
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            useruserName.textColor = UIColor.blackColor()
            userRating.textColor = UIColor.lightGrayColor()
            bc1.backgroundColor = UIColor.whiteColor()
            bc2.backgroundColor = UIColor.whiteColor()
            
        }
        
        
    }
    
}
