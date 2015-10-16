//
//  FriendsMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

let usersObject = PFObject(className: "_User")


class FriendsMenu: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate{
    
    // Array for users that are being searched for
    var users:NSMutableArray = []
    var friends: Array<String> = []
    
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var top10World: UIScrollView!
//    @IBOutlet weak var top10Friends: UIScrollView!
//    @IBOutlet weak var grossing: UIScrollView!
////    @IBOutlet weak var top10WorldView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var top10WorldArrayRating = [Int]()
    var top10WorldArrayUsers:Array<String> = []
    var top10WorldArrayImage: Array<NSData> = []
    var top10WorldUserImage = NSData()
    
    var top10FriendsArrayRating = [Int]()
    var top10FriendsArrayUsers:Array<String> = []
    var top10FriendsArrayImage: Array<NSData> = []
    var top10FriendsUserImage = NSData()

    
    var usersScope:Bool = true
    var friendsScope:Bool = false

    var blurBC1 = UIImageView()
    var blurBC2 = UIImageView()

    var friendsArray = NSMutableArray()
    
    override func viewWillDisappear(animated: Bool) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Explore"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth, 2000)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
       // scrollView.bounces = false

        
        
//        top10World.scrollEnabled = true
//        top10World.contentSize = CGSizeMake(1400, 140)
//        top10World.showsHorizontalScrollIndicator = false
//        top10World.bounces = false
//        
//        
//        top10Friends.scrollEnabled = true
//        top10Friends.contentSize = CGSizeMake(1400, 140)
//        top10Friends.showsHorizontalScrollIndicator = false
//        top10Friends.bounces = false
//        
//        grossing.scrollEnabled = true
//        grossing.contentSize = CGSizeMake(1400, 140)
//        grossing.showsHorizontalScrollIndicator = false
//        grossing.bounces = false
        
        addTop10World()
        
        
        let findFriends = PFQuery(className:"Friends")
        findFriends.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        
        findFriends.findObjectsInBackgroundWithBlock { (friends:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                for friends in friends! {
                    self.friendsArray = friends["friends"] as! NSMutableArray
                }
                //print(self.friendsArray)
                self.addTop10Friends()

            }
        }
        
    }
    
    
    
    //func to set up people in top10WorldView
    func addTop10World () {
        
        blurBC1 = UIImageView(frame: CGRectMake(10, 55, screenWidth - 20, (screenWidth - 20)/(16/9)))
      //  blurBC.image = UIImage(named: "JBpp.jpg")
        blurBC1.layer.cornerRadius = cornerRadius
        blurBC1.contentMode = .ScaleAspectFill
        blurBC1.layer.borderColor = UIColor.lightGrayColor().CGColor
        blurBC1.layer.borderWidth = 0.5
        blurBC1.userInteractionEnabled = true
        blurBC1.clipsToBounds = true
        
        //bluring bc of profile pic
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = blurBC1.bounds
        blurBC1.addSubview(visualEffectView)
        
        let whiteF = UILabel(frame: CGRectMake(0, 0, blurBC1.frame.size.width, blurBC1.frame.size.height * (1/3)))
        whiteF.backgroundColor = UIColor.whiteColor()
        whiteF.alpha = 0.8
        blurBC1.addSubview(whiteF)
        
        let identifierLabel = UILabel(frame: CGRectMake(20, whiteF.frame.origin.y, blurBC1.frame.size.width - 20, whiteF.frame.size.height))
        identifierLabel.font = UIFont(name: "Didot", size: 20)
        identifierLabel.text = "Top 10 - World"
        identifierLabel.textColor = UIColor.blackColor()
        blurBC1.addSubview(identifierLabel)
        
        let arrow = UIImageView(frame: CGRectMake(blurBC1.frame.size.width - 30, 0, 15, whiteF.frame.size.height))
        arrow.image = UIImage(named: "arrow_black.png")
        arrow.alpha = 0.3
        arrow.contentMode = .ScaleAspectFit
        blurBC1.addSubview(arrow)
        
        let toTop10World = UIButton(frame: CGRectMake(0, 0, blurBC1.frame.size.width, blurBC1.frame.size.height / 3))
        toTop10World.addTarget(self, action: "toTop10WorldPressed:", forControlEvents: .TouchUpInside)
        toTop10World.backgroundColor = UIColor.clearColor()
        blurBC1.addSubview(toTop10World)
        
        let currentToLabel = UILabel(frame: CGRectMake(20, whiteF.frame.size.height + 10, blurBC1.frame.size.width - 20, 20))
        currentToLabel.font = UIFont(name: "Didot-Italic", size: 15)
        currentToLabel.text = "Current no.1"
        currentToLabel.textColor = UIColor.grayColor()
        blurBC1.addSubview(currentToLabel)
        
        let profilePic = UIImageView(frame: CGRectMake(20, whiteF.frame.size.height + 10 + currentToLabel.frame.size.height + 5, 70, 70))
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.contentMode = .ScaleAspectFill
        blurBC1.addSubview(profilePic)
        
        let usernameLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y, 200, 40))
        usernameLabel.font = UIFont(name: "Didot-Bold", size: 30)
        blurBC1.addSubview(usernameLabel)
        
        let ratingLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y + usernameLabel.frame.size.height, 200, 30))
        ratingLabel.font = UIFont(name: "Didot-Italic", size: 15)
        ratingLabel.textColor = UIColor.grayColor()
        blurBC1.addSubview(ratingLabel)
        
        let toTop10WorldUser = UIButton(frame: CGRectMake(0, blurBC1.frame.size.height/3, blurBC1.frame.size.width, blurBC1.frame.size.height * (2/3)))
        toTop10WorldUser.addTarget(self, action: "toTop10WorldUserPressed:", forControlEvents: .TouchUpInside)
        toTop10WorldUser.backgroundColor = UIColor.clearColor()
        blurBC1.addSubview(toTop10WorldUser)
        
        
        let ratingQuery = PFQuery(className: "_User")
       // ratingQuery.orderByDescending("username")
        ratingQuery.orderByDescending("rating")
        ratingQuery.limit = 10
        ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                self.top10WorldArrayUsers = []
                self.top10WorldArrayRating = []
                self.top10WorldArrayImage = []
                
                for usersObject in usersObject! {
                    
                    
                    self.top10WorldArrayRating.append(usersObject["rating"] as! Int)
                    //print(self.top10WorldArrayRating)
                    self.top10WorldArrayUsers.append(usersObject["username"] as! String)
                    //print(self.top10WorldArrayUsers)
                    usernameLabel.text = self.top10WorldArrayUsers.first
                    ratingLabel.text = "\(self.top10WorldArrayRating.first!)"
                    
                  
           
                }
           
           
                var alreadyRan = false
                
                
                let query = PFQuery(className: "_User")
                
                query.whereKey("username", containedIn: self.top10WorldArrayUsers)
                
                // Find the matching users asynchronously
                query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                    if (error == nil) {
                        // Fetch the images of the users
                        if let userArray = objects as? [PFUser] {
                            for user in userArray {
                                if let userPicture = user["profile_picture"] as? PFFile {
                                    
                                    userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                        if (error == nil) {
                                            
                                            if alreadyRan == false {
                                                let image = UIImage(data: imageData!)!
                                                profilePic.image = image
                                                self.blurBC1.image = image
                                                self.top10WorldUserImage = imageData!
                                                
                                                visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                                                if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
                                                else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
                                                visualEffectView.frame = self.blurBC1.bounds
                                                
                                                self.blurBC1.alpha = 0
                                                self.scrollView.addSubview(self.blurBC1)
                                                self.blurBC1.alpha = 1
                                                alreadyRan = true
                                            }
                                            
                                            self.top10WorldArrayImage.append(imageData!)
                                            
                                        } else {
                                            // Error handling
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
                /*
                for var i = 0; i < 10; i++ {
                    let imageQuery = PFQuery(className: "_User")
                    imageQuery.whereKey("username", equalTo: self.top10WorldArrayUsers[i])
                    let user = imageQuery.getFirstObject() as! PFUser
                    
                    let profileImage:PFFile = user["profile_picture"] as! PFFile
                    profileImage.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                        
                        if error == nil {
                            if alreadyRan == false {
                                let image = UIImage(data: imageData!)!
                                profilePic.image = image
                                self.blurBC1.image = image
                                self.top10WorldUserImage = imageData!
                                
                                visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                                if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
                                else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
                                visualEffectView.frame = self.blurBC1.bounds
                                
                                self.blurBC1.alpha = 0
                                self.scrollView.addSubview(self.blurBC1)
                                self.blurBC1.alpha = 1
                                alreadyRan = true
                            }
                            
                            self.top10WorldArrayImage.append(imageData!)
                            
                            
                            //                                        UIView.animateWithDuration(0.5, animations: {
                            //                                            })
                        }
                        
                    }
                }

*/

            
            }
        
        })
        


        

    
//        let headerImage = UIImageView(frame: CGRectMake(0, 0, blurBC.frame.size.width, blurBC.frame.size.height - 70))
//        headerImage.image = UIImage(named: "earth53.png")
//        headerImage.contentMode = .ScaleAspectFit
//        headerImage.alpha = 0.6
//        blurBC.addSubview(headerImage)
        
        

                /*
                var t = 0
                for var i:CGFloat = 0; i < 7; i++, t++ {
                    
                    let personView = UIView(frame: CGRectMake((self.top10World.frame.size.height) * i, 5, self.top10World.frame.size.height, self.top10World.frame.size.height))
                  //  personView.layer.cornerRadius = cornerRadius
                    personView.backgroundColor = UIColor.whiteColor()
                   // personView.layer.borderWidth = 0.5
                  //  personView.layer.borderColor = UIColor.lightGrayColor().CGColor
                    personView.clipsToBounds = true
                    self.top10World.addSubview(personView)
                    
                    
                    
                    //making usernamelabel
                    let usernameLabel = UILabel(frame: CGRectMake(5, personView.frame.size.height / 1.6 , personView.frame.size.width - 10, 20))
                    usernameLabel.text = self.top10WorldArrayUsers[t]
                    usernameLabel.textAlignment = .Center
                    usernameLabel.font = UIFont(name: "Didot", size: 14)
                    personView.addSubview(usernameLabel)
                    
                    //ratinglabel
                    let ratingLabel = UILabel(frame: CGRectMake(5, personView.frame.size.height / 1.3 , personView.frame.size.width - 10, 20))
                    ratingLabel.text = self.top10WorldArrayRating[t]
                    ratingLabel.textColor = UIColor.lightGrayColor()
                    ratingLabel.textAlignment = .Center
                    ratingLabel.font = UIFont(name: "Didot", size: 12)
                    personView.addSubview(ratingLabel)
                    
                    //placement
                    let placeLabel = UILabel(frame: CGRectMake(8, 8,11,11))
                    placeLabel.text = "\(t+1)."
                    placeLabel.textColor = UIColor.grayColor()
                    placeLabel.textAlignment = .Center
                    placeLabel.font = UIFont(name: "Didot-Italic", size: 11)
                    personView.addSubview(placeLabel)
                    
                    //profilepic
                    let profilePicture = UIImageView(frame: CGRectMake(personView.frame.size.width / 2 * 0.5, 10, personView.frame.size.width / 2 , personView.frame.size.width / 2 ))
                    profilePicture.layer.cornerRadius = profilePicture.frame.size.height / 2
                    profilePicture.layer.borderColor = UIColor.lightGrayColor().CGColor
                    profilePicture.layer.borderWidth = 0.5
                    profilePicture.clipsToBounds = true
                    profilePicture.contentMode = UIViewContentMode.ScaleAspectFill
                    personView.addSubview(profilePicture)
                    
                    let sep = UIImageView(frame: CGRectMake(personView.frame.size.width - 1, 0, 0.5, personView.frame.size.height))
                    sep.backgroundColor = UIColor.lightGrayColor()
                    personView.addSubview(sep)
                    
                    
                    let findUserName: PFQuery = PFQuery(className:"_User")
                    findUserName.whereKey("username", containsString: self.top10WorldArrayUsers[t])
                    
                    findUserName.findObjectsInBackgroundWithBlock{(usersObject: [AnyObject]?, error: NSError?) -> Void in
                        if (error == nil) {
                            
                            for usersObject in usersObject! {
                                if let profileImage:PFFile = usersObject["profile_picture"] as? PFFile {
                                    profileImage.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                                        
                                        if error == nil {
                                            image = UIImage(data: imageData!)!
                                            profilePicture.image = image
                                            // tableView.reloadInputViews()
                                            //bluring bc
                                            //                                            profilePicBlur.image = image
                                            //                                            //bluring bc of profile pic
                                            //                                            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                                            //                                            if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
                                            //                                            else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
                                            //                                            visualEffectView.frame = profilePicBlur.bounds
                                            //                                            profilePicBlur.addSubview(visualEffectView)
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                    
                }
*/
                
            }

    func addTop10Friends () {
    
        blurBC2 = UIImageView(frame: CGRectMake(10, 55 + blurBC1.frame.size.height + 15, screenWidth - 20, (screenWidth - 20)/(16/9)))
        //  blurBC.image = UIImage(named: "JBpp.jpg")
        blurBC2.layer.cornerRadius = cornerRadius
        blurBC2.contentMode = .ScaleAspectFill
        blurBC2.layer.borderColor = UIColor.lightGrayColor().CGColor
        blurBC2.layer.borderWidth = 0.5
        blurBC2.userInteractionEnabled = true
        blurBC2.clipsToBounds = true
        
        //bluring bc of profile pic
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = blurBC2.bounds
        blurBC2.addSubview(visualEffectView)
        
        let whiteF = UILabel(frame: CGRectMake(0, 0, blurBC2.frame.size.width, blurBC2.frame.size.height * (1/3)))
        whiteF.backgroundColor = UIColor.whiteColor()
        whiteF.alpha = 0.8
        blurBC2.addSubview(whiteF)
        
        let identifierLabel = UILabel(frame: CGRectMake(20, whiteF.frame.origin.y, blurBC2.frame.size.width - 20, whiteF.frame.size.height))
        identifierLabel.font = UIFont(name: "Didot", size: 20)
        identifierLabel.text = "Top 10 - Friends"
        identifierLabel.textColor = UIColor.blackColor()
        blurBC2.addSubview(identifierLabel)
        
        let arrow = UIImageView(frame: CGRectMake(blurBC2.frame.size.width - 30, 0, 15, whiteF.frame.size.height))
        arrow.image = UIImage(named: "arrow_black.png")
        arrow.alpha = 0.3
        arrow.contentMode = .ScaleAspectFit
        blurBC2.addSubview(arrow)
        
        let toTop10Friends = UIButton(frame: CGRectMake(0, 0, blurBC2.frame.size.width, blurBC2.frame.size.height / 3))
        toTop10Friends.addTarget(self, action: "toTop10FriendsPressed:", forControlEvents: .TouchUpInside)
        toTop10Friends.backgroundColor = UIColor.clearColor()
        blurBC2.addSubview(toTop10Friends)
        
        let currentToLabel = UILabel(frame: CGRectMake(20, whiteF.frame.size.height + 10, blurBC2.frame.size.width - 20, 20))
        currentToLabel.font = UIFont(name: "Didot-Italic", size: 15)
        currentToLabel.text = "Current no.1"
        currentToLabel.textColor = UIColor.grayColor()
        blurBC2.addSubview(currentToLabel)
        
        let profilePic = UIImageView(frame: CGRectMake(20, whiteF.frame.size.height + 10 + currentToLabel.frame.size.height + 5, 70, 70))
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.contentMode = .ScaleAspectFill
        blurBC2.addSubview(profilePic)
        
        let usernameLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y, 200, 40))
        usernameLabel.font = UIFont(name: "Didot-Bold", size: 30)
        blurBC2.addSubview(usernameLabel)
        
        let ratingLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y + usernameLabel.frame.size.height, 200, 30))
        ratingLabel.font = UIFont(name: "Didot-Italic", size: 15)
        ratingLabel.textColor = UIColor.grayColor()
        blurBC2.addSubview(ratingLabel)
        
        let toTop10FriendsUser = UIButton(frame: CGRectMake(0, blurBC2.frame.size.height/3, blurBC2.frame.size.width, blurBC2.frame.size.height * (2/3)))
        toTop10FriendsUser.addTarget(self, action: "toTop10FriendsUserPressed:", forControlEvents: .TouchUpInside)
        toTop10FriendsUser.backgroundColor = UIColor.clearColor()
        blurBC2.addSubview(toTop10FriendsUser)
        
        
        for var i = 0; i < friendsArray.count; i++ {
        
            
            let ratingQuery = PFQuery(className: "_User")
            ratingQuery.whereKey("username", equalTo: friendsArray[i])
            ratingQuery.orderByDescending("rating")
            ratingQuery.limit = 10
            ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    for usersObject in usersObject! {
                        self.top10FriendsArrayRating.append(usersObject["rating"] as! Int)
                        print(self.top10FriendsArrayRating)
                        self.top10FriendsArrayUsers.append(usersObject["username"] as! String)
                        print(self.top10FriendsArrayUsers)
                        
                    }
                    usernameLabel.text = self.top10FriendsArrayUsers[0]
                    ratingLabel.text = "\(self.top10FriendsArrayRating[0])"
                    

                    let findUserName: PFQuery = PFQuery(className:"_User")
                    findUserName.whereKey("username", containsString: self.top10FriendsArrayUsers[0])
                    
                    findUserName.findObjectsInBackgroundWithBlock{(usersObject: [AnyObject]?, error: NSError?) -> Void in
                        if (error == nil) {
                            
                            for usersObject in usersObject! {
                                if let profileImage:PFFile = usersObject["profile_picture"] as? PFFile {
                                    profileImage.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                                        
                                        if error == nil {
                                            let image = UIImage(data: imageData!)!
                                            profilePic.image = image
                                            self.blurBC2.image = image
                                            self.top10FriendsUserImage = imageData!
                                            visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                                            if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
                                            else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
                                            visualEffectView.frame = self.blurBC2.bounds
                                            self.blurBC2.alpha = 0
                                            self.scrollView.addSubview(self.blurBC2)
                                            self.blurBC2.alpha = 1
                                            
                                            self.top10FriendsArrayImage.append(imageData!)

//                                            UIView.animateWithDuration(0.5, animations: {
//                                            })
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                }
                
            })
        }

    
    
    }
    
    func toTop10WorldPressed(sender: UIButton!) {
    
        NSUserDefaults.standardUserDefaults().setObject(top10WorldArrayUsers, forKey: "userArray")
        NSUserDefaults.standardUserDefaults().setObject(top10WorldArrayRating, forKey: "ratingArray")
        NSUserDefaults.standardUserDefaults().setObject(top10WorldArrayImage, forKey: "profilePicArray")
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderBoard")
        self.showViewController(vc as! UIViewController, sender: vc)
    
    }
    
    func toTop10FriendsPressed(sender: UIButton!) {
        
        NSUserDefaults.standardUserDefaults().setObject(top10FriendsArrayUsers, forKey: "userArray")
        NSUserDefaults.standardUserDefaults().setObject(top10FriendsArrayRating, forKey: "ratingArray")
        NSUserDefaults.standardUserDefaults().setObject(top10FriendsArrayImage, forKey: "profilePicArray")
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderBoard")
        self.showViewController(vc as! UIViewController, sender: vc)
    
    }
    
    func toTop10WorldUserPressed(sender: UIButton!) {
//        sender.highlighted = true
//        if sender.highlighted == true {
//        sender.backgroundColor = UIColor.purpleColor()
//        sender.alpha = 0.2
//        }
//        
//        UIView.animateWithDuration(0.5, animations: {            sender.alpha = 1
//}) { (Bool) -> Void in
//        }
        
        NSUserDefaults.standardUserDefaults().setObject(top10WorldArrayUsers[0], forKey: "other_username")
        NSUserDefaults.standardUserDefaults().setObject(top10WorldUserImage, forKey: "other_userImage")
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
        self.showViewController(vc as! UIViewController, sender: vc)

    }
    
    func toTop10FriendsUserPressed(sender: UIButton!) {
    
        NSUserDefaults.standardUserDefaults().setObject(top10FriendsArrayUsers[0], forKey: "other_username")
        NSUserDefaults.standardUserDefaults().setObject(top10FriendsUserImage, forKey: "other_userImage")
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
        self.showViewController(vc as! UIViewController, sender: vc)

    }
    


    // Func that searches for user with key and stores it in an array
    func searchUsers(searchString: String) {
        
        let query: PFQuery = PFQuery(className:"_User")
        query.whereKey("username", matchesRegex:searchString, modifiers:"i")
        query.whereKey("username", notEqualTo: (PFUser.currentUser()?.username)!)
        query.orderByAscending("username")
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.users.removeAllObjects()
                for object in objects! {
                    self.users.addObject(object)
                }
                print(self.users.count)
                dispatch_async(dispatch_get_main_queue()) {
                    self.searchDisplayController?.searchResultsTableView.reloadData()
                }
            }
        }
    }
    
    func getFriends(searchString: String) {
        
//        let query = PFQuery(className: "Friends")
//        if let user = PFUser.currentUser()?.username {
//            query.whereKey("username", equalTo: (user))
//            // pfQuery.orderByDescending("updatedAt")
//            query.findObjectsInBackgroundWithBlock({ (friends:[AnyObject]?, error:NSError?) -> Void in
//                for friends in friends! {
//                    self.friends = (friends["friends"] as? Array<String>)!
//                }
//                print(friends?.count)
//            })
//        }
//        for var i = 0; i < friends.count; i++ {
//            if friends[i].containsString(searchString.lowercaseString) || friends[i].containsString(searchString.capitalizedString) {
//                let query: PFQuery = PFQuery(className:"_User")
//            query.whereKey("username", equalTo: friends[i])
//            let _user = query.getFirstObject() as! PFUser
//            self.users.removeAllObjects()
//            self.users.addObject(_user)
//            dispatch_async(dispatch_get_main_queue()) {
//                self.searchDisplayController?.searchResultsTableView.reloadData()
//            }
//            }
//
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if users.count == 0 {
            self.searchDisplayController?.searchResultsTableView.rowHeight = 70
        }
        return users.count

    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 && usersScope == true {
            searchUsers(searchText)
        }
        if searchText.characters.count > 0 && friendsScope == true {
            getFriends(searchText)
        }
        tableView.hidden = false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell

        // Declare user object and set cell text to username
        let user:PFUser = users[indexPath.row] as! PFUser
        
        cell.username.text = user["username"] as? String
        
        let profilePictureObject = user["profile_picture"] as? PFFile
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    cell.userProfileImage.image = UIImage(data: imageData!)
                }
                
            }
        }
        //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        return cell
    }
    
    //     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //
    //
    //        let currentCell = tableView.cellForRowAtIndexPath(indexPath)
    //
    //
    //
    //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    //
    //
    //
    //    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell
        
        let user:PFUser = users[indexPath.row] as! PFUser
        
        cell.username.text = user["username"] as? String
        NSUserDefaults.standardUserDefaults().setObject(cell.username.text, forKey: "other_username")
        
        let profilePictureObject = user["profile_picture"] as? PFFile
        
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    NSUserDefaults.standardUserDefaults().setObject(imageData!, forKey: "other_userImage")

                }
                
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Search
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        
        tableView.hidden = false
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        return true
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            
            print("Users")
            usersScope = true
            friendsScope = false
            users.removeAllObjects()
            tableView.reloadData()
            if searchBar.text?.characters.count > 0 {
                searchUsers(searchBar.text!)
            }
            break
        case 1:
            print("Friends")
            friendsScope = true
            usersScope = false
            users.removeAllObjects()
            tableView.reloadData()
            if searchBar.text?.characters.count > 0 {
            }
            break
            
        default:
            break
            
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        tableView.hidden = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
        //searchUsers(searchBar.text!)
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