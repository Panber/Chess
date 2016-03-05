//
//  Legal.swift
//  Chess♔
//
//  Created by Johannes Berge on 23/11/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit

class Legal: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(screenWidth, 1000)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.delegate = self
     
        
        var movesField = UITextView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        movesField.text = "// PANBER SOFTWARE: ALEXANDER PANAYOTOV -- JOHANNES BERGE // Pieces designed by Gyan Lakhwani from the Noun Project // Some images from http://www.flaticon.com/… // NO COPYRIGHT INFRINGEMENTS INTENDED // CHESS BY PANBER SOFTWARE COPYRIGHT © 2016"
        movesField.font = UIFont(name: "Times", size: 19)
        movesField.backgroundColor = UIColor.clearColor()
        if darkMode {movesField.textColor = UIColor.whiteColor()}
        else {movesField.textColor = UIColor.blackColor() }
        movesField.userInteractionEnabled = true
        movesField.editable = false
        print(movesField.userActivity)
        scrollView.addSubview(movesField)
        
        
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
            
            scrollView.backgroundColor = UIColor(red: 0.20, green: 0.20 , blue: 0.20, alpha: 1)
            
            
            
        }
        else if darkMode == false {
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            scrollView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            
            
        }
        
    }


}
