//
//  FriendsMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class FriendsMenu: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // Array for users that are being searched for
    var users = NSMutableArray()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // make tab-bar and navigation bar black
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent
        
    }

    // Func that searches for user with key and stores it in an array
    func searchUsers(search_lower: String) {
        
        var query: PFQuery = PFQuery(className:"_User")
        
        query.whereKey("username", containsString: search_lower)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        // Declare user object and set cell text to username
        var user: PFUser = users[indexPath.row] as! PFUser
        cell.textLabel?.text = user["username"] as! String
        
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            self.searchUsers(searchText)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // When button tapped seachbar appears
    @IBAction func startSearch(sender: AnyObject) {
//        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
//            self.searchBar.frame = CGRectMake(0.0, 64, self.searchBar.frame.width, self.searchBar.frame.height)
//        }, completion: nil)
        
    }
    

}
