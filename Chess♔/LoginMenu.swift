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

var login = false
//emailU... is to check if email signu up button has been pressed
var emailUEnabled = false
var alreadyUserTappedOnce = false


var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
var bottomConstraint0: NSLayoutConstraint = NSLayoutConstraint()
var bottomConstraint2 : NSLayoutConstraint = NSLayoutConstraint()
var bottomConstraint3 : NSLayoutConstraint = NSLayoutConstraint()
var bottomConstraint4 : NSLayoutConstraint = NSLayoutConstraint()
var bottomConstraint5: NSLayoutConstraint = NSLayoutConstraint()
var bottomConstraint6: NSLayoutConstraint = NSLayoutConstraint()

class LoginMenu: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var BlackBC: UIImageView!
    @IBOutlet weak var SignUpFacebookOutlet: UIButton!
    @IBOutlet weak var signUpEmailOutlet: UIButton!
    @IBOutlet weak var imageBC: UIImageView!
    
    @IBOutlet weak var imageBC2: UIImageView!
    @IBOutlet weak var chessIconHeader: UIImageView!
    
    @IBOutlet weak var lineOutlet: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
    @IBOutlet weak var selectProfilePhotoOutlet: UIButton!
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    
    @IBOutlet weak var alreadyAUserButtonOutlet: UIButton!
    
    @IBOutlet weak var selectProfilePhotoHeigthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profilePhotoImageViewHeightConstraint: NSLayoutConstraint!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("viewDidLoad")
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent
        
        BlackBC.alpha = 1
        
        UIView.animateWithDuration(1, animations: {self.BlackBC.alpha = 0.4})
        
        
        //Editing look at startup
        SignUpFacebookOutlet.layer.cornerRadius = cornerRadius
        signUpEmailOutlet.layer.cornerRadius = cornerRadius
        emailInput.layer.cornerRadius = cornerRadius
        passwordInput.layer.cornerRadius = cornerRadius
        signUpOutlet.layer.cornerRadius = cornerRadius
        usernameInput.layer.cornerRadius = cornerRadius
        selectProfilePhotoOutlet.layer.cornerRadius = (self.profilePhotoImageView.frame.size.width / 2)
        alreadyAUserButtonOutlet.layer.cornerRadius = cornerRadius

        //changing profileImage
        self.profilePhotoImageView.layer.cornerRadius = (self.profilePhotoImageView.frame.size.width / 2)
        self.profilePhotoImageView.clipsToBounds = true
        self.profilePhotoImageView.layer.borderWidth = 2
        self.profilePhotoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        //changing alpha of things
        emailInput.alpha = 0
        passwordInput.alpha = 0
        signUpOutlet.alpha = 0
        usernameInput.alpha = 0
        selectProfilePhotoOutlet.alpha = 0
        profilePhotoImageView.alpha = 0
        alreadyAUserButtonOutlet.alpha = 0

        

        
        passwordInput.delegate = self
        emailInput.delegate = self
        
        bcFade()

        //assigning guesture to background
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        BlackBC.addGestureRecognizer(tapGestureRecognizer)
        
        let tapProfileImageGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("profileImageTapped:"))
        profilePhotoImageView.addGestureRecognizer(tapProfileImageGestureRecognizer)

        
    }
    
    //func to detect if BCImage was tapped
    func imageTapped(img: AnyObject) {
        
        if emailUEnabled == false {
            }
            
        else {
            
            //dismisses keyboard
            view.endEditing(true)

            
            usernameInput.translatesAutoresizingMaskIntoConstraints = true
            passwordInput.translatesAutoresizingMaskIntoConstraints = true
            emailInput.translatesAutoresizingMaskIntoConstraints = true
            profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = true
            selectProfilePhotoOutlet.translatesAutoresizingMaskIntoConstraints = true
            signUpOutlet.translatesAutoresizingMaskIntoConstraints = true
            alreadyAUserButtonOutlet.translatesAutoresizingMaskIntoConstraints = true

            UIView.animateWithDuration(0.8, animations: { () -> Void in

                
                
                self.view.layoutIfNeeded()
            })
            
            //animate out
            UIView.animateWithDuration(0.8, animations: {
                
                //animating the view
                self.view.frame.origin.y += 800
                self.view.frame.size.height -= 800
                self.imageBC.frame.size.height -= 800
                self.imageBC2.frame.size.height -= 800
                
                //changing alpha of elements
                self.usernameInput.alpha = 0
                self.passwordInput.alpha = 0
                self.signUpOutlet.alpha = 0
                self.lineOutlet.alpha = 1
                self.BlackBC.alpha -= 0.5
                self.emailInput.alpha = 0
                self.profilePhotoImageView.alpha = 0
                self.usernameInput.alpha = 0
                self.selectProfilePhotoOutlet.alpha = 0
                self.profilePhotoImageView.alpha = 0
                
                if alreadyUserTappedOnce == true {
                    

                        self.signUpOutlet.translatesAutoresizingMaskIntoConstraints = false
                    
                        
                        UIView.animateWithDuration(0.8, animations: {
                            
                            login = false
                            
                            self.signUpOutlet.setTitle("Sign Up", forState: .Normal)
                            self.alreadyAUserButtonOutlet.setTitle("Already an user?", forState: .Normal)
                            
                            self.profilePhotoImageView.alpha = 0
                            self.selectProfilePhotoOutlet.alpha = 0
                            self.emailInput.alpha = 0
                            
                            self.selectProfilePhotoOutlet.userInteractionEnabled = false
                            self.emailInput.userInteractionEnabled = false
                            
                            bottomConstraint.constant = 800 + 166
                            self.view.addConstraint(bottomConstraint)
                            
                            bottomConstraint2.constant += 58
                            self.view.addConstraint(bottomConstraint2)
                            
                            self.view.layoutIfNeeded()
                            
                            alreadyUserTappedOnce = false
                            
                        })
                        
                        
                    
                
                
                }
                
            })
            
            emailUEnabled = false
        }
        print("BCImage tapped!!")
    
    }
    
    //fadeing bc func
    func bcFade() {
        
        //bc fade
        var nameOfimages = ["1.jpg","2.JPG","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.png","10.jpg","11.jpg","12.jpg","13.jpg","14.jpg","15.jpg"]
        
        //animating side to side
        func animateSideToSide() {
        UIView.animateWithDuration(80, delay:0 , options: UIViewAnimationOptions.CurveEaseInOut,animations: {
            self.imageBC.frame.size.width += 200
            self.imageBC2.frame.size.width -= 200
            },  completion: { starting in
                UIView.animateWithDuration(80, animations: {
                    self.imageBC.frame.size.width -= 200
                    self.imageBC2.frame.size.width += 200
                })
        })
        }
        animateSideToSide()
        
        //animate in bcimage
        func animateInBCImage() {
            print("animateInBC gets called")
            UIView.animateWithDuration(5, delay: 3, options: UIViewAnimationOptions.TransitionCurlUp, animations: {
            self.imageBC.alpha = 1
            self.imageBC2.alpha = 0
            
            }, completion: { starting in
                self.imageBC2.image = UIImage(named: nameOfimages[Int(arc4random_uniform(15))])
                animateInBCImage2()
            })
        }
        
        //animate in bcimage2
        func animateInBCImage2() {
            print("animateInBC2 gets called")
            UIView.animateWithDuration(5, delay: 3, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.imageBC.alpha = 0
                self.imageBC2.alpha = 1
                }, completion: { starting in
                    self.imageBC.image = UIImage(named: nameOfimages[Int(arc4random_uniform(15))])
                    animateInBCImage()
            })
            
        }
        
        animateInBCImage2()
    }
    
    
    //Function to blur images
    func blur(let imageView: UIImageView) {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = imageView.bounds
        imageView.addSubview(visualEffectView)
    }

    
    
    
    
    //Signup or sgin in
    @IBAction func signUp(sender: AnyObject) {
        
        //login!!
        if (login) {
            let userName = usernameInput.text
            let userPassword = passwordInput.text
            
            if (userName == "" || userPassword == "") {
            
                return
            }

            PFUser.logInWithUsernameInBackground(userName!, password: userPassword!) { (user:PFUser?, error:NSError?) -> Void in
                
                var userMessage = "Welcome!"
                
                if user != nil {
                    
                    //remember sign in stage
                    let userName: String? = user?.username
                    NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
//                    let maxinStoryboard: UIStoryboard = UIStoryboard(name: "Sett", bundle: nil)
//                    var mainPage:MainPageViewcontroller = mainStoryboard.instantiateViewControllerWithIdentifier("Sett")
                    
                    if(userName != nil)
                    {
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Sett")
                    self.showViewController(vc as! UIViewController, sender: vc)
                    
                }
                }
                else {
                    userMessage = error!.localizedDescription
                    
                    let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction  = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
                }
                }
            }
        
            //if signup
        else if (!login) {
        print("signing up")
            
        let userEmail = emailInput.text
        let userPassword = passwordInput.text
        let userName = usernameInput.text
        
        //checking if forms are typed in
            if (userName == "" || userPassword == "" || userEmail == "" || profilePhotoImageView.image == UIImage(named:"") ){
            
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
        myUser.setObject(userName!, forKey: "username")
            
            
            if let profileImageData = profilePhotoImageView.image
            {
                let profileImageDataJPEG = UIImageJPEGRepresentation(profileImageData, 1)
                
                let profileImageFile = PFFile(data: profileImageDataJPEG!)
                myUser.setObject(profileImageFile, forKey: "profile_picture")
                
            }
            
        
        
        
        myUser.signUpInBackgroundWithBlock { (success, error) -> Void in
            
            var userMessage = "Welcome! Your registration was successfull"
            
            if !success {
                //                userMessage = "The registration was not completed."
                userMessage = error!.localizedDescription
            }
            
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            // if success sign up
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

    }
    

    
    //setting the profile photo
    @IBAction func selectProfilePhoto(sender: AnyObject) {

        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.Camera
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
                self.imageBC2.frame.size.height += 800

                self.BlackBC.alpha += 0.5
            })
        }
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage

        selectProfilePhotoOutlet.setTitle("", forState: .Normal)
        
        self.dismissViewControllerAnimated(false, completion: animateOut)
        


    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    
        func animateOut() {
            UIView.animateWithDuration(0.8, animations: {
                //animating the view
                self.view.frame.origin.y -= 800
                self.view.frame.size.height += 800
                self.imageBC.frame.size.height += 800
                self.imageBC2.frame.size.height += 800

                self.BlackBC.alpha += 0.5
            })
        }
        self.dismissViewControllerAnimated(false, completion: animateOut)
    }


    
    
    
    
    
    @IBAction func signUpFacebook(sender: AnyObject) {
        
    }
    @IBAction func signUpEmail(sender: AnyObject) {
        
        emailUEnabled = true
        emailInput.adjustsFontSizeToFitWidth = true
        
        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        selectProfilePhotoOutlet.translatesAutoresizingMaskIntoConstraints = false
        signUpOutlet.translatesAutoresizingMaskIntoConstraints = false
        alreadyAUserButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        
    bottomConstraint = NSLayoutConstraint(item: usernameInput, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 20)

        

        //animate in
        UIView.animateWithDuration(0.8, animations: {
            self.usernameInput.becomeFirstResponder()
            
            //animating the view
            self.view.frame.origin.y -= 800
            self.view.frame.size.height += 800
            self.imageBC.frame.size.height += 800
            self.imageBC2.frame.size.height += 800
            
            //changing alpha of elements
            self.usernameInput.alpha = 1
            self.passwordInput.alpha = 1
            self.emailInput.alpha = 1
            self.profilePhotoImageView.alpha = 1
            self.selectProfilePhotoOutlet.alpha = 1
            self.alreadyAUserButtonOutlet.alpha = 1
            self.signUpOutlet.alpha = 1
            self.lineOutlet.alpha = 0
            self.BlackBC.alpha += 0.5

            
            bottomConstraint.constant = 800 + 166
            self.view.addConstraint(bottomConstraint)
            self.view.layoutIfNeeded()
            
                })
    
    }
    
    
    @IBAction func alreadyUser(sender: AnyObject) {
        
        if alreadyUserTappedOnce == false {
            
        signUpOutlet.translatesAutoresizingMaskIntoConstraints = false

        bottomConstraint = NSLayoutConstraint(item: usernameInput, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 20)
        bottomConstraint2 = NSLayoutConstraint(item: signUpOutlet, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: passwordInput, attribute: NSLayoutAttribute.TopMargin, multiplier: 1, constant: 20)
        
        UIView.animateWithDuration(0.8, animations: {
            
            login = true
            
            self.signUpOutlet.setTitle("Log in", forState: .Normal)
            self.alreadyAUserButtonOutlet.setTitle("New user?", forState: .Normal)
            
            self.profilePhotoImageView.alpha = 0
            self.selectProfilePhotoOutlet.alpha = 0
            self.emailInput.alpha = 0
            
            self.selectProfilePhotoOutlet.userInteractionEnabled = false
            self.emailInput.userInteractionEnabled = false
        
            bottomConstraint.constant = 800 + 20
            self.view.addConstraint(bottomConstraint)
            
            bottomConstraint2.constant = 50
            self.view.addConstraint(bottomConstraint2)
            
            self.view.layoutIfNeeded()
            
            alreadyUserTappedOnce = true
        
        })
        
        }
        
        else {
            
                
                signUpOutlet.translatesAutoresizingMaskIntoConstraints = false
            
                
                UIView.animateWithDuration(0.8, animations: {
                    
                    login = false
                    
                    self.signUpOutlet.setTitle("Sign Up", forState: .Normal)
                    self.alreadyAUserButtonOutlet.setTitle("Already an user?", forState: .Normal)
                    
                    self.profilePhotoImageView.alpha = 1
                    self.selectProfilePhotoOutlet.alpha = 1
                    self.emailInput.alpha = 1
                    
                    self.selectProfilePhotoOutlet.userInteractionEnabled = true
                    self.emailInput.userInteractionEnabled = true
                    
                    bottomConstraint.constant = 800 + 166
                    self.view.addConstraint(bottomConstraint)
                    
                    bottomConstraint2.constant += 58
                    self.view.addConstraint(bottomConstraint2)
                    
                    self.view.layoutIfNeeded()
                    
                    alreadyUserTappedOnce = false
                    
                })
        
        
    }
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

