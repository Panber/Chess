//
//  GameMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse
import Bolts
import CoreLocation
import SystemConfiguration
import Firebase

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}


//var blue = UIColor(red:0.17, green:0.33, blue:0.71, alpha:1.0)
//var blue = UIColor(red:0.27, green:0.59, blue:0.94, alpha:1.0)
var blue = UIColor(red:0.36, green:0.56, blue:0.79, alpha:1.0)
var red = UIColor(red:0.89, green:0.36, blue:0.36, alpha:1.0)


var gameIDSYourTurn:Array<String> = []
var gameIDSTheirTurn:Array<String> = []
var gameIDSGameOver:Array<String> = []
var gameID = ""

var pressedCreateNewGame = NSUserDefaults()

var scrollView: UIScrollView!

var logo = UIImage(named: "ChessIconSmallTextAndLogo.png")
var logoView = UIImageView(image:logo)


var location = PFGeoPoint()

//newpressed
var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
var visualEffectSub = UIView()

class GameMenu: UIViewController, UIScrollViewDelegate,UINavigationBarDelegate, UITableViewDelegate, UITabBarControllerDelegate, UITabBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var invitesButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var newButtonOutlet: UIBarButtonItem!
    
  //  @IBOutlet weak var editButtonOutlet: UIBarButtonItem!

    
    var usernameArray: Array<String> = []
    var ratingArray: Array<Int> = []
    var updatedArray: Array<String> = []
    var timeleftArray: Array<String> = []
    var profilePicArray: Array<UIImage> = []
    var imageDataArray: Array<NSData> = []
    var indicatorDataArray: Array<String> = []

    var yourturnArray: Array<String> = []
    var theirturnArray: Array<String> = []
    var gameoverArray: Array<String> = []
    
    var yourturnUpdateSince: Array<NSTimeInterval> = []
    var theirturnUpdateSince: Array<NSTimeInterval> = []
    var gameoverUpdateSince: Array<NSTimeInterval> = []
    

    
    var yourturnLeft: Array<NSTimeInterval> = []
    var theirturnLeft: Array<NSTimeInterval> = []
    var gameoverLeft: Array<NSTimeInterval> = []

    var yourturnLeftPrint: Array<Int> = []
    var theirturnLeftPrint: Array<Int> = []
    var gameoverLeftPrint: Array<Int> = []

    var yourTurnColor: Array<String> = []
    var theirTurnColor: Array<String> = []
    var gameoverTurnColor: Array<String> = []

    var yourTurnSpeed: Array<String> = []
    var theirTurnSpeed: Array<String> = []
    var gameoverTurnSpeed: Array<String> = []
    
    var timer = NSTimer()

    var loadingAlphas: Array<CGFloat> = [0.1,0.2,0.3,0.4,0.5,0.4,0.3,0.2,0.1,0.2,0.3,0.4,0.5]

    
    var typeofGameover: Array<String> = []
    
    var instructionsLabel = UILabel()
    
    
    var locationManager = CLLocationManager()
    
    var lastLocation = CLLocation()
    var locationAuthorizationStatus:CLAuthorizationStatus!
    var window: UIWindow?
   // var locationManager: CLLocationManager!
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"

    
    
    override func viewDidLoad() {
        


        
        instructionsLabel = UILabel(frame: CGRectMake(20, 64 ,screenWidth - 40,100))
        let new = "-New-"
        instructionsLabel.text = "Please add a new game by pressing \(new)"
        instructionsLabel.font = UIFont(name: "Times", size: 20)
        instructionsLabel.textColor = UIColor.darkGrayColor()
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textAlignment = .Center
        view.addSubview(instructionsLabel)
        
        
        
        super.viewDidLoad()
        
        let installation = PFInstallation.currentInstallation()
        installation["username"] = PFUser.currentUser()!.username
        installation.saveInBackground()

        
        let customFont = UIFont(name: "Times", size: 18.0)
        newButtonOutlet.setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        invitesButtonOutlet.setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        
   //     editButtonOutlet.setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)

       self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        print("the current installation is \(PFInstallation.currentInstallation())")


        //check this before launching!!!!!!
//        //Checking if first launch
//        let notFirstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
//        if notFirstLaunch  {
//            print("Not first launch.")
//        }
//        else {
//            print("First launch, setting NSUserDefault.")
          //  NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
//            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("firstLaunchVC")
//            self.showViewController(vc as! UIViewController, sender: vc)
//
        
    

//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        let authstate = CLLocationManager.authorizationStatus()
//        if(authstate == CLAuthorizationStatus.NotDetermined){
//            print("Not Authorised")
//            locationManager.requestWhenInUseAuthorization()
//        }
//        locationManager.startUpdatingLocation()
     
        
            self.initLocationManager()

        //query for friends, find out if the user already has friends, if not add friends
//        let friends = PFObject(className: "Friends")
//        friends["user"] = PFUser.currentUser()
//        friends["username"] = PFUser.currentUser()?.username
//        friends["friends"] = []
//        friends.saveInBackground()
//
//        }
        
        
        //setting the different variables for the current user, remember to implement this in a firstload method
            let users = PFQuery(className: "_User")
            if let user = PFUser.currentUser() {
                users.whereKey("username", equalTo: user.username!)
                users.findObjectsInBackgroundWithBlock({ (users: [AnyObject]?, error: NSError?) -> Void in
        
                    if error == nil {
                        if let users = users as? [PFObject]{
                            for users in users {
                                users["won"] = "0"
                                users["drawn"] = "0"
                                users["lost"] = "0"
                                users["rating"] = 601
                                users["request_everyone"] = true
                                
                                
                                PFGeoPoint.geoPointForCurrentLocationInBackground {
                                    (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                                    if error == nil {
                                        users["location"] = geoPoint
                                        users.saveInBackground()
                                        location = geoPoint!
                                        print("location added to parse")
                                        //add later!!
                                        //NSUserDefaults.standardUserDefaults().setObject(geoP, forKey: "user_geopoint")
                                        
                                    }
                                }

                            }
                        }
                    }
                    else {
                        print("annerror accured")
                    }
                })
            }
        
        
        
        
        //...and remove this after a while
//                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("firstLaunchVC")
//                    self.showViewController(vc as! UIViewController, sender: vc)

        
 

//        //logo things
//        logoView.contentMode = UIViewContentMode.ScaleAspectFit
//        logoView.frame.size.height = 50
//        self.navigationItem.titleView = logoView
//        
        
        navigationController?.navigationBar.topItem?.title = "Play"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
    
//      //setting scrollview
//        view.frame.size.height = 2000
//        scrollView = UIScrollView(frame: view.bounds)
//        scrollView.contentSize = view.bounds.size
//        scrollView.frame.size.height = screenHeight
//        scrollView.showsHorizontalScrollIndicator = true
//        scrollView.userInteractionEnabled = true
//        scrollView.delegate = self
//        scrollView.bounces = false
//        scrollView.scrollEnabled = true
//        view.addSubview(scrollView)
//        scrollView.showsVerticalScrollIndicator = false
        
        //setting newgameView
        visualEffectView.frame = view.bounds
        visualEffectView.alpha = 0
        visualEffectView.userInteractionEnabled = false
        
        visualEffectSub.frame = view.bounds
        visualEffectSub.alpha = 1
        visualEffectSub.userInteractionEnabled = false
        
        visualEffectView.addSubview(visualEffectSub)


        
        let currentWindow: UIWindow = UIApplication.sharedApplication().keyWindow!
        currentWindow.addSubview(visualEffectView)
        
        loadingView.image = UIImage(named: "cm3.png")
        loadingView.alpha = 0
        self.tableView.addSubview(loadingView)
        
        
        
    }

    // Location Manager helper stuff
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Location Manager Delegate stuff
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()
       // if error != nil {
            if (seenError == false) {
                seenError = true
                print(error)
        //    }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locationFixAchieved == false) {
            locationFixAchieved = true
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as! CLLocation
            let coord = locationObj.coordinate
            
            print(coord.latitude)
            print(coord.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager,  didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.Restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.Denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.NotDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    
    
    @IBAction func newGame(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "created_New_Game")
        
       // newGameSetup()
     //   newGameSetup("", ProfilePic: UIImage(named: "")!, Rating: "", UpdatedAt: "", TimeLeft: "")

    }
    
    func findGames() {
        
        //tableView.hidden = true
        let gamesQuery = PFQuery(className: "Games")
        //fix this
        gamesQuery.orderByDescending("updatedAt")
        gamesQuery.whereKey("players", equalTo: PFUser.currentUser()!.username!)
        gamesQuery.findObjectsInBackgroundWithBlock { (games:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
            if let games = games as! [PFObject]! {
            for games in games {
                
                
                
                
                if games["confirmed"] as? Bool == true {
                    if games["whitePlayer"] as? String == PFUser.currentUser()?.username {
                
                    
                    if games["status_white"] as? String == "move" {
                        
                        self.yourturnArray.append((games["blackPlayer"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        self.yourturnUpdateSince.append(since)
                        
                        
                        //adding time left
                        let left = games["timeLeftToMove"] as? NSDate
                        let left2 = NSDate().timeIntervalSinceDate(left!)
                        self.yourturnLeft.append(left2)
                        print(self.yourturnLeft)
                        
                        gameIDSYourTurn.append(games.objectId!)
                        self.yourTurnColor.append("white")
                        
                        self.yourTurnSpeed.append((games["speed"] as? String)!)

                        
                    }
                    else if games["status_white"] as? String == "notmove" {
                        
                        self.theirturnArray.append((games["blackPlayer"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        
                        self.theirturnUpdateSince.append(since)
                        
                        //adding time left
                        let left = games["timeLeftToMove"] as? NSDate
                        let left2 = NSDate().timeIntervalSinceDate(left!)
                        self.theirturnLeft.append(left2)
                        
                        gameIDSTheirTurn.append(games.objectId!)

                        self.theirTurnColor.append("white")
                        
                        self.theirTurnSpeed.append((games["speed"] as? String)!)


                        
                    }
                    else if games["status_white"] as? String == "won" || games["status_white"] as? String == "lost"{
                        
                        self.gameoverArray.append((games["blackPlayer"] as? String)!)
                        self.typeofGameover.append((games["status_white"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        self.gameoverUpdateSince.append(since)
                        
               
                        
                        gameIDSGameOver.append(games.objectId!)

                        self.gameoverTurnColor.append("white")
                        
                        self.gameoverTurnSpeed.append((games["speed"] as? String)!)


                        
                    }
                    
                }
                    else {
                    
                    if games["status_black"] as? String == "move" {
                        
                        self.yourturnArray.append((games["whitePlayer"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        self.yourturnUpdateSince.append(since)
                        
                        //adding left
                        let left = games["timeLeftToMove"] as? NSDate
                        let left2 = NSDate().timeIntervalSinceDate(left!)
                        self.yourturnLeft.append(left2)
                        
                        gameIDSYourTurn.append(games.objectId!)

                        self.yourTurnColor.append("black")
                        
                        self.yourTurnSpeed.append((games["speed"] as? String)!)


                        
                        
                        
                    }
                    else if games["status_black"] as? String == "notmove" {
                        
                        self.theirturnArray.append((games["whitePlayer"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        self.theirturnUpdateSince.append(since)
                        
                        //adding left
                        let left = games["timeLeftToMove"] as? NSDate
                        let left2 = NSDate().timeIntervalSinceDate(left!)
                        self.theirturnLeft.append(left2)
                        
                        gameIDSTheirTurn.append(games.objectId!)

                        self.theirTurnColor.append("black")
                        
                        self.theirTurnSpeed.append((games["speed"] as? String)!)


                        
                    }
                    else if games["status_black"] as? String == "won" || games["status_black"] as? String == "lost"{
                        
                        self.gameoverArray.append((games["whitePlayer"] as? String)!)
                        self.typeofGameover.append((games["status_black"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        self.gameoverUpdateSince.append(since)
                        
                        gameIDSGameOver.append(games.objectId!)

                        self.gameoverTurnColor.append("black")
                        
                        self.gameoverTurnSpeed.append((games["speed"] as? String)!)


                        
                    }

                
                
                }
                }
                else {
                    
                    if games["inviteTo"] as? String == PFUser.currentUser()?.username {
                    self.invitesButtonOutlet.title = "Invites"
                    self.invitesButtonOutlet.enabled = true
                    self.invitesButtonOutlet.tintColor = blue
                    }
                }
                
                
                
                self.loaded = false
                //self.ratingArray.append(games["blackPlayer"] as! Int)
                //  updatedArrayppend(games["blackPlayer"] as! String)
                //  timeleftArrayppend(games["blackPlayer"] as! String)
                
            }
            }
                
            self.tableView.reloadData()
            self.tableView.hidden = false
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.tableView.alpha = 1
                    }, completion: { (finished) -> Void in
                        if finished {
                        
                        
                        
                        }
                })
                

                
      
            }

        }
    
    }
    
    
    /*func find(name:String) {
    
        let query = PFQuery(className: "_User")
        
        query.whereKey("username", equalTo: name)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                
                if let userArray = objects as? [PFUser] {
                    for user in userArray {
                        
                        cell.rating.text = String(user["rating"] as! Int)
                        
                        if let userPicture = user["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    cell.userProfileImage.image = UIImage(data: imageData!)
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
    }*/
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell:GameMenuTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("gameCell",forIndexPath: indexPath) as! GameMenuTableViewCell
        
        
        
        if darkMode {cell.backgroundColor = UIColor.clearColor() //(red:0.22, green:0.22, blue:0.22, alpha:1.0)
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            cell.rating.textColor = UIColor.lightTextColor()


        cell.username.textColor = UIColor.whiteColor()
        
        }
        else {cell.backgroundColor = UIColor.whiteColor()
        
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            cell.rating.textColor = UIColor.darkGrayColor()
            cell.username.textColor = UIColor.blackColor()


        }
       // cell.userProfileImage.image = nil
        cell.username.text = ""
        
        
        func find(name:String) {
            
            cell.username.text = name
            cell.userProfileImage.image = nil
            
            
            
        let query = PFQuery(className: "_User")
            
        query.whereKey("username", equalTo: name)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                
                if let userArray = objects as? [PFUser] {
                    for user in userArray {
                        
                        cell.rating.text = String(user["rating"] as! Int)

                        if let userPicture = user["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    cell.userProfileImage.alpha = 0
                                    cell.userProfileImage.image = UIImage(data: imageData!)
                                    self.imageDataArray.append(imageData!)
                                    
                                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                                        cell.userProfileImage.alpha = 1


                                    })
                       
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
        }
        
        
        
        
     

        
       // cell.rating.text = "601"
       // cell.updated.text = "Last Update: 1h 5min"
        
        switch indexPath.section {
        case 0:
                cell.colorIndicator.backgroundColor = blue
                find(yourturnArray[indexPath.row])
            
                if yourTurnColor[indexPath.row] == "white" {
                    cell.pieceIndicator.backgroundColor = UIColor.whiteColor()
                }
                else {
                    cell.pieceIndicator.backgroundColor = UIColor.blackColor()
                }
                
                
                if yourTurnSpeed[indexPath.row] == "Normal" {
                    cell.speedIndicator.image = UIImage(named: "normalIndicator.png")
                }
                else if yourTurnSpeed[indexPath.row] == "Fast" {
                    cell.speedIndicator.image = UIImage(named: "flash31.png")

                }
                else if yourTurnSpeed[indexPath.row] == "Slow" {
                    cell.speedIndicator.image = UIImage(named: "clock104.png")
                }


                
                
                var since = yourturnUpdateSince[indexPath.row]
                //making to minutes
                cell.updated.text = "Last Updated: Now"

                if since >= 60 {
                    since = since/60
                    let sinceOutput = Int(since)
                    cell.updated.text = "Last Updated: \(sinceOutput)min ago"
                }
                //making to hours
                if since >= 60 {
                    since = since/60
                    let sinceOutput = Int(since)
                    cell.updated.text = "Last Updated: \(sinceOutput)h ago"
                    
                    //making to days
                    if since >= 24 {
                        since = since/24
                        let sinceOutput = Int(since)
                        cell.updated.text = "Last Updated: \(sinceOutput)d ago"
                        
                    }
                    
                }
            
                var timeLeftC = yourturnLeft[indexPath.row]
                cell.timeleft.text = "Left To Move: Less than a minute"
                cell.timeleft.textColor = red
                
                if timeLeftC <= -60 {
                    timeLeftC = timeLeftC/60
                    let sinceOutput = Int(timeLeftC) * -1
                    cell.timeleft.text = "Left To Move: \(sinceOutput)min"
                    print("time left in is \(sinceOutput)")
                }

                //making to hours
                if timeLeftC <= -60 {
                    timeLeftC = timeLeftC/60
                    let sinceOutput = Int(timeLeftC) * -1
                    cell.timeleft.text = "Left To Move: \(sinceOutput)h"
                    cell.timeleft.textColor = UIColor.lightGrayColor()

                    
                    //making to days
                    if timeLeftC <= -24 {
                        timeLeftC = timeLeftC/24
                        let sinceOutput = Int(timeLeftC) * -1
                        cell.timeleft.text = "Left To Move: \(sinceOutput)d"
                        
                    }
                    
                }
            
   


            
            
        case 1:
                cell.colorIndicator.backgroundColor = UIColor.lightGrayColor()
                find(theirturnArray[indexPath.row])
            
                if theirTurnColor[indexPath.row] == "white" {
                    cell.pieceIndicator.backgroundColor = UIColor.whiteColor()
                }
                else {
                    cell.pieceIndicator.backgroundColor = UIColor.blackColor()
                }
                
                if theirTurnSpeed[indexPath.row] == "Normal" {
                    cell.speedIndicator.image = UIImage(named: "normalIndicator.png")
                }
                else if theirTurnSpeed[indexPath.row] == "Fast" {
                    cell.speedIndicator.image = UIImage(named: "flash31.png")
                    
                }
                else if theirTurnSpeed[indexPath.row] == "Slow" {
                    cell.speedIndicator.image = UIImage(named: "clock104.png")
                }
                
                var since = theirturnUpdateSince[indexPath.row]
                //making to minutes
                cell.updated.text = "Last Updated: Now"

                if since >= 60 {
                    since = since/60
                    let sinceOutput = Int(since)
                    cell.updated.text = "Last Updated: \(sinceOutput)min ago"
                }
                //making to hours
                if since >= 60 {
                    since = since/60
                    let sinceOutput = Int(since)
                    cell.updated.text = "Last Updated: \(sinceOutput)h ago"
                    
                    //making to days
                    if since >= 24 {
                        since = since/24
                        let sinceOutput = Int(since)
                        cell.updated.text = "Last Updated: \(sinceOutput)d ago"
                    }
                    
                }

            
            
                var timeLeftC = theirturnLeft[indexPath.row]
                cell.timeleft.text = "Left To Move: Less than a minute"
                cell.timeleft.textColor = red
                
                if timeLeftC <= -60 {
                    timeLeftC = timeLeftC/60
                    let sinceOutput = Int(timeLeftC) * -1
                    cell.timeleft.text = "Left To Move: \(sinceOutput)min"
                    
                }
                
                //making to hours
                if timeLeftC <= -60 {
                    timeLeftC = timeLeftC/60
                    let sinceOutput = Int(timeLeftC) * -1
                    cell.timeleft.text = "Left To Move: \(sinceOutput)h"
                    cell.timeleft.textColor = UIColor.lightGrayColor()

                    
                    //making to days
                    if timeLeftC <= -24 {
                        timeLeftC = timeLeftC/24
                        let sinceOutput = Int(timeLeftC) * -1
                        cell.timeleft.text = "Left To Move: \(sinceOutput)d"
                        
                    }
                    
            }
            
            
        case 2:
            if typeofGameover[indexPath.row] == "lost" {
                cell.colorIndicator.backgroundColor = UIColor.redColor()
            }
            else {
                cell.colorIndicator.backgroundColor = UIColor.greenColor()
            }
                find(gameoverArray[indexPath.row])
            
            if gameoverTurnColor[indexPath.row] == "white" {
                cell.pieceIndicator.backgroundColor = UIColor.whiteColor()
            }
            else {
                cell.pieceIndicator.backgroundColor = UIColor.blackColor()
            }
            
            if gameoverTurnSpeed[indexPath.row] == "Normal" {
                cell.speedIndicator.image = UIImage(named: "normalIndicator.png")
            }
            else if gameoverTurnSpeed[indexPath.row] == "Fast" {
                cell.speedIndicator.image = UIImage(named: "flash31.png")
                
            }
            else if gameoverTurnSpeed[indexPath.row] == "Slow" {
                cell.speedIndicator.image = UIImage(named: "clock104.png")
            }
            
            var since = gameoverUpdateSince[indexPath.row]
            //making to minutes
            cell.updated.text = "Last Updated: Now"

            if since >= 60 {
                since = since/60
                let sinceOutput = Int(since)
                cell.updated.text = "Last Updated: \(sinceOutput)min ago"
            }
            //making to hours
            if since >= 60 {
                since = since/60
                let sinceOutput = Int(since)
                cell.updated.text = "Last Updated: \(sinceOutput)h ago"
                
                //making to days
                if since >= 24 {
                    since = since/24
                    let sinceOutput = Int(since)
                    cell.updated.text = "Last Updated: \(sinceOutput)d ago"
                }
            }
            
            cell.timeleft.text = "Game Over"
            cell.timeleft.font = UIFont(name: "Times-Italic", size: 14)


            
        default:
            ""
        
        
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

//        let cell:GameMenuTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("gameCell",forIndexPath: indexPath) as! GameMenuTableViewCell
        
        switch indexPath.section {
        case 0:
            gameID = gameIDSYourTurn[indexPath.row]
        case 1:
            gameID = gameIDSTheirTurn[indexPath.row]
        case 2:
            gameID = gameIDSGameOver[indexPath.row]
        default :
            ""
            
        }
        print("this is \(gameID)")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if yourturnArray.count == 0 && theirturnArray.count == 0 && gameoverArray.count == 0 {
        
        tableView.hidden = true
        

            
        }
        else {
        instructionsLabel.hidden = true
        tableView.hidden = false

        
        }
        
        switch section {
        case 0:
            return yourturnArray.count
        case 1:
            return theirturnArray.count
        case 2:
            return gameoverArray.count
        default:
            return 0
        
        }
       
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        
        return 3
    }
    
    

    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        
        switch section {
        case 0:
            return "Your Turn"
        case 1:
            return "Their Turn"
        case 2:
            return "Game Over"
        default:
            ""
        }
        return nil
    }

    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Didot", size: 19)!
        header.textLabel?.textColor = UIColor.lightGrayColor()
        header.backgroundColor = blue
        header.contentView.backgroundColor = UIColor.whiteColor()
        header.textLabel?.textAlignment = .Center
        header.alpha = 0.97

        if darkMode {        header.contentView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
}
        
        
        header.textLabel?.text? = (header.textLabel?.text?.uppercaseString)!
        
    }
    
    let loadingView = UIImageView(frame: CGRectMake((screenWidth/2)-30,-70,60,60))
var loaded = false

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        

        
        let yPos = -tableView.contentOffset.y
        
        if yPos > 200 {
    
            tableView.contentOffset.y = -150
        }
        
        if yPos > 64 {
            
            self.loadingView.alpha = (((yPos/1000) * 10)) - 1.1
          //  self.tableView.alpha = (2-((yPos/1000) * 15))

        }
//        else {
//            
////            UIView.animateWithDuration(0.2, animations: { () -> Void in
////                self.tableView.alpha = 1
////
////            })
//        }
        
        if yPos > 200 {
            
       
            if loaded == false {
                self.tableView.alpha = 0

            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                
                }, completion: { (finished) -> Void in
                if finished {
                
                    self.usernameArray = []
                    self.yourturnArray = []
                    self.theirturnArray = []
                    self.gameoverArray = []
                    self.imageDataArray = []
                    self.typeofGameover = []
                    
                    self.usernameArray = []
                    self.ratingArray = []
                    self.updatedArray = []
                    self.timeleftArray = []
                    //self.profilePicArray = []
                  //  self.imageDataArray = []
                    self.indicatorDataArray = []
                    
                    self.yourturnUpdateSince = []
                    self.theirturnUpdateSince = []
                    self.gameoverUpdateSince = []
                    
                    self.yourturnLeft = []
                    self.theirturnLeft = []
                    self.gameoverLeft = []
                    
                    self.tableView.reloadData()

                    self.findGames()
                    
                    
                    self.loaded = true
                    
                    
                    
                    
                }
            })
            }
            
        }
        
    }
    


    @IBAction func analyze(sender: AnyObject) {
        

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.tableView.frame.origin.x = -screenWidth
            
            self.newButtonOutlet.title = ""
            self.invitesButtonOutlet.title = ""
            self.navigationItem.title = "Analyze"
            
            }) { Finish in
                
                self.newButtonOutlet.title = "New"
                self.invitesButtonOutlet.title = "Invites"
                self.navigationItem.title = "Chess♔"
                self.tabBarController?.selectedIndex = 1
                self.tableView.frame.origin.x = 0
        }
        
        
    }
    
    
//    func updateTimer() {
//        
//        
//        for var i = 0; i < yourturnLeft.count; i++ {
//            yourturnLeft[i]++
//            yourturnLeftPrint.append(Int(yourturnLeft[i]))
//
//        }
//        for var i = 0; i < theirturnLeft.count; i++ {
//            theirturnLeft[i]++
//            theirturnLeftPrint.append(Int(theirturnLeft[i]))
//        }
//        for var i = 0; i < yourturnLeft.count; i++ {
//            gameoverLeft[i]++
//            gameoverLeftPrint.append(Int(gameoverLeft[i]))
//            
//            //
//            if gameoverLeftPrint[i] <= -60 {
//                gameoverLeftPrint[i] = gameoverLeftPrint[i]/60
//                let sinceOutput = gameoverLeftPrint[i] * -1
//                timeL.text = "\(sinceOutput)min"
//            }
//            else {
//                let sinceOutput = Int(timeLeftC) * -1
//                timeL.text = "\(sinceOutput)s"
//            }
//            //making to hours
//            if timeLeftC <= -60 {
//                timeLeftC = timeLeftC/60
//                let sinceOutput = Int(timeLeftC) * -1
//                timeL.text = "\(sinceOutput)h"
//                
//                //making to days
//                if timeLeftC <= -24 {
//                    timeLeftC = timeLeftC/24
//                    let sinceOutput = Int(timeLeftC) * -1
//                    timeL.text = "\(sinceOutput)d"
//                    
//                }
//                
//            }
//            
//        }
//        
//
//
//        
//        timeLeft++
//        var timeLeftC = timeLeft
//        print(timeLeft)
//        if timeLeftC <= -60 {
//            timeLeftC = timeLeftC/60
//            let sinceOutput = Int(timeLeftC) * -1
//            timeL.text = "\(sinceOutput)min"
//        }
//        else {
//            let sinceOutput = Int(timeLeftC) * -1
//            timeL.text = "\(sinceOutput)s"
//        }
//        //making to hours
//        if timeLeftC <= -60 {
//            timeLeftC = timeLeftC/60
//            let sinceOutput = Int(timeLeftC) * -1
//            timeL.text = "\(sinceOutput)h"
//            
//            //making to days
//            if timeLeftC <= -24 {
//                timeLeftC = timeLeftC/24
//                let sinceOutput = Int(timeLeftC) * -1
//                timeL.text = "\(sinceOutput)d"
//                
//            }
//            
//        }
//        
//        if timeLeftC >= 0 {
//            timeL.text = "Game Finished"
//            timeL.font = UIFont(name: "Times-Italic", size: 19)
//        }
//        
//    
//    }

    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        
        
        gameIDSYourTurn = []
        gameIDSTheirTurn = []
        gameIDSGameOver = []
        gameID = ""
        
        findGames()

        
        
        invitesButtonOutlet.title = "Invites"
        invitesButtonOutlet.enabled = false
        self.invitesButtonOutlet.tintColor = UIColor.grayColor()


        darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
        lightOrDarkMode()
    }
    override func viewDidAppear(animated: Bool) {
        
        

        //        //adding the game
//        let game = ["id": "123456"]
//        let gamesRef = ref.childByAppendingPath("games")
//        gamesRef.setValue(game)
//        
//        //add who's turn it is
//        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
//        let status = ["turn": "white"]
//        let statusRef = checkstatus.childByAppendingPath("123456")
//        statusRef.setValue(status)
//
//        //check for any changes that may have accured at the destined game ≈_≈
//        let check = Firebase(url:"https://chess-panber.firebaseio.com/games/123456")
//        check.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value)
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        usernameArray = []
        yourturnArray = []
        theirturnArray = []
        gameoverArray = []
        imageDataArray = []
        typeofGameover = []
        
         usernameArray = []
         ratingArray = []
         updatedArray = []
         timeleftArray = []
         profilePicArray = []
         imageDataArray = []
         indicatorDataArray = []
        
         yourturnUpdateSince = []
         theirturnUpdateSince = []
         gameoverUpdateSince = []
        
         yourturnLeft = []
         theirturnLeft = []
        gameoverLeft = []

        
        tableView.alpha = 0
        tableView.reloadData()
        
    }

    
    @IBAction func newPressed(sender: AnyObject) {

        
        UIView.animateWithDuration(0.3) { () -> Void in
            visualEffectView.alpha = 1
        }
        
        visualEffectView.userInteractionEnabled = true
        visualEffectSub.userInteractionEnabled = true
        
        //friends
        let friendsImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 85,100,50,50))
        if darkMode {friendsImage.image = UIImage(named:"group4.png")}
        else {friendsImage.image = UIImage(named:"group4-2.png")}
        friendsImage.contentMode = .ScaleAspectFill
        friendsImage.alpha = 0.7
        visualEffectSub.addSubview(friendsImage)
        
        let friendsButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80,120,120))
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        friendsButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        friendsButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        friendsButton.layer.cornerRadius = cornerRadius
        friendsButton.clipsToBounds = true
        friendsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        friendsButton.addTarget(self, action: "friendsButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(friendsButton)
        //-----friends end
        
        
        //random
        let randomImage = UIImageView(frame: CGRectMake((screenWidth / 2) + 35,100,50,50))
        if darkMode {randomImage.image = UIImage(named:"multimedia option23-2.png")}
        else {randomImage.image = UIImage(named:"multimedia option23.png")}
        randomImage.contentMode = .ScaleAspectFill
        randomImage.alpha = 0.7
        visualEffectSub.addSubview(randomImage)
        
        let randomButton = UIButton(frame: CGRectMake((screenWidth / 2),80,120,120))
        randomButton.setTitle("Random", forState: .Normal)
        randomButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        randomButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        randomButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        randomButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        randomButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        randomButton.layer.cornerRadius = cornerRadius
        randomButton.clipsToBounds = true
        randomButton.addTarget(self, action: "randomButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(randomButton)
        //------random end
        
        //username
        let usernameImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 85,100 + 140,50,50))
        if darkMode {usernameImage.image = UIImage(named:"search74.png")}
        else {usernameImage.image = UIImage(named:"search74-2.png")}
        usernameImage.contentMode = .ScaleAspectFill
        usernameImage.alpha = 0.7
        visualEffectSub.addSubview(usernameImage)
        
        let usernameButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80 + 140,120,120))
        usernameButton.setTitle("Username", forState: .Normal)
        usernameButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        usernameButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        usernameButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        usernameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        usernameButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        usernameButton.layer.cornerRadius = cornerRadius
        usernameButton.clipsToBounds = true
        visualEffectSub.addSubview(usernameButton)
        //------username end
        
        //rating
        let ratingImage = UIImageView(frame: CGRectMake((screenWidth / 2) + 35,100 + 140,50,50))
        if darkMode {ratingImage.image = UIImage(named:"search74.png")}
        else {ratingImage.image = UIImage(named:"search74-2.png")}
        ratingImage.contentMode = .ScaleAspectFill
        ratingImage.alpha = 0.7
        visualEffectSub.addSubview(ratingImage)
        
        let ratingButton = UIButton(frame: CGRectMake((screenWidth / 2),80 + 140,120,120))
        ratingButton.setTitle("Rating", forState: .Normal)
        ratingButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        ratingButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        ratingButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        ratingButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        ratingButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        ratingButton.layer.cornerRadius = cornerRadius
        ratingButton.clipsToBounds = true
        visualEffectSub.addSubview(ratingButton)
        //------rating end
        
        
        //location
        let locationImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 25,100 + 140 + 140,50,50))
        if darkMode {locationImage.image = UIImage(named:"map-pointer7-2.png")}
        else{locationImage.image = UIImage(named:"map-pointer7.png")}
        locationImage.contentMode = .ScaleAspectFill
        locationImage.alpha = 0.7
        visualEffectSub.addSubview(locationImage)
        
        let locationButton = UIButton(frame: CGRectMake((screenWidth / 2) - 60,80 + 140 + 140,120,120))
        locationButton.setTitle("Nearby", forState: .Normal)
        locationButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        locationButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        locationButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        locationButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        locationButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        locationButton.layer.cornerRadius = cornerRadius
        locationButton.clipsToBounds = true
        locationButton.addTarget(self, action: "nearbyButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(locationButton)
        //------location end
  
        let gesture3 = UITapGestureRecognizer(target: self, action: "effectSubPressed:")
        visualEffectSub.userInteractionEnabled = true
        visualEffectSub.addGestureRecognizer(gesture3)
        
    }
    
    func friendsButtonPressed(sender:UIButton) {
        removeNewView()
    
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("newGameFriends")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    func randomButtonPressed(sender:UIButton) {
    
        removeNewView()
        
        let meUser = PFUser.currentUser() as PFUser!
        let meRating = meUser["rating"] as! Int
        
        var userArray: Array<String> = []
        
        let query = PFQuery(className: "_User")
        query.limit = 100
        query.whereKey("request_everyone", equalTo: true)
        query.whereKey("username", notEqualTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                if let result = result as! [PFObject]! {
                    for result in result {
                        if (result["rating"] as! Int) > (meRating - 100) && (result["rating"] as! Int) < (meRating + 100) {
                            
                            userArray.append(result["username"] as! String)
                        }
                    
                    }
                    
                    let count = UInt32(userArray.count)
                    let ranInt = arc4random_uniform(count)
                    let _count = Int(ranInt)
                    

                    
                    
                    let query2 = PFQuery(className: "_User")
                    query2.whereKey("username", equalTo: userArray[_count])
                    query2.findObjectsInBackgroundWithBlock({ (result2:[AnyObject]?, error2:NSError?) -> Void in
                        
                        if error2 == nil {
                            if let userArray2 = result2 as? [PFUser] {
                                    for user in userArray2 {
                                        
                                        NSUserDefaults.standardUserDefaults().setObject(user["rating"] as! Int, forKey: "other_userrating_from_friends_gamemenu")
                                        
                                        NSUserDefaults.standardUserDefaults().setObject(userArray[_count], forKey: "other_username_from_friends_gamemenu")
                                        
                                        if let userPicture = user["profile_picture"] as? PFFile {
                                            
                                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error3: NSError?) -> Void in
                                                if (error3 == nil) {
                                             
                                                    NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "other_userImage_from_friends_gamemenu")
                                                    
                                                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("GameInvite")
                                                    self.showViewController(vc as! UIViewController, sender: vc)
                                                    
                                                    
                                                } else {
                                                }
                                            }
                                            
                                        }
                                    }
                                    
                                }
                                

                                
                            
                        
                        }
                        
                    })
                    
                    
                
                }
            
            
            }
            
        }
    

    }
    
    
    func nearbyButtonPressed(sender:UIButton) {
        
        removeNewView()
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("NewGameNearby")
        self.showViewController(vc as! UIViewController, sender: vc)
        
    }
    
    
    func effectSubPressed(sender:UITapGestureRecognizer){
        removeNewView()
  
    }
    
    func removeNewView() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            visualEffectView.alpha = 0
            
            }, completion: {finish in
                
                for view in visualEffectSub.subviews {
                    view.removeFromSuperview()
                }
                
        })
        
        visualEffectView.userInteractionEnabled = false
        visualEffectSub.userInteractionEnabled = false
    
    }
    
    
    
    
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        if darkMode == true {
        

            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            //this is to gamemenu black
            self.view.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
                visualEffectView.effect = UIBlurEffect(style: .Dark)

            
            
                    self.newButtonOutlet.tintColor = blue
            
                
            


            
                tableView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)


            
        }
        else if darkMode == false {
            
                self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
                self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            //this is to gamemenu white
                self.view.backgroundColor = UIColor.whiteColor()
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
                self.tabBarController?.tabBar.tintColor = blue
                self.navigationController?.navigationBar.tintColor = blue
                self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()

                self.newButtonOutlet.tintColor = blue

                visualEffectView.effect = UIBlurEffect(style: .Light)
            
                tableView.backgroundColor = UIColor.whiteColor()






            
        }
    
    
    }
    

}



