//
//  GameInterFace2.swift
//  Chess♔
//
//  Created by Johannes Berge on 24/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//



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

//y-axis
let _1 = screenHeight/2 + 3 * square
let _2 = screenHeight/2 + 2 * square
let _3 = screenHeight/2 + 1 * square
let _4 = screenHeight/2
let _5 = screenHeight/2 - 1 * square
let _6 = screenHeight/2 - 2 * square
let _7 = screenHeight/2 - 3 * square
let _8 = screenHeight/2 - 4 * square


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

import UIKit
import Parse

class GameInterFace2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //If EXISTING GAME, then load all positions of pieces from the cloud
        var boardState = PFObject(className: "BoardState4")
        boardState["wPawn1X"] = 1
        boardState["wPawn1Y"] = screenHeight/2 + 2 * square
        boardState["pieceID"] = wPawn1_id
        boardState.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                ojId = String(boardState.objectId)
                print("the oj in the load is \(ojId)")
                
            }
        }

        
        var query = PFQuery(className:"BoardState4")
        query.getObjectInBackgroundWithId("5IRfGX02gR") {
            (boardState: PFObject?, error: NSError?) -> Void in
            if error == nil && boardState != nil {
                print("the boardstate is \(boardState)")
                
                wPawn1.frame.origin.x = CGFloat((boardState?.objectForKey("wPawn1X"))! as! NSNumber)
                
            } else {
                print(error)
            }
        }
            
        
    
        print("the oj is\(boardState.objectId)")
        print(boardState.objectId)
        print(boardState.objectForKey("wPawn1Y"))
        
        //else is NEW GAME, then load all pieces to view and do additional setup
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

        // MARK: - Touches began! 👆
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch!
    
        for var i = 0; i < wPieces.count; i++ {
    
            if touch.view == wPieces[i] {
                
                print("touches began!!")
                movePiece(wPieces[i])
                return
            }
            print("2")
    
        }
        print("3")

        
        }
    
    func movePiece(piece: UIImageView) {
        
        UIView.animateWithDuration(1.0, animations: {
                piece.frame.origin.x = CGFloat(100)
                piece.frame.origin.y =  CGFloat(200)
            
            }, completion: {Void in
        
        })
    
    }

}
