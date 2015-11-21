////
//////
//////  FriendRequests.swift
//////  Chess♔
//////
//////  Created by Johannes Berge on 01/10/15.
//////  Copyright © 2015 Panber. All rights reserved.
//////
////
////import UIKit
////import Parse
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
//                        self.userFriends = friends["friends"] as! NSMutableArray
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


/*   //func to set up people in top10WorldView
func addTop10World () {

blurBC1 = UIImageView(frame: CGRectMake(0, 0, screenWidth , (screenWidth )/(16/9)))
//  blurBC.image = UIImage(named: "JBpp.jpg")
//blurBC1.layer.cornerRadius = cornerRadius
blurBC1.contentMode = .ScaleAspectFill
//blurBC1.layer.borderColor = UIColor.lightGrayColor().CGColor
// blurBC1.layer.borderWidth = 0
blurBC1.userInteractionEnabled = true
blurBC1.clipsToBounds = true

//bluring bc of profile pic
var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
visualEffectView.frame = blurBC1.bounds
visualEffectView.frame.size.height += 1
blurBC1.addSubview(visualEffectView)

let whiteF = UILabel(frame: CGRectMake(0, 0, blurBC1.frame.size.width, blurBC1.frame.size.height * (1/3)))
whiteF.backgroundColor = UIColor.whiteColor()
//whiteF.alpha = 0.8
blurBC1.addSubview(whiteF)

let identifierLabel = UILabel(frame: CGRectMake(20, whiteF.frame.origin.y, blurBC1.frame.size.width - 20, whiteF.frame.size.height))
identifierLabel.font = UIFont(name: "Didot", size: 20)
identifierLabel.text = "Top 10 - World"
identifierLabel.textColor = UIColor.blackColor()
blurBC1.addSubview(identifierLabel)

let arrow = UIImageView(frame: CGRectMake(blurBC1.frame.size.width - 30, 0, 15, whiteF.frame.size.height))
arrow.image = UIImage(named: "arrow_black.png")
arrow.alpha = 0.3
arrow.contentMode = .ScaleAspectFit
blurBC1.addSubview(arrow)

let toTop10World = UIButton(frame: CGRectMake(0, 0, blurBC1.frame.size.width, blurBC1.frame.size.height / 3))
toTop10World.addTarget(self, action: "toTop10WorldPressed:", forControlEvents: .TouchUpInside)
toTop10World.backgroundColor = UIColor.clearColor()
blurBC1.addSubview(toTop10World)

let currentToLabel = UILabel(frame: CGRectMake(20, whiteF.frame.size.height + 10, blurBC1.frame.size.width - 20, 20))
currentToLabel.font = UIFont(name: "Didot-Italic", size: 15)
currentToLabel.text = "Current no.1"
currentToLabel.textColor = UIColor.grayColor()
blurBC1.addSubview(currentToLabel)

let profilePic = UIImageView(frame: CGRectMake(20, whiteF.frame.size.height + 10 + currentToLabel.frame.size.height + 5, 70, 70))
profilePic.layer.cornerRadius = profilePic.frame.size.width/2
profilePic.clipsToBounds = true
profilePic.layer.borderColor = UIColor.whiteColor().CGColor
profilePic.layer.borderWidth = 3
profilePic.contentMode = .ScaleAspectFill
blurBC1.addSubview(profilePic)

let usernameLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y, 200, 40))
usernameLabel.font = UIFont(name: "Didot-Bold", size: 30)
blurBC1.addSubview(usernameLabel)

let ratingLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y + usernameLabel.frame.size.height, 200, 30))
ratingLabel.font = UIFont(name: "Didot-Italic", size: 15)
ratingLabel.textColor = UIColor.grayColor()
blurBC1.addSubview(ratingLabel)

let seperator = UILabel(frame: CGRectMake(0,blurBC1.frame.size.height - 0.5,screenWidth,0.5))
seperator.backgroundColor = UIColor.lightGrayColor()
blurBC1.addSubview(seperator)


let toTop10WorldUser = UIButton(frame: CGRectMake(0, blurBC1.frame.size.height/3, blurBC1.frame.size.width, blurBC1.frame.size.height * (2/3)))
toTop10WorldUser.addTarget(self, action: "toTop10WorldUserPressed:", forControlEvents: .TouchUpInside)
toTop10WorldUser.backgroundColor = UIColor.clearColor()
blurBC1.addSubview(toTop10WorldUser)

var GlobalUserInitiatedQueue: dispatch_queue_t {
return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
}
var GlobalBackgroundQueue: dispatch_queue_t {
return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
}
var GlobalMainQueue: dispatch_queue_t {
return dispatch_get_main_queue()
}


let ratingQuery = PFQuery(className: "_User")
ratingQuery.orderByDescending("rating")
ratingQuery.limit = 10
ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
if error == nil {
self.top10WorldArrayUsers = []
self.top10WorldArrayRating = []
self.top10WorldArrayImage = []

if let usersObject = usersObject as! [PFObject]! {
for usersObject in usersObject {


self.top10WorldArrayRating.append(usersObject["rating"] as! Int)
//print(self.top10WorldArrayRating)
self.top10WorldArrayUsers.append(usersObject["username"] as! String)
//print(self.top10WorldArrayUsers)
usernameLabel.text = self.top10WorldArrayUsers.first
ratingLabel.text = "\(self.top10WorldArrayRating.first!)"



}
}
//image

let query = PFQuery(className: "_User")


query.whereKey("username", equalTo: self.top10WorldArrayUsers.first!)
query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
if (error == nil) {

if let userArray = objects as? [PFUser] {
for user in userArray {
if let userPicture = user["profile_picture"] as? PFFile {

userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
if (error == nil) {

let image = UIImage(data: imageData!)!
profilePic.image = image
self.blurBC1.image = image
self.top10WorldUserImage = imageData!

visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
visualEffectView.frame = self.blurBC1.bounds

self.blurBC1.alpha = 0
self.scrollView.addSubview(self.blurBC1)
self.blurBC1.alpha = 1


} else {
}
}

}
}

}
} else {
// Log details of the failure
print("query error: \(error) \(error!.userInfo)")
}

}



}

})



}

func addTop10Friends () {

blurBC2 = UIImageView(frame: CGRectMake(0,  blurBC1.frame.size.height, screenWidth, (screenWidth)/(16/9)))
blurBC2.contentMode = .ScaleAspectFill
blurBC2.userInteractionEnabled = true
blurBC2.clipsToBounds = true

//bluring bc of profile pic
var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
visualEffectView.frame = blurBC2.bounds
visualEffectView.frame.size.height += 1
blurBC2.addSubview(visualEffectView)

let whiteF = UILabel(frame: CGRectMake(0, 0, blurBC2.frame.size.width, blurBC2.frame.size.height * (1/3)))
whiteF.backgroundColor = UIColor.whiteColor()
//whiteF.alpha = 0.8
blurBC2.addSubview(whiteF)

let identifierLabel = UILabel(frame: CGRectMake(20, whiteF.frame.origin.y, blurBC2.frame.size.width - 20, whiteF.frame.size.height))
identifierLabel.font = UIFont(name: "Didot", size: 20)
identifierLabel.text = "Top 10 - Friends"
identifierLabel.textColor = UIColor.blackColor()
blurBC2.addSubview(identifierLabel)

let arrow = UIImageView(frame: CGRectMake(blurBC2.frame.size.width - 30, 0, 15, whiteF.frame.size.height))
arrow.image = UIImage(named: "arrow_black.png")
arrow.alpha = 0.3
arrow.contentMode = .ScaleAspectFit
blurBC2.addSubview(arrow)

let toTop10Friends = UIButton(frame: CGRectMake(0, 0, blurBC2.frame.size.width, blurBC2.frame.size.height / 3))
toTop10Friends.addTarget(self, action: "toTop10FriendsPressed:", forControlEvents: .TouchUpInside)
toTop10Friends.backgroundColor = UIColor.clearColor()
blurBC2.addSubview(toTop10Friends)

let currentToLabel = UILabel(frame: CGRectMake(20, whiteF.frame.size.height + 10, blurBC2.frame.size.width - 20, 20))
currentToLabel.font = UIFont(name: "Didot-Italic", size: 15)
currentToLabel.text = "Current no.1"
currentToLabel.textColor = UIColor.grayColor()
blurBC2.addSubview(currentToLabel)

let profilePic = UIImageView(frame: CGRectMake(20, whiteF.frame.size.height + 10 + currentToLabel.frame.size.height + 5, 70, 70))
profilePic.layer.cornerRadius = profilePic.frame.size.width/2
profilePic.clipsToBounds = true
profilePic.layer.borderColor = UIColor.whiteColor().CGColor
profilePic.layer.borderWidth = 3
profilePic.contentMode = .ScaleAspectFill
blurBC2.addSubview(profilePic)

let usernameLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y, 200, 40))
usernameLabel.font = UIFont(name: "Didot-Bold", size: 30)
blurBC2.addSubview(usernameLabel)

let ratingLabel = UILabel(frame: CGRectMake(profilePic.frame.origin.x + profilePic.frame.size.width + 20, profilePic.frame.origin.y + usernameLabel.frame.size.height, 200, 30))
ratingLabel.font = UIFont(name: "Didot-Italic", size: 15)
ratingLabel.textColor = UIColor.grayColor()
blurBC2.addSubview(ratingLabel)

let toTop10FriendsUser = UIButton(frame: CGRectMake(0, blurBC2.frame.size.height/3, blurBC2.frame.size.width, blurBC2.frame.size.height * (2/3)))
toTop10FriendsUser.addTarget(self, action: "toTop10FriendsUserPressed:", forControlEvents: .TouchUpInside)
toTop10FriendsUser.backgroundColor = UIColor.clearColor()
blurBC2.addSubview(toTop10FriendsUser)

let seperator = UILabel(frame: CGRectMake(0,blurBC2.frame.size.height - 0.5,screenWidth,0.5))
seperator.backgroundColor = UIColor.lightGrayColor()
blurBC2.addSubview(seperator)


//    for var i = 0; i < friendsArray.count; i++ {


let ratingQuery = PFQuery(className: "_User")
ratingQuery.whereKey("username", containedIn: friendsArray)
ratingQuery.orderByDescending("rating")
ratingQuery.limit = 10
ratingQuery.findObjectsInBackgroundWithBlock({ (usersObject:[AnyObject]?, error:NSError?) -> Void in
if error == nil {

if let usersObject = usersObject as! [PFObject]! {
for usersObject in usersObject {
self.top10FriendsArrayRating.append(usersObject["rating"] as! Int)
print(self.top10FriendsArrayRating)
self.top10FriendsArrayUsers.append(usersObject["username"] as! String)
print(self.top10FriendsArrayUsers)

}
}
if self.top10FriendsArrayUsers.count > 0 {

usernameLabel.text = self.top10FriendsArrayUsers[0]
ratingLabel.text = "\(self.top10FriendsArrayRating[0])"


//image

let query = PFQuery(className: "_User")


query.whereKey("username", equalTo: self.top10FriendsArrayUsers.first!)
query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
if (error == nil) {

if let userArray = objects as? [PFUser] {
for user in userArray {
if let userPicture = user["profile_picture"] as? PFFile {

userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
if (error == nil) {

let image = UIImage(data: imageData!)!
profilePic.image = image
self.blurBC2.image = image
self.top10FriendsUserImage = imageData!
visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
visualEffectView.frame = self.blurBC2.bounds
self.blurBC2.alpha = 0
self.scrollView.addSubview(self.blurBC2)
self.blurBC2.alpha = 1


} else {
}
}

}
}

}
} else {
// Log details of the failure
print("query error: \(error) \(error!.userInfo)")
}

}

}

}

})
//}



}
*/
