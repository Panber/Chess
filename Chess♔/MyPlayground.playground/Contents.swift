//: Playground - noun: a place where people can play

//only testsss

import UIKit
import Darwin

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


// MARK: Rating calc
///////

    //  ----- the parameters -----
    //  wR  = whiteRating before
    //  bR  = blacRating before
    //  K   = K-factor, how much the rating will impact
    //  sW  = scoreWhite -> 1 , 0.5 or 0 , depending on who won
    //  sB  = scoreblack -> 1 , 0.5 or 0 , depending on who won
    //  ----- the calculation -----
    //  wR_2 = tranformed whiteRating, part of the calcultaion
    //  bR_2 = tranformed blackRating, part of the calcultaion
    //  ExW  = expected whiteRating after based on whiteRating before
    //  ExB  = expected blackRating after based on blackRating before
    //  wR_2 = final calculation of whiteScore
    //  bR_2 = final calculation of blackScore

//  function to raise number
infix operator ^^ { }
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

//calculateRating to calculate rating of players
func calculateRating(wR:Double, bR:Double, K:Double, sW:Double, sB:Double) -> (Int,Int) {

    var wR_2 = Double(10^^(Int(wR / 400)))
    var bR_2 = Double(10^^(Int(bR / 400)))
    
    let ExW:Double = wR_2/(wR_2 + bR_2)
    let ExB:Double = bR_2/(wR_2 + bR_2)
    
    wR_2 = wR+(K*(sW - ExW))
    bR_2 = bR+(K*(sB - ExB))

    return (Int(wR_2) , Int(bR_2))
}

let rating = calculateRating(1000, bR: 1000, K: 32, sW: 1, sB: 0)

//print whiteRating
let whiteRating = rating.0
print("whiteRating after is \(whiteRating)")

//print blackRating
let blackRating = rating.1
print("blackRating after is \(blackRating)")





////////



let Rating = calculateRating(Double(900), bR: Double(1200), K: 32, sW: 1, sB: 0)
Rating.0
Rating.1
let nowRating = 1200
let addRating = Rating.0 - 1200

print("me addrating is \(addRating) and nowRating is  \(nowRating) and both are \(addRating+nowRating)")
print("other addrating is \(Rating.1 - 900) and nowRating is  \(843) and both are \(843+Rating.1 - 900)")















