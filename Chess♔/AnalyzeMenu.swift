//
//  AnalyzeMenu.swift
//  Chess♔
//
//  Created by Johannes Berge on 05/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class AnalyzeMenu: UIViewController {

    @IBOutlet weak var board: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.title = "Analyze"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        visualEffectView.alpha = 1
        
        
        let info = UILabel(frame: CGRectMake(0,37,screenWidth, 32))
        info.text = "INFORMATION"
        info.textAlignment = .Center
        if darkMode {info.textColor = UIColor.lightGrayColor()}
        else {info.textColor = UIColor.darkGrayColor() }
        info.font = UIFont(name: "Didot", size: 22)
        visualEffectView.addSubview(info)
        
        let turn = UILabel(frame: CGRectMake(40,100,screenWidth, 29))
        turn.text = "Your Turn"
        if darkMode {turn.textColor = UIColor.whiteColor()}
        else {turn.textColor = UIColor.blackColor() }
        turn.font = UIFont(name: "Times", size: 19)
        visualEffectView.addSubview(turn)
        
        let color = UILabel(frame: CGRectMake(40,129,screenWidth, 29))
        color.text = "You are White"
        if darkMode {color.textColor = UIColor.whiteColor()}
        else {color.textColor = UIColor.blackColor() }
        color.font = UIFont(name: "Times", size: 19)
        visualEffectView.addSubview(color)
        
        let speed = UILabel(frame: CGRectMake(40,158,screenWidth, 29))
        speed.text = "Fast Speedmode"
        if darkMode {speed.textColor = UIColor.whiteColor()}
        else {speed.textColor = UIColor.blackColor() }
        speed.font = UIFont(name: "Times", size: 19)
        visualEffectView.addSubview(speed)
        
        let rated = UILabel(frame: CGRectMake(40,187,screenWidth, 29))
        rated.text = "Rated"
        if darkMode {rated.textColor = UIColor.whiteColor()}
        else {rated.textColor = UIColor.blackColor() }
        rated.font = UIFont(name: "Times", size: 19)
        visualEffectView.addSubview(rated)
        
        let turnIndicator = UILabel(frame: CGRectMake(turn.frame.origin.x - 20, turn.frame.origin.y + 12, 11, 11))
        turnIndicator.layer.cornerRadius = (turnIndicator.frame.size.width)/2
        turnIndicator.clipsToBounds = true
        turnIndicator.backgroundColor = blue
        visualEffectView.addSubview(turnIndicator)
        
        let colorIndicator = UILabel(frame: CGRectMake(color.frame.origin.x - 20, color.frame.origin.y + 12, 11, 11))
        colorIndicator.layer.borderColor = UIColor.blackColor().CGColor
        colorIndicator.layer.borderWidth = 1
        colorIndicator.backgroundColor = UIColor.whiteColor()
        visualEffectView.addSubview(colorIndicator)
        
        let speedImage = UIImageView(frame: CGRectMake(speed.frame.origin.x - 20, speed.frame.origin.y, 11, 29))
        speedImage.contentMode = .ScaleAspectFit
        speedImage.image = UIImage(named: "flash31.png")
        visualEffectView.addSubview(speedImage)
        
        let timeLeft = UILabel(frame: CGRectMake(40,216,screenWidth, 29))
        timeLeft.text = "Time Left To Move:"
        if darkMode {timeLeft.textColor = UIColor.lightGrayColor()}
        else {timeLeft.textColor = UIColor.darkGrayColor() }
        timeLeft.font = UIFont(name: "Times", size: 19)
        visualEffectView.addSubview(timeLeft)
        
        let time = UILabel(frame: CGRectMake(208,216,screenWidth-208, 29))
        time.text = "1 day"
        if darkMode {time.textColor = UIColor.whiteColor()}
        else {time.textColor = UIColor.blackColor() }
        time.font = UIFont(name: "Times", size: 19)
        visualEffectView.addSubview(time)
        
        let opponent = UILabel(frame: CGRectMake(0,300,screenWidth, 29))
        opponent.text = "OPPONENT:"
        opponent.textAlignment = .Center
        if darkMode {opponent.textColor = UIColor.lightGrayColor()}
        else {opponent
            .textColor = UIColor.darkGrayColor() }
        opponent.font = UIFont(name: "Didot", size: 19)
        visualEffectView.addSubview(opponent)
        
        let pImage = UIImageView(frame: CGRectMake(screenWidth/2 - 90, 340, 65, 65))
        pImage.layer.cornerRadius = pImage.frame.size.width/2
        pImage.clipsToBounds = true
        pImage.contentMode = .ScaleAspectFill
        pImage.image = UIImage(named: "JBpp.jpg")
        visualEffectView.addSubview(pImage)
        
        let name = UILabel(frame: CGRectMake(pImage.frame.origin.x + pImage.frame.size.width + 25,pImage.frame.origin.y + 10,screenWidth - (pImage.frame.origin.x + pImage.frame.size.width + 25),27))
        name.font = UIFont(name: "Times", size: 22)
        name.text = "mufcjb"
        name.textAlignment = .Left
        if darkMode {name.textColor = UIColor.whiteColor()}
        else {name.textColor = UIColor.blackColor() }
        visualEffectView.addSubview(name)
        
      let  rating = UILabel(frame: CGRectMake(name.frame.origin.x,name.frame.origin.y + name.frame.size.height,screenWidth - (pImage.frame.origin.x + pImage.frame.size.width + 25),21))
        rating.font = UIFont(name: "Times-Italic", size: 15)
        rating.textColor = UIColor.darkGrayColor()
        rating.text = "888"
        if darkMode {rating.textColor = UIColor.lightGrayColor()}
        else {rating.textColor = UIColor.darkGrayColor() }
        visualEffectView.addSubview(rating)
        
        
        // Do any additional setup after loading the view.
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
