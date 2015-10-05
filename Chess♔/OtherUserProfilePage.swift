//
//  OtherUserProfilePage.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var contentView = UIView()
var profilePicBlur = UIImageView()

class OtherUserProfilePage: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!

    override func viewWillAppear(animated: Bool) {
        setUpProfile()
    }
    override func viewWillDisappear(animated: Bool) {
        UIView.animateWithDuration(0.8, animations: {self.removeProfile()})
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //setting scrollview
        view.frame.size.height = 1000
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.frame.size.height = screenHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.scrollEnabled = true
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        
        var yPos = -scrollView.contentOffset.y
        
                contentView.frame.origin.y = scrollView.contentOffset.y + 65
            // contentView.frame.size.height =  screenHeight/5 + yPos
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
        
        
    }

    func setUpProfile () {
    
    
        //creating the view
        //  var contentView: UIView = UIView(frame: CGRectMake(0, 0, screenWidth - 20 , screenHeight/7))
        contentView = UIView(frame: CGRectMake(0, 65, screenWidth, screenHeight/5))
        //contentView.layer.cornerRadius = cornerRadius
        if darkMode { contentView.backgroundColor = UIColor(red: 0.12, green: 0.12 , blue: 0.12, alpha: 1) }
        else { contentView.backgroundColor = UIColor.whiteColor() }
        contentView.clipsToBounds = true
        scrollView.addSubview(contentView)
        
        //setting up bc image of profile pic
        if NSUserDefaults.standardUserDefaults().objectForKey("other_userImage") == nil {
        sleep(5)
        }
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("other_userImage") as! NSData
        
        profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height))
        profilePicBlur.image = UIImage(data: imageData)
        profilePicBlur.clipsToBounds = true
        profilePicBlur.contentMode = .ScaleAspectFill
        contentView.addSubview(profilePicBlur)
        
        //bluring bc of profile pic
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = profilePicBlur.bounds
        profilePicBlur.addSubview(visualEffectView)
        
        //adding the profile pic
        let profilePic = UIImageView(frame: CGRectMake(20, 20, (contentView.frame.size.height) - 40, (contentView.frame.size.height) - 40))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(data: imageData)
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(contentView.frame.size.height  + 15, contentView.frame.size.height/5, 250, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = NSUserDefaults.standardUserDefaults().objectForKey("other_username")as? String
        label.font = UIFont(name: "Didot-Bold", size: 30)
        if darkMode { label.textColor = UIColor.whiteColor() }
        else { label.textColor = UIColor.blackColor() }
        contentView.addSubview(label)
        
        
        //adding updated since label
        let label2 = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height - contentView.frame.size.height/2.4, 100, 40))
        label2.textAlignment = NSTextAlignment.Left
        label2.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        label2.numberOfLines = 0
        label2.text = "Rating: "
        label2.font = UIFont(name: "Didot-Italic", size: 10)
        if darkMode { label2.textColor = UIColor.whiteColor() }
        else { label2.textColor = UIColor.blackColor() }
        contentView.addSubview(label2)
        
        
        

        
    }
    
    
    func removeProfile() {
    contentView.removeFromSuperview()
    
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var yPos = -scrollView.contentOffset.y
        
        if yPos >= 0 {
//            CGRect imgRect = self.imageView.frame;
//            imgRect.origin.y = scrollView.contentOffset.y;
//            imgRect.size.height = HeaderHeight+yPos;
//            self.imageView.frame = imgRect;
            
            contentView.frame.origin.y = scrollView.contentOffset.y + 65
           // contentView.frame.size.height =  screenHeight/5 + yPos
            
            profilePicBlur.frame.size.height = contentView.frame.size.height + yPos
            profilePicBlur.contentMode = .ScaleAspectFill
 
        }
        
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

}
