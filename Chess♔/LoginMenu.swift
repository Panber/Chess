//
//  ViewController.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

let cornerRadius:CGFloat = 8
let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


class LoginMenu: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var BlackBC: UIImageView!
    @IBOutlet weak var SignUpFacebookOutlet: UIButton!
    @IBOutlet weak var signUpEmailOutlet: UIButton!
    @IBOutlet weak var imageBC: UIImageView!
    
    @IBOutlet weak var chessIconHeader: UIImageView!
    
    @IBOutlet weak var lineOutlet: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
    @IBOutlet weak var selectProfilePhotoOutlet: UIButton!
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("viewDidLoad")
        
        
        
        //Editing look at startup
        SignUpFacebookOutlet.layer.cornerRadius = cornerRadius
        signUpEmailOutlet.layer.cornerRadius = cornerRadius
        emailInput.layer.cornerRadius = cornerRadius
        passwordInput.layer.cornerRadius = cornerRadius
        signUpOutlet.layer.cornerRadius = cornerRadius
        usernameInput.layer.cornerRadius = cornerRadius
        selectProfilePhotoOutlet.layer.cornerRadius = cornerRadius

        //changing profileImage
        self.profilePhotoImageView.layer.cornerRadius = (self.profilePhotoImageView.frame.size.width / 2)
        self.profilePhotoImageView.clipsToBounds = true
        self.profilePhotoImageView.layer.borderWidth = 3
        self.profilePhotoImageView.layer.borderColor = UIColor.whiteColor().CGColor

        
        //changing alpha of things
        emailInput.alpha = 0
        passwordInput.alpha = 0
        signUpOutlet.alpha = 0
        usernameInput.alpha = 0
        selectProfilePhotoOutlet.alpha = 0
        profilePhotoImageView.alpha = 0
        
        passwordInput.delegate = self
        emailInput.delegate = self
        

        
    }
    
    
    //Function to blur images
    func blur(let imageView: UIImageView) {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = imageView.bounds
        imageView.addSubview(visualEffectView)
    }

    @IBAction func signUp(sender: AnyObject) {
        print("signing up")
        
        let userEmail = emailInput.text
        let userPassword = passwordInput.text
        let userName = usernameInput.text
        
        //checking if forms are typed in
            //remember to add photo to this list
        if (userName == "" || userPassword == "" || userEmail == "" || profilePhotoImageView.image == UIImage(named: "")) {
            
            let myAlert = UIAlertController(title: "Alert", message: "You have to submit all forms", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        
        }
        
        let myUser:PFUser = PFUser()
        myUser.username = userName
        myUser.email = userEmail
        myUser.password = userPassword
        
        let profileImageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, 1)
        
        if profileImageData != nil {
                let profileImageFile = PFFile(data: profileImageData!)
                myUser.setObject(profileImageFile, forKey: "profile_picture")
        }
        
        
        myUser.signUpInBackgroundWithBlock { (success:Bool, error: NSError?) -> Void in
            
            var userMessage = "Welcome! Your registration was successfull"
            
            if !success {
//                userMessage = "The registration was not completed."
                userMessage = error!.localizedDescription
            }
            

            
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { action in
                if success {
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Sett")
                    self.showViewController(vc as! UIViewController, sender: vc)
                }
            }
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }

        
    }
    //setting the profile photo
    @IBAction func selectProfilePhoto(sender: AnyObject) {
        
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(myPickerController, animated: true, completion: nil)
        BlackBC.alpha -= 0.5
    
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        func animateOut() {
            UIView.animateWithDuration(0.8, animations: {
                //animating the view
                self.view.frame.origin.y -= 800
                self.view.frame.size.height += 800
                self.imageBC.frame.size.height += 800
                self.BlackBC.alpha += 0.5
            })
        }

            profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.dismissViewControllerAnimated(false, completion: animateOut)
        

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    
        func animateOut() {
            UIView.animateWithDuration(0.8, animations: {
                //animating the view
                self.view.frame.origin.y -= 800
                self.view.frame.size.height += 800
                self.imageBC.frame.size.height += 800
                self.BlackBC.alpha += 0.5
            })
        }
        self.dismissViewControllerAnimated(false, completion: animateOut)
    }


    
    @IBAction func signUpFacebook(sender: AnyObject) {
        
    }
    @IBAction func signUpEmail(sender: AnyObject) {
        
        emailInput.adjustsFontSizeToFitWidth = true
//        emailInput.minimumScaleFactor = 0.2

        //animate in
        UIView.animateWithDuration(0.8, animations: {
            
            //animating the view
            self.view.frame.origin.y -= 800
            self.view.frame.size.height += 800
            self.imageBC.frame.size.height += 800
            
            //changing alpha of elements
            self.emailInput.alpha = 1
            self.passwordInput.alpha = 1
            self.signUpOutlet.alpha = 1
            self.usernameInput.alpha = 1
            self.selectProfilePhotoOutlet.alpha = 1
            self.profilePhotoImageView.alpha = 1
            self.lineOutlet.alpha = 0
            self.BlackBC.alpha += 0.5
            
//                //previous elements
//                self.signUpEmailOutlet.alpha = 0
//                self.SignUpFacebookOutlet.alpha = 0

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

