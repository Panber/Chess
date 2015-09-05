//
//  ViewController.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

let cornerRadius:CGFloat = 13
let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


class LoginMenu: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    //Black Background Image Overlay for nice effect
    @IBOutlet weak var BlackBC: UIImageView!
    @IBOutlet weak var SignUpFacebookOutlet: UIButton!
    @IBOutlet weak var signUpEmailOutlet: UIButton!
    @IBOutlet weak var imageBC: UIImageView!
    
    @IBOutlet weak var chessIconHeader: UIImageView!
    
    @IBOutlet weak var lineOutlet: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("viewDidLoad")
        
        // A Parse test, uncomment to test Parse
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
        
        
        //Editing look at startup
        SignUpFacebookOutlet.layer.cornerRadius = cornerRadius
        signUpEmailOutlet.layer.cornerRadius = cornerRadius
        emailInput.layer.cornerRadius = cornerRadius
        passwordInput.layer.cornerRadius = cornerRadius
        passwordInput.layer.cornerRadius = cornerRadius
        
        passwordInput.delegate = self
        emailInput.delegate= self
        
    }
    
    //Function to blur images
    func blur(let imageView: UIImageView) {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = imageView.bounds
        imageView.addSubview(visualEffectView)
    }

    @IBAction func signUp(sender: AnyObject) {
        print("signing up")
        
    }
    @IBAction func signUpFacebook(sender: AnyObject) {
        
        
    }
    @IBAction func signUpEmail(sender: AnyObject) {
        
        emailInput.adjustsFontSizeToFitWidth = true
//        emailInput.minimumScaleFactor = 0.2

        //animate in
        UIView.animateWithDuration(0.8, animations: {
//            self.chessIconHeader.frame.origin.y -= 220
//            self.emailInput.frame.origin.y -= 750
//            self.passwordInput.frame.origin.y -= 750
//            self.SignUpFacebookOutlet.frame.origin.y -= 1000
//            self.signUpEmailOutlet.frame.origin.y -= 1000
//            self.lineOutlet.frame.origin.y -= 1000
            self.lineOutlet.alpha = 0
            self.BlackBC.alpha += 0.5
//            self.signUpOutlet.frame.origin.y -= 750
            self.view.frame.origin.y -= 750
            self.view.frame.size.height += 750
            self.imageBC.frame.size.height += 750
            
        })
        
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        print("viewWillAppear")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

