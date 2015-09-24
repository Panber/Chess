//: Playground - noun: a place where people can play

//only testsss

import UIKit


var wPawn1 = ["pawn","1","white","1","2"]
let rook = "rook"
let knight = "knight"
let bishop = "bishop"
let queen = "queen"
let king = "king"

var wPawn = [wPawn1]

var positionX = 0
var positionY = 0


//chek if move is possible
func isMoveLegal() {


}

var id = "1"
var toX = 9
var toY = 8

        
        wPawn[0][3] = String(toX)
        wPawn[0][4] = String(toY)
        
        wpawn1 
        
        wPawn

wPawn1
//func to moev piece
func movePiece( piece:String,id: String, colour: String,toX:Int, toY:Int) {
    
    if colour == "white" {
        
        if piece == "pawn" {
            
            for var i = -1; i <= wPawn.count; i++ {
                if id == "\(i)" {
                    
                    wPawn[i][3] = String(toX)
                    wPawn[i][4] = String(toY)
                    
                    wPawn1
                    
                }
            
            }
        }
        
    }

    UIView.animateWithDuration(1.0, animations: {
        //move piece
        
    })
    
}

wPawn

movePiece("pawn", id: "1", colour: "white", toX: 6, toY: 0)
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
    
