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

    
    var featuredView = UIView()
    
    
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
        
        addFeatured()
        addTop()
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
    
    
    
    
    
    func addFeatured() {
    
    
        featuredView = UIView(frame: CGRectMake(0,0,screenWidth , 200))
        featuredView.userInteractionEnabled = true
        scrollView.addSubview(featuredView)
    
        let featuredViewText = UILabel(frame: CGRectMake(0,10,screenWidth,50))
        featuredViewText.font = UIFont(name: "Didot", size: 25)
        featuredViewText.text = "FEATURED"
        featuredViewText.textColor = UIColor.darkGrayColor()
        featuredViewText.textAlignment = .Center
        scrollView.backgroundColor = UIColor.whiteColor()
        featuredView.addSubview(featuredViewText)
        
        let featuredProfilePicView = UIImageView(frame: CGRectMake(screenWidth/2 - 90, 85, 65, 65))
        featuredProfilePicView.layer.cornerRadius = featuredProfilePicView.frame.size.width/2
        featuredProfilePicView.clipsToBounds = true
        featuredProfilePicView.alpha = 0
        featuredProfilePicView.contentMode = .ScaleAspectFill
        featuredView.addSubview(featuredProfilePicView)
        
        let featuredUsername = UILabel(frame: CGRectMake(featuredProfilePicView.frame.origin.x + featuredProfilePicView.frame.size.width + 25,featuredProfilePicView.frame.origin.y + 16,screenWidth - (featuredProfilePicView.frame.origin.x + featuredProfilePicView.frame.size.width + 25),21))
        featuredUsername.font = UIFont(name: "Didot", size: 22)
        featuredUsername.text = "mufcjb"
        featuredUsername.textAlignment = .Left
        featuredUsername.alpha = 0
        featuredView.addSubview(featuredUsername)
        
        let featuredRating = UILabel(frame: CGRectMake(featuredUsername.frame.origin.x,featuredUsername.frame.origin.y + featuredUsername.frame.size.height,screenWidth - (featuredProfilePicView.frame.origin.x + featuredProfilePicView.frame.size.width + 25),21))
        featuredRating.font = UIFont(name: "Didot-Italic", size: 15)
        featuredRating.textColor = UIColor.darkGrayColor()
        featuredRating.alpha = 0
        featuredView.addSubview(featuredRating)
        
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
                                    
                                    featuredProfilePicView.image = UIImage(data: imageData!)
                                    let r = result["rating"] as! Int
                                    featuredRating.text = "\(r)"
                                    featuredUsername.text = result["username"] as? String
                                    
                                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                                        featuredProfilePicView.alpha = 1
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
    
    
    func addTop() {
    
        let topView = UIView(frame: CGRectMake(0,featuredView.frame.origin.y + featuredView.frame.size.height,screenWidth,400))
        topView.userInteractionEnabled = true
        scrollView.addSubview(topView)
        
        let topText = UILabel(frame: CGRectMake(0,10,screenWidth,50))
        topText.font = UIFont(name: "Didot", size: 22)
        topText.text = "Top"
        topText.textColor = UIColor.darkGrayColor()
        topText.textAlignment = .Center
        topView.addSubview(topText)
        
        let topWorldImage = UIImageView(frame: CGRectMake((screenWidth / 2) - (screenWidth/4)-25,100,50,50))
        topWorldImage.image = UIImage(named:"map158.png")
        topWorldImage.contentMode = .ScaleAspectFill
        topWorldImage.alpha = 0.7
        topView.addSubview(topWorldImage)
        
        let topWorldButton = UIButton(frame: CGRectMake(10,80,(screenWidth/2) - 20,120))
        topWorldButton.setTitle("WORLD", forState: .Normal)
        topWorldButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        topWorldButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        topWorldButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        topWorldButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        topWorldButton.layer.cornerRadius = cornerRadius
        topWorldButton.clipsToBounds = true
        topWorldButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
       // topWorldButton.addTarget(self, action: "topWorldButtonPressed:", forControlEvents: .TouchUpInside)
        topView.addSubview(topWorldButton)
        
        let topFriendsImage = UIImageView(frame: CGRectMake((screenWidth / 2) + (screenWidth/4)-25,100,50,50))
        topFriendsImage.image = UIImage(named:"group4-2.png")
        topFriendsImage.contentMode = .ScaleAspectFill
        topFriendsImage.alpha = 0.7
        topView.addSubview(topFriendsImage)
        
        let topFriendsButton = UIButton(frame: CGRectMake((screenWidth / 2) + 10,80,(screenWidth/2) - 20,120))
        topFriendsButton.setTitle("FRIENDS", forState: .Normal)
        topFriendsButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        topFriendsButton.titleLabel?.font = UIFont(name: "Didot", size: 16)
        topFriendsButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        topFriendsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        topFriendsButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        topFriendsButton.layer.cornerRadius = cornerRadius
        topFriendsButton.clipsToBounds = true
      //  topFriendsButton.addTarget(self, action: "randomButtonPressed:", forControlEvents: .TouchUpInside)
        topView.addSubview(topFriendsButton)
        
        
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
     //       self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.view.backgroundColor = UIColor.whiteColor()
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            
        }
        
    }
    
}