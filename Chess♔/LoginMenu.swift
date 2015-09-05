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

class LoginMenu: UIViewController {

    //Black Background Image Overlay for nice effect
    @IBOutlet weak var BlackBC: UIImageView!
    @IBOutlet weak var SignUpFacebookOutlet: UIButton!
    @IBOutlet weak var signUpEmailOutlet: UIButton!
    @IBOutlet weak var imageBC: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        // A Parse test, uncomment to test Parse
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
        
        //Editing look at startup
        SignUpFacebookOutlet.layer.cornerRadius = cornerRadius
        signUpEmailOutlet.layer.cornerRadius = cornerRadius
        
    }
    
    func blur(let imageView: UIImageView) {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = imageView.bounds
        imageView.addSubview(visualEffectView)
    }

    @IBAction func signUpFacebook(sender: AnyObject) {
        
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

