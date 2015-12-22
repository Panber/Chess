//
//  AnalyzeMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse


class AnalyzeMenu: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var board: UIImageView!
  
    var slider = UISlider()
    var capsuleB = UIButton()
    var capsuleL = UILabel()
    
    var forwardB = UIButton()
    var backwardB = UIButton() 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.title = "Analyze"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]

        //
        slider = UISlider(frame:CGRectMake(20, screenHeight/2 + 150, screenWidth - 40, 20))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.continuous = true
        slider.tintColor = blue
        slider.value = 100
        slider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
        view.addSubview(slider)
        view.sendSubviewToBack(slider)
        //
        
        capsuleL = UILabel(frame: CGRectMake(0,screenHeight/2 - 150,screenWidth,60))
        capsuleL.text = "TIME CAPSULE"
        capsuleL.font = UIFont(name: "Didot", size: 22)
        capsuleL.textAlignment = .Center
        if darkMode {capsuleL.textColor = UIColor.whiteColor()}
        else {capsuleL.textColor = UIColor.blackColor()}
        view.addSubview(capsuleL)
        view.sendSubviewToBack(capsuleL)
        
        
        capsuleB = UIButton(frame: CGRectMake(screenWidth - 60,screenHeight/2 + 246,40,40))
        capsuleB.setBackgroundImage(UIImage(named: "capsuleClock.png"), forState: .Normal)
        capsuleB.addTarget(self, action: "capsuleButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(capsuleB)
        
        backwardB = UIButton(frame: CGRectMake(screenWidth/2-70,540 - 52,40,40))
        backwardB.setBackgroundImage(UIImage(named: "arrow_blueB.png"), forState: .Normal)
        backwardB.addTarget(self, action: "backwardButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(backwardB)
        backwardB.enabled = false
        view.sendSubviewToBack(backwardB)

        
        forwardB = UIButton(frame: CGRectMake(screenWidth/2+30,540 - 52,40,40))
        forwardB.setBackgroundImage(UIImage(named: "arrow_blueF.png"), forState: .Normal)
        forwardB.addTarget(self, action: "forwardButtonPressed:", forControlEvents: .TouchUpInside)
        forwardB.enabled = false
        view.addSubview(forwardB)
        view.sendSubviewToBack(forwardB)

        
    }

    func capsuleButtonPressed(sender: UIButton!) {
    
        forwardB.enabled = false
        backwardB.enabled = true

        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.slider.frame.origin.y = 652
            self.capsuleB.frame.origin.y += 200
            self.capsuleL.frame.origin.y = 78
            
            self.backwardB.frame.origin.y = 600
            self.forwardB.frame.origin.y = 600
            
            }, completion: {finish in
        
        })
        
    }
    
    func sliderValueDidChange(sender:UISlider!)
    {
        forwardB.enabled = true
        
        if sender.value == 0 {
            backwardB.enabled = false
            
        }
        else {
            backwardB.enabled = true
        }
        
        print("value--\(sender.value)")
        if sender.value == 100 {
            forwardB.enabled = false

            
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.slider.frame.origin.y = 540
                self.capsuleB.frame.origin.y = screenHeight/2 + 246
                self.capsuleL.frame.origin.y = 200
                
                self.backwardB.frame.origin.y = 540 - 52
                self.forwardB.frame.origin.y = 540 - 52

                }, completion: {finish in
                    //sender.value = 50

            })
        
        }
        
    
    }
    
    func forwardButtonPressed(sender:UIButton!) {
        slider.value++
        backwardB.enabled = true

        
        if slider.value == 100 {
            forwardB.enabled = false
            
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.slider.frame.origin.y = 540
                self.capsuleB.frame.origin.y = screenHeight/2 + 246
                self.capsuleL.frame.origin.y = 200
                
                self.backwardB.frame.origin.y = 540 - 52
                self.forwardB.frame.origin.y = 540 - 52
                
                }, completion: {finish in
                    //sender.value = 50
                    
            })

        }
    }
    func backwardButtonPressed(sender:UIButton!) {
        slider.value--
        forwardB.enabled = true
        
        if slider.value == 0 {
            backwardB.enabled = false
            
        }
        
    }

    func cancelButtonPressed(sender:UITapGestureRecognizer){
        removeNewView()
        
    }
    
    func removeNewView() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            visualEffectView.alpha = 0
            
            }, completion: {finish in
                
                for view in visualEffectSub.subviews {
                    view.removeFromSuperview()
                }
                
        })
        
        visualEffectView.userInteractionEnabled = false
        visualEffectSub.userInteractionEnabled = false
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()

        board.alpha = 0
        
        
        UIView.animateWithDuration(0.3) { () -> Void in
            self.board.alpha = 1
        }
        
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
                self.tabBarController?.tabBar.tintColor = blue
                self.navigationController?.navigationBar.tintColor = blue
                
            
        }
        
        
    }

    
}
