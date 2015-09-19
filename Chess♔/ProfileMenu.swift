//
//  SettingsMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class ProfileMenu: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Enable user to scroll up and down
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(screenSize.width, 565)
        scrollView.showsVerticalScrollIndicator = false
        
        let usernameObject = PFUser.currentUser()?.objectForKey("username") as! String
        username.text = usernameObject
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        self.userProfileImage.layer.borderWidth = 3
        self.userProfileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        loadUserDetails()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logOut(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
        
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            
            let signInPage:LoginMenu = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginMenu") as! LoginMenu
            
            let signInPageNav = UINavigationController(rootViewController: signInPage)
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = signInPageNav
        }
    }
    
    func loadUserDetails() {
        
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile
        
        if(profilePictureObject != nil)
        {
            profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.userProfileImage.image = UIImage(data: imageData!)
                }
                
            }
        }
    }
}
