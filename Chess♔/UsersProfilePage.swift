//
//  UsersProfilePage.swift
//  Chess♔
//
//  Created by Alexander Panayotov on 04/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse


class UsersProfilePage: UITableViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Blur picture
        //        var blur = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        //        var blurView = UIVisualEffectView(effect: blur)
        //        blurredProfilePicture.addSubview(blurView)
        
        //Confugure profile picture
        self.profilePicture.layer.cornerRadius = (self.profilePicture.frame.size.width / 2)
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.borderWidth = 2
        self.profilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        
        var usernameOutlet = NSUserDefaults.standardUserDefaults().objectForKey("user_pressed") as! NSData
        
        self.profilePicture.image = UIImage(data: usernameOutlet)
        
    }
    
    
    
}