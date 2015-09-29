//
//  FriendsMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class FriendsMenu: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    // Array for users that are being searched for
    var users = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    // Func that searches for user with key and stores it in an array
    func searchUsers(search_string: String) {
        
        var query: PFQuery = PFQuery(className:"_User")
        
        query.whereKey("username", containsString: search_string)
        query.orderByAscending("username")
        query.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.users.removeAllObjects()
                self.users.addObjectsFromArray(objects!)
                self.tableView.reloadData()
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UserTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UserTableViewCell
        
        var user:PFUser = users[indexPath.row] as! PFUser
        
        cell.username.text = user["username"] as! String
        
        let profilePictureObject = user.objectForKey("profile_picture") as! PFFile
        
       
            profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    cell.userProfileImage.image = UIImage(data: imageData!)
                }
                
            }

        
        return cell
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            searchUsers(searchText)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Search
    
//    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
//        
//        
//        return true
//    }
    
//    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
//        
//        self.searchUsers((self.searchDisplayController?.searchBar.text)!)
//        
//        return true
//    }
    
    
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
