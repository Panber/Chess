//
//  SignUpMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 20/10/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse
import Firebase

let cornerRadius:CGFloat = 8
let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
var ref = Firebase(url: "https://chess-panber.firebaseio.com/")

class SignUpMenu: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
    
    var bcImage = UIImageView()
    
    var loginView = UIView()
    var usernameMenu = UIView()
    
    var signupView = UIView()
    
    var doAnimateBc = true
    
    var usernameInputLogin = UITextField()
    var usernameInputFacebook = UITextField()
    
    var passwordInputLogin = UITextField()
    
    var emailInput = UITextField()
    var usernameInputSignup = UITextField()
    var passwordInputSignup = UITextField()
    
    var profilePicImageView = UIImageView()
    var addProfileButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent
        
        
        
        //view.frame.size.height = 2000
        //  scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize.height = 2000
        scrollView.frame.size.height = screenHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = true
        scrollView.scrollEnabled = false
        // view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        loadStartMenu()
        animateBC()
    }
    
    func loadStartMenu() {
        
        bcImage = UIImageView(frame: CGRectMake(0, 0, view.frame.size.height * 1.53, view.frame.size.height))
        bcImage.contentMode = .ScaleAspectFill
        bcImage.image = UIImage(named: "nasaearth.jpg")
        scrollView.addSubview(bcImage)
        
        visualEffectView.frame = view.bounds
        
        let iconImage = UIImageView(frame: CGRectMake(0, 40, view.frame.size.width, view.frame.size.height/3 + 30))
        iconImage.contentMode = .ScaleAspectFit
        iconImage.image = UIImage(named: "ChessLogoFront")
        scrollView.addSubview(iconImage)
        
        let loginButton = UIButton(frame: CGRectMake(30, view.frame.size.height - 170, screenWidth-60, 55))
        loginButton.layer.cornerRadius = cornerRadius
        loginButton.backgroundColor = UIColor.lightGrayColor()
        loginButton.setTitle("Log In", forState: .Normal)
        loginButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        loginButton.userInteractionEnabled = true
        loginButton.addTarget(self, action: "loginFromStartPressed:", forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(loginButton)
        
        let signupButton = UIButton(frame: CGRectMake(30, view.frame.size.height - 105, screenWidth-60, 55))
        signupButton.layer.cornerRadius = cornerRadius
        signupButton.backgroundColor = UIColor.lightGrayColor()
        signupButton.setTitle("Sign Up", forState: .Normal)
        signupButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        signupButton.userInteractionEnabled = true
        signupButton.addTarget(self, action: "signupFromStartPressed:", forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(signupButton)
        
        let forgotButton = UIButton(frame: CGRectMake(30, view.frame.size.height - 50, screenWidth-60, 50))
        forgotButton.layer.cornerRadius = cornerRadius
        forgotButton.backgroundColor = UIColor.clearColor()
        forgotButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        forgotButton.setTitle("Forgot Password?", forState: .Normal)
        forgotButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        scrollView.addSubview(forgotButton)
        
        visualEffectView.alpha = 0
        view.addSubview(visualEffectView)
        
        self.view.userInteractionEnabled = true
        
        let gesture1 = UITapGestureRecognizer(target: self, action: "loginViewPressed:")
        gesture1.delegate = self
        self.view.addGestureRecognizer(gesture1)
        
        let gesture3 = UITapGestureRecognizer(target: self, action: "effectViewViewPressed:")
        visualEffectView.userInteractionEnabled = true
        self.visualEffectView.addGestureRecognizer(gesture3)
        
    }
    
    
    
    func effectViewViewPressed(sender:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func loginViewPressed(sender:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func loginMenu() {
        
        
        loginView = UIView(frame: CGRectMake(10, screenHeight + 30, screenWidth - 20, 370))
        loginView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        loginView.layer.cornerRadius = cornerRadius
        
        view.addSubview(loginView)
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.loginView.frame.origin.y -= screenHeight
            self.loginView.alpha = 1
            self.visualEffectView.alpha = 1
            
            }, completion: nil)
        
        //setting up loginview
        
        let cancelButton = UIButton(frame: CGRectMake(loginView.frame.size.width - 60, 15, 30, 30))
        cancelButton.setTitle("", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        cancelButton.setTitleColor(blue, forState: .Normal)
        cancelButton.setBackgroundImage(UIImage(named: "arrow483.png"), forState: .Normal)
        cancelButton.titleLabel?.textAlignment = .Right
        cancelButton.addTarget(self, action: "cancelLoginButtonPressed:", forControlEvents: .TouchUpInside)
        loginView.addSubview(cancelButton)
        
        usernameInputLogin = UITextField(frame: CGRectMake(20, 60, view.frame.size.width-60, 55))
        usernameInputLogin.layer.cornerRadius = cornerRadius
        usernameInputLogin.backgroundColor = UIColor.darkGrayColor()
        usernameInputLogin.alpha = 0.8
        usernameInputLogin.textColor = UIColor.whiteColor()
        usernameInputLogin.font = UIFont(name: "Times", size: 20)
        usernameInputLogin.keyboardType = UIKeyboardType.Default
        usernameInputLogin.keyboardAppearance = UIKeyboardAppearance.Dark
        usernameInputLogin.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        usernameInputLogin.adjustsFontSizeToFitWidth = true
        usernameInputLogin.clearButtonMode = UITextFieldViewMode.WhileEditing
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, usernameInputLogin.frame.height))
        usernameInputLogin.leftView = paddingView
        usernameInputLogin.leftViewMode = UITextFieldViewMode.Always
        usernameInputLogin.autocapitalizationType = UITextAutocapitalizationType.None
        loginView.addSubview(usernameInputLogin)
        //usernameInput.becomeFirstResponder()
        
        passwordInputLogin = UITextField(frame: CGRectMake(20, 60 + usernameInputLogin.frame.size.height + 10, view.frame.size.width-60, 55))
        passwordInputLogin.layer.cornerRadius = cornerRadius
        passwordInputLogin.backgroundColor = UIColor.darkGrayColor()
        passwordInputLogin.alpha = 0.8
        passwordInputLogin.textColor = UIColor.whiteColor()
        passwordInputLogin.font = UIFont(name: "Times", size: 20)
        passwordInputLogin.secureTextEntry = true
        passwordInputLogin.keyboardType = UIKeyboardType.Default
        passwordInputLogin.keyboardAppearance = UIKeyboardAppearance.Dark
        passwordInputLogin.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        passwordInputLogin.adjustsFontSizeToFitWidth = true
        passwordInputLogin.clearButtonMode = UITextFieldViewMode.WhileEditing
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 15, passwordInputLogin.frame.height))
        passwordInputLogin.leftView = paddingView2
        passwordInputLogin.leftViewMode = UITextFieldViewMode.Always
        passwordInputLogin.autocapitalizationType = UITextAutocapitalizationType.None
        loginView.addSubview(passwordInputLogin)
        
        let loginButton = UIButton(frame: CGRectMake(20, 60 + usernameInputLogin.frame.size.height + 10 + passwordInputLogin.frame.size.height + 10, view.frame.size.width-60, 55))
        loginButton.layer.cornerRadius = cornerRadius
        loginButton.backgroundColor = UIColor(red:0.10, green:0.67, blue:0.18, alpha:1.0)
        loginButton.setTitle("Log In", forState: .Normal)
        loginButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        loginButton.addTarget(self, action: "loginButtonPressed:", forControlEvents: .TouchUpInside)
        loginView.addSubview(loginButton)
        
        let loginWithFacebookLabel = UILabel(frame: CGRectMake(30, loginView.frame.size.height - 20 - 55 - 30, view.frame.size.width-60, 30))
        loginWithFacebookLabel.text = "Log in using"
        loginWithFacebookLabel.font = UIFont(name: "Times", size: 18)
        loginWithFacebookLabel.textColor = UIColor.darkGrayColor()
        loginView.addSubview(loginWithFacebookLabel)
        
        let facebookLoginButton = UIButton(frame: CGRectMake(20, loginView.frame.size.height - 20 - 55, view.frame.size.width-60 ,55))
        facebookLoginButton.layer.cornerRadius = cornerRadius
        facebookLoginButton.backgroundColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0)
        facebookLoginButton.setTitle("Facebook", forState: .Normal)
        facebookLoginButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        facebookLoginButton.addTarget(self, action: "facebookLoginButtonPressed:", forControlEvents: .TouchUpInside)
        loginView.addSubview(facebookLoginButton)
        
        let forgotPasswordButton = UIButton(frame: CGRectMake(30, view.frame.height - 10, 100, 30))
        forgotPasswordButton.setTitle("Forgot Password?", forState: .Normal)
        
        
        
    }
    
    func addUsername() {
        
        
        usernameMenu = UIView(frame: CGRectMake(10, screenHeight + 30, screenWidth - 20, 210))
        usernameMenu.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        usernameMenu.layer.cornerRadius = cornerRadius
        
        view.addSubview(usernameMenu)
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.usernameMenu.frame.origin.y -= screenHeight
            self.usernameMenu.alpha = 1
            self.visualEffectView.alpha = 1
            
            }, completion: nil)
        
        //setting up loginview
        
        let cancelButton = UIButton(frame: CGRectMake(usernameMenu.frame.size.width - 60, 15, 30, 30))
        cancelButton.setTitle("", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        cancelButton.setTitleColor(blue, forState: .Normal)
        cancelButton.setBackgroundImage(UIImage(named: "arrow483.png"), forState: .Normal)
        cancelButton.titleLabel?.textAlignment = .Right
        cancelButton.addTarget(self, action: "cancelDoneButtonPressed:", forControlEvents: .TouchUpInside)
        usernameMenu.addSubview(cancelButton)
        
        usernameInputFacebook = UITextField(frame: CGRectMake(20, 60, view.frame.size.width-60, 55))
        usernameInputFacebook.layer.cornerRadius = cornerRadius
        usernameInputFacebook.backgroundColor = UIColor.darkGrayColor()
        usernameInputFacebook.alpha = 0.8
        usernameInputFacebook.textColor = UIColor.whiteColor()
        usernameInputFacebook.font = UIFont(name: "Times", size: 20)
        usernameInputFacebook.keyboardType = UIKeyboardType.Default
        usernameInputFacebook.keyboardAppearance = UIKeyboardAppearance.Dark
        usernameInputFacebook.attributedPlaceholder = NSAttributedString(string:"Please enter Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        usernameInputFacebook.adjustsFontSizeToFitWidth = true
        usernameInputFacebook.clearButtonMode = UITextFieldViewMode.WhileEditing
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, usernameInputFacebook.frame.height))
        usernameInputFacebook.leftView = paddingView
        usernameInputFacebook.leftViewMode = UITextFieldViewMode.Always
        usernameInputFacebook.autocapitalizationType = UITextAutocapitalizationType.None
        usernameMenu.addSubview(usernameInputFacebook)
        //usernameInput.becomeFirstResponder()
        
        
        let Done = UIButton(frame: CGRectMake(20, 60 + usernameInputFacebook.frame.size.height + 10 , view.frame.size.width-60, 55))
        Done.layer.cornerRadius = cornerRadius
        Done.backgroundColor = UIColor(red:0.10, green:0.67, blue:0.18, alpha:1.0)
        Done.setTitle("Done", forState: .Normal)
        Done.titleLabel?.font = UIFont(name: "Times", size: 20)
        Done.addTarget(self, action: "DoneButtonPressed:", forControlEvents: .TouchUpInside)
        usernameMenu.addSubview(Done)
        
        
        
        
    }
    
    
    func DoneButtonPressed(sender: UIButton!){
        
        if self.usernameInputFacebook.text!.characters.count == 0 {
            let myAlert = UIAlertController(title: "Alert", message: "Please enter a username", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction  = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        } else {
            
            var query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: self.usernameInputFacebook.text!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) in
                if error == nil {
                    if (objects!.count > 0){
                        print("username is taken")
                        let myAlert = UIAlertController(title: "Alert", message: "username is taken", preferredStyle: UIAlertControllerStyle.Alert)
                        let okAction  = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        myAlert.addAction(okAction)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                        
                    } else {
                        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email"], block: { (user:PFUser?, error:NSError?) -> Void in
                            
                            if(error != nil)
                            {
                                //Display an alert message
                                let myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                                
                                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                                
                                myAlert.addAction(okAction);
                                self.presentViewController(myAlert, animated:true, completion:nil);
                                
                                return
                            }
                            
                            if let user = user {
                                if user.isNew {
                                    
                                    print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
                                    
                                    print("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
                                    
                                    if(FBSDKAccessToken.currentAccessToken() != nil)
                                    {
                                        
                                        self.loadFacebookUserDetails()
                                    }
                                } else {
                                    print("User logged in through Facebook!")
                                    let myAlert = UIAlertController(title: "Alert", message: "Your facebook account is already linked to CHESS", preferredStyle: UIAlertControllerStyle.Alert)
                                    let okAction  = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                                    myAlert.addAction(okAction)
                                    self.presentViewController(myAlert, animated: true, completion: nil)
                                }
                            } else {
                                print("Uh oh. The user cancelled the Facebook login.")
                            }
                            
                        })
                    }
                }
            }
            
        }
        
        //something with usernameInputFacebook textfield
        
    }
    
    func loadSignupView() {
        
        signupView = UIView(frame: CGRectMake(10, screenHeight + 30, screenWidth - 20, 475))
        signupView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        signupView.layer.cornerRadius = cornerRadius
        
        view.addSubview(signupView)
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.signupView.frame.origin.y -= screenHeight
            self.visualEffectView.alpha = 1
            
            }, completion: nil)
        
        //setting up signupview
        
        let cancelButton = UIButton(frame: CGRectMake(signupView.frame.size.width - 60, 15, 30, 30))
        cancelButton.setBackgroundImage(UIImage(named: "arrow483.png"), forState: .Normal)
        cancelButton.titleLabel?.textAlignment = .Right
        cancelButton.addTarget(self, action: "cancelSignupButtonPressed:", forControlEvents: .TouchUpInside)
        signupView.addSubview(cancelButton)
        
        profilePicImageView = UIImageView(frame: CGRectMake((signupView
            .frame.size.width/2) - 40, 10, 80, 80))
        profilePicImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePicImageView.layer.borderWidth = 3
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.width/2
        profilePicImageView.clipsToBounds = true
        profilePicImageView.contentMode = .ScaleAspectFill
        profilePicImageView.image = UIImage(named: "profilePicPlaceholderDark.jpg")
        signupView.addSubview(profilePicImageView)
        
        addProfileButton = UIButton(frame: CGRectMake((signupView.frame.size.width/2) - 40, 10, 80, 80))
        addProfileButton.setTitle("ADD", forState: .Normal)
        addProfileButton.titleLabel?.font = UIFont(name: "Times", size: 18)
        addProfileButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addProfileButton.addTarget(self, action: "addProfilePicButtonPressed:", forControlEvents: .TouchUpInside)
        signupView.addSubview(addProfileButton)
        
        emailInput = UITextField(frame: CGRectMake(20, 100, view.frame.size.width-60, 55))
        emailInput.layer.cornerRadius = cornerRadius
        emailInput.backgroundColor = UIColor.darkGrayColor()
        emailInput.alpha = 0.8
        emailInput.textColor = UIColor.whiteColor()
        emailInput.font = UIFont(name: "Times", size: 20)
        emailInput.keyboardType = UIKeyboardType.EmailAddress
        emailInput.keyboardAppearance = UIKeyboardAppearance.Dark
        emailInput.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        emailInput.adjustsFontSizeToFitWidth = true
        emailInput.clearButtonMode = UITextFieldViewMode.WhileEditing
        let paddingView0 = UIView(frame: CGRectMake(0, 0, 15, emailInput.frame.height))
        emailInput.leftView = paddingView0
        emailInput.leftViewMode = UITextFieldViewMode.Always
        emailInput.autocapitalizationType = UITextAutocapitalizationType.None
        signupView.addSubview(emailInput)
        
        usernameInputSignup = UITextField(frame: CGRectMake(20, 100 + emailInput.frame.size.height + 10, view.frame.size.width-60, 55))
        usernameInputSignup.layer.cornerRadius = cornerRadius
        usernameInputSignup.backgroundColor = UIColor.darkGrayColor()
        usernameInputSignup.alpha = 0.8
        usernameInputSignup.textColor = UIColor.whiteColor()
        usernameInputSignup.font = UIFont(name: "Times", size: 20)
        usernameInputSignup.keyboardType = UIKeyboardType.Default
        usernameInputSignup.keyboardAppearance = UIKeyboardAppearance.Dark
        usernameInputSignup.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        usernameInputSignup.adjustsFontSizeToFitWidth = true
        usernameInputSignup.clearButtonMode = UITextFieldViewMode.WhileEditing
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, usernameInputSignup.frame.height))
        usernameInputSignup.leftView = paddingView
        usernameInputSignup.leftViewMode = UITextFieldViewMode.Always
        usernameInputSignup.autocapitalizationType = UITextAutocapitalizationType.None
        signupView.addSubview(usernameInputSignup)
        //usernameInput.becomeFirstResponder()
        
        passwordInputSignup = UITextField(frame: CGRectMake(20, 100 + emailInput.frame.size.height + 10 + usernameInputSignup.frame.size.height + 10, view.frame.size.width-60, 55))
        passwordInputSignup.layer.cornerRadius = cornerRadius
        passwordInputSignup.backgroundColor = UIColor.darkGrayColor()
        passwordInputSignup.alpha = 0.8
        passwordInputSignup.textColor = UIColor.whiteColor()
        passwordInputSignup.font = UIFont(name: "Times", size: 20)
        passwordInputSignup.secureTextEntry = true
        passwordInputSignup.keyboardType = UIKeyboardType.Default
        passwordInputSignup.keyboardAppearance = UIKeyboardAppearance.Dark
        passwordInputSignup.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        passwordInputSignup.adjustsFontSizeToFitWidth = true
        passwordInputSignup.clearButtonMode = UITextFieldViewMode.WhileEditing
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 15, passwordInputSignup.frame.height))
        passwordInputSignup.leftView = paddingView2
        passwordInputSignup.leftViewMode = UITextFieldViewMode.Always
        passwordInputSignup.autocapitalizationType = UITextAutocapitalizationType.None
        signupView.addSubview(passwordInputSignup)
        
        let signupButton = UIButton(frame: CGRectMake(20, 100 + emailInput.frame.size.height + 10 + usernameInputSignup.frame.size.height + 10 + passwordInputSignup.frame.size.height + 10, view.frame.size.width-60, 55))
        signupButton.layer.cornerRadius = cornerRadius
        signupButton.backgroundColor = UIColor(red:0.10, green:0.67, blue:0.18, alpha:1.0)
        signupButton.setTitle("Sign Up", forState: .Normal)
        signupButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        signupButton.addTarget(self, action: "signupButtonPressed:", forControlEvents: .TouchUpInside)
        signupView.addSubview(signupButton)
        
        let loginWithFacebookLabel = UILabel(frame: CGRectMake(30, signupView.frame.size.height - 20 - 55 - 30, view.frame.size.width-60, 30))
        loginWithFacebookLabel.text = "Sign up using"
        loginWithFacebookLabel.font = UIFont(name: "Times", size: 18)
        loginWithFacebookLabel.textColor = UIColor.darkGrayColor()
        signupView.addSubview(loginWithFacebookLabel)
        
        let facebookSignupButton = UIButton(frame: CGRectMake(20, signupView.frame.size.height - 20 - 55, view.frame.size.width-60 ,55))
        facebookSignupButton.layer.cornerRadius = cornerRadius
        facebookSignupButton.backgroundColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0)
        facebookSignupButton.setTitle("Facebook", forState: .Normal)
        facebookSignupButton.titleLabel?.font = UIFont(name: "Times", size: 20)
        facebookSignupButton.addTarget(self, action: "facebookSignUpButtonPressed:", forControlEvents: .TouchUpInside)
        signupView.addSubview(facebookSignupButton)
        
        
    }
    
    
    func blur(let view: UIView) {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = view.bounds
        view.addSubview(visualEffectView)
    }
    
    func loginFromStartPressed(sender: UIButton!) {
        
        print("pressed")
        loginMenu()
        //  addUsername()
        
    }
    
    func loginButtonPressed(sender: UIButton!) {
        
        let userName = usernameInputLogin.text
        let userPassword = passwordInputLogin.text
        
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
    
    func facebookLoginButtonPressed(sender: UIButton!) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email"], block: { (user:PFUser?, error:NSError?) -> Void in
            
            if(error != nil)
            {
                //Display an alert message
                let myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
                
                return
            }
            print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
            
            print("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
            
            if(FBSDKAccessToken.currentAccessToken() != nil)
            {
                
                dispatch_async(dispatch_get_main_queue()) {
                    let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Sett")
                    self.showViewController(vc as! UIViewController, sender: vc)
                }
            }
            
        })
        
    }
    
    func cancelLoginButtonPressed(sender: UIButton!) {
        view.endEditing(true)
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.loginView.frame.origin.y += screenHeight
            //self.loginView.alpha = 1
            self.visualEffectView.alpha = 0
            
            }, completion: nil)
        
    }
    
    func cancelDoneButtonPressed(sender: UIButton!) {
        view.endEditing(true)
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.usernameMenu.frame.origin.y += screenHeight
            //self.loginView.alpha = 1
            self.visualEffectView.alpha = 0
            
            }, completion: nil)
        
    }
    
    func cancelSignupButtonPressed(sender: UIButton!) {
        
        view.endEditing(true)
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.signupView.frame.origin.y += screenHeight
            self.visualEffectView.alpha = 0
            
            }, completion: nil)
        
    }
    
    
    func animateBC() {
        
        print("1")
        UIView.animateWithDuration(60, animations: { () -> Void in
            print("2")
            
            if self.doAnimateBc == true {
                self.bcImage.frame.origin.x -= screenWidth*1.53
            }
            
            }, completion: { Animate in
                print("3")
                
                UIView.animateWithDuration(60, animations: { () -> Void in
                    if self.doAnimateBc == true {
                        self.bcImage.frame.origin.x += screenWidth*1.53
                    }
                    }, completion: { Void in
                        return
                })
                
        })
        
        
    }
    
    func signupFromStartPressed(sender:UIButton!) {
        
        loadSignupView()
        
    }
    
    func signupButtonPressed(sender:UIButton!) {
        
        print("signing up")
        
        let userEmail = emailInput.text
        let userPassword = passwordInputSignup.text
        var userName = usernameInputSignup.text?.lowercaseString
        
        //checking if forms are typed in
        if (userName == "" || userPassword == "" || userEmail == "" || profilePicImageView.image == UIImage(named:"profilePicPlaceholderDark.jpg") ){
            
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
        
        
        func resizeImage(image:UIImage) -> UIImage
        {
            var actualHeight = image.size.height
            var actualWidth = image.size.width
            let maxHeight: CGFloat = 1000.0
            let maxWidth: CGFloat = 1000.0
            var imgRatio = actualWidth/actualHeight
            let maxRatio = maxWidth/maxHeight
            let compressionQuality: CGFloat = 0.0
            //50 percent compression
            
            if (actualHeight > maxHeight || actualWidth > maxWidth)
            {
                if(imgRatio < maxRatio)
                {
                    //adjust width according to maxHeight
                    imgRatio = maxHeight / actualHeight;
                    actualWidth = imgRatio * actualWidth;
                    actualHeight = maxHeight;
                }
                else if(imgRatio > maxRatio)
                {
                    //adjust height according to maxWidth
                    imgRatio = maxWidth / actualWidth;
                    actualHeight = imgRatio * actualHeight;
                    actualWidth = maxWidth;
                }
                else
                {
                    actualHeight = maxHeight;
                    actualWidth = maxWidth;
                }
            }
            
            let rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
            UIGraphicsBeginImageContext(rect.size);
            image.drawInRect(rect)
            let img = UIGraphicsGetImageFromCurrentImageContext();
            let imageData = UIImageJPEGRepresentation(img, compressionQuality)
            UIGraphicsEndImageContext();
            
            return UIImage(data:imageData!)!
            
            
            
        }
        
        profilePicImageView.image = resizeImage(profilePicImageView.image!)
        
        if let profileImageData = profilePicImageView.image
        {
            
            
            let profileImageDataJPEG = UIImageJPEGRepresentation(profileImageData, 0)
            
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
                    
                    NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            }
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }
        
        
    }
    
    func addProfilePicButtonPressed(sender:UIButton!) {
        
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        profilePicImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        addProfileButton.setTitle("", forState: .Normal)
        addProfileButton.removeFromSuperview()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func facebookSignUpButtonPressed(sender:UIButton!) {
        
        self.view.endEditing(true)
        self.signupView.frame.origin.y += screenHeight
        self.visualEffectView.alpha = 0
        
        addUsername()
        
        
    }
    
    func loadFacebookUserDetails() {
        
        
        // Define fields we would like to read from Facebook User object
        let requestParameters = ["fields": "email, first_name, last_name, name"]
        
        // Send Facebook Graph API Request for /me
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        userDetails.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if error != nil {
                
                let userMessage = error!.localizedDescription
                let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                
                PFUser.logOut()
                
                return
            }
            
            // Extract user fields
            let userId:String = FBSDKAccessToken.currentAccessToken().userID
            let userEmail:String? = result["email"] as? String
            let userFirstName:String?  = result["first_name"] as? String
            let userLastName:String? = result["last_name"] as? String
            let username:String = self.usernameInputFacebook.text!
            
            // Get Facebook profile picture
            let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
            
            let profilePictureUrl = NSURL(string: userProfile)
            
            let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
            
            
            // Prepare PFUser object
            if(profilePictureData != nil)
            {
                let profileFileObject = PFFile(data:profilePictureData!)
                PFUser.currentUser()?.setObject(profileFileObject, forKey: "profile_picture")
            }
            
            PFUser.currentUser()?.setObject(username, forKey: "username")
            
            if let userEmail = userEmail
            {
                PFUser.currentUser()?.email = userEmail
                PFUser.currentUser()?.username = username
            }
            
            
            PFUser.currentUser()?.saveInBackgroundWithBlock({ (success, error) -> Void in
                
                if(error != nil)
                {
                    let userMessage = error!.localizedDescription
                    let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    myAlert.addAction(okAction)
                    
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                    
                    PFUser.logOut()
                    return
                    
                    
                }
                
                if(success)
                {
                    if !userId.isEmpty
                    {
                        NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "user_name")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("Sett")
                            self.showViewController(vc as! UIViewController, sender: vc)
                        }
                        
                    }
                    
                }
                
            })
            
            
        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
        application.statusBarHidden = true
        return true
    }
    
}