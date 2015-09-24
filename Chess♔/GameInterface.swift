//
//  GameInterface.swift
//  Chess♔
//
//  Created by Johannes Berge on 04/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

//coulors
let white = "white"; let black = "black"

//pieces
let pawn = "pawn"; let rook = "rook"; let knight = "knight";
let bishop = "bishop"; let queen = "queen"; let king = "king"

//positions
var positionX = 0; var positionY = 0

//variable to find piecetomove
var pieceToMove = [""]


//remember that wpawn1 will not be changed if you change wPawn
//piece-Ids for white pawns
var wPawn1 = [white,pawn,"1","1","2"]
var wPawn2 = [white,pawn,"2","2","2"]
var wPawn3 = [white,pawn,"3","3","2"]
var wPawn4 = [white,pawn,"4","4","2"]
var wPawn5 = [white,pawn,"5","5","2"]
var wPawn6 = [white,pawn,"6","6","2"]
var wPawn7 = [white,pawn,"7","7","2"]
var wPawn8 = [white,pawn,"8","8","2"]

var wPawn = [wPawn1,wPawn2,wPawn3,wPawn4,wPawn5,wPawn6,wPawn7,wPawn8]



class GameInterface: UIViewController {

    @IBOutlet weak var pawnTest: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadNewGame()
        movePiece(white, piece: pawn, id: 1, toX: 100, toY: 0)
        // Do any additional setup after loading the view.
    }

// MARK: -TEsting something new

    
    //remember that wpawn1 will not be changed if you change wPawn
    //func to moev piece
    func movePiece(colour: String, piece:String,id: Int, toX:Int, toY:Int) {
        
        if colour == white {
            
            if piece == pawn {
                
                wPawn[id][3] = String(toX)
                wPawn[id][4] = String(toY)
                
                pieceToMove = wPawn[id]
                
                print(wPawn[id])
            }
            
        }
        
        UIView.animateWithDuration(5.0, animations: {
            //move piece
            self.pawnTest.frame.origin.x += CGFloat(toX)
            
            
        })
        
    }
  
    
// MARK: -Some Functions that could be used
    
    //func to moev piece
//    func movePiece( piece:String, x:Int, y:Int) {
//    
//        UIView.animateWithDuration(1.0, animations: {
//            //move piece
//        })
//        
//    }
    
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
        
        let image = UIImage(named: "whitePawn.png")
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        view.addSubview(imageView)
    
    }
    
    
    
    // MARK: - Touches began! 👆
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        let touch = touches.first as UITouch!
        
        if touch.view == pawnTest {
            
            print("touches began!!")

                movePiece(white, piece: pawn, id: 1, toX: 500, toY: 0)
        
            }
        
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
