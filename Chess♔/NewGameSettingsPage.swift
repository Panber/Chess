//
//  NewGameSettingsPage.swift
//  Chess♔
//
//  Created by Johannes Berge on 24/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}

class NewGameSettingsPage: UIViewController {
    
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var useruserName: UILabel!
    
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
        let p = NSUserDefaults.standardUserDefaults().objectForKey("other_userImage_from_friends_gamemenu") as! NSData
        userProfilePic.image = UIImage(data: p)
        
        useruserName.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username_from_friends_gamemenu") as? String
        
        userRating.text = String(NSUserDefaults.standardUserDefaults().objectForKey("other_userrating_from_friends_gamemenu")!)
        
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
        
        
        if color == "White" {
            white = (PFUser.currentUser()?.username)!
            black = useruserName.text!
            pushto = black
        }
        else {
            black = (PFUser.currentUser()?.username)!
            white = useruserName.text!
            pushto = white
        }
        
        let game = PFObject(className: "Games")
        game["whitePlayer"] = white
        game["blackPlayer"] = black
        game["speed"] = speed
        game["mode"] = mode
        game["confirmed"] = false
        game["piecePosition"] = NSMutableArray()
        game["turn"] = white
        
        game["timeLeftToMove"] = NSDate()
        
        if speed == "Normal" {
            
            game["timePerMove"] = 1
            
            //            let now = NSDate()
            //            let daysToAdd: Double = 1
            //            let newDate = now.dateByAddingTimeInterval(60 * 60 * 24 * daysToAdd)
            //
            //            game["gameEnds"] = newDate
            
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
                
                // Create our Installation query
                let pushQuery = PFInstallation.query()
                pushQuery!.whereKey("username", equalTo: pushto)
                
                // Send push notification to query
                let push = PFPush()
                push.setQuery(pushQuery) // Set our Installation query
                push.setMessage("\(PFUser.currentUser()!.username!) has invited you to play Chess!")
                push.sendPushInBackground()
                
            }
        }
        
        
        
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
            //self.scrollView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            //scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            
            
        }
        
        
    }
    
}
