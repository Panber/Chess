//
//  FriendRequestsPage.swift
//  Chess♔
//
//  Created by Johannes Berge on 07/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var frequests = PFObject(className: "FriendRequest")


class FriendRequestsPage: UIViewController, UITableViewDelegate, UIScrollViewDelegate {

    var userss:NSMutableArray = NSMutableArray()
    var i = 0

    var scrollView = UIScrollView()
    var scrollViewView = UIView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        scrollView.userInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        scrollView.scrollEnabled = true
        view.addSubview(scrollView)
        
        scrollViewView = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight + 200))
       // scrollView.addSubview(scrollViewView)
        
        
        
        
    }
    
    
    func loadRequestToView( t:CGFloat, _name:String) {
        
        //create bc
        let bcLabel = UILabel(frame: CGRectMake(0, 0 + (70 * t), screenWidth, 70))
        bcLabel.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(bcLabel)
        
        //create seperator
        let seperator = UILabel(frame: CGRectMake(0, 0 + (70 * t), screenWidth, 0.5))
        seperator.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(seperator)
        
        //create namelabel
        let name = UILabel(frame: CGRectMake(30, bcLabel.frame.size.height / 2 + (t*70), 200, 40))
        name.font = UIFont(name: "Didot", size: 20)
        name.textAlignment = .Left
        name.text = _name
        scrollView.addSubview(name)
    
        
        let profilePic = UIImageView(frame: CGRectMake(10, 10 + (70 * t), 50, 50))
        
        
    }
    

    
    
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
        
        let frequestsQuery = PFQuery(className: "FriendRequest")
        
        if let user = PFUser.currentUser()?.username {
            frequestsQuery.whereKey("toUserr", equalTo: (user))
            frequestsQuery.orderByDescending("updatedAt")
            frequestsQuery.whereKey("status", equalTo: "pending")
            
            frequestsQuery.findObjectsInBackgroundWithBlock({ (frequests:[AnyObject]?, error:NSError?) -> Void in
                
                for frequests in frequests! {
                    self.i++
                    self.loadRequestToView(CGFloat(self.i), _name: frequests["fromUser"] as! String)
                }
                
            })
        }
        
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
