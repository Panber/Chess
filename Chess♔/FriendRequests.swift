
//
//  FriendRequests.swift
//  Chess♔
//
//  Created by Johannes Berge on 01/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var userFriends = [""]
var request = PFObject(className: "FriendRequest")
var friends = PFObject(className: "Friends")



class FriendRequests: UIViewController {

    @IBOutlet weak var userInputTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        
        let requestQuery = PFQuery(className:"FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery.whereKey("toUser", equalTo: user)
            
            print("success!!")
        }
        let friendsQuery = PFQuery(className: "Friends")
        if let user = PFUser.currentUser() {
            friendsQuery.whereKey("user", equalTo: user)
          //  userFriends = (friends["friends"] as? Array)!
//            var r = friends["friends"]
//            userFriends = Array(arrayLiteral: r)
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
        
        request["fromUser"] = String(PFUser.currentUser())
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
        
        friends["user"] = PFUser.currentUser()
        userFriends.append(String(request["fromUser"]))
        friends["friends"] = userFriends
        
        friends.saveInBackground()
        print("the usernam is")
        print(userFriends[1])
        
        //
//        //the buttons tag stores the indexPath.row of the array
//        let friendRequest: PFObject = self.friendRequestsToCurrentUser[sender.tag] as PFObject
//        
//        let fromUser: PFUser = friendRequest[FriendRequestKeyFrom] as PFUser
//        
//        //call the cloud code function that adds the current user to the user who sent the request and pass in the friendRequest id as a parameter
//        PFCloud.callFunctionInBackground("addFriendToFriendsRelation", withParameters: ["friendRequest": friendRequest.objectId]) { (object:AnyObject!, error: NSError!) -> Void in
//            
//            //add the person who sent the request as a friend of the current user
//            let friendsRelation: PFRelation = self.currentUser.relationForKey(UserKeyFriends)
//            friendsRelation.addObject(fromUser)
//            self.currentUser.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError!) -> Void in
//                
//                if succeeded {
//                    
//                    
//                    
//                } else {
//                    
//                    Utilities.handleError(error)
//                }
//            })
//        }
        
    }
    

}
