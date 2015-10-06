//
////
////  FriendRequests.swift
////  Chess♔
////
////  Created by Johannes Berge on 01/10/15.
////  Copyright © 2015 Panber. All rights reserved.
////
//
//import UIKit
//import Parse
//
//var request = PFObject(className: "FriendRequest")
//var friends = PFObject(className: "Friends")
//var usersFrom = String()
//
//
//class FriendRequests: UIViewController {
//    
//    var userFriends = NSMutableArray()
//
//    @IBOutlet weak var userInputTextField: UITextField!
//    
//    override func viewWillAppear(animated: Bool) {
//        
//
//        let loadFriendsQuery = PFQuery(className: "Friends")
//        if let user = PFUser.currentUser() {
//            loadFriendsQuery.whereKey("user", equalTo: user)
//            loadFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error:NSError?) -> Void in
//                if let friends = friends  as? [PFObject]{
//                    for friends in friends {
//                    self.userFriends = friends["friends"] as! NSMutableArray
//                        print("user friends is \(self.userFriends)")
//                    }
//                }
//            })
//        }
//        
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //send request to user
//    @IBAction func sendButton(sender: AnyObject) {
//        
//        request["fromUser"] = PFUser.currentUser()?.username
//        request["toUserr"] = userInputTextField.text
//        request["status"] = "pending"
//        
//        let toUserQuery = PFQuery(className: "FriendRequest")
//        toUserQuery.findObjectsInBackgroundWithBlock { (request:[AnyObject]?, error:NSError?) -> Void in
//            
//        }
//        
//        request.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
//            if success {
//                print("request was saved in background")
//            }
//            else {}
//        }
//        view.endEditing(true)
//    }
//
//    
//    //accept request given
//    @IBAction func handleAcceptButtonPressed(sender: AnyObject) {
//        
//        let requestQuery = PFQuery(className:"FriendRequest")
//        if let user = PFUser.currentUser() {
//            requestQuery.whereKey("toUserr", equalTo: user.username!)
//            requestQuery.findObjectsInBackgroundWithBlock({ (toUser:[AnyObject]?, error:NSError?) -> Void in
//                
//                if error == nil {
//                    
//                    
//                    for request in toUser! {
//                        
//                        self.userFriends.addObject(request["fromUser"] as! String)
//                        print(self.userFriends)
//                        print("accepeted")
//                    }
//                }
//            })
//        }
//        
//        let requestQuery2 = PFQuery(className: "FriendRequest")
//        if let user = PFUser.currentUser() {
//            requestQuery2.whereKey("toUserr", equalTo: user.username!)
//            requestQuery2.findObjectsInBackgroundWithBlock({ (request:[AnyObject]?, error:NSError?) -> Void in
//                
//                if error == nil {
//                    
//                    
//                    for request in request! {
//                        usersFrom = request["fromUser"] as! String
//                        
//                        request.deleteEventually()
//                    }
//                    
//                    let userFriendsQuery = PFQuery(className: "Friends")
//                    userFriendsQuery.whereKey("username", equalTo: usersFrom)
//                    userFriendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
//                        
//                        if error == nil {
//                            if let friends = friends as? [PFObject]{
//                                for friends in friends {
//                                    
//                                    friends["friends"]?.addObject((PFUser.currentUser()?.username)!)
//                                    let r = friends["friends"]
//                                    print("his friends are \(r)")
//                                    friends.saveInBackground()
//                                    usersFrom = ""
//                                }
//                            }
//                        }
//                        else {
//                            print("annerror accured")
//                        }
//                    })
//                }
//            })
//        }
//        
//        let friendsQuery = PFQuery(className: "Friends")
//        if let user = PFUser.currentUser() {
//            friendsQuery.whereKey("user", equalTo: user)
//            friendsQuery.findObjectsInBackgroundWithBlock({ (friends: [AnyObject]?, error: NSError?) -> Void in
//
//                if error == nil {
//                    if let friends = friends as? [PFObject]{
//                        for friends in friends {
//                            
//                            friends["friends"] = self.userFriends
//                            friends.saveInBackground()
//                        }
//                    }
//                }
//                else {
//                    print("annerror accured")
//                }
//            })
//        }
//
//    }
//}
