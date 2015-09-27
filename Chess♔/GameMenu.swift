//
//  GameMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

var gameIDS = []
var pressedCreateNewGame = NSUserDefaults()

var scrollView: UIScrollView!

class GameMenu: UIViewController, UIScrollViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //check this before launching!!!!!!
//        //Checking if first launch
//        let notFirstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
//        if notFirstLaunch  {
//            print("Not first launch.")
//        }
//        else {
//            print("First launch, setting NSUserDefault.")
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
//            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("firstLaunchVC")
//            self.showViewController(vc as! UIViewController, sender: vc)
//            
//            
//        }
        
        //...and remove this after a while
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("firstLaunchVC")
                    self.showViewController(vc as! UIViewController, sender: vc)

    
        // Do any additional setup after loading the view.
      
        view.frame.size.height = 2000
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.frame.size.height = screenHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.scrollEnabled = true
        view.addSubview(scrollView)
    }

    
    @IBAction func newGame(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "created_New_Game")
        
        newGameSetup()
     //   newGameSetup("", ProfilePic: UIImage(named: "")!, Rating: "", UpdatedAt: "", TimeLeft: "")

    }

    func newGameSetup() {
        
        
//        //creating the view
//        var shadowView: UIView = UIView(frame: CGRectMake(10, 75, screenWidth - 20 , screenHeight/7))
//        shadowView.layer.cornerRadius = cornerRadius
//        shadowView.backgroundColor = UIColor.whiteColor()
//        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
//        shadowView.layer.shadowOpacity = 0.1
//        shadowView.layer.shadowRadius = cornerRadius
//        shadowView.layer.shadowOffset = CGSizeZero
//        scrollView.addSubview(shadowView)
        
        //creating the view
      //  var contentView: UIView = UIView(frame: CGRectMake(0, 0, screenWidth - 20 , screenHeight/7))
        var contentView: UIView = UIView(frame: CGRectMake(10, 75, screenWidth - 20 , screenHeight/7))
        contentView.layer.cornerRadius = cornerRadius
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.shadowColor = UIColor.blackColor().CGColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = cornerRadius
        contentView.layer.shadowOffset = CGSizeZero
        contentView.clipsToBounds = true
        scrollView.addSubview(contentView)

        //setting up bc image of profile pic
        let profilePicBlur = UIImageView(frame: CGRectMake(0, 0, contentView.frame.size.height, contentView.frame.size.height))
        profilePicBlur.image = UIImage(named:"JBpp.jpg")
        profilePicBlur.clipsToBounds = true
        contentView.addSubview(profilePicBlur)
        
        //bluring bc of profile pic
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = profilePicBlur.bounds
        profilePicBlur.addSubview(visualEffectView)

        //adding the profile pic
        let profilePic = UIImageView(frame: CGRectMake(7.5, 7.5, (contentView.frame.size.height) - 15, (contentView.frame.size.height) - 15))
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2
        profilePic.clipsToBounds = true
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.borderWidth = 3
        profilePic.image = UIImage(named:"JBpp.jpg")
        profilePic.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(profilePic)
        
        //adding username to view
        let label = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height/8, 200, 40))
        label.textAlignment = NSTextAlignment.Left
        label.text = "johannesberge"
        label.font = UIFont(name: "Didot-Bold", size: 30)
        contentView.addSubview(label)
        
        
        //adding updated since label
        let label2 = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height - contentView.frame.size.height/2.4, 150, 20))
        label2.textAlignment = NSTextAlignment.Left
        label2.text = "Last move: 8 hours ago"
        label2.font = UIFont(name: "Didot-Italic", size: 10)
        contentView.addSubview(label2)
        
        //adding time left label
        let label3 = UILabel(frame: CGRectMake(profilePicBlur.frame.size.width + 20, contentView.frame.size.height - contentView.frame.size.height/3.2, 150, 20))
        label3.textAlignment = NSTextAlignment.Left
        label3.text = "Time left: 2 hours"
        label3.font = UIFont(name: "Didot-Italic", size: 10)
        contentView.addSubview(label3)
    
        //adding moveindicator
        let moveindicator = UILabel(frame: CGRectMake(contentView.frame.size.width - 10, 0, 10, contentView.frame.size.height))
        moveindicator.backgroundColor = UIColorFromRGB(0x02C223)
        contentView.addSubview(moveindicator)
    
    }
    
    //function to update the ui of things like time left etc...
    func updateGameSetup(User: String, ProfilePic: UIImage, Rating: String, UpdatedAt: String, TimeLeft: String) {
    
    }

    
    
    //func to find hexadecimal color value
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        lightOrDarkMode()
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
                self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
                self.navigationController?.navigationBar.tintColor = UIColor.blueColor()

  
        
        }
    
    
    }

}
