//
//  GameMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var blue = UIColor(red:0.17, green:0.33, blue:0.71, alpha:1.0)

var gameIDS = []
var pressedCreateNewGame = NSUserDefaults()

var scrollView: UIScrollView!

var logo = UIImage(named: "ChessIconSmallTextAndLogo.png")
var logoView = UIImageView(image:logo)

class GameMenu: UIViewController, UIScrollViewDelegate,UINavigationBarDelegate, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var newButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!

    
    var usernameArray: Array<String> = []
    var ratingArray: Array<Int> = []
    var updatedArray: Array<String> = []
    var timeleftArray: Array<String> = []
    var profilePicArray: Array<UIImage> = []
    var imageDataArray: Array<NSData> = []

    
    
    override func viewDidLoad() {
        

        
        super.viewDidLoad()
        
        let installation = PFInstallation.currentInstallation()
        installation["username"] = PFUser.currentUser()!.username
        installation.saveInBackground()

        
        let customFont = UIFont(name: "Didot", size: 18.0)
        newButtonOutlet.setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
        editButtonOutlet.setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        
        print("the current installation is \(PFInstallation.currentInstallation())")

        findGames()

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
                                users.saveInBackground()
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
    }

    
    @IBAction func newGame(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "created_New_Game")
        
       // newGameSetup()
     //   newGameSetup("", ProfilePic: UIImage(named: "")!, Rating: "", UpdatedAt: "", TimeLeft: "")

    }
    
    func findGames() {
        
        usernameArray = []
        let gamesQuery = PFQuery(className: "Games")
        //fix this
        gamesQuery.whereKey("whitePlayer", equalTo: PFUser.currentUser()!.username!)
        gamesQuery.findObjectsInBackgroundWithBlock { (games:[AnyObject]?, error:NSError?) -> Void in
            for games in games! {
                
                self.usernameArray.append((games["blackPlayer"] as? String)!)
                //self.ratingArray.append(games["blackPlayer"] as! Int)
                //  updatedArrayppend(games["blackPlayer"] as! String)
                //  timeleftArrayppend(games["blackPlayer"] as! String)
                
            }
            self.tableView.reloadData()

        }
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:GameMenuTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath) as! GameMenuTableViewCell
        
        

                
       // cell.username.text = self.usernameArray[indexPath.row]

        
        let query = PFQuery(className: "_User")
        
        query.whereKey("username", equalTo: usernameArray[indexPath.row] )
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                
                if let userArray = objects as? [PFUser] {
                    for user in userArray {
                        
                        cell.username.text = user["username"] as? String

                        
                        if let userPicture = user["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    
                                    cell.userProfileImage.image = UIImage(data: imageData!)
                                    cell.userProfileImageBC.image = UIImage(data: imageData!)
                                    //self.imageDataArray.append(imageData!)
                                   // self.Z[indexPath.row] = imageData!
                                    self.imageDataArray.append(imageData!)
                                    
                                    //        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
                                    //        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
                                    //        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
                                    //        visualEffectView.frame = self.userProfileImageBC.bounds
                                    //        visualEffectView.frame.size.height += 1
                                    //        self.userProfileImageBC.addSubview(visualEffectView)
                                    
                                    
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
        
        
        

        
        cell.rating.text = "601"
        cell.updated.text = "Last Update:"
        cell.timeleft.text = "Time Left:"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return usernameArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    

//    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
//        return nil
//    }
//
//    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = UIFont(name: "Didot", size: 16)!
//        header.textLabel?.textColor = UIColor.lightGrayColor()
//        header.backgroundColor = UIColor.lightGrayColor()
//        header.textLabel?.text? = (header.textLabel?.text?.lowercaseString)!
//        
//    }
    


    
    
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

        lightOrDarkMode()
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
                self.editButtonOutlet.tintColor = UIColor.whiteColor()
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
                self.editButtonOutlet.tintColor = blue
            
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
