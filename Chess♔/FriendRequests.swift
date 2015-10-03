//
//  FriendRequests.swift
//  Chess♔
//
//  Created by Johannes Berge on 01/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class FriendRequests: UIViewController {

    @IBOutlet weak var userInputTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        
        let requestQuery = PFQuery(className:"FriendRequest")
        if let user = PFUser.currentUser() {
            requestQuery.whereKey("toUser", equalTo: user)
            
            print("success!!")
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
        
        let request = PFObject(className: "FriendRequest")
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
