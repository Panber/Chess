//: Playground - noun: a place where people can play

//only testsss

import UIKit

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


//chek if move is possible
func isMoveLegal() {

}



//remember that wpawn1 will not be changed if you change wPawn
//func to moev piece
func movePiece(colour: String, piece:String,id: Int, toX:Int, toY:Int) {
    
    if colour == "white" {
        
        if piece == "pawn" {
            
                    wPawn[id][3] = String(toX)
                    wPawn[id][4] = String(toY)
            
                    pieceToMove = wPawn[id]
            
                    print(wPawn[id])
            }
        
    }

    UIView.animateWithDuration(1.0, animations: {
        //move piece
        
        
        
    })
    
}

wPawn

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

var arra: Array<String> = []

















