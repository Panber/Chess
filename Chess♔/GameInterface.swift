//
//  GameInterface.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class GameInterface: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

// MARK: -Some Functions that could be used
    
    //func to moev piece
    func movePiece( piece:String, x:Int, y:Int) {
    
        UIView.animateWithDuration(1.0, animations: {
            //move piece
        })
        
    }
    
    //func to load previous positions adn information
    func updateBoardWithPositionsAndInformation() {
    
    }
    
    //func to remove piece after capture
    func removePieceAfterCapture() {
    
    }
    
    //func to update the score
    func updateScore() {
    
    }
    
    //func to load new game
    func loadNewGame() {
    
    }
    
    
    
// MARK: -light or dark
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
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
                self.tabBarController?.tabBar.tintColor = UIColor.blueColor()
                self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
                
                
                        
        }
        
        
    }


}
