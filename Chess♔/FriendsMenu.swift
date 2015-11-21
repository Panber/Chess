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


class FriendsMenu: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UIScrollViewDelegate{
    
    // Array for users that are being searched for
    var users:NSMutableArray = []
    var userFriends: Array<String> = []
    
    @IBOutlet weak var scrollView: UIScrollView!

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

    var friendsArray: Array<String> = []
    
    override func viewWillDisappear(animated: Bool) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tblView =  UIView(frame: CGRectZero)
        searchDisplayController?.searchResultsTableView.tableFooterView = tblView
        searchDisplayController?.searchResultsTableView.tableFooterView!.hidden = true
        searchDisplayController?.searchResultsTableView.backgroundColor = UIColor.clearColor()
        
        tableView.hidden = true

        
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Explore"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth, 2000)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        

        
//        addTop10World()
//        
//        
//        let findFriends = PFQuery(className:"Friends")
//        findFriends.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
//        
//        findFriends.findObjectsInBackgroundWithBlock { (friends:[AnyObject]?, error:NSError?) -> Void in
//            if error == nil {
//                if let friends = friends as! [PFObject]! {
//                for friends in friends {
//                    self.friendsArray = friends["friends"] as! Array<String>
//                }
//                print(self.friendsArray)
//                self.addTop10Friends()
//                }
//            }
//        }
        
    }
    
    
    
 /*   //func to set up people in top10WorldView
    func addTop10World () {
        
        blurBC1 = UIImageView(frame: CGRectMake(0, 0, screenWidth , (screenWidth )/(16/9)))
      //  blurBC.image = UIImage(named: "JBpp.jpg")
        //blurBC1.layer.cornerRadius = cornerRadius
        blurBC1.contentMode = .ScaleAspectFill
        //blurBC1.layer.borderColor = UIColor.lightGrayColor().CGColor
       // blurBC1.layer.borderWidth = 0
        blurBC1.userInteractionEnabled = true
        blurBC1.clipsToBounds = true
        
        //bluring bc of profile pic
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = blurBC1.bounds
        visualEffectView.frame.size.height += 1
        blurBC1.addSubview(visualEffectView)
        
        let whiteF = UILabel(frame: CGRectMake(0, 0, blurBC1.frame.size.width, blurBC1.frame.size.height * (1/3)))
        whiteF.backgroundColor = UIColor.whiteColor()
        //whiteF.alpha = 0.8
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
        
        let seperator = UILabel(frame: CGRectMake(0,blurBC1.frame.size.height - 0.5,screenWidth,0.5))
        seperator.backgroundColor = UIColor.lightGrayColor()
        blurBC1.addSubview(seperator)
        
        
        let toTop10WorldUser = UIButton(frame: CGRectMake(0, blurBC1.frame.size.height/3, blurBC1.frame.size.width, blurBC1.frame.size.height * (2/3)))
        toTop10WorldUser.addTarget(self, action: "toTop10WorldUserPressed:", forControlEvents: .TouchUpInside)
        toTop10WorldUser.backgroundColor = UIColor.clearColor()
        blurBC1.addSubview(toTop10WorldUser)
        
        var GlobalUserInitiatedQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
        }
        var GlobalBackgroundQueue: dispatch_queue_t {
            return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
        }
        var GlobalMainQueue: dispatch_queue_t {
            return dispatch_get_main_queue()
        }
        
        
        let ratingQuery = PFQuery(className: "_User")
        ratingQuery.orderByDescending("rating")
        ratingQuery.limit = 10
        ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                self.top10WorldArrayUsers = []
                self.top10WorldArrayRating = []
                self.top10WorldArrayImage = []
                
                if let usersObject = usersObject as! [PFObject]! {
                for usersObject in usersObject {
                    
                    
                    self.top10WorldArrayRating.append(usersObject["rating"] as! Int)
                    //print(self.top10WorldArrayRating)
                    self.top10WorldArrayUsers.append(usersObject["username"] as! String)
                    //print(self.top10WorldArrayUsers)
                    usernameLabel.text = self.top10WorldArrayUsers.first
                    ratingLabel.text = "\(self.top10WorldArrayRating.first!)"
                    
                  
                
                }
                }
                //image

                let query = PFQuery(className: "_User")
                

                    query.whereKey("username", equalTo: self.top10WorldArrayUsers.first!)
                query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                    if (error == nil) {
                        
                        if let userArray = objects as? [PFUser] {
                            for user in userArray {
                                if let userPicture = user["profile_picture"] as? PFFile {
                                    
                                    userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                        if (error == nil) {
                                            
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
        
        })
        
    
        
    }

    func addTop10Friends () {
    
        blurBC2 = UIImageView(frame: CGRectMake(0,  blurBC1.frame.size.height, screenWidth, (screenWidth)/(16/9)))
        blurBC2.contentMode = .ScaleAspectFill
        blurBC2.userInteractionEnabled = true
        blurBC2.clipsToBounds = true
        
        //bluring bc of profile pic
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = blurBC2.bounds
        visualEffectView.frame.size.height += 1
        blurBC2.addSubview(visualEffectView)
        
        let whiteF = UILabel(frame: CGRectMake(0, 0, blurBC2.frame.size.width, blurBC2.frame.size.height * (1/3)))
        whiteF.backgroundColor = UIColor.whiteColor()
        //whiteF.alpha = 0.8
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
        
        let seperator = UILabel(frame: CGRectMake(0,blurBC2.frame.size.height - 0.5,screenWidth,0.5))
        seperator.backgroundColor = UIColor.lightGrayColor()
        blurBC2.addSubview(seperator)
        
        
    //    for var i = 0; i < friendsArray.count; i++ {
        
            
            let ratingQuery = PFQuery(className: "_User")
            ratingQuery.whereKey("username", containedIn: friendsArray)
            ratingQuery.orderByDescending("rating")
            ratingQuery.limit = 10
            ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    
                    if let usersObject = usersObject as! [PFObject]! {
                    for usersObject in usersObject {
                        self.top10FriendsArrayRating.append(usersObject["rating"] as! Int)
                        print(self.top10FriendsArrayRating)
                        self.top10FriendsArrayUsers.append(usersObject["username"] as! String)
                        print(self.top10FriendsArrayUsers)
                        
                    }
                    }
                    if self.top10FriendsArrayUsers.count > 0 {
                    
                    usernameLabel.text = self.top10FriendsArrayUsers[0]
                    ratingLabel.text = "\(self.top10FriendsArrayRating[0])"
                    

                    //image
                    
                    let query = PFQuery(className: "_User")
                    
                    
                    query.whereKey("username", equalTo: self.top10FriendsArrayUsers.first!)
                    query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                        if (error == nil) {
                            
                            if let userArray = objects as? [PFUser] {
                                for user in userArray {
                                    if let userPicture = user["profile_picture"] as? PFFile {
                                        
                                        userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                            if (error == nil) {
                                                
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
                    
                }
                
            })
        //}

    
    
    }
    */
    
    
    func addFeatured() {
    
    
    let featuredView = UIView(frame: CGRectMake(0,0,screenWidth , (screenWidth )/(16/9)))
    featuredView.userInteractionEnabled = true
    scrollView.addSubview(featuredView)
    
    let featuredViewText = UILabel(frame: CGRectMake(0,10,screenWidth,50))
    featuredViewText.font
        
    }
    
    
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos > 0 {
            
       //     blurBC1.frame.origin.y = scrollView.contentOffset.y

            
        }
        
//        if yPos < 64 {
//            
// 
//           
//        }
//        
//        if yPos < 64 - blurBC1.frame.size.height {
//            
//            blurBC2.frame.origin.y = scrollView.contentOffset.y
//            
//            
//        }
        
        
        
        
        
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
    
    func searchFriends(searchString: String) {
        
        let query = PFQuery(className: "Friends")
        if let user = PFUser.currentUser()?.username {
            query.whereKey("username", equalTo: (user))
            // pfQuery.orderByDescending("updatedAt")
            query.findObjectsInBackgroundWithBlock({ (friends:[AnyObject]?, error:NSError?) -> Void in
                for friends in friends! {
                    self.userFriends = (friends["friends"] as? Array<String>)!
                }
                print(self.userFriends)
            })
        }

       for var i = 0; i < userFriends.count; i++ {
        if (userFriends[i].lowercaseString.rangeOfString(searchString.lowercaseString) != nil) {
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("username", equalTo: userFriends[i])
            userQuery.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
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
        }
        
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
            searchFriends(searchText)
        }
        

        
        tableView.hidden = false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell

        // Declare user object and set cell text to username
        let user:PFUser = users[indexPath.row] as! PFUser
        
        let rating = user["rating"] as? Int
        cell.rating.text = "\(rating!)"
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
                searchFriends(searchBar.text!)
            }
            break
            
        default:
            break
            
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        
        
        UITableView.animateWithDuration(0.3, animations: { () -> Void in
            self.tableView.alpha = 0
            self.searchDisplayController?.searchResultsTableView.alpha = 0
            
            }, completion: { finish in
        
                self.tableView.alpha = 1
                self.searchDisplayController?.searchResultsTableView.alpha = 1

                self.tableView.hidden = true



        })
        
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