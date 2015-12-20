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
    
    var movesField = UITextView()
    var copyB = UIButton()
    var cancelB = UIButton()
    var turnL = UILabel()
    var colorL = UILabel()
    var speedL = UILabel()
    var ratedL = UILabel()
    var turnIndicator = UILabel()
    var colorIndicator = UILabel()
    var speedImage = UIImageView()
    var timeL = UILabel()
    var pImage = UIImageView()
    var nameL = UILabel()
    var  ratingL = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.title = "Analyze"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        visualEffectView.alpha = 1
        

        
        visualEffectSub.userInteractionEnabled = true
        visualEffectView.userInteractionEnabled = true
        
        var scrollView1 = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        scrollView1.delegate = self
        scrollView1.userInteractionEnabled = true
        scrollView1.scrollEnabled = true
        scrollView1.pagingEnabled = false
        scrollView1.contentSize = CGSizeMake(screenWidth, 738)
        visualEffectSub.addSubview(scrollView1)
        
        
        var info = UILabel(frame: CGRectMake(0,37,screenWidth, 32))
        info.text = "INFORMATION"
        info.textAlignment = .Center
        if darkMode {info.textColor = UIColor.lightGrayColor()}
        else {info.textColor = UIColor.darkGrayColor() }
        info.font = UIFont(name: "Didot", size: 22)
        scrollView1.addSubview(info)
        
        turnL = UILabel(frame: CGRectMake(40,100 - 10,screenWidth, 29))
        turnL.text = "Your Turn"
        if darkMode {turnL.textColor = UIColor.whiteColor()}
        else {turnL.textColor = UIColor.blackColor() }
        turnL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(turnL)
        
        colorL = UILabel(frame: CGRectMake(40,129 - 10,screenWidth, 29))
        colorL.text = "You are White"
        if darkMode {colorL.textColor = UIColor.whiteColor()}
        else {colorL.textColor = UIColor.blackColor() }
        colorL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(colorL)
        
         speedL = UILabel(frame: CGRectMake(40,158 - 10,screenWidth, 29))
        speedL.text = "Fast Speedmode"
        if darkMode {speedL.textColor = UIColor.whiteColor()}
        else {speedL.textColor = UIColor.blackColor() }
        speedL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(speedL)
        
        ratedL = UILabel(frame: CGRectMake(40,187 - 10,screenWidth, 29))
        ratedL.text = "Rated"
        if darkMode {ratedL.textColor = UIColor.whiteColor()}
        else {ratedL.textColor = UIColor.blackColor() }
        ratedL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(ratedL)
        
        turnIndicator = UILabel(frame: CGRectMake(turnL.frame.origin.x - 20, turnL.frame.origin.y + 12 , 11, 11))
        turnIndicator.layer.cornerRadius = (turnIndicator.frame.size.width)/2
        turnIndicator.clipsToBounds = true
        turnIndicator.backgroundColor = blue
        scrollView1.addSubview(turnIndicator)
        
        colorIndicator = UILabel(frame: CGRectMake(colorL.frame.origin.x - 20, colorL.frame.origin.y + 12 , 11, 11))
        colorIndicator.layer.borderColor = UIColor.blackColor().CGColor
        colorIndicator.layer.borderWidth = 1
        colorIndicator.backgroundColor = UIColor.whiteColor()
        scrollView1.addSubview(colorIndicator)
        
        speedImage = UIImageView(frame: CGRectMake(speedL.frame.origin.x - 20, speedL.frame.origin.y, 11, 29))
        speedImage.contentMode = .ScaleAspectFit
        speedImage.image = UIImage(named: "flash31.png")
        scrollView1.addSubview(speedImage)
        
        let timeLeft = UILabel(frame: CGRectMake(40,216 - 10,screenWidth, 29))
        timeLeft.text = "Time Left To Move:"
        if darkMode {timeLeft.textColor = UIColor.lightGrayColor()}
        else {timeLeft.textColor = UIColor.darkGrayColor() }
        timeLeft.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(timeLeft)
        
        timeL = UILabel(frame: CGRectMake(199,216 - 10,screenWidth-208, 29))
        timeL.text = "1 day"
        if darkMode {timeL.textColor = UIColor.whiteColor()}
        else {timeL.textColor = UIColor.blackColor() }
        timeL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(timeL)
        
        let opponent = UILabel(frame: CGRectMake(0,280,screenWidth, 29))
        opponent.text = "OPPONENT"
        opponent.textAlignment = .Center
        if darkMode {opponent.textColor = UIColor.lightGrayColor()}
        else {opponent
            .textColor = UIColor.darkGrayColor() }
        opponent.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(opponent)
        
        pImage = UIImageView(frame: CGRectMake(screenWidth/2 - 90, 330, 65, 65))
        pImage.layer.cornerRadius = pImage.frame.size.width/2
        pImage.clipsToBounds = true
        pImage.contentMode = .ScaleAspectFill
        pImage.image = UIImage(named: "JBpp.jpg")
        scrollView1.addSubview(pImage)
        
        nameL = UILabel(frame: CGRectMake(pImage.frame.origin.x + pImage.frame.size.width + 25,pImage.frame.origin.y + 10,screenWidth - (pImage.frame.origin.x + pImage.frame.size.width + 25),27))
        nameL.font = UIFont(name: "Times", size: 22)
        nameL.text = "mufcjb"
        nameL.textAlignment = .Left
        if darkMode {nameL.textColor = UIColor.whiteColor()}
        else {nameL.textColor = UIColor.blackColor() }
        scrollView1.addSubview(nameL)
        
        ratingL = UILabel(frame: CGRectMake(nameL.frame.origin.x,nameL.frame.origin.y + nameL.frame.size.height,screenWidth - (pImage.frame.origin.x + pImage.frame.size.width + 25),21))
        ratingL.font = UIFont(name: "Times-Italic", size: 15)
        ratingL.textColor = UIColor.darkGrayColor()
        ratingL.text = "888"
        if darkMode {ratingL.textColor = UIColor.lightGrayColor()}
        else {ratingL.textColor = UIColor.darkGrayColor() }
        scrollView1.addSubview(ratingL)
        
        let moves = UILabel(frame: CGRectMake(0,450,screenWidth, 29))
        moves.text = "MOVES"
        moves.textAlignment = .Center
        if darkMode {moves.textColor = UIColor.lightGrayColor()}
        else {moves
            .textColor = UIColor.darkGrayColor() }
        moves.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(moves)
        
        movesField = UITextView(frame: CGRectMake(30,485,screenWidth-60,200))
        movesField.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        movesField.font = UIFont(name: "Times", size: 19)
        movesField.backgroundColor = UIColor.clearColor()
        if darkMode {movesField.textColor = UIColor.whiteColor()}
        else {movesField.textColor = UIColor.blackColor() }
        movesField.userInteractionEnabled = true
        movesField.editable = false
        print(movesField.userActivity)
        scrollView1.addSubview(movesField)

        //invite to game btn
        copyB = UIButton(frame: CGRectMake(screenWidth/2 + 75, 450,45,25))
        copyB.titleLabel?.font = UIFont(name: "Times", size: 14)
        copyB.setTitle("Copy", forState: .Normal)
        copyB.layer.cornerRadius = cornerRadius - 3
        copyB.userInteractionEnabled = true
        copyB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        copyB.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        copyB.backgroundColor = blue
        copyB.addTarget(self, action: "copyButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(copyB)
        
        cancelB = UIButton(frame: CGRectMake(screenWidth - 40, 43,20 ,20))
        cancelB.userInteractionEnabled = true
        if darkMode {cancelB.setBackgroundImage(UIImage(named: "cross-mark1-3.png"), forState: .Normal)}
        else {cancelB.setBackgroundImage(UIImage(named: "cross-mark1-2.png"), forState: .Normal) }
        cancelB.addTarget(self, action: "cancelButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(cancelB)
        
    }

    func copyButtonPressed(sender: UIButton!) {
    
        UIPasteboard.generalPasteboard().string = movesField.text
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.copyB.frame.size.width += 16
            self.copyB.frame.origin.x -= 8
            self.copyB.setTitle("Copied", forState: .Normal)
            self.copyB.backgroundColor = UIColor.lightGrayColor()
            self.copyB.userInteractionEnabled = false

            }, completion: {finish in
        
        
        })
        
        
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
