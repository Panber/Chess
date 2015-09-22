//: Playground - noun: a place where people can play

//only testsss

import UIKit


var wPawn1 = ["pawn","1","white","1","2"]
let rook = "rook"
let knight = "knight"
let bishop = "bishop"
let queen = "queen"
let king = "king"

var positionX = 0
var positionY = 0


//chek if move is possible
func isMoveLegal() {


}

//func to moev piece
func movePiece( piece:String,id: String, colour: String,toX:Int, toY:Int) {
    
    if colour == "white" {
        
        if piece == "pawn" {
            
            for var i = 0; i < 8; i++ {
                if id == "\(i)" {
                    
                    wPawn1[3] = String(toX)
                    wPawn1[4] = String(toY)
                    print(wPawn1)
return
                }
            
            }
        }
        
    }

    UIView.animateWithDuration(1.0, animations: {
        //move piece
        
    })
    
}
movePiece("pawn", id: "1", colour: "white", toX: 8, toY: 5)

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
    