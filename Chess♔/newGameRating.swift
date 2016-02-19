//
//  NewGameRating.swift
//  Chess♔
//
//  Created by Alexander Panayotov on 18/02/16.
//  Copyright © 2016 Panber. All rights reserved.
//

import UIKit
import Parse

class NewGameRating: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var ratingArray: Array<Int> = []
    
    var profilePicArray: Array<UIImage> = []
    
    var imageDataArray: Array<NSData> = []
    
    // Array for users that are being searched for
    var users:NSMutableArray = []
    
    var usersArray: Array<String> = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.topItem?.title = "Rating"
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
        
        profilePicArray = []
        
        imageDataArray = []
        
        usersArray = []
        users = []
        if searchBar.text!.characters.count > 0 {
        searchUsers( Int(searchBar.text!)!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if users.count == 0 {
            self.searchDisplayController?.searchResultsTableView.rowHeight = 70
        }
        return users.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:NewGameRatingTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("newGameRatingCell") as! NewGameRatingTableViewCell
        
        
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
        ratingArray.append(user["rating"] as! Int)
        cell.username.text = user["username"] as? String
        usersArray .append((user["username"] as? String)!)
        
        let profilePictureObject = user["profile_picture"] as? PFFile
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    cell.userProfileImage.image = UIImage(data: imageData!)
                    self.imageDataArray.append(imageData!)
                }
                
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        NSUserDefaults.standardUserDefaults().setObject(usersArray[indexPath.row], forKey: "other_username_from_friends_gamemenu")
        
        let p = imageDataArray[indexPath.row]
        NSUserDefaults.standardUserDefaults().setObject(p, forKey: "other_userImage_from_friends_gamemenu")
        
        NSUserDefaults.standardUserDefaults().setObject(ratingArray[indexPath.row], forKey: "other_userrating_from_friends_gamemenu")
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            searchUsers(Int(searchText)!)
        }
        print("textDidChange")
    }
    
    // Func that searches for user with key and stores it in an array
    func searchUsers(searchString: Int) {

        let query: PFQuery = PFQuery(className:"_User")
        query.whereKey("rating", equalTo: searchString)
//        query.whereKey("username", notEqualTo: (PFUser.currentUser()?.username)!)
        query.orderByAscending("rating")
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
    
    // MARK: - Search
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        
        tableView.hidden = false
        return true
    }
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        if darkMode == true {
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            
            self.view.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            
            searchBar.barTintColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            searchBar.tintColor = UIColor.whiteColor()
            
            
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
            
            searchBar.barStyle = UIBarStyle.Default
            
            searchBar.barTintColor = UIColor.whiteColor()
            searchBar.tintColor = blue
            
        }
        
    }
    
    
}
