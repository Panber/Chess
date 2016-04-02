//
//  FriendsMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse
import MessageUI

let usersObject = PFObject(className: "_User")

var featuredViewText = UILabel()
var featuredUsername = UILabel()
var featuredRating = UILabel()

var topText = UILabel()
var topWorldImage = UIImageView()
var topFriendsImage = UIImageView()
var topNearbyImage = UIImageView()

     var PData = NSData()


var contactMailImage = UIImageView()
var contactText = UILabel()

class FriendsMenu: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UIScrollViewDelegate,MFMailComposeViewControllerDelegate{
    
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
    
    var userNameFromFeatured = String()
    var ratingFromFeatured = Int()
    var imageFromFeatured = NSData()
    

    
    var featuredView = UIView()
    let featuredProfilePicView = UIImageView(frame: CGRectMake(screenWidth/2 - 90, 85, 65, 65))
    
    var topView = UIView()
    
    var contactView = UIView()
    
    var usersScope:Bool = true
    var friendsScope:Bool = false
    
    var blurBC1 = UIImageView()
    var blurBC2 = UIImageView()
    
    var friendsArray: Array<String> = []
    
    override func viewWillDisappear(animated: Bool) {
        view.endEditing(true)
    }
    override func viewDidDisappear(animated: Bool) {
        self.searchDisplayController?.searchResultsTableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tblView =  UIView(frame: CGRectZero)
        searchDisplayController?.searchResultsTableView.tableFooterView = tblView
        searchDisplayController?.searchResultsTableView.tableFooterView!.hidden = true
        //        searchDisplayController?.searchResultsTableView.backgroundColor = UIColor.clearColor()
        
        tableView.hidden = true
        
        
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Explore"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth, 910)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.delegate = self
        
        if darkMode {scrollView.backgroundColor = UIColor.clearColor()}
        else{scrollView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)}
        
        addFeatured()
        addTop()
        addContact()
        addCreatorAndLegal()
        
        
    }
    
    func addFeatured() {
        
        
        featuredView = UIView(frame: CGRectMake(0,0,screenWidth , 200))
        featuredView.userInteractionEnabled = true
        scrollView.addSubview(featuredView)
        
        featuredViewText = UILabel(frame: CGRectMake(0,10,screenWidth,50))
        featuredViewText.font = UIFont(name: "Didot", size: 25)
        featuredViewText.text = "FEATURED"
        if darkMode {featuredViewText.textColor = UIColor.lightGrayColor()}
        else {featuredViewText.textColor = UIColor.darkGrayColor()}
        featuredViewText.textAlignment = .Center
        featuredView.addSubview(featuredViewText)
        
        
        let _scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,200))
        _scrollView.delegate = self
        _scrollView.userInteractionEnabled = true
        _scrollView.scrollEnabled = true
        _scrollView.pagingEnabled = true
        _scrollView.contentSize = CGSizeMake(screenWidth, 200)
        featuredView.addSubview(_scrollView)
        
        
        featuredProfilePicView.layer.cornerRadius = featuredProfilePicView.frame.size.width/2
        featuredProfilePicView.clipsToBounds = true
        featuredProfilePicView.alpha = 0
        featuredProfilePicView.contentMode = .ScaleAspectFill
        _scrollView.addSubview(featuredProfilePicView)
        
        featuredUsername = UILabel(frame: CGRectMake(featuredProfilePicView.frame.origin.x + featuredProfilePicView.frame.size.width + 25,featuredProfilePicView.frame.origin.y + 10,screenWidth - (featuredProfilePicView.frame.origin.x + featuredProfilePicView.frame.size.width + 25),27))
        featuredUsername.font = UIFont(name: "Times", size: 22)
        featuredUsername.text = "mufcjb"
        featuredUsername.textAlignment = .Left
        featuredUsername.alpha = 0
        _scrollView.addSubview(featuredUsername)
        
        featuredRating = UILabel(frame: CGRectMake(featuredUsername.frame.origin.x,featuredUsername.frame.origin.y + featuredUsername.frame.size.height,screenWidth - (featuredProfilePicView.frame.origin.x + featuredProfilePicView.frame.size.width + 25),21))
        featuredRating.font = UIFont(name: "Times-Italic", size: 15)
        featuredRating.textColor = UIColor.darkGrayColor()
        featuredRating.alpha = 0
        _scrollView.addSubview(featuredRating)
        
        let featuredSeperator = UILabel(frame: CGRectMake(0,featuredView.frame.origin.y + featuredView.frame.size.height - 1,screenWidth,0.2))
        featuredSeperator.backgroundColor = UIColor.lightGrayColor()
        featuredView.addSubview(featuredSeperator)
        
        let featuredQuery = PFQuery(className: "_User")
        featuredQuery.orderByDescending("rating")
        featuredQuery.limit = 1
        featuredQuery.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, error:NSError?) -> Void in
            if error == nil{
                if let result = result as? [PFUser] {
                    for result in result {
                        
                        if let userPicture = result["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    
                                    self.featuredProfilePicView.image = UIImage(data: imageData!)
                                    PData = imageData!
                                    let r = result["rating"] as! Int
                                    featuredRating.text = "\(r)"
                                    featuredUsername.text = result["username"] as? String
                                    
                                    self.userNameFromFeatured = (result["username"] as? String)!
                                    self.ratingFromFeatured = result["rating"] as! Int
                                    self.imageFromFeatured = imageData!
                                    
                                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                                        self.featuredProfilePicView.alpha = 1
                                        featuredUsername.alpha = 1
                                        featuredRating.alpha = 1
                                        
                                    })
                                    
                                } else {
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
        }
        
        let featuredButton1 = UIButton(frame: CGRectMake(0,0,screenWidth,200))
        featuredButton1.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        featuredButton1.clipsToBounds = true
        featuredButton1.addTarget(self, action: "featuredButton1Pressed:", forControlEvents: .TouchUpInside)
        _scrollView.addSubview(featuredButton1)
        
    }
    
    func featuredButton1Pressed(sender:UIButton) {
        
        if userNameFromFeatured == PFUser.currentUser()?.username {
            
            
            
        }
        else {
            
            NSUserDefaults.standardUserDefaults().setObject(userNameFromFeatured, forKey: "other_username")
            
            let data = imageFromFeatured
            PData = data
            
            NSUserDefaults.standardUserDefaults().setObject(PData, forKey: "other_userImage")
            
            profilePic.image = UIImage(data: PData)
            profilePicBlur.image = UIImage(data: PData)
            
            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
            self.showViewController(vc as! UIViewController, sender: vc)
            
        }
        
    }
    
    
    func addTop() {
        
        topView = UIView(frame: CGRectMake(0,featuredView.frame.origin.y + featuredView.frame.size.height,screenWidth,375))
        topView.userInteractionEnabled = true
        scrollView.addSubview(topView)
        
        topText = UILabel(frame: CGRectMake(0,10,screenWidth,50))
        topText.font = UIFont(name: "Didot", size: 22)
        topText.text = "TOP"
        if darkMode {topText.textColor = UIColor.lightGrayColor()}
        else {topText.textColor = UIColor.darkGrayColor()}
        topText.textAlignment = .Center
        topView.addSubview(topText)
        
        topWorldImage = UIImageView(frame: CGRectMake((screenWidth / 2) - (screenWidth/4)-25,100,50,50))
        if darkMode {topWorldImage.image = UIImage(named:"map158-2.png")}
        else{topWorldImage.image = UIImage(named:"map158.png")}
        topWorldImage.contentMode = .ScaleAspectFill
        topWorldImage.alpha = 0.7
        topView.addSubview(topWorldImage)
        
        let topWorldButton = UIButton(frame: CGRectMake(10,80,(screenWidth/2) - 20,120))
        topWorldButton.setTitle("World", forState: .Normal)
        topWorldButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        topWorldButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        topWorldButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        topWorldButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        topWorldButton.layer.cornerRadius = cornerRadius
        topWorldButton.clipsToBounds = true
        topWorldButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        topWorldButton.addTarget(self, action: "topWorldButtonPressed:", forControlEvents: .TouchUpInside)
        topView.addSubview(topWorldButton)
        
        topFriendsImage = UIImageView(frame: CGRectMake((screenWidth / 2) + (screenWidth/4)-25,100,50,50))
        if darkMode {topFriendsImage.image = UIImage(named:"group4.png")}
        else {topFriendsImage.image = UIImage(named:"group4-2.png")}
        topFriendsImage.contentMode = .ScaleAspectFill
        topFriendsImage.alpha = 0.7
        topView.addSubview(topFriendsImage)
        
        let topFriendsButton = UIButton(frame: CGRectMake((screenWidth / 2) + 10,80,(screenWidth/2) - 20,120))
        topFriendsButton.setTitle("Friends", forState: .Normal)
        topFriendsButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        topFriendsButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        topFriendsButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        topFriendsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        topFriendsButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        topFriendsButton.layer.cornerRadius = cornerRadius
        topFriendsButton.clipsToBounds = true
        topFriendsButton.addTarget(self, action: "topFriendsButtonPressed:", forControlEvents: .TouchUpInside)
        topView.addSubview(topFriendsButton)
        
        topNearbyImage = UIImageView(frame: CGRectMake((screenWidth / 2)-25,  210 + 30,50,50))
        if darkMode {topNearbyImage.image = UIImage(named:"map-pointer7-2.png")}
        else {topNearbyImage.image = UIImage(named:"map-pointer7.png")}
        topNearbyImage.contentMode = .ScaleAspectFill
        topNearbyImage.alpha = 0.7
        topView.addSubview(topNearbyImage)
        
        let topNearbyButton = UIButton(frame: CGRectMake((screenWidth/2) - ((screenWidth/2) - 20)/2,190 + 30,(screenWidth/2) - 20,120))
        topNearbyButton.setTitle("Nearby", forState: .Normal)
        topNearbyButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        topNearbyButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        topNearbyButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        topNearbyButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        topNearbyButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        topNearbyButton.layer.cornerRadius = cornerRadius
        topNearbyButton.clipsToBounds = true
        topNearbyButton.addTarget(self, action: "topNearbyButtonPressed:", forControlEvents: .TouchUpInside)
        topView.addSubview(topNearbyButton)
        
        let topSeperator = UILabel(frame: CGRectMake(0,topView.frame.size.height - 1,screenWidth,0.2))
        topSeperator.backgroundColor = UIColor.lightGrayColor()
        topView.addSubview(topSeperator)
        
    }
    
    
    func topWorldButtonPressed(sender:UIButton) {
        
        NSUserDefaults.standardUserDefaults().setObject("world", forKey: "leaderboard")
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderBoard")
        self.showViewController(vc as! UIViewController, sender: vc)
        
    }
    
    func topFriendsButtonPressed(sender:UIButton) {
        
        NSUserDefaults.standardUserDefaults().setObject("friends", forKey: "leaderboard")
        
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderBoard")
        self.showViewController(vc as! UIViewController, sender: vc)
        
    }
    
    
    func topNearbyButtonPressed(sender:UIButton) {
        
        NSUserDefaults.standardUserDefaults().setObject("nearby", forKey: "leaderboard")
        
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("LeaderBoard")
        self.showViewController(vc as! UIViewController, sender: vc)
        
    }
    
    func addContact() {
        
        contactView = UIView(frame: CGRectMake(0,topView.frame.origin.y + topView.frame.size.height,screenWidth,235))
        contactView.userInteractionEnabled = true
        scrollView.addSubview(contactView)
        
        contactText = UILabel(frame: CGRectMake(0,10,screenWidth,50))
        contactText.font = UIFont(name: "Didot", size: 22)
        contactText.text = "CONTACT US"
        if darkMode {contactText.textColor = UIColor.lightGrayColor()}
        else {contactText.textColor = UIColor.darkGrayColor()}
        contactText.textAlignment = .Center
        contactView.addSubview(contactText)
        
        
        let contactTwitterImage = UIImageView(frame: CGRectMake((screenWidth / 2) - (screenWidth/4)-25,100,50,50))
        contactTwitterImage.image = UIImage(named:"TwitterLogo_#55acee.png")
        contactTwitterImage.contentMode = .ScaleAspectFill
        contactTwitterImage.alpha = 1
        contactView.addSubview(contactTwitterImage)
        
        let contactTwitterButton = UIButton(frame: CGRectMake(10,80,(screenWidth/2) - 20,120))
        contactTwitterButton.setTitle("Twitter", forState: .Normal)
        contactTwitterButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        contactTwitterButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        contactTwitterButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        contactTwitterButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        contactTwitterButton.layer.cornerRadius = cornerRadius
        contactTwitterButton.clipsToBounds = true
        contactTwitterButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        contactTwitterButton.addTarget(self, action: "contactTwitterButtonPressed:", forControlEvents: .TouchUpInside)
        contactView.addSubview(contactTwitterButton)
        
        contactMailImage = UIImageView(frame: CGRectMake((screenWidth / 2) + (screenWidth/4)-25,100,50,50))
        if darkMode {contactMailImage.image = UIImage(named:"new100.png")}
        else {contactMailImage.image = UIImage(named:"new100-2.png")}
        contactMailImage.contentMode = .ScaleAspectFill
        contactMailImage.alpha = 0.7
        contactView.addSubview(contactMailImage)
        
        let contactMailButton = UIButton(frame: CGRectMake((screenWidth / 2) + 10,80,(screenWidth/2) - 20,120))
        contactMailButton.setTitle("Mail", forState: .Normal)
        contactMailButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        contactMailButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        contactMailButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        contactMailButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        contactMailButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        contactMailButton.layer.cornerRadius = cornerRadius
        contactMailButton.clipsToBounds = true
        contactMailButton.addTarget(self, action: "contactMailButtonPressed:", forControlEvents: .TouchUpInside)
        contactView.addSubview(contactMailButton)
        
        let contactSeperator = UILabel(frame: CGRectMake(0,contactView.frame.size.height - 1,screenWidth,0.2))
        contactSeperator.backgroundColor = UIColor.lightGrayColor()
        contactView.addSubview(contactSeperator)
        
        
    }
    
    
    
    func contactTwitterButtonPressed(sender:UIButton) {
        
        if let url = NSURL(string: "https://twitter.com/PanBerSoftware") {
            UIApplication.sharedApplication().openURL(url)
        }
        
    }
    
    func contactMailButtonPressed(sender:UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["panber@panber.com"])
            mail.setMessageBody("<p>I LOVE CHESS! :D</p>", isHTML: true)
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addCreatorAndLegal() {
        
        let creatorView = UIView(frame: CGRectMake(0,contactView.frame.origin.y + contactView.frame.size.height,screenWidth,100))
        creatorView.userInteractionEnabled = true
        scrollView.addSubview(creatorView)
        
        
        let creatorButton = UIButton(frame: CGRectMake(0,10,screenWidth,50))
        creatorButton.titleLabel!.font = UIFont(name: "Times", size: 14)
        creatorButton.setTitle("A PANBER SOFTWARE PRODUCTION ©2016", forState: .Normal)
        creatorButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        creatorButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        creatorButton.addTarget(self, action: "creatorButtonPressed:", forControlEvents: .TouchUpInside)
        creatorView.addSubview(creatorButton)
        
        let creatorLegalButton = UIButton(frame: CGRectMake(0,60,screenWidth,50))
        creatorLegalButton.titleLabel!.font = UIFont(name: "Times", size: 15)
        creatorLegalButton.setTitle("Legal", forState: .Normal)
        creatorLegalButton.setTitleColor(blue, forState: .Normal)
        creatorLegalButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        creatorLegalButton.addTarget(self, action: "creatorLegalButtonPressed:", forControlEvents: .TouchUpInside)
        creatorView.addSubview(creatorLegalButton)
        
        
        
    }
    
    func creatorLegalButtonPressed(sender:UIButton) {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Legal")
        self.showViewController(vc as! UIViewController, sender: vc)
        
    }
    
    
    func creatorButtonPressed(sender:UIButton) {
        
        
        let logo = UIImageView(frame: CGRectMake((screenWidth/2) - 75, (screenHeight/2) - 75, 150, 150))
        logo.contentMode = .ScaleAspectFill
        if darkMode {logo.image = UIImage(named: "PanberLogov9 copy2.png")}
        else {logo.image = UIImage(named: "PanberLogov9 copy.png")}
        visualEffectView.addSubview(logo)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            visualEffectView.alpha = 1
            visualEffectView.userInteractionEnabled = true
             
            
            }, completion: {finish in
                
                UIView.animateWithDuration(0.3, delay: 3, options: .CurveEaseInOut, animations: { () -> Void in
                    
                    visualEffectView.alpha = 0
                    
                    }, completion: { finish in
                        
                        visualEffectView.userInteractionEnabled = false
                        logo.removeFromSuperview()
                        
                })
                
        })
        
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos > 0 {
            
            
            
        }
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
        
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("username", matchesRegex:searchString, modifiers:"i")
        userQuery.whereKey("username", containedIn: userFriends)
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
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.searchDisplayController?.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        if darkMode {
            cell.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            cell.rating.textColor = UIColor.lightTextColor()
            cell.username.textColor =  UIColor.whiteColor()
            cell.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
            
        }
        else {
            
            cell.backgroundColor = UIColor.whiteColor()
            cell.rating.textColor = UIColor.darkGrayColor()
            cell.username.textColor =  UIColor.blackColor()
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        
        
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
                    profilePic.image = UIImage(data: imageData!)
                    profilePicBlur.image = UIImage(data: imageData!)
                    NSUserDefaults.standardUserDefaults().setObject(imageData!, forKey: "other_userImage")
                    tableView.deselectRowAtIndexPath(indexPath, animated: true)
                    print(indexPath.row)
                    PData = imageData!
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
        navigationController?.navigationBar.topItem?.title = "Explore"
self.title = "Explore"
        
        // This is to keep the rating of featured player up to date
        
        let featuredQuery = PFQuery(className: "_User")
        featuredQuery.orderByDescending("rating")
        featuredQuery.limit = 1
        featuredQuery.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, error:NSError?) -> Void in
            if error == nil{
                if let result = result as? [PFUser] {
                    for result in result {
                        
                        if let userPicture = result["profile_picture"] as? PFFile {
                            
                            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                if (error == nil) {
                                    
                                    self.featuredProfilePicView.image = UIImage(data: imageData!)
                                    PData = imageData!
                                    let r = result["rating"] as! Int
                                    featuredRating.text = "\(r)"
                                    featuredUsername.text = result["username"] as? String
                                    
                                    self.userNameFromFeatured = (result["username"] as? String)!
                                    self.ratingFromFeatured = result["rating"] as! Int
                                    self.imageFromFeatured = imageData!
                                    
                                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                                        self.featuredProfilePicView.alpha = 1
                                        featuredUsername.alpha = 1
                                        featuredRating.alpha = 1
                                        
                                    })
                                    
                                } else {
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    
    
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        checkInternetConnection()

        if darkMode == true {
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            
            self.view.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            
            self.scrollView.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
            
            
            
            featuredViewText.textColor = UIColor.lightGrayColor()
            featuredUsername.textColor = UIColor.whiteColor()
            featuredRating.textColor = UIColor.lightGrayColor()
            
            topText.textColor = UIColor.lightGrayColor()
            topWorldImage.image = UIImage(named:"map158-2.png")
            topFriendsImage.image = UIImage(named:"group4.png")
            topNearbyImage.image = UIImage(named:"map-pointer7-2.png")
            
            contactMailImage.image = UIImage(named:"new100.png")
            contactText.textColor = UIColor.lightGrayColor()
            
            searchBar.barTintColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            searchBar.tintColor = blue
            
            
            self.searchDisplayController?.searchResultsTableView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor.whiteColor()
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()
            
            
            self.searchDisplayController?.searchResultsTableView.backgroundColor = UIColor.whiteColor()
            
            self.scrollView.backgroundColor = UIColor.whiteColor()
            
            
            featuredViewText.textColor = UIColor.darkGrayColor()
            featuredUsername.textColor = UIColor.blackColor()
            featuredRating.textColor = UIColor.darkGrayColor()
            
            topText.textColor = UIColor.darkGrayColor()
            topWorldImage.image = UIImage(named:"map158.png")
            topFriendsImage.image = UIImage(named:"group4-2.png")
            topNearbyImage.image = UIImage(named:"map-pointer7.png")
            
            contactMailImage.image = UIImage(named:"new100-2.png")
            contactText.textColor = UIColor.darkGrayColor()
            
            searchBar.barStyle = UIBarStyle.Default
            
            searchBar.barTintColor = UIColor.whiteColor()
            searchBar.tintColor = blue
            
        }
        
    }
    
}