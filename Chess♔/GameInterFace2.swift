//
//  GameInterFace2.swift
//  Chess♔
//
//  Created by Johannes Berge on 24/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

var boardState = PFObject(className: "BoardState")


var square = sqrt(screenWidth * screenWidth / 64)

//x-axis
var a: CGFloat = square - square
var b = square
var c = square * 2
var d = square * 3
var e = square * 4
var f = square * 5
var g = square * 6
var h = square * 7

var xCoordinates = [a,b,c,d,e,f,g,h]

//y-axis
let _1 = screenHeight/2 + 3 * square
let _2 = screenHeight/2 + 2 * square
let _3 = screenHeight/2 + 1 * square
let _4 = screenHeight/2
let _5 = screenHeight/2 - 1 * square
let _6 = screenHeight/2 - 2 * square
let _7 = screenHeight/2 - 3 * square
let _8 = screenHeight/2 - 4 * square

var yCoordinates = [_1,_2,_3,_4,_5,_6,_7,_8]

//All pieces
var wPawn1 = UIImageView(frame: CGRectMake(a, _2, square, square))
var wPawn2 = UIImageView(frame: CGRectMake(b, _2, square, square))
var wPawn3 = UIImageView(frame: CGRectMake(c, _2, square, square))
var wPawn4 = UIImageView(frame: CGRectMake(d, _2, square, square))
var wPawn5 = UIImageView(frame: CGRectMake(e, _2, square, square))
var wPawn6 = UIImageView(frame: CGRectMake(f, _2, square, square))
var wPawn7 = UIImageView(frame: CGRectMake(g, _2, square, square))
var wPawn8 = UIImageView(frame: CGRectMake(h, _2, square, square))
var wRook1 = UIImageView(frame: CGRectMake(a, _1, square , square))
var wRook2 = UIImageView(frame: CGRectMake(h, _1, square, square))
var wKnight1 = UIImageView(frame: CGRectMake(b, _1, square, square))
var wKnight2 = UIImageView(frame: CGRectMake(g, _1, square, square))
var wBishop1 = UIImageView(frame: CGRectMake(c, _1, square, square))
var wBishop2 = UIImageView(frame: CGRectMake(f, _1, square, square))
var wQueen1 = UIImageView(frame: CGRectMake(d, _1, square, square))
var wKing1 = UIImageView(frame: CGRectMake(e, _1, square, square))

var wPieces = [wPawn1,wPawn2,wPawn3,wPawn4,wPawn5,wPawn6,wPawn7,wPawn8,wRook1,wRook2,wKnight1,wKnight2,wBishop1,wBishop2,wQueen1,wKing1]

var wPiecesX = ["wPawn1X","wPawn2X","wPawn3X","wPawn4X","wPawn5X","wPawn6X","wPawn7X","wPawn8X","wRook1X","wRook2X","wKnight1X","wKnight2X","wBishop1X","wBishop2X","wQueen1X","wKing1X"]
var wPiecesY = ["wPawn1Y","wPawn2Y","wPawn3Y","wPawn4Y","wPawn5Y","wPawn6Y","wPawn7Y","wPawn8Y","wRook1Y","wRook2Y","wKnight1Y","wKnight2Y","wBishop1Y","wBishop2Y","wQueen1Y","wKing1Y"]

//variables so set up positions from cloud. needed to times with variable
var wPiecesXint = [0,1,2,3,4,5,6,7,0,7,1,6,2,5,3,4]
var wPiecesYint = [2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3]


//all Pieces IDS
var wPawn1_id = 1
var wPawn2_id = 2
var wPawn3_id = 3
var wPawn4_id = 4
var wPawn5_id = 5
var wPawn6_id = 6
var wPawn7_id = 7
var wPawn8_id = 8
var wRook1_id = 101
var wRook2_id = 102
var wKnight1_id = 201
var wKnight2_id =  202
var wBishop1_id = 301
var wBishop2_id = 302
var wQueen1_id = 401
var wKing1_id = 501

var wPieces_ids = [wPawn1_id,wPawn2_id,wPawn3_id,wPawn4_id,wPawn5_id,wPawn6_id,wPawn7_id,wPawn8_id,wRook1_id,wRook2_id,wKnight1_id,wKnight2_id,wBishop1_id,wBishop2_id,wQueen1_id,wKing1_id]

var ojId = ""

let gameID = NSUserDefaults.standardUserDefaults().stringArrayForKey("game_with")


import UIKit
import Parse

class GameInterFace2: UIViewController {

    @IBOutlet weak var boardImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
        
        //check if new game or not
        if NSUserDefaults.standardUserDefaults().boolForKey("created_New_Game") == true {
            loadNewGame()
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "created_New_Game")
            print("creted new game = true")
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("created_New_Game") == false {
            retrieveBoardFromCloud()
            print("creted new game = false")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //func to load new game
    func loadNewGame() {
        
        //setting board state
        for var i = 0; i < wPiecesX.count; i++ {
            boardState[wPiecesX[i]] = wPiecesXint[i]
            boardState[wPiecesY[i]] = wPiecesYint[i]
        }
        boardState["GameWith"] = (PFUser.currentUser()?.username)! + ""
        
        boardState.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                ojId = String(boardState.objectId)
                print("the oj in the load is \(ojId)")
                for var i = 0; i < wPieces.count; i++ {
                    UIView.animateWithDuration(1, animations: {
                        wPieces[i].frame.origin.x = CGFloat((boardState.objectForKey(wPiecesX[i]))! as! NSNumber) * square
                        wPieces[i].frame.origin.y = CGFloat((boardState.objectForKey(wPiecesY[i]))! as! NSNumber) * square + (screenHeight/2)
                        }
                    )}
             self.saveBoardToCloud()
                
                NSUserDefaults.standardUserDefaults().setObject(ojId, forKey: "game_with_")
            }
        }
        
        //Add pieces to view
        for var i = 0; i < wPieces.count; i++ {
            
            wPieces[i].userInteractionEnabled = true
            let _view = wPieces[i]
            
            if wPieces_ids[i] > 0 && wPieces_ids[i] < 100 {
                
                let image = UIImage(named: "whitePawn.png")
                wPieces[i].image = image
                view.addSubview(_view)
            }
            else if wPieces_ids[i] > 100 && wPieces_ids[i] < 200 {
                
                let image = UIImage(named: "whiteRook.png")
                wPieces[i].image = image
                view.addSubview(_view)
            }
            else if wPieces_ids[i] > 200 && wPieces_ids[i] < 300 {
                
                let image = UIImage(named: "whiteKnight.png")
                wPieces[i].image = image
                view.addSubview(_view)
            }
            else if wPieces_ids[i] > 300 && wPieces_ids[i] < 400 {
                
                let image = UIImage(named: "whiteBishop.png")
                wPieces[i].image = image
                view.addSubview(_view)
            }
            else if wPieces_ids[i] > 400 && wPieces_ids[i] < 500 {
                
                let image = UIImage(named: "whiteQueen.png")
                wPieces[i].image = image
                view.addSubview(_view)
            }
            else if wPieces_ids[i] > 500 && wPieces_ids[i] < 600 {
                
                let image = UIImage(named: "whiteKing.png")
                wPieces[i].image = image
                view.addSubview(_view)
            }
        }
    }


    //retrieve board from cloud
    func retrieveBoardFromCloud() {
        
        //you should rather store the piece moved in a collum called "pieces moved", and then limit the search this way in order to make more efficient code to parse
        
        
        let query = PFQuery(className:"BoardState")
        query.whereKey("GameWith", equalTo:"b3rge")

        query.findObjectsInBackgroundWithBlock {
            (boardState: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil && boardState != nil {
                print("the boardstate is \(boardState)")
                
                if let boardState = boardState as? [PFObject] {
                    for boardState in boardState {
                        
                        for var i = 0; i < wPieces.count; i++ {
                            UIView.animateWithDuration(1, animations: {
                                wPieces[i].frame.origin.x = CGFloat((boardState.objectForKey(wPiecesX[i]))! as! NSNumber) * square
                                wPieces[i].frame.origin.y = CGFloat((boardState.objectForKey(wPiecesY[i]))! as! NSNumber) * square + (screenHeight/2)
                                
                                }
                            )}
                        
                    }
                }
                

                
            } else {
                print(error)
            }
        }
        
//        let query = PFQuery(className:"BoardState")
//        
//        query.getObjectInBackgroundWithId("aqmUTFRLSL") {
//            (boardState: PFObject?, error: NSError?) -> Void in
//            if error == nil && boardState != nil {
//                print("the boardstate is \(boardState)")
//                
//                for var i = 0; i < wPieces.count; i++ {
//                    UIView.animateWithDuration(1, animations: {
//                        wPieces[i].frame.origin.x = CGFloat((boardState?.objectForKey(wPiecesX[i]))! as! NSNumber) * square
//                        wPieces[i].frame.origin.y = CGFloat((boardState?.objectForKey(wPiecesY[i]))! as! NSNumber) * square + (screenHeight/2)
//                }
//                )}
//                
//            } else {
//                print(error)
//            }
//        }
    }
    
    //save existing board to cloud
    func saveBoardToCloud() {
        
        let query = PFQuery(className:"BoardState")
        query.whereKey("GameWith", equalTo:"b3rge")
        
        query.findObjectsInBackgroundWithBlock {
            (boardState: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil {
                print(error)
            }
            
            if let boardState = boardState as? [PFObject] {
                for boardState in boardState {
                
                for var i = 0; i < wPiecesX.count; i++ {
                    
                    if  wPieces[i].frame.origin.x == a  {
                        boardState[wPiecesX[i]] = 0
                    }
                    else if  wPieces[i].frame.origin.x == b  {
                        boardState[wPiecesX[i]] = 1
                    }
                    else if  wPieces[i].frame.origin.x == c  {
                        boardState[wPiecesX[i]] = 2
                    }
                    else if  wPieces[i].frame.origin.x == d  {
                        boardState[wPiecesX[i]] = 3
                    }
                    else if  wPieces[i].frame.origin.x == e  {
                        boardState[wPiecesX[i]] = 4
                    }
                    else if  wPieces[i].frame.origin.x == f  {
                        boardState[wPiecesX[i]] = 5
                    }
                    else if  wPieces[i].frame.origin.x == g  {
                        boardState[wPiecesX[i]] = 6
                    }
                    else if  wPieces[i].frame.origin.x == h  {
                        boardState[wPiecesX[i]] = 7
                    }

                    if wPieces[i].frame.origin.y == _1 {
                        boardState[wPiecesY[i]] = 3
                    }
                    else if wPieces[i].frame.origin.y == _2 {
                        boardState[wPiecesY[i]] = 2
                    }
                    else if wPieces[i].frame.origin.y == _3 {
                        boardState[wPiecesY[i]] = 1
                    }
                    else if wPieces[i].frame.origin.y == _4 {
                        boardState[wPiecesY[i]] = 0
                    }
                    else if wPieces[i].frame.origin.y == _5 {
                        boardState[wPiecesY[i]] = -1
                    }
                    else if wPieces[i].frame.origin.y == _6 {
                        boardState[wPiecesY[i]] = -2
                    }
                    else if wPieces[i].frame.origin.y == _7 {
                        boardState[wPiecesY[i]] = -3
                    }
                    else if wPieces[i].frame.origin.y == _8 {
                        boardState[wPiecesY[i]] = -4
                    }
                    
                }
                
                boardState.saveInBackground()
            }
            
        }
    }
    }
    
    //move piece
    func movePiece(piece: UIImageView) {
        
        UIView.animateWithDuration(1.0, animations: {
                piece.frame.origin.x = h
                piece.frame.origin.y = _8
            
            }, completion: {Void in
        
        })
    }
    
    // MARK: - Touches began! 👆
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
        
        for var i = 0; i < wPieces.count; i++ {
          
            if touch.view == wPieces[i] {
                
                print("touches began!!")
                movePiece(wPieces[i])
                return
            }
        }
    }
    
    @IBAction func loadBoard(sender: AnyObject) {
        retrieveBoardFromCloud()
    }
    
    @IBAction func submitMove(sender: AnyObject) {
        saveBoardToCloud()
    }
    
    // MARK: - BLACK OR WHITE
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
