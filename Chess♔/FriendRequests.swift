
//
//  FriendRequests.swift
//  Chess♔
//
//  Created by Johannes Berge on 01/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var request = PFObject(className: "FriendRequest")
var friends = PFObject(className: "Friends")
var userToAdd = "1"


class FriendRequests: UIViewController {
    
    var userFriends = NSMutableArray()

    @IBOutlet weak var userInputTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        
        let loadFriendsQuery = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            loadFriendsQuery.whereKey("user", equalTo: user)
            loadFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error:NSError?) -> Void in
                if let friends = friends  as? [PFObject]{
                    for friends in friends {
                    self.userFriends = friends["friends"] as! NSMutableArray
                        print("user friends is \(self.userFriends)")
                    }
                }
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButton(sender: AnyObject) {
        
        request["fromUser"] = PFUser.currentUser()
        request["toUser"] = userInputTextField.text
        request["status"] = "pending"
        
        request.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                print("request was saved in background")
            }
            else {}
        }
        
        view.endEditing(true)
        
    }

    @IBAction func handleAcceptButtonPressed(sender: AnyObject) {
        
        let requestQuery = PFQuery(className:"FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery.whereKey("fromUser", equalTo: userToAdd)
            requestQuery.findObjectsInBackgroundWithBlock({ (toUser:[AnyObject]?, error:NSError?) -> Void in
                
                if error == nil {
                    for request in toUser! {
                        
                        self.userFriends.addObject(request["fromUser"] as! String)
                        print(self.userFriends)
                    }
                }
            })
        }
        
        let friendsQuery = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery.whereKey("user", equalTo: user)
            friendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in

                if error == nil {
                    if let friends = friends as? [PFObject]{
                        for friends in friends {
                            
                            friends["friends"] = self.userFriends
                            friends.saveInBackground()
                        }
                    }
                }
                else {
                    print("annerror accured")
                }
            })
        }
    }
}
