//
//  FriendsMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class FriendsMenu: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    
    // Array for users that are being searched for
    var users = NSMutableArray()
    
    @IBOutlet weak var top10World: UIScrollView!
    @IBOutlet weak var top10Friends: UIScrollView!
    @IBOutlet weak var grossing: UIScrollView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
        
    }
    
    // Func that searches for user with key and stores it in an array
    func searchUsers(search_string: String) {
        
        var query: PFQuery = PFQuery(className:"_User")
        
        query.whereKey("username", matchesRegex:search_string, modifiers:"i")
        query.orderByAscending("username")
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.users.removeAllObjects()
                self.users.addObjectsFromArray(objects!)
                //self.tableView.reloadData()
            }
            else {
                print("error")
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
        
        return users.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell
        
        // Declare user object and set cell text to username
        let user:PFUser = users[indexPath.row] as! PFUser
        cell.username.text = user["username"] as? String

        
//        var userRating = user["ratingg"] as? String
//        NSUserDefaults.standardUserDefaults().setObject(userRating, forKey: "other_userRating")
        
        let profilePictureObject = user["profile_picture"] as? PFFile
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    cell.userProfileImage.image = UIImage(data: imageData!)
                   // NSUserDefaults.standardUserDefaults().setObject(imageData!, forKey: "other_userImage")
                   // NSUserDefaults.standardUserDefaults().synchronize()
                    print(cell.userProfileImage.image)
                }
                
            }
        }
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            searchUsers(searchText)
        }
        tableView.hidden = false
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
            self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
            self.navigationController?.navigationBar.tintColor = UIColor.blueColor()

            
        }

    }
    
}
