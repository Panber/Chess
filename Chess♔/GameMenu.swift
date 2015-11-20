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

var blue = UIColor(red:0.17, green:0.33, blue:0.71, alpha:1.0)

var gameIDS = []
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

    var yourTurnColor: Array<String> = []
    var theirTurnColor: Array<String> = []
    var gameoverTurnColor: Array<String> = []

    var yourTurnSpeed: Array<String> = []
    var theirTurnSpeed: Array<String> = []
    var gameoverTurnSpeed: Array<String> = []
    


    
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
        instructionsLabel.font = UIFont(name: "Didot", size: 20)
        instructionsLabel.textColor = UIColor.darkGrayColor()
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textAlignment = .Center
        view.addSubview(instructionsLabel)
        
        
        super.viewDidLoad()
        
        let installation = PFInstallation.currentInstallation()
        installation["username"] = PFUser.currentUser()!.username
        installation.saveInBackground()

        
        let customFont = UIFont(name: "Didot", size: 18.0)
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
                                
                                PFGeoPoint.geoPointForCurrentLocationInBackground {
                                    (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
                                    if error == nil {
                                        users["location"] = geoPoint
                                        users.saveInBackground()
                                        location = geoPoint!
                                        
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
        
        navigationController?.navigationBar.topItem?.title = "Chess♔"
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
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation
            var coord = locationObj.coordinate
            
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
        
        tableView.hidden = true
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
                        
                        
                        self.yourTurnColor.append("white")
                        
                        self.yourTurnSpeed.append((games["speed"] as? String)!)

                        
                    }
                    else if games["status_white"] as? String == "notmove" {
                        
                        self.theirturnArray.append((games["blackPlayer"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        
                        self.theirturnUpdateSince.append(since)
                        
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
                        
                        self.yourTurnColor.append("black")
                        
                        self.yourTurnSpeed.append((games["speed"] as? String)!)


                        
                        
                        
                    }
                    else if games["status_black"] as? String == "notmove" {
                        
                        self.theirturnArray.append((games["whitePlayer"] as? String)!)
                        
                        //adding updated since
                        let lastupdate = games.updatedAt!
                        let since = NSDate().timeIntervalSinceDate(lastupdate)
                        self.theirturnUpdateSince.append(since)
                        
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
                        
                        self.gameoverTurnColor.append("black")
                        
                        self.gameoverTurnSpeed.append((games["speed"] as? String)!)


                        
                    }

                
                
                }
                }
                else {
                    
                    self.invitesButtonOutlet.title = "Invites"
                    self.invitesButtonOutlet.enabled = true
                    self.invitesButtonOutlet.tintColor = blue

                }
                
                
                
                
                //self.ratingArray.append(games["blackPlayer"] as! Int)
                //  updatedArrayppend(games["blackPlayer"] as! String)
                //  timeleftArrayppend(games["blackPlayer"] as! String)
                
            }
            }
            self.tableView.hidden = false
            self.tableView.reloadData()
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
        cell.timeleft.text = "Time Left: 2h 29min"
        
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

            
        default:
            ""
        
        
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

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
        header.textLabel?.font = UIFont(name: "Didot", size: 17)!
        header.textLabel?.textColor = UIColor.lightGrayColor()
        header.backgroundColor = blue
        header.contentView.backgroundColor = UIColor.whiteColor()
        header.textLabel?.textAlignment = .Center
        header.alpha = 0.97

        
        header.textLabel?.text? = (header.textLabel?.text?.uppercaseString)!
        
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
    
    
//    func newGameSetup() {
//        
//        
////        //creating the view
////        var shadowView: UIView = UIView(frame: CGRectMake(10, 75, screenWidth - 20 , screenHeight/7))
////        shadowView.layer.cornerRadius = cornerRadius
////        shadowView.backgroundColor = UIColor.whiteColor()
////        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
////        shadowView.layer.shadowOpacity = 0.1
////        shadowView.layer.shadowRadius = cornerRadius
////        shadowView.layer.shadowOffset = CGSizeZero
////        scrollView.addSubview(shadowView)
//        
//        //creating the view
//      //  var contentView: UIView = UIView(frame: CGRectMake(0, 0, screenWidth - 20 , screenHeight/7))
//        let contentView: UIView = UIView(frame: CGRectMake(10, 75, screenWidth - 20 , screenHeight/7))
//        contentView.layer.cornerRadius = cornerRadius
//        
//        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
//        else { contentView.backgroundColor = UIColor.whiteColor() }
//      //  contentView.layer.shadowColor = UIColor.blackColor().CGColor
//     //   contentView.layer.shadowOpacity = 0.1
//     //   contentView.layer.shadowRadius = cornerRadius
//     //   contentView.layer.shadowOffset = CGSizeZero
//        contentView.clipsToBounds = true
//        scrollView.addSubview(contentView)
//
//        //setting up bc image of profile pic
//        let profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.height, contentView.frame.size.height))
//        profilePicBlur.image = UIImage(named:"JBpp.jpg")
//        profilePicBlur.clipsToBounds = true
//        contentView.addSubview(profilePicBlur)
//        
//        //bluring bc of profile pic
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
//        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
//        else { visualEffectView.effect = UIBlurEffect(style: .Light) }
//        visualEffectView.frame = profilePicBlur.bounds
//        profilePicBlur.addSubview(visualEffectView)
//
//        //adding the profile pic
//        let profilePic = UIImageView(frame: CGRectMake(7.5, 7.5, (contentView.frame.size.height) - 15, (contentView.frame.size.height) - 15))
//        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
//        profilePic.clipsToBounds = true
//        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
//        profilePic.layer.borderWidth = 3
//        profilePic.image = UIImage(named:"JBpp.jpg")
//        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
//        contentView.addSubview(profilePic)
//        
//        //adding username to view
//        let label = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height/8, 250, 40))
//        label.textAlignment = NSTextAlignment.Left
//        label.text = (PFUser.currentUser()?.username)
//        label.font = UIFont(name: "Didot-Bold", size: 30)
//        if darkMode { label.textColor = UIColor.whiteColor() }
//        else { label.textColor = UIColor.blackColor() }
//        contentView.addSubview(label)
//        
//        
//        //adding updated since label
//        let label2 = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height - contentView.frame.size.height/2.4, 100, 40))
//        label2.textAlignment = NSTextAlignment.Left
//        label2.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
//        label2.numberOfLines = 0
//        label2.text = "Last move: 8 hours ago" + " Time left: 2 hours"
//        label2.font = UIFont(name: "Didot-Italic", size: 10)
//        if darkMode { label2.textColor = UIColor.whiteColor() }
//        else { label2.textColor = UIColor.blackColor() }
//        contentView.addSubview(label2)
//        
//        //adding time left label
//        let label3 = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height - contentView.frame.size.height/3.2, 150, 20))
//        label3.textAlignment = NSTextAlignment.Left
//        label3.text = "Time left: 2 hours"
//        label3.font = UIFont(name: "Didot-Italic", size: 10)
//       // contentView.addSubview(label3)
//    
//        //adding moveindicator
//        let moveindicator = UILabel(frame: CGRectMake(contentView.frame.size.width - 10, 0, 10, contentView.frame.size.height))
//        moveindicator.backgroundColor = UIColorFromRGB(0x02C223)
//        contentView.addSubview(moveindicator)
//    
//    }
//    
//    //function to update the ui of things like time left etc...
//    func updateGameSetup(User: String, ProfilePic: UIImage, Rating: String, UpdatedAt: String, TimeLeft: String) {
//    
//    }
//
//    
//    
//    //func to find hexadecimal color value
//    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        findGames()

        invitesButtonOutlet.title = "Invites"
        invitesButtonOutlet.enabled = false
        self.invitesButtonOutlet.tintColor = UIColor.grayColor()


        darkMode = NSUserDefaults.standardUserDefaults().boolForKey("dark_mode")
        lightOrDarkMode()
    }
    override func viewDidAppear(animated: Bool) {
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
        
        tableView.reloadData()
        
    }

    
    @IBAction func newPressed(sender: AnyObject) {
        
        if darkMode {  visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .Light) }
        
        let currentWindow: UIWindow = UIApplication.sharedApplication().keyWindow!
        currentWindow.addSubview(visualEffectView)

        
        UIView.animateWithDuration(0.3) { () -> Void in
            visualEffectView.alpha = 1
        }
        
        visualEffectView.userInteractionEnabled = true
        visualEffectSub.userInteractionEnabled = true
        
        //friends
        let friendsImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 85,100,50,50))
        friendsImage.image = UIImage(named:"group4-2.png")
        friendsImage.contentMode = .ScaleAspectFill
        friendsImage.alpha = 0.7
        visualEffectSub.addSubview(friendsImage)
        
        let friendsButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80,120,120))
        friendsButton.setTitle("FRIENDS", forState: .Normal)
        friendsButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
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
        randomImage.image = UIImage(named:"multimedia option23.png")
        randomImage.contentMode = .ScaleAspectFill
        randomImage.alpha = 0.7
        visualEffectSub.addSubview(randomImage)
        
        let randomButton = UIButton(frame: CGRectMake((screenWidth / 2),80,120,120))
        randomButton.setTitle("RANDOM", forState: .Normal)
        randomButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        randomButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
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
        usernameImage.image = UIImage(named:"search74-2.png")
        usernameImage.contentMode = .ScaleAspectFill
        usernameImage.alpha = 0.7
        visualEffectSub.addSubview(usernameImage)
        
        let usernameButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80 + 140,120,120))
        usernameButton.setTitle("USERNAME", forState: .Normal)
        usernameButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        usernameButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        usernameButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        usernameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        usernameButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        usernameButton.layer.cornerRadius = cornerRadius
        usernameButton.clipsToBounds = true
        visualEffectSub.addSubview(usernameButton)
        //------username end
        
        //rating
        let ratingImage = UIImageView(frame: CGRectMake((screenWidth / 2) + 35,100 + 140,50,50))
        ratingImage.image = UIImage(named:"search74-2.png")
        ratingImage.contentMode = .ScaleAspectFill
        ratingImage.alpha = 0.7
        visualEffectSub.addSubview(ratingImage)
        
        let ratingButton = UIButton(frame: CGRectMake((screenWidth / 2),80 + 140,120,120))
        ratingButton.setTitle("RATING", forState: .Normal)
        ratingButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        ratingButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        ratingButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        ratingButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        ratingButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        ratingButton.layer.cornerRadius = cornerRadius
        ratingButton.clipsToBounds = true
        visualEffectSub.addSubview(ratingButton)
        //------rating end
        
        
        //location
        let locationImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 25,100 + 140 + 140,50,50))
        locationImage.image = UIImage(named:"map-pointer7.png")
        locationImage.contentMode = .ScaleAspectFill
        locationImage.alpha = 0.7
        visualEffectSub.addSubview(locationImage)
        
        let locationButton = UIButton(frame: CGRectMake((screenWidth / 2) - 60,80 + 140 + 140,120,120))
        locationButton.setTitle("NEARBY", forState: .Normal)
        locationButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        locationButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
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
                self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
                
                self.view.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
                self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
                self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
                self.newButtonOutlet.tintColor = UIColor.whiteColor()
            //    self.editButtonOutlet.tintColor = UIColor.whiteColor()
//            
//            //setting top logo
//            logo = UIImage(named: "ChessIconSmallTextAndLogoDarkMode.png")
//            logoView = UIImageView(image:logo)
//            logoView.contentMode = UIViewContentMode.ScaleAspectFit
//            logoView.frame.size.height = 50
//            self.navigationItem.titleView = logoView
            
            
            
            
        }
        else if darkMode == false {
            
                self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
                self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
                self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
                self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
                self.tabBarController?.tabBar.tintColor = blue
                self.navigationController?.navigationBar.tintColor = blue
                self.newButtonOutlet.tintColor = blue
           //     self.editButtonOutlet.tintColor = blue
            
//            //setting top logo
//            logo = UIImage(named: "ChessIconSmallTextAndLogo.png")
//            logoView = UIImageView(image:logo)
//            logoView.contentMode = UIViewContentMode.ScaleAspectFit
//            logoView.frame.size.height = 50
//            self.navigationItem.titleView = logoView
//            

  
        
        }
    
    
    }

}
