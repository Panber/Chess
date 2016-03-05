//
//  NewAnalyzeRegular.swift
//  Chess♔
//
//  Created by Johannes Berge on 16/01/16.
//  Copyright © 2016 Panber. All rights reserved.
//

import UIKit

class NewAnalyzeRegular: UIViewController,UITextFieldDelegate {

    
    var color = "White"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate=self

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var nameInput: UITextField!

    @IBOutlet weak var whiteOrBlack: UISegmentedControl!
    
    @IBAction func blackOrWhiteChanged(sender: UISegmentedControl) {
        
        nameInput.resignFirstResponder()
        
        switch whiteOrBlack.selectedSegmentIndex
        {
        case 0:
            color = "White"
        case 1:
            color = "Black"
        default:
            break;
        }
        
    }
    
    func textFieldShouldReturn(nameInput: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        nameInput.resignFirstResponder()
        return true;
    }
    
    func textFieldDidBeginEditing(nameInput: UITextField) {
        print(nameInput.text)
    }
    
    func textField(nameInput: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print(nameInput.text)
        

        return true
    }
    
    @IBAction func createButtonPressed(sender: AnyObject) {
        

        if nameInput.text?.characters.count == 0 {
            
            let alert = UIAlertController(title: "WARNING", message: "Please add a name to your analysis!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        
        else if nameInput.text?.characters.count > 25 {
            let alert = UIAlertController(title: "WARNING", message: "The name you have entered is too long!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        else {
        
        nameInput.resignFirstResponder()
        
        var white = ""
        var black = ""
        
        let game = PFObject(className: "Analyze")

        
        if color == "White" {
            white = (PFUser.currentUser()?.username)!
            black = "arnold"
            game["mainColor"] = "white"

        }
        else {
            black = (PFUser.currentUser()?.username)!
            white = "arnold"
            game["mainColor"] = "black"

        }
        game["player"] = (PFUser.currentUser()?.username)!
        game["whitePlayer"] = white
        game["blackPlayer"] = black
        game["players"] = [white,black]
        game["confirmed"] = true
        game["piecePosition"] = NSMutableArray()
        game["status_white"] = "analyze"
        game["status_black"] = "analyze"
        game["whitePromotionType"] = NSMutableArray()
        game["blackPromotionType"] = NSMutableArray()
        game["board"] = "regular"
        
        game["name"] = nameInput.text
        
        game.saveInBackgroundWithBlock { (bool:Bool, error:NSError?) -> Void in
            if error == nil {
                print("analyze Made!!")
                //self.tabBarController?.selectedIndex = 0
                //  navigationController.popViewControllerAnimated = true
                
                let completeSignal = UIImageView(frame: CGRectMake((screenWidth/2) - 30, (screenHeight/2) - 50, 60, 60))
                completeSignal.image = UIImage(named: "checkmark12.png")
                
                let completeText = UILabel(frame: CGRectMake((screenWidth/2) - 40,completeSignal.frame.size.height + completeSignal.frame.origin.y, 80, 40))
                completeText.text = "Created!"
                completeText.font = UIFont(name: "Times", size: 16)
                completeText.textAlignment = .Center
                completeText.textColor = UIColor.lightGrayColor()
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    visualEffectView.addSubview(completeSignal)
                    visualEffectView.addSubview(completeText)
                    visualEffectView.alpha = 1
                    visualEffectView.userInteractionEnabled = true
                    
                    }, completion: {finish in
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                        
                        UIView.animateWithDuration(0.3, delay: 2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            
                            visualEffectView.alpha = 0
                            visualEffectView.userInteractionEnabled = false
                            
                            
                            }, completion: { finish in
                                
                                completeSignal.removeFromSuperview()
                                completeText.removeFromSuperview()
                                
                                
                        })
                        
                })
                
                
        
                
            }
        }
        
        
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
    }

    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        checkInternetConnection()

        if darkMode == true {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            
            self.view.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            
//            useruserName.textColor = UIColor.whiteColor()
//            userRating.textColor = UIColor.lightTextColor()
//            bc1.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
//            bc2.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            
            
            
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
//            useruserName.textColor = UIColor.blackColor()
//            userRating.textColor = UIColor.lightGrayColor()
//            bc1.backgroundColor = UIColor.whiteColor()
//            bc2.backgroundColor = UIColor.whiteColor()
            
        }
        
        
    }
}
