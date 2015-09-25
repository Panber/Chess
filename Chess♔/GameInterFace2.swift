//
//  GameInterFace2.swift
//  Chess♔
//
//  Created by Johannes Berge on 24/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

var square = sqrt(screenWidth * screenWidth / 64)

//x-axis
var a: CGFloat = 0
var b = square * 2
var c = square * 3
var d = square * 4
var e = square * 5
var f = square * 6
var g = square * 7
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
var wRook1_id = 9
var wRook2_id = 10
var wKnight1_id = 11
var wKnight2_id = 12
var wBishop1_id = 13
var wBishop2_id = 14
var wQueen1_id = 15
var wKing1_id = 16

var wPieces_ids = [wPawn1_id,wPawn2_id,wPawn3_id,wPawn4_id,wPawn5_id,wPawn6_id,wPawn7_id,wPawn8_id,wRook1_id,wRook2_id,wKnight1_id,wKnight2_id,wBishop1_id,wBishop2_id,wQueen1_id,wKing1_id]



import UIKit

class GameInterFace2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //If EXISTING GAME, then load all positions of pieces from the cloud
        
        
        
        //else is NEW GAME, then load all pieces to view and do additional setup
        for var i = 0; i < wPieces.count; i++ {
                wPieces[i].userInteractionEnabled = true
                let _view = wPieces[i]
                let image = UIImage(named: "whitePawn.png")
                wPieces[i].image = image
                view.addSubview(_view)
        
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
                print("1")
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
