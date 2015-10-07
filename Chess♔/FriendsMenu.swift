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


class FriendsMenu: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    
    // Array for users that are being searched for
    var users:NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var top10World: UIScrollView!
    @IBOutlet weak var top10Friends: UIScrollView!
    @IBOutlet weak var grossing: UIScrollView!
    @IBOutlet weak var top10WorldView: UIView!
    
    @IBOutlet weak var searchText: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var top10WorldArrayRating = [String]()
    var top10WorldArrayUsers:Array<String> = []
    
    override func viewWillDisappear(animated: Bool) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        top10World.scrollEnabled = true
        top10World.contentSize = CGSizeMake(796, 105)
        top10World.showsHorizontalScrollIndicator = false
        top10World.bounces = false
        
        top10Friends.scrollEnabled = true
        top10Friends.contentSize = CGSizeMake(796, 105)
        top10Friends.showsHorizontalScrollIndicator = false
        top10Friends.bounces = false
        
        grossing.scrollEnabled = true
        grossing.contentSize = CGSizeMake(796, 105)
        grossing.showsHorizontalScrollIndicator = false
        grossing.bounces = false
        
        addTop10World()
        
    }

    
    
    //func to set up people in top10WorldView
    func addTop10World () {
        
        var image = UIImage()
        
        let ratingQuery = PFQuery(className: "_User")
        ratingQuery.orderByDescending("rating")
        ratingQuery.limit = 10 
        ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                for usersObject in usersObject! {
                    self.top10WorldArrayRating.append(usersObject["rating"] as! String)
                    print(self.top10WorldArrayRating)
                    self.top10WorldArrayUsers.append(usersObject["username"] as! String)
                    print(self.top10WorldArrayUsers)
                }
                var t = 0
                for var i:CGFloat = 0; i < 5; i++, t++ {
                    
                    let personView = UIView(frame: CGRectMake(5 + (self.top10WorldView.frame.size.height) * i, 5, self.top10WorldView.frame.size.height - 10, self.top10WorldView.frame.size.height - 10))
                    personView.layer.cornerRadius = cornerRadius
                    personView.backgroundColor = UIColor.whiteColor()
                    personView.layer.borderWidth = 0.5
                    personView.layer.borderColor = UIColor.lightGrayColor().CGColor
                    personView.clipsToBounds = true
                    self.top10WorldView.addSubview(personView)
                    
                    
                    
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
                
            }
            else {
                
            }
        })
        
    
    }
    
    // Func that searches for user with key and stores it in an array
    func searchUsers() {
        
        var query: PFQuery = PFQuery(className:"_User")
        query.whereKey("username", matchesRegex:searchText.text!, modifiers:"i")
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if objects?.count != 0 {
                self.users.removeAllObjects() // <- I'm not sure where to put this yet
                }
         //       self.tableView.reloadData()
                print(objects?.count)
                for object in objects! {
                    if objects?.count != 0 {
                    self.users.addObject(object)
                        
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                    })
                print(self.users.count)
            }
        }
        
        
        
        //        query.whereKey("username", matchesRegex:searchText.text!, modifiers:"i")
        //        query.orderByAscending("username")
        //        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
        //            if error == nil {
        //                self.users.removeAllObjects()
        //                self.users.addObjectsFromArray(objects!)
        //                self.tableView.reloadData()
        //                //print(search_string)
        //            }
        //            else {
        //                print("error")
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
        
        return users.count
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
        searchUsers()
        }
        if searchText.characters.count == 0 {
            self.users.removeAllObjects()
        }
        tableView.hidden = false
    }
    
//    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//       
//    }
//    
    
    
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell
        
        // Declare user object and set cell text to username
        let users:PFObject = self.users.objectAtIndex(indexPath.row) as! PFObject
        
        var findUserName: PFQuery = PFQuery(className:"_User")
        findUserName.whereKey("username", containsString: searchText.text)
        
        findUserName.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
            if (error == nil) {
                if let user:PFUser = users as? PFUser {
                    cell.username.text = user.username
                    
                    if let profileImage:PFFile = user["profile_picture"] as? PFFile {
                        profileImage.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                            
                            if error == nil {
                                let image:UIImage = UIImage(data: imageData!)!
                                cell.userProfileImage.image = image as! UIImage
                                
                               // tableView.reloadInputViews()
                            }
                            
                        }
                    }
                    
                }
            }
        }
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
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("OtherProfile")
                    self.showViewController(vc as! UIViewController, sender: vc)
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
    
    //    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
    //
    //        self.searchUsers((self.searchDisplayController?.searchBar.text)!)
    //
    //        return true
    //    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        tableView.hidden = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
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