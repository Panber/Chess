//
//  ViewController.swift
//  ChessNow
//
//  Created by Johannes Berge on 21/11/14.
//  Copyright (c) 2014 Johannes Berge & Alexander Panayotov. All rights reserved.
//

import UIKit
import SpriteKit
import Firebase
import AudioToolbox
import Social
import Darwin


extension String
{
    subscript(integerIndex: Int) -> Character {
        let index = startIndex.advancedBy(integerIndex)
        return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
}

//        //  function to raise number
infix operator ^^ { }
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}



var game = PFObject(className: "Games")
var notations: Array<String> = []

let pieceSize = sqrt(screenWidth * screenWidth / 64)

var notationsWithNumber = ""

//x-Axis coordinates
let a:CGFloat = 0 * pieceSize
let b =  pieceSize
let c = 2 * pieceSize
let d = 3 * pieceSize
let e = 4 * pieceSize
let f = 5 * pieceSize
let g = 6 * pieceSize
let h = 7 * pieceSize

let xAxisArr = [a,b,c,d,e,f,g,h]


//y-Axis coordinates
let _1 = screenHeight/2 + 3 * pieceSize
let _2 = screenHeight/2 + 2 * pieceSize
let _3 = screenHeight/2 + 1 * pieceSize
let _4 = screenHeight/2
let _5 = screenHeight/2 - 1 * pieceSize
let _6 = screenHeight/2 - 2 * pieceSize
let _7 = screenHeight/2 - 3 * pieceSize
let _8 = screenHeight/2 - 4 * pieceSize

let yAxisArr = [_1,_2,_3,_4,_5,_6,_7,_8]


var xAxisArrStr = ["a","b","c","d","e","f","g","h"]
var yAxisArrStr = ["1","2","3","4","5","6","7","8"]
var pieceString = ""
var xAxisArrStr2 = ["a","b","c","d","e","f","g","h"]
var yAxisArrStr2 = ["1","2","3","4","5","6","7","8"]
var pieceStringPos = ""
var piecesNotationSeperator = "-"
var chessNotationCheck = ""
var chessNotationx = ""
var chessNotationy = ""

let yAxisArrq = [_8,_7,_6,_5,_4,_3,_2,_1]
let xAxisArrq = [h,g,f,e,d,c,b,a]

// This is for taken pieces
var takenWhitePieces : Array<UIImageView> = []
var takenBlackPieces : Array<UIImageView> = []
// This is for taken pieces
var takenWhitePiecesForMove : Array<UIImageView> = []
var takenBlackPiecesForMove : Array<UIImageView> = []

var takenWhitePiecesForInfo : Array<UIImageView> = []
var takenBlackPiecesForInfo : Array<UIImageView> = []

var takenPiece = UIImageView()

var blackPawnCount = 0
var blackBishopCount = 0
var blackKnightCount = 0
var blackRookCount = 0
var blackQueenCount = 0

var blackCount : Array<Int> = [blackPawnCount,blackBishopCount,blackKnightCount,blackRookCount,blackQueenCount]


var takenBlackPawn = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenBlackBishop = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenBlackKnight = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenBlackRook = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenBlackQueen = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))


var takenBlackPiecesLbl :Array<UILabel> = [takenBlackPawn, takenBlackBishop, takenBlackKnight, takenBlackRook, takenBlackQueen]
var takenBlackPiecesShow :Array<UILabel> = []

var blackPiecesTypes = ["blackPawn","blackBishop","blackKnight","blackRook", "blackQueen"]

var whitePawnCount = 0
var whiteBishopCount = 0
var whiteKnightCount = 0
var whiteRookCount = 0
var whiteQueenCount = 0

var whiteCount : Array<Int> = [whitePawnCount,whiteBishopCount,whiteKnightCount,whiteRookCount,whiteQueenCount]


var takenWhitePawn = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 - 4.7 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenWhiteBishop = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 - 4.7 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenWhiteKnight = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 - 4.7 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenWhiteRook = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 - 4.7 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))
var takenWhiteQueen = UILabel(frame: CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50, screenHeight / 2 - 4.7 * pieceSize + pieceSize * 0.3, pieceSize * 0.65, pieceSize * 0.65))

var takenWhitePiecesLbl :Array<UILabel> = [takenWhitePawn, takenWhiteBishop, takenWhiteKnight, takenWhiteRook, takenWhiteQueen]
var takenWhitePiecesShow :Array<UILabel> = []

var whitePiecesTypes = ["whitePawn","whiteBishop","whiteKnight","whiteRook", "whiteQueen"]

// move only one colour
var canOnlyMoveWhite = true

// Collection view
class MoveCell: UICollectionViewCell {
    
    var notation = UILabel()
    
    func configureWithColor() {
        
        if darkMode == true {
            
            backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            notation.textColor = UIColor.whiteColor()
            notation.font = UIFont(name: "Times", size: 16)
        } else if darkMode == false {
            backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            notation.textColor = UIColor.blackColor()
            notation.font = UIFont(name: "Times", size: 16)
        }
        self.addSubview(notation)
    }
}

class Game: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var shouldLoadGameFinished = false
    var typeOfGameFinished = ""
    
    var promotionAtIndex: Array<Int> = []
    
    
    var iamWhite = Bool()
    
    var takenPiecesToReload: Array<UIImageView> = []
    var takenPiecesToReloadAtIndex: Array<Int> = []
    
    var pointsStorage: Array<Double> = []
    var points = Double()
    
    var movesCap: Array<String> = []
    
    var slider = UISlider()
    var capsuleB = UIButton()
    var capsuleL = UILabel()
    
    var forwardB = UIButton()
    var backwardB = UIButton()
    
    var meImage = UIImageView()
    var otherImage = UIImageView()
    
    var collectionView: UICollectionView!
    
    var piecesToDelete: Array<UIImageView> = []
    
    var game = PFObject(className: "Games")
    var notations: Array<String> = []
    
    var whitePromotionType: Array<String> = []
    var blackPromotionType: Array<String> = []
    
    var moveNum: Array<Int> = []
    
    var LAN = ""
    
    var canTake: Bool = true
    
    var size : CGFloat = pieceSize
    
    var otherUserImage = UIImage()
    var otherUserName = ""
    var otherUserRating = ""
    var otherUserRatingInt = Int()
    
    var otherUserWon = Int()
    var otherUserLost = Int()
    var otherUserDrawn = Int()

    
    
    var meUserImage = UIImage()
    
    var meUserName = ""
    var meUserRating = ""
    var meUserRatingInt = Int()
    
    var meUserWon = Int()
    var meUserLost = Int()
    var meUserDrawn = Int()


    
    
    //BOARDER
    let boarderBoard = UIImageView(frame: CGRectMake(-0.01*pieceSize, _1 - 7*pieceSize, 8*pieceSize, 8*pieceSize))
    
    
    //timers
    var timerNumber:Double = 0
    var movementTimer = NSTimer()
    
    //markers
    var pieceMarked = UIImageView(frame: CGRectMake(0, 0, pieceSize, pieceSize))
    var pieceOptions : Array<UIImageView> = []
    
    // Logic pieces caslte by white king
    var leftWhiteCastleLogic : Array<UIImageView> = []
    var rightWhiteCastleLogic : Array<UIImageView> = []
    
    // Logic pieces caslte by black king
    var leftBlackCastleLogic : Array<UIImageView> = []
    var rightBlackCastleLogic : Array<UIImageView> = []
    
    var whiteCastlingLeft : Array<UIImageView> = []
    var whiteCastlingRight : Array<UIImageView> = []
    
    var blackCastlingLeft : Array<UIImageView> = []
    var blackCastlingRight : Array<UIImageView> = []
    
    
    // Logic options for all pieces
    var pieceWhiteLogicOptions: Array<UIImageView> = []
    var pieceBlackLogicOptions: Array<UIImageView> = []
    
    // Logic options to check if piece can move if king is in danger
    var pieceWhiteCanMove: Array<UIImageView> = []
    var pieceBlackCanMove: Array<UIImageView> = []
    
    // Logic options for Queen, Bishop and Rook
    var queenLogicOptions : Array<UIImageView> = []
    var bishopLogicOptions : Array<UIImageView> = []
    var rookLogicOptions : Array<UIImageView> = []
    var knightLogicOptions : Array<UIImageView> = []
    var pawnLogicOptions : Array<UIImageView> = []
    
    //
    var blackPieceLogic: Array<UIImageView> = []
    var whitePieceLogic: Array<UIImageView> = []
    
    // Decides who makes check
    var checkByWhite = false
    var checkByBlack = false
    
    var checkByQueen = false
    var checkByBishop = false
    var checkByRook = false
    var checkByPawn = false
    var checkByKnight = false
    
    var foundKing: Bool = false
    
    // Used in check logic to see if pieces are vertically aligned
    var verticallyAlignedWhite = false
    var horizontallyAlignedWhite = false
    
    var verticallyAlignedBlack = false
    var horizontallyAlignedBlack = false
    
    // Castling White
    var hasWhiteRookMoved = false
    var hasWhiteRookMoved2 = false
    var hasWhiteKingMoved = false
    var whiteCastle = false
    var castleLeft = false
    var castleRight = false
    
    // Castling Black
    var hasBlackRookMoved = false
    var hasBlackRookMoved2 = false
    var hasBlackKingMoved = false
    var blackCastle = false
    
    //chesspieces:
    var whitePawn1 = UIImageView(frame: CGRectMake(a, _2, pieceSize , pieceSize))
    var whitePawn2 = UIImageView(frame: CGRectMake(b, _2, pieceSize, pieceSize))
    var whitePawn3 = UIImageView(frame: CGRectMake(c, _2, pieceSize , pieceSize))
    var whitePawn4 = UIImageView(frame: CGRectMake(d, _2, pieceSize, pieceSize))
    var whitePawn5 = UIImageView(frame: CGRectMake(e, _2, pieceSize , pieceSize))
    var whitePawn6 = UIImageView(frame: CGRectMake(f, _2, pieceSize, pieceSize))
    var whitePawn7 = UIImageView(frame: CGRectMake(g, _2, pieceSize , pieceSize))
    var whitePawn8 = UIImageView(frame: CGRectMake(h, _2, pieceSize, pieceSize))
    
    var selectedPawn = 0
    var pieceOpt = UIImageView()
    
    // Check piece
    var checkByPiece  = UIImageView()
    
    var whiteKnight1 = UIImageView(frame: CGRectMake(b, _1, pieceSize, pieceSize))
    var whiteKnight2 = UIImageView(frame: CGRectMake(g, _1, pieceSize, pieceSize))
    
    var whiteBishop1 = UIImageView(frame: CGRectMake(c, _1, pieceSize, pieceSize))
    var whiteBishop2 = UIImageView(frame: CGRectMake(f, _1, pieceSize, pieceSize))
    
    
    var whiteRook1 = UIImageView(frame: CGRectMake(h, _1, pieceSize, pieceSize))
    var whiteRook2 = UIImageView(frame: CGRectMake(a, _1, pieceSize, pieceSize))
    
    
    var whiteQueen = UIImageView(frame: CGRectMake(d, _1, pieceSize, pieceSize))
    
    var whiteKing = UIImageView(frame: CGRectMake(e, _1, pieceSize, pieceSize))
    
    var blackPawn1 = UIImageView(frame: CGRectMake(a, _7, pieceSize, pieceSize))
    var blackPawn2 = UIImageView(frame: CGRectMake(b, _7, pieceSize, pieceSize))
    var blackPawn3 = UIImageView(frame: CGRectMake(c ,_7, pieceSize, pieceSize))
    var blackPawn4 = UIImageView(frame: CGRectMake(d, _7, pieceSize, pieceSize))
    var blackPawn5 = UIImageView(frame: CGRectMake(e, _7, pieceSize, pieceSize))
    var blackPawn6 = UIImageView(frame: CGRectMake(f, _7, pieceSize, pieceSize))
    var blackPawn7 = UIImageView(frame: CGRectMake(g, _7, pieceSize, pieceSize))
    var blackPawn8 = UIImageView(frame: CGRectMake(h, _7, pieceSize, pieceSize))
    
    var blackKnight1 = UIImageView(frame: CGRectMake(b, _8, pieceSize, pieceSize))
    var blackKnight2 = UIImageView(frame: CGRectMake(g, _8, pieceSize, pieceSize))
    
    var blackBishop1 = UIImageView(frame: CGRectMake(c, _8, pieceSize, pieceSize))
    var blackBishop2 = UIImageView(frame: CGRectMake(f, _8, pieceSize, pieceSize))
    
    var blackRook1 = UIImageView(frame: CGRectMake(a, _8, pieceSize, pieceSize))
    var blackRook2 = UIImageView(frame: CGRectMake(h, _8, pieceSize, pieceSize))
    
    var blackQueen = UIImageView(frame: CGRectMake(d, _8, pieceSize, pieceSize))
    
    var blackKing = UIImageView(frame: CGRectMake(e, _8, pieceSize, pieceSize))
    
    
    var blackKnights: Array<UIImageView> = []
    var blackBishops: Array<UIImageView> = []
    var blackRooks: Array<UIImageView> = []
    var blackPawns: Array<UIImageView> = []
    var blackQueens: Array<UIImageView> = []
    var blackKings: Array<UIImageView> = []
    
    var blackKnightsM: Array<UIImageView> = []
    var blackBishopsM: Array<UIImageView> = []
    var blackRooksM: Array<UIImageView> = []
    var blackPawnsM: Array<UIImageView> = []
    var blackQueensM: Array<UIImageView> = []
    
    var whitePawns: Array<UIImageView> = []
    var whiteKnights: Array<UIImageView> = []
    var whiteBishops: Array<UIImageView> = []
    var whiteRooks: Array<UIImageView> = []
    var whiteQueens: Array<UIImageView> = []
    var whiteKings: Array<UIImageView> = []
    
    
    var whitePawnsM: Array<UIImageView> = []
    var whiteKnightsM: Array<UIImageView> = []
    var whiteBishopsM: Array<UIImageView> = []
    var whiteRooksM: Array<UIImageView> = []
    var whiteQueensM: Array<UIImageView> = []
    
    var blackPieces: Array<UIImageView> = []
    var blackPiecesString: Array<String> = []
    var whitePieces: Array<UIImageView> = []
    var whitePiecesString: Array<String> = []
    
    
    //Must be equal!
    var piecesArrs: Array<Array<UIImageView>> = []
    var piecesString: Array<String> = []
    //
    
    var pieces: Array<UIImageView> = []
    
    var piecesWhiteLogic: Array<UIImageView> = []
    
    var piecesBlackLogic: Array<UIImageView> = []
    
    var moveByAmounty: CGFloat = 0.0
    var moveByAmountx: CGFloat = 0.0
    
    // Must be assigned to a UIImageView when created
    var selectedPiece = UIImageView()
    var eatenPieces = UIImageView()
    var pieceCanTake = UIImageView()
    var pieceToTake : Array<UIImageView> = []
    
    var increasey : CGFloat = 1;
    var increasex : CGFloat = 1;
    var piecePos : Array<UIImageView> = []
    
    var isWhiteTurn = true
    
    // bishop = 1, knight = 2, rook = 3, queen = 4, king = 5
    var pieceID = 0
    
    var castlePiece = UIImageView()
    
    // En Passant
    var blackPassant: Bool = false
    var canPassant: Bool = false
    var canPassantBlack: Bool = false
    
    var whitePassant: Bool = false
    
    var whitePassantPieces = UIImageView()
    var blackPassantPieces = UIImageView()
    
    var passantPiece: Int = 0
    
    @IBOutlet weak var infoButton: UIButton!
    
    var movesField = UITextView()
    var copyB = UIButton()
    var cancelB = UIButton()
    var turnL = UILabel()
    var colorL = UILabel()
    var speedL = UILabel()
    var ratedL = UILabel()
    var turnIndicator = UILabel()
    var colorIndicator = UILabel()
    var speedImage = UIImageView()
    var timeL = UILabel()
    var pImage = UIImageView()
    var nameL = UILabel()
    var  ratingL = UILabel()
    
    var turnLturn = "test"
    var colorLcolor = ""
    var speedLspeed = ""
    var ratedLrated = ""
    var turnIndicatorturn = UIColor()
    var colorIndicatorcolor = UIColor()
    var speedImagespeed = UIImage()
    
    var multiplySpeedWith = Double()
    var multiplySpeedWithIfNew = Double()
    
    
    var timeLeft = NSTimeInterval()
    var timer = NSTimer()
    
    var promoted = false
    
    var touchPosition : CGRect!
    
    var promotion = false
    var promotionBlack = false
    
    func loadVariablesAndConstants() {
        print("View did load!")
        //size-properties
        let pieceSize = sqrt(screenWidth * screenWidth / 64)
        
        promotionAtIndex = []
        
        
        pointsStorage = []
        
        
        
        points = Double()
        
        
        piecesToDelete = []
        
        canTake = true
        
        size = pieceSize
        
        //timers
        timerNumber = 0
        movementTimer = NSTimer()
        
        //markers
        pieceMarked = UIImageView(frame: CGRectMake(0, 0, pieceSize, pieceSize))
        pieceOptions  = []
        
        // Logic pieces caslte by white king
        leftWhiteCastleLogic  = []
        rightWhiteCastleLogic  = []
        
        // Logic pieces caslte by black king
        leftBlackCastleLogic  = []
        rightBlackCastleLogic  = []
        
        whiteCastlingLeft  = []
        whiteCastlingRight  = []
        
        blackCastlingLeft  = []
        blackCastlingRight  = []
        
        // Logic options for all pieces
        pieceWhiteLogicOptions = []
        pieceBlackLogicOptions = []
        
        // Logic options to check if piece can move if king is in danger
        pieceWhiteCanMove = []
        pieceBlackCanMove = []
        
        // Logic options for Queen, Bishop and Rook
        queenLogicOptions  = []
        bishopLogicOptions  = []
        rookLogicOptions = []
        knightLogicOptions = []
        pawnLogicOptions = []
        
        //
        blackPieceLogic = []
        whitePieceLogic = []
        
        takenBlackPieces = []
        takenWhitePieces = []
        takenBlackPiecesForInfo = []
        takenWhitePiecesForInfo = []
        takenBlackPiecesShow = []
        takenWhitePiecesShow = []
        blackPawnCount = 0
        blackBishopCount = 0
        blackKnightCount = 0
        blackRookCount = 0
        blackQueenCount = 0
        
        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
            blackCount[t] = 0
        }
        
        whitePawnCount = 0
        whiteBishopCount = 0
        whiteKnightCount = 0
        whiteRookCount = 0
        whiteQueenCount = 0
        
        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
            whiteCount[t] = 0
        }
        
        // Decides who makes check
        checkByWhite = false
        checkByBlack = false
        
        checkByQueen = false
        checkByBishop = false
        checkByRook = false
        checkByPawn = false
        checkByKnight = false
        
        // Used in check logic to see if pieces are vertically aligned
        verticallyAlignedWhite = false
        horizontallyAlignedWhite = false
        
        verticallyAlignedBlack = false
        horizontallyAlignedBlack = false
        
        // Castling White
        //        hasWhiteRookMoved = false
        //        hasWhiteRookMoved2 = false
        hasWhiteKingMoved = false
        whiteCastle = false
        castleLeft = false
        castleRight = false
        
        // Castling Black
        //        hasBlackRookMoved = false
        //        hasBlackRookMoved2 = false
        hasBlackKingMoved = false
        blackCastle = false
        
        //chesspieces:
        whitePawn1 = UIImageView(frame: CGRectMake(a, _2, pieceSize , pieceSize))
        whitePawn2 = UIImageView(frame: CGRectMake(b, _2, pieceSize, pieceSize))
        whitePawn3 = UIImageView(frame: CGRectMake(c, _2, pieceSize , pieceSize))
        whitePawn4 = UIImageView(frame: CGRectMake(d, _2, pieceSize, pieceSize))
        whitePawn5 = UIImageView(frame: CGRectMake(e, _2, pieceSize , pieceSize))
        whitePawn6 = UIImageView(frame: CGRectMake(f, _2, pieceSize, pieceSize))
        whitePawn7 = UIImageView(frame: CGRectMake(g, _2, pieceSize , pieceSize))
        whitePawn8 = UIImageView(frame: CGRectMake(h, _2, pieceSize, pieceSize))
        
        
        whiteKnight1 = UIImageView(frame: CGRectMake(b, _1, pieceSize, pieceSize))
        whiteKnight2 = UIImageView(frame: CGRectMake(g, _1, pieceSize, pieceSize))
        
        whiteBishop1 = UIImageView(frame: CGRectMake(c, _1, pieceSize, pieceSize))
        whiteBishop2 = UIImageView(frame: CGRectMake(f, _1, pieceSize, pieceSize))
        
        
        whiteRook1 = UIImageView(frame: CGRectMake(h, _1, pieceSize, pieceSize))
        whiteRook2 = UIImageView(frame: CGRectMake(a, _1, pieceSize, pieceSize))
        
        
        whiteQueen = UIImageView(frame: CGRectMake(d, _1, pieceSize, pieceSize))
        
        whiteKing = UIImageView(frame: CGRectMake(e, _1, pieceSize, pieceSize))
        
        blackPawn1 = UIImageView(frame: CGRectMake(a, _7, pieceSize, pieceSize))
        blackPawn2 = UIImageView(frame: CGRectMake(b, _7, pieceSize, pieceSize))
        blackPawn3 = UIImageView(frame: CGRectMake(c, _7, pieceSize, pieceSize))
        blackPawn4 = UIImageView(frame: CGRectMake(d, _7, pieceSize, pieceSize))
        blackPawn5 = UIImageView(frame: CGRectMake(e, _7, pieceSize, pieceSize))
        blackPawn6 = UIImageView(frame: CGRectMake(f, _7, pieceSize, pieceSize))
        blackPawn7 = UIImageView(frame: CGRectMake(g, _7, pieceSize, pieceSize))
        blackPawn8 = UIImageView(frame: CGRectMake(h, _7, pieceSize, pieceSize))
        
        blackKnight1 = UIImageView(frame: CGRectMake(b, _8, pieceSize, pieceSize))
        blackKnight2 = UIImageView(frame: CGRectMake(g, _8, pieceSize, pieceSize))
        
        blackBishop1 = UIImageView(frame: CGRectMake(c, _8, pieceSize, pieceSize))
        blackBishop2 = UIImageView(frame: CGRectMake(f, _8, pieceSize, pieceSize))
        
        blackRook1 = UIImageView(frame: CGRectMake(a, _8, pieceSize, pieceSize))
        blackRook2 = UIImageView(frame: CGRectMake(h, _8, pieceSize, pieceSize))
        
        blackQueen = UIImageView(frame: CGRectMake(d, _8, pieceSize, pieceSize))
        
        blackKing = UIImageView(frame: CGRectMake(e, _8, pieceSize, pieceSize))
        
        
        blackKnights = [blackKnight1, blackKnight2]
        blackBishops = [blackBishop1, blackBishop2]
        blackRooks = [blackRook1, blackRook2]
        blackPawns = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8]
        blackQueens = [blackQueen]
        blackKings = [blackKing]
        
        blackKnightsM = [blackKnight1, blackKnight2]
        blackBishopsM = [blackBishop1, blackBishop2]
        blackRooksM = [blackRook1, blackRook2]
        blackPawnsM = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8]
        blackQueensM = [blackQueen]
        
        whitePawns  = [whitePawn1, whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8]
        whiteKnights = [whiteKnight1, whiteKnight2]
        whiteBishops = [whiteBishop1, whiteBishop2]
        whiteRooks = [whiteRook1, whiteRook2]
        whiteQueens = [whiteQueen]
        whiteKings = [whiteKing]
        
        whitePawnsM  = [whitePawn1, whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8]
        whiteKnightsM = [whiteKnight1, whiteKnight2]
        whiteBishopsM = [whiteBishop1, whiteBishop2]
        whiteRooksM = [whiteRook1, whiteRook2]
        whiteQueensM = [whiteQueen]
        
        blackPieces = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
        blackPiecesString = ["blackPawn","blackPawn","blackPawn", "blackPawn", "blackPawn", "blackPawn",  "blackPawn", "blackPawn", "blackKnight", "blackKnight", "blackBishop",  "blackBishop", "blackRook", "blackRook", "blackQueen", "blackKing" ]
        whitePieces = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2 ,whiteBishop1, whiteBishop2, whiteRook1, whiteRook2 , whiteQueen, whiteKing]
        whitePiecesString = ["whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whiteKnight","whiteKnight","whiteBishop","whiteBishop","whiteRook", "whiteRook", "whiteQueen","whiteKing"]
        
        
        //Must be equal!
        piecesArrs = [whiteQueens,whiteKings,whitePawns,blackPawns,whiteKnights,whiteBishops,whiteRooks, blackKnights, blackBishops, blackRooks, blackQueens, blackKings]
        piecesString = ["whiteQueen","whiteKing","whitePawn","blackPawn","whiteKnight","whiteBishop","whiteRook", "blackKnight", "blackBishop", "blackRook", "blackQueen", "blackKing"]
        
        pieces = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen, whiteKing,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
        
        piecesWhiteLogic = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, whiteKing]
        
        piecesBlackLogic = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
        
        moveByAmounty = 0.0
        moveByAmountx = 0.0
        
        // Must be assigned to a UIImageView when created
        selectedPiece = whitePawn1
        eatenPieces = UIImageView(frame: CGRectMake(a, _2, pieceSize , pieceSize))
        pieceCanTake = whitePawn1
        pieceToTake = []
        
        
        increasey = 1
        increasex  = 1
        piecePos  = []
        
        isWhiteTurn = true
        
        castlePiece = whitePawn1
        
        // En Passant
        blackPassant = false
        canPassant = false
        canPassantBlack = false
        
        whitePassant = false
        
        whitePassantPieces = whitePawn1
        blackPassantPieces = whitePawn1
        
        selectedPawn = 0
        pieceOpt = whitePawn1
        
        // Check piece
        checkByPiece = whitePawn1
        
        // bishop = 1, knight = 2, rook = 3, queen = 4, king = 5
        pieceID = 0
        
    }
    
    
    @IBOutlet weak var chessBoard: UIImageView!
    
    var passantArray: Array<Bool> = []
    
    override func viewDidLoad() {
       
        loadVariablesAndConstants()
        
        lightOrDarkMode()
        
        for var i = 0 ; i < 8; i++ {
            for var t = 0; t < 8; t++ {
                let pieceSqr = UIImageView(frame: CGRectMake(xAxisArr[t] , yAxisArr[i] , pieceSize, pieceSize))
                self.view.addSubview(pieceSqr)
                piecePos += [pieceSqr]
            }
        }
        
        //tab-bar and navigation bar
        //   self.tabBarController?.tabBar.hidden = true
        // let nav = self.navigationController?.navigationBar
        
        if NSUserDefaults.standardUserDefaults().boolForKey("numbered_board") == true {
            
            if iamWhite {
                numbered = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
                numbered.image = UIImage(named:"WN")
                numbered.contentMode = .ScaleAspectFit
                self.view.addSubview(numbered)
            }
            else {
                numbered = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
                numbered.image = UIImage(named:"BN")
                numbered.contentMode = .ScaleAspectFit
                self.view.addSubview(numbered)
            }
            
        }
        else {
            numbered = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
            numbered.image = UIImage(named:"BB")
            numbered.contentMode = .ScaleAspectFit
            self.view.addSubview(numbered)
        }
        
        
        //load marker
        pieceMarked.image = UIImage(named: "pieceMarked.png")
        self.view.addSubview(pieceMarked)
        pieceMarked.hidden = true
        
        otherImage = UIImageView(frame: CGRectMake((screenWidth/2) - 30, 0, 60, 60))
        
        
        meImage = UIImageView(frame: CGRectMake((screenWidth/2) - 30, (screenHeight/2) + (screenWidth/2) + 30, 60, 60))
        
        
        var images:Array<NSData> = []
        
        print(screenHeight)
        if screenHeight == 667.0 {
            otherImage.frame.origin.y = 64 + 8
            meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 13
            
        }
        else if screenHeight == 736.0 {
            otherImage.frame.origin.y = 64 + 13
            meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 20
            
        }
        else if screenHeight == 568.0 {
            meImage.frame.size.width -= 20
            otherImage.frame.size.width -= 20
            meImage.frame.size.height -= 20
            otherImage.frame.size.height -= 20
            
            meImage.frame.origin.x += 10
            otherImage.frame.origin.x += 10
            
            
            otherImage.frame.origin.y = 64 + 7
            meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 11
            
        }
        else if screenHeight == 480.0 {
            otherImage.alpha = 0
            meImage.alpha = 0
            
        }
        otherImage.contentMode = .ScaleAspectFill
        otherImage.clipsToBounds = true
        otherImage.alpha = 0
        otherImage.layer.cornerRadius = otherImage.frame.size.width/2
        
        meImage.contentMode = .ScaleAspectFill
        meImage.clipsToBounds = true
        meImage.alpha = 0
        meImage.layer.cornerRadius = meImage.frame.size.width/2
        
        let query = PFQuery(className: "Games")
        query.whereKey("objectId", equalTo: gameID)
        let r = query.getFirstObject()
        game = r!
        
        passantArray = game["passantArray"] as! Array<Bool>
        
        notations = r!["piecePosition"] as! Array<String>
        
        whitePromotionType = r!["whitePromotionType"] as! Array<String>
        blackPromotionType = r!["blackPromotionType"] as! Array<String>
        
        // Important to not get error
        if notations.count == 0 {
            game.setObject(false, forKey: "can_Castle_white")
            game.setObject(false, forKey: "can_Castle_black")
            game.setObject(false, forKey: "passant")
            game.setObject(false, forKey: "passantBlack")
            game.setObject(0, forKey: "passantPiece")
            game.setObject(false, forKey: "promotion")
            game.setObject(false, forKey: "promotionBlack")
            game.setObject(false, forKey: "hasWhiteRookMoved")
            game.setObject(false, forKey: "hasWhiteRookMoved2")
            game.setObject(false, forKey: "hasBlackRookMoved")
            game.setObject(false, forKey: "hasBlackRookMoved2")
        }
        
        hasWhiteKingMoved = r!["can_Castle_white"] as! Bool
        hasBlackKingMoved = r!["can_Castle_black"] as! Bool
        
        hasWhiteRookMoved = r!["hasWhiteRookMoved"] as! Bool
        hasWhiteRookMoved2 = r!["hasWhiteRookMoved2"] as! Bool
        
        hasBlackRookMoved = r!["hasBlackRookMoved"] as! Bool
        hasBlackRookMoved2 = r!["hasBlackRookMoved2"] as! Bool
        
        promotion = r!["promotion"] as! Bool
        promotionBlack = r!["promotionBlack"] as! Bool
        
        if game["mode"] as? String == "Rated" {
            ratedLrated = "Rated"
            
        }
        else {
            ratedLrated = "Not Rated"
            
        }
        if game["speed"] as? String == "Normal" {
            speedLspeed = "Normal Speedmode"
            speedImagespeed = UIImage(named: "normalIndicator.png")!
            multiplySpeedWithIfNew = 0.25
            multiplySpeedWith = 0.00003
            
            
        }
        else if game["speed"] as? String == "Fast" {
            speedLspeed = "Fast Speedmode"
            speedImagespeed = UIImage(named: "flash31.png")!
            multiplySpeedWithIfNew = 0.00695
            multiplySpeedWith = 0.00003
            
            
        }
        else if game["speed"] as? String == "Slow" {
            speedLspeed = "Slow Speedmode"
            speedImagespeed = UIImage(named: "clock104.png")!
            multiplySpeedWithIfNew = 3
            multiplySpeedWith = 0.00003
            
        }
        

//        let lastupdate = game["timeLeftToMove"] as? NSDate
//        timeLeft = NSDate().timeIntervalSinceDate(lastupdate!)
//        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
        
        var moves: Array<String> = []
        func loadMoves() {
            moves = []
            notationsWithNumber = ""
            var t = 1
            for var i = 0; i < notations.count; i++ {
                
                if i % 2 == 0{
                    notationsWithNumber +=  "\(t). "
                    t++
                }
                notationsWithNumber += "\(notations[i]) "
                
                
                print("\(i+1).")
                var t = (i+1)
                for var q = 0; q < 2; q++ {
                    moveNum.append(t)
                }
                var putIntoMoves = ""
                for var o = 0; o < notations[i].characters.count; o++ {
                    let output = notations[i][o]
                    let letter = String(output)
                    
                    if letter.lowercaseString == String(output){
                        
                        if output != "-" && output != "x" {
                            //print(output)
                            putIntoMoves.append(output)
                            
                        }
                        
                    }
                }
                print(putIntoMoves)
                moves.append(putIntoMoves)
            }
            print(moves)
            movesCap = moves
            
            movesField.text = notationsWithNumber
            
            if copyB.frame.size.width > 45 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.copyB.frame.size.width -= 16
                    self.copyB.frame.origin.x += 8
                    self.copyB.setTitle("Copy", forState: .Normal)
                    self.copyB.backgroundColor = blue
                    self.copyB.userInteractionEnabled = true
                    
                    }, completion: {finish in
                        
                        
                })
            }
        }
        loadMoves()
        
        if r!["whitePlayer"] as? String == PFUser.currentUser()?.username {
            
            let lastupdate = game["whiteDate"] as? NSDate
            timeLeft = NSDate().timeIntervalSinceDate(lastupdate!)

//            let timeToAdd = game["whiteTime"] as? Int
//            newDate = now.dateByAddingTimeInterval(timeToAdd)
//            game["whiteDate"] = newDate
            
            colorLcolor = "You are White"
            colorIndicatorcolor = UIColor.whiteColor()
            



            
            
            //chesspieces loading - REMEMBER TO ADD PIECES TO ARRAYS!! Right order as well!!
            if r!["status_white"] as! String == "move" {
                isWhiteTurn = true
                
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
                
                
                turnLturn = "Your Turn"
                turnIndicatorturn = blue
                
                myTurnAtlaunch = true
                
                addMyTurnAndTime()
                
                
                for var i = 0; i < piecesArrs.count; i++ {
                    for var t = 0; t < piecesArrs[i].count; t++ {
                        piecesArrs[i][t].image = UIImage(named: piecesString[i])
                        self.view.addSubview(piecesArrs[i][t])
                        piecesArrs[i][t].contentMode = .ScaleAspectFit
                        piecesArrs[i][t].userInteractionEnabled = false
                        piecesArrs[i][t].multipleTouchEnabled = true
                    }
                }
            }
            else {
                isWhiteTurn = false
                
                turnLturn = "Their Turn"
                turnIndicatorturn = UIColor.lightGrayColor()
                
                myTurnAtlaunch = false
                addMyTurnAndTime()
                
                self.myTurnAtlaunch = false
                self.addMyTurnAndTime()
                
                self.myTurnAtlaunch = false
                self.addMyTurnAndTime()
                
                
                for var i = 0; i < piecesArrs.count; i++ {
                    for var t = 0; t < piecesArrs[i].count; t++ {
                        piecesArrs[i][t].image = UIImage(named: piecesString[i])
                        self.view.addSubview(piecesArrs[i][t])
                        piecesArrs[i][t].contentMode = .ScaleAspectFit
                        piecesArrs[i][t].userInteractionEnabled = false
                        piecesArrs[i][t].multipleTouchEnabled = true
                    }
                }
                
            }
            xAxisArrStr = ["a","b","c","d","e","f","g","h"]
            yAxisArrStr = ["1","2","3","4","5","6","7","8"]
            ////////this is where the magic happens\\\\\\\\
            func magic1() {
                xAxisArrStr2 = ["a","b","c","d","e","f","g","h"]
                yAxisArrStr2 = ["1","2","3","4","5","6","7","8"]
                var am = 0
                var count = 0
                var countBlack = 0
                for var o = 0; o < moves.count; o++ {
                    am++
                    print("am variable is \(am)")
                    for var t = 0; t < xAxisArrStr2.count; t++ {
                        
                        if moves[o].characters.count == 3 {
                            if String(moves[o][2])  == "0" {
                                if  o % 2 == 0 {
                                    print("Castling white long")
                                    if moves.last == moves[o] && am == moves.count{
                                        
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            
                                            self.whiteKing.frame.origin.x = c
                                            self.whiteKing.frame.origin.y = _1
                                            self.whiteRook2.frame.origin.x = d
                                            self.whiteRook2.frame.origin.y = _1
                                            
                                            }, completion: { finish in
                                                
                                                for var i = 0; i < self.piecesArrs.count; i++ {
                                                    for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                        self.piecesArrs[i][t].userInteractionEnabled = true
                                                    }
                                                }
                                                self.deletePiecesAfterLoad()
                                                self.updateLogic()
                                        })
                                        
                                    }
                                    else {
                                        self.whiteKing.frame.origin.x = c
                                        self.whiteKing.frame.origin.y = _1
                                        self.whiteRook2.frame.origin.x = d
                                        self.whiteRook2.frame.origin.y = _1
                                    }
                                }
                                    
                                else {
                                    
                                    if moves.last == moves[o] && am == moves.count{
                                        print("Castling black long")
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            
                                            self.blackKing.frame.origin.x = c
                                            self.blackKing.frame.origin.y = _8
                                            self.blackRook1.frame.origin.x = d
                                            self.blackRook1.frame.origin.y = _8
                                            
                                            
                                            }, completion: { finish in
                                                for var i = 0; i < self.piecesArrs.count; i++ {
                                                    for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                        self.piecesArrs[i][t].userInteractionEnabled = true
                                                    }
                                                }
                                                self.deletePiecesAfterLoad()
                                                self.updateLogic()
                                        })
                                        
                                    }
                                    else {
                                        self.blackKing.frame.origin.x = c
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook1.frame.origin.x = d
                                        self.blackRook1.frame.origin.y = _8
                                    }
                                    
                                }
                            }
                        }
                        else if String(moves[o][0])  == "0" && String(moves[o][1])  == "0" {
                            
                            if  o % 2 == 0 {
                                print("Castling white short")
                                if moves.last == moves[o] && am == moves.count{
                                    
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        
                                        self.whiteKing.frame.origin.x = g
                                        self.whiteKing.frame.origin.y = _1
                                        self.whiteRook1.frame.origin.x = f
                                        self.whiteRook1.frame.origin.y = _1
                                        
                                        }, completion: { finish in
                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                }
                                            }
                                            self.deletePiecesAfterLoad()
                                            self.updateLogic()
                                    })
                                    
                                    
                                }  else {
                                    
                                    self.whiteKing.frame.origin.x = g
                                    self.whiteKing.frame.origin.y = _1
                                    self.whiteRook1.frame.origin.x = f
                                    self.whiteRook1.frame.origin.y = _1
                                }
                                
                            } else {
                                if moves.last == moves[o] && am == moves.count{
                                    print("Castling black short")
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        // white castling bottom-right
                                        self.blackKing.frame.origin.x = g
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook2.frame.origin.x = f
                                        self.blackRook2.frame.origin.y = _8
                                        
                                        }, completion: { finish in
                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                }
                                            }
                                            self.deletePiecesAfterLoad()
                                            self.updateLogic()})
                                    
                                }
                                else {
                                    self.blackKing.frame.origin.x = g
                                    self.blackKing.frame.origin.y = _8
                                    self.blackRook2.frame.origin.x = f
                                    self.blackRook2.frame.origin.y = _8
                                }
                                
                            }
                        }
                        else if String(moves[o][0]) == xAxisArrStr2[t] {
                            for var p = 0; p < yAxisArrStr2.count; p++ {
                                if String(moves[o][1]) == yAxisArrStr2[p] {
                                    for var i = 0; i < pieces.count; i++ {
                                        var remove = false
                                        if pieces[i].frame.origin.x == xAxisArr[t] {
                                            if pieces[i].frame.origin.y == yAxisArr[p] {
                                                
                                                print("this is complicated")
                                                
                                                for var q = 0; q < xAxisArrStr2.count; q++ {
                                                    if String(moves[o][2]) == xAxisArrStr2[q] {
                                                        for var a = 0; a < yAxisArrStr2.count; a++ {
                                                            if String(moves[o][3]) == yAxisArrStr2[a] {
                                                                
                                                                let range = notations[o].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                                
                                                                func checkIfTakenLast() {
                                                                    
                                                                    for var w = 0; w < whitePawns.count; w++ {
                                                                        if String(moves[o][1])  == "7" && String(moves[o][3]) == "8" && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == whitePawns[w]   {
                                                                            print("Notation promotion")
                                                                            if whitePromotionType[count] == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                                self.whiteQueens += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"whiteRook")
                                                                                self.whiteRooks += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            } else  if whitePromotionType[count] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                                self.whiteBishops += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            } else  if whitePromotionType[count] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                                self.whiteKnights += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    for var w = 0; w < blackPawns.count; w++ {
                                                                        if String(moves[o][1])  == "2" && String(moves[o][3]) == "1"  && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == blackPawns[w] {
                                                                            print("Notation promotion")
                                                                            if blackPromotionType[countBlack] == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"blackQueen")
                                                                                self.blackQueens += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"blackRook")
                                                                                self.blackRooks += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"blackBishop")
                                                                                self.blackBishops += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"blackKnight")
                                                                                self.blackKnights += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    // range will be nil if no letters is found
                                                                    if  (range != nil) {
                                                                        print("letters  found")
                                                                        self.canPassant = r!["passant"] as! Bool
                                                                        self.canPassantBlack = r!["passantBlack"] as! Bool
                                                                        for var iy = 0; iy < pieces.count; iy++ {
                                                                                     if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && passantArray[o] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && passantArray[o] == true   {
                                                                                
                                                                                print("iy is \(iy)")
                                                                                
                                                                                
                                                                                for var ty = 0; ty < self.whitePieces.count; ty++ {
                                                                                    if self.whitePieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenWhitePieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenWhitePieces += [self.pieces[iy]]
                                                                                            takenWhitePiecesForMove += [takenPiece]

                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenWhitePiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: whitePiecesTypes[t])) {
                                                                                                whiteCount[t] += 1
                                                                                                if (!self.containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                                                                                    takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenWhitePiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                                                                                if darkMode {takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()}
                                                                                                else {takenWhitePiecesLbl[t].textColor = UIColor.blackColor()}
                                                                                                takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenWhitePiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.whitePieces[ty]]
                                                                                        //    self.whitePieces[ty].removeFromSuperview()
                                                                                        self.whitePieces.removeAtIndex(ty)
                                                                                        self.whitePiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPieces.count; ty++ {
                                                                                    if  self.blackPieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenBlackPieces, _image: pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = pieces[iy].image
                                                                                            takenBlackPieces += [pieces[iy]]
                                                                                            takenBlackPiecesForMove += [takenPiece]
                                                                                            
                                                                                            view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenBlackPiecesForInfo += [self.pieces[iy]]
                                                                                        
                                                                                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                                                                            print(blackCount[t])
                                                                                            if (pieces[iy].image == UIImage(named: blackPiecesTypes[t])) {
                                                                                                blackCount[t] += 1
                                                                                                print("Taken piece")
                                                                                                if (!containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                                                                                    takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenBlackPiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                                                                                if darkMode {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                view.addSubview(takenBlackPiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.blackPieces[ty]]
                                                                                        //      self.blackPieces[ty].removeFromSuperview()
                                                                                        self.blackPieces.removeAtIndex(ty)
                                                                                        self.blackPiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.whitePawns.count; ty++ {
                                                                                    if self.whitePawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        points -= 100
                                                                                        //                                                                                        self.whitePawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPawns.count; ty++ {
                                                                                    if self.blackPawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        points += 100
                                                                                        
                                                                                        //                                                                                        self.blackPawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                self.piecesToDelete.append(self.pieces[iy])
                                                                                
                                                                                self.takenPiecesToReload.append(self.pieces[iy])
                                                                                self.takenPiecesToReloadAtIndex.append(iy)
                                                                                
                                                                                
                                                                                func chartData() {
                                                                                    for var gr = 0; gr < whiteRooks.count; gr++ {
                                                                                        if self.pieces[iy] == whiteRooks[gr]  {
                                                                                            points -= 500
                                                                                            whiteRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    for var gr = 0; gr < blackRooks.count; gr++ {
                                                                                        if self.pieces[iy] == blackRooks[gr]  {
                                                                                            points += 500
                                                                                            blackRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteKnights.count; gr++ {
                                                                                        if self.pieces[iy] == whiteKnights[gr]  {
                                                                                            points -= 300
                                                                                            whiteKnights.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackKnights.count; gr++ {
                                                                                        if self.pieces[iy] == blackKnights[gr]  {
                                                                                            points += 300
                                                                                            blackKnights.removeAtIndex(gr)
                                                                                            print("blackKnights taken")
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteBishops.count; gr++ {
                                                                                        if self.pieces[iy] == whiteBishops[gr]  {
                                                                                            points -= 300
                                                                                            whiteBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackBishops.count; gr++ {
                                                                                        if self.pieces[iy] == blackBishops[gr]  {
                                                                                            points += 300
                                                                                            blackBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteQueens.count; gr++ {
                                                                                        if self.pieces[iy] == whiteQueens[gr]  {
                                                                                            points -= 900
                                                                                            whiteQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackQueens.count; gr++ {
                                                                                        if self.pieces[iy] == blackQueens[gr]  {
                                                                                            points += 900
                                                                                            blackQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                //  chartData()
                                                                                
                                                                                UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                                                                                    
                                                                                    self.pieces[iy].alpha = 0
                                                                                    
                                                                                    }, completion: { finish in
                                                                                        
                                                                                })
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                    } else {
                                                                        print("letters not found")
                                                                    }
                                                                }
                                                                func checkIfTaken() {
                                                                    
                                                                    for var w = 0; w < whitePawns.count; w++ {
                                                                        if String(moves[o][1])  == "7" && String(moves[o][3]) == "8" && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == whitePawns[w]   {
                                                                            print("Notation promotion")
                                                                            if whitePromotionType[count] == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                                self.whiteQueens += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"whiteRook")
                                                                                self.whiteRooks += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            } else  if whitePromotionType[count] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                                self.whiteBishops += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            } else  if whitePromotionType[count] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                                self.whiteKnights += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                count++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    for var w = 0; w < blackPawns.count; w++ {
                                                                        if String(moves[o][1])  == "2" && String(moves[o][3]) == "1"  && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == blackPawns[w] {
                                                                            print("Notation promotion")
                                                                            if blackPromotionType[countBlack] == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"blackQueen")
                                                                                self.blackQueens += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"blackRook")
                                                                                self.blackRooks += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"blackBishop")
                                                                                self.blackBishops += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"blackKnight")
                                                                                self.blackKnights += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    print("checkIfTaken")
                                                                    // range will be nil if no x is found
                                                                    if  (range != nil) {
                                                                        print("x  found")
                                                                        
                                                                        for var iy = 0; iy < pieces.count ; iy++ {

                                                                            if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && passantArray[o] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && passantArray[o] == true{

                                                                                
                                                                                
                                                                                for var ty = 0; ty < self.whitePieces.count; ty++ {
                                                                                    if self.whitePieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        print("whitePieces take")
                                                                                        if (!self.contains(takenWhitePieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenWhitePieces += [self.pieces[iy]]
                                                                                            takenWhitePiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenWhitePiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: whitePiecesTypes[t])) {
                                                                                                whiteCount[t] += 1
                                                                                                if (!self.containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                                                                                    takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenWhitePiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                                                                                if darkMode {takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()}
                                                                                                else {takenWhitePiecesLbl[t].textColor = UIColor.blackColor()}
                                                                                                takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenWhitePiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.whitePieces[ty]]
                                                                                        //    self.whitePieces[ty].removeFromSuperview()
                                                                                        self.whitePieces.removeAtIndex(ty)
                                                                                        self.whitePiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPieces.count; ty++ {
                                                                                    if  self.blackPieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        print("blackPieces take")
                                                                                        if (!self.contains(takenBlackPieces, _image: pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = pieces[iy].image
                                                                                            takenBlackPieces += [pieces[iy]]
                                                                                            takenBlackPiecesForMove += [takenPiece]
                                                                                            
                                                                                            view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenBlackPiecesForInfo += [self.pieces[iy]]
                                                                                        
                                                                                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                                                                            print(blackCount[t])
                                                                                            if (pieces[iy].image == UIImage(named: blackPiecesTypes[t])) {
                                                                                                blackCount[t] += 1
                                                                                                print("Taken piece")
                                                                                                if (!containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                                                                                    takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenBlackPiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                                                                                if darkMode {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                view.addSubview(takenBlackPiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.blackPieces[ty]]
                                                                                        //      self.blackPieces[ty].removeFromSuperview()
                                                                                        self.blackPieces.removeAtIndex(ty)
                                                                                        self.blackPiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                //                                                                                for var ty = 0; ty < self.whitePawns.count; ty++ {
                                                                                //                                                                                    if self.whitePawns[ty] == self.pieces[iy] {
                                                                                //
                                                                                //                                                                                        //chrta
                                                                                //                                                                                        points -= 100
                                                                                //
                                                                                ////                                                                                        self.whitePawns.removeAtIndex(ty)
                                                                                ////                                                                                        ty--
                                                                                //                                                                                        print("TAKEN")
                                                                                //                                                                                    }
                                                                                //
                                                                                //                                                                                }
                                                                                //                                                                                for var ty = 0; ty < self.blackPawns.count; ty++ {
                                                                                //                                                                                    if self.blackPawns[ty] == self.pieces[iy]{
                                                                                //
                                                                                //                                                                                        //chrta
                                                                                //                                                                                        points += 100
                                                                                //
                                                                                ////                                                                                        self.blackPawns.removeAtIndex(ty)
                                                                                ////                                                                                        ty--
                                                                                //                                                                                        print("TAKEN")
                                                                                //                                                                                    }
                                                                                //
                                                                                //                                                                                }
                                                                                
                                                                                self.pieces[iy].alpha = 0
                                                                                
                                                                                self.piecesToDelete.append(self.pieces[iy])
                                                                                
                                                                                
                                                                                
                                                                                self.takenPiecesToReload.append(self.pieces[iy])
                                                                                self.takenPiecesToReloadAtIndex.append(iy)
                                                                                
                                                                                
                                                                                //setting material points to game
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                //                                                                                    for var gr = 0; gr < whitePawnsM.count; gr++ {
                                                                                //                                                                                        if takenPiecesToReload[ttpr] == whitePawnsM[gr]  {
                                                                                //                                                                                            points -= 100
                                                                                //                                                                                        }
                                                                                //                                                                                    }
                                                                                //                                                                                    for var gr = 0; gr < blackPawnsM.count; gr++ {
                                                                                //                                                                                        if takenPiecesToReload[ttpr] == blackPawnsM[gr]  {
                                                                                //                                                                                            points += 100
                                                                                //                                                                                        }
                                                                                //                                                                                    }
                                                                                
                                                                                func chartData() {
                                                                                    for var gr = 0; gr < whiteRooks.count; gr++ {
                                                                                        if self.pieces[iy] == whiteRooks[gr]  {
                                                                                            points -= 500
                                                                                            whiteRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    for var gr = 0; gr < blackRooks.count; gr++ {
                                                                                        if self.pieces[iy] == blackRooks[gr]  {
                                                                                            points += 500
                                                                                            blackRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteKnights.count; gr++ {
                                                                                        if self.pieces[iy] == whiteKnights[gr]  {
                                                                                            points -= 300
                                                                                            whiteKnights.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackKnights.count; gr++ {
                                                                                        if self.pieces[iy] == blackKnights[gr]  {
                                                                                            points += 300
                                                                                            blackKnights.removeAtIndex(gr)
                                                                                            print("blackKnights taken")
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteBishops.count; gr++ {
                                                                                        if self.pieces[iy] == whiteBishops[gr]  {
                                                                                            points -= 300
                                                                                            whiteBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackBishops.count; gr++ {
                                                                                        if self.pieces[iy] == blackBishops[gr]  {
                                                                                            points += 300
                                                                                            blackBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteQueens.count; gr++ {
                                                                                        if self.pieces[iy] == whiteQueens[gr]  {
                                                                                            points -= 900
                                                                                            whiteQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackQueens.count; gr++ {
                                                                                        if self.pieces[iy] == blackQueens[gr]  {
                                                                                            points += 900
                                                                                            blackQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                // chartData()
                                                                            }
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    else {
                                                                        print("x not found")
                                                                    }
                                                                    
                                                                    
                                                                }
                                                                
                                                                if moves.last == moves[o] && am == moves.count{
                                                                    
                                                                    
                                                                    
                                                                    checkIfTakenLast()
                                                                    
                                                                    //chart
                                                                    pointsStorage.append(points)
                                                                    
                                                                    NSUserDefaults.standardUserDefaults().setObject(pointsStorage, forKey: "material"+gameID)
                                                                    
                                                                    
                                                                    print("moves.count in magic1() is \(moves.count)")
                                                                    
                                                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                                                        self.pieces[i].frame.origin.x = xAxisArr[q]
                                                                        self.pieces[i].frame.origin.y = yAxisArr[a]
                                                                        
                                                                        print("last pieces[i] is \(self.pieces[i])  ")
                                                                        
                                                                        }, completion: { finish in
                                                                            self.deletePiecesAfterLoad()
                                                                            self.updateLogic()
                                                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                                                }
                                                                            }
                                                                          
                                                                            //return
                                                                    })
                                                                    
                                                                }
                                                                else {
                                                                    checkIfTaken()
                                                                    
                                                                    
                                                                    //chart
                                                                    pointsStorage.append(points)
                                                                    
                                                                    
                                                                    
                                                                    print("pieces[i] is \(pieces[i]) with")
                                                                    
                                                                    
                                                                    pieces[i].frame.origin.x = xAxisArr[q]
                                                                    pieces[i].frame.origin.y = yAxisArr[a]
                                                                    self.deletePiecesAfterLoad()
                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            
            
            magic1()
            
            if r!["status_white"] as! String == "move" {
                
                if movesCap.count == 0 {
                    for var i = 0; i < piecesArrs.count; i++ {
                        for var t = 0; t < piecesArrs[i].count; t++ {

                            piecesArrs[i][t].userInteractionEnabled = true
                        }
                    }
                }
                
            }
            
            print("I am white player!")
            iamWhite = true
            canOnlyMoveWhite = true
            self.title = r!["blackPlayer"] as? String
            self.hasBlackKingMoved = r!["can_Castle_black"] as! Bool
            self.hasWhiteKingMoved = r!["can_Castle_white"] as! Bool
            let un = [r!["blackPlayer"]!,r!["whitePlayer"]!]
            self.passantPiece = (r!["passantPiece"] as? Int)!
            self.canPassant = r!["passant"] as! Bool
            self.canPassantBlack = r!["passantBlack"] as! Bool
            self.promotionBlack = r!["promotionBlack"] as! Bool
            let userQuery = PFQuery(className: "_User")
            userQuery.whereKey("username", containedIn: un )
            userQuery.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    if let result = result as! [PFUser]! {
                        for result in result {
                            
                            let rating = result["rating"] as? Int
                            
                            if (result["username"] as? String)! == r!["whitePlayer"]! as! String {
                                self.meUserRatingInt = result["rating"] as! Int!
                                self.meUserWon = Int(result["won"] as! String!)!
                                self.meUserLost = Int(result["lost"] as! String!)!
                                self.meUserDrawn = Int(result["drawn"] as! String!)!

                            }
                            else {
                                self.otherUserRatingInt = result["rating"] as! Int!
                            }
                            
                            let profilePictureObject = result["profile_picture"] as? PFFile
                            
                            if(profilePictureObject != nil)
                            {
                                profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                                    
                                    if(imageData != nil)
                                    {
                                        images.append(imageData!)
                                        if (result["username"] as? String)! == r!["whitePlayer"]! as! String {
                                            
                                            self.meImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(self.meImage)
                                            
                                            self.meUserImage = UIImage(data: imageData!)!
                                            self.meUserName = (result["username"] as? String)!
                                            self.meUserRating = "\(result["rating"] as! Int)"
                                            
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                self.meImage.alpha = 1
                                                
                                                
                                                if screenHeight == 480.0 {
                                                    self.meImage.alpha = 0
                                                    
                                                }
                                                },completion: {finish in
                                                    //self.addMyTurnAndTime()
                                                    
                                            })
                                            
                                        }
                                        else {
                                            self.otherImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(self.otherImage)
                                            
                                            
                                            self.otherUserImage = UIImage(data: imageData!)!
                                            self.otherUserRating = "\(result["rating"] as! Int!)"
                                            self.otherUserName = (result["username"] as? String)!
                                            
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                self.otherImage.alpha = 1
                                                if screenHeight == 480.0 {
                                                    self.otherImage.alpha = 0
                                                    
                                                }
                                            })
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    //setting rating and won/lost/drawn
                    if r!["status_white"] as! String == "won" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 1, sB: 0).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                    
                            let s = self.meUserWon + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "won")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()

                            self.gameFinishedScreen("won",statusBy: "")
                        }
                    }
                    else if r!["status_white"] as! String == "lost" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0, sB: 1).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserLost + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()

                            self.gameFinishedScreen("lost",statusBy: "")

                        }
                    }
                    else if r!["status_white"] as! String == "draw" {
                        
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserDrawn + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("drew",statusBy: "")

                        }
                    }
                    if r!["draw_white"] as! String == "drawto" {
                        
                        let drawAlert = UIAlertController(title: "Draw Offered", message: "You have been offered a draw. Do you want to accept it?", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        drawAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                                if self.iamWhite {
                                    
                                    if r!["whiteRatedComplete"] as! Bool == false {
                                        
                                        let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                                        PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                                        
                                        let s = self.meUserDrawn + 1
                                        PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                                        
                                        PFUser.currentUser()!.save()
                                        
                                        r!["status_white"] = "draw"
                                        
                                        r!["status_black"] = "draw"
                                        
                                        
                                        r!["whiteRatedComplete"] = true
                                        r!.save()
                                        
                                        for var i = 0; i < self.piecesArrs.count; i++ {
                                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                
                                                self.piecesArrs[i][t].userInteractionEnabled = false
                                            }
                                        }
                                        
                                        self.gameFinishedScreen("drew",statusBy: "")
                                        
                                    
                                    
                                 
                                    
                                    //firebase
                                    
                                    //add who's turn it is
                                    let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                                    var status = ["turn": "done"]
                                    
                                    let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                                    statusRef.setValue(status)
                                    //firebase - end
                                    
                                    }
                                }
                                
                            }
                        }))
                        drawAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                                if self.iamWhite {
                                
                                    

                                        
                                        r!["draw_white"] = ""
                                        
                                        r!["draw_black"] = ""
                                        
                                        
                                        r!.save()
                                    
                                    

                                }
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                            }
                        }))
                        self.presentViewController(drawAlert, animated: true, completion: nil)


                    }
                    
                }
                
            })
            

            
            //firebase
            //check for any changes that may have accured at the destined game ≈_≈
            let check = Firebase(url:"https://chess-panber.firebaseio.com/games/\(gameID)")
            check.observeEventType(.ChildChanged, withBlock: { snapshot in
                print(snapshot.value)
                if self.didEnterTimeCapsule {
                    self.forwardB.userInteractionEnabled = false
                    self.backwardB.userInteractionEnabled = false
                    self.exitTimeCapsuleB.userInteractionEnabled = false
                    
                    self.magic4(Int(self.slider.value))
                    
                    self.slider.value = self.slider.maximumValue
                    
                    self.didEnterTimeCapsule = false
                    
                    if self.myturnAfterTimeCapsule {
                        
                        for var i = 0; i < self.piecesArrs.count; i++ {
                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                self.piecesArrs[i][t].userInteractionEnabled = true
                                self.piecesArrs[i][t].multipleTouchEnabled = true
                            }
                        }
                    }
                    
                    if self.slider.value == self.slider.maximumValue {
                        self.forwardB.enabled = false
                        
                        
                        
                        UIView.animateWithDuration(0.8, animations: { () -> Void in
                            if self.iamWhite {
                                for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                    takenWhitePiecesLbl[t].frame.origin.y += 100
                                }
                                for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                                    takenWhitePiecesForMove[t].frame.origin.y += 100
                                }
                                for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                    takenBlackPiecesLbl[t].frame.origin.y -= 100
                                }
                                for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                                    takenBlackPiecesForMove[t].frame.origin.y -= 100
                                }
                            }
                            else {
                                for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                    takenWhitePiecesLbl[t].frame.origin.y -= 100
                                }
                                for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                                    takenWhitePiecesForMove[t].frame.origin.y -= 100
                                }
                                for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                    takenBlackPiecesLbl[t].frame.origin.y += 100
                                }
                                for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                                    takenBlackPiecesForMove[t].frame.origin.y += 100
                                }
                            }
                            self.slider.frame.origin.y = screenHeight/2 + 150
                            self.capsuleB.frame.origin.y = screenHeight/2 + 246
                            self.capsuleL.frame.origin.y = 200
                            
                            self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                            self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                            
                            self.collectionView.frame.origin.y  = 86
                            self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 20
                            self.otherImage.frame.origin.y = 64 + 13
                            
                            
                            self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2
                            self.notationsL.frame.origin.y = screenHeight/2 + 150 - 47
                            self.exitTimeCapsuleB.frame.origin.y = screenHeight/2 + 150 - 47
                            
                            
                            
                            self.timeGL.frame.origin.y -= 100
                            self.turnGL.frame.origin.y -= 100
                            self.turnIndicatorG.frame.origin.y -= 100
                            
                            if screenHeight == 667 {
                                self.capsuleB.frame.origin.y = screenHeight/2 + 220
                                self.slider.frame.origin.y = screenHeight/2 + 150
                                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 47
                                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 47
                                self.collectionView.frame.origin.y = 78
                                
                                self.otherImage.frame.origin.y = 64 + 8
                                self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 13
                                
                                
                            }
                            else if screenHeight ==  568 {self.capsuleB.frame.origin.y = screenHeight/2 + 180
                                self.slider.frame.origin.y = screenHeight/2 + 150 - 50
                                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.collectionView.frame.origin.y = 74
                                
                                self.otherImage.frame.origin.y = 64 + 7
                                self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 9
                                
                                
                            }
                            else   if screenHeight == 480 {
                                self.slider.frame.origin.y = screenHeight/2 + 150 - 47
                                self.capsuleB.frame.origin.y = screenHeight/2 + 180
                                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.collectionView.frame.origin.y = 74
                                
                                
                            }
                            
                            }, completion: {finish in
                                //sender.value = 50
                                
                        })
                        
                    }
                    
                }
                if self.game ["whitePlayer"] as? String == PFUser.currentUser()?.username && snapshot.value as! String == "white" {
                    
                    //   self.loadVariablesAndConstants()
                    let query = PFQuery(className: "Games")
                    query.whereKey("objectId", equalTo: gameID)
                    let r = query.getFirstObject()
                    self.game = r!
                    var last = r!["piecePosition"] as! Array<String>
                    self.passantArray = self.game["passantArray"] as! Array<Bool>


                    self.notations.append(last.last!)
                    var lastPromotionType = r!["blackPromotionType"] as! Array<String>
                    if lastPromotionType.count > 0 {
                        self.blackPromotionType.append(lastPromotionType.last!)
                    }
                    self.hasWhiteRookMoved = r!["hasWhiteRookMoved"] as! Bool
                    self.hasWhiteRookMoved2 = r!["hasWhiteRookMoved2"] as! Bool
                    self.hasBlackKingMoved = r!["can_Castle_black"] as! Bool
                    self.hasWhiteKingMoved = r!["can_Castle_white"] as! Bool
                    self.promotionBlack = r!["promotionBlack"] as! Bool
                    let newIndexPath = NSIndexPath(forItem: self.notations.count - 1, inSection: 0)
                    self.collectionView.insertItemsAtIndexPaths([newIndexPath])
                    self.collectionView.layoutIfNeeded()
                    self.collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .Bottom, animated: true)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionView.reloadData()
                    }
                    
                    
                    
                    print("notations.count is \(self.notations.count)")
                    self.passantPiece = (r!["passantPiece"] as? Int)!
                    self.canPassant = r!["passant"] as! Bool
                    self.canPassantBlack = r!["passantBlack"] as! Bool
                    loadMoves()
                    

                    for var i = 0; i < self.piecesArrs.count; i++ {
                        for var t = 0; t < self.piecesArrs[i].count; t++ {
                            self.piecesArrs[i][t].userInteractionEnabled = false
                        }
                    }
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)

                    for var t = 0; t < xAxisArrStr2.count; t++ {
                        if moves.last!.characters.count == 3 {
                            
                            if String(moves.last![2])  == "0" {
                                //can return false value??
                                if  moves.indexOf(moves.last!)!  % 2 == 0 {
                                    
                                    if moves.last == moves.last{
                                        
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            self.blackKing.frame.origin.x = c
                                            self.blackKing.frame.origin.y = _8
                                            self.blackRook1.frame.origin.x = d
                                            self.blackRook1.frame.origin.y = _8
                                            
                                            }, completion: { finish in})
                                        
                                    }
                                    
                                    
                                }
                                    
                                else {
                                    
                                    if moves.last == moves.last{
                                        print("Castling black long")
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            
                                            self.blackKing.frame.origin.x = c
                                            self.blackKing.frame.origin.y = _8
                                            self.blackRook1.frame.origin.x = d
                                            self.blackRook1.frame.origin.y = _8
                                            
                                            }, completion: { finish in})
                                        
                                    }
                                    
                                    
                                }
                            }
                        }
                        else if String(moves.last![0])  == "0" && String(moves.last![1])  == "0" {
                            
                            if  moves.indexOf(moves.last!)!  % 2 == 0  {
                                if moves.last == moves.last{
                                    
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        
                                        self.blackKing.frame.origin.x = g
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook2.frame.origin.x = f
                                        self.blackRook2.frame.origin.y = _8
                                        
                                        }, completion: { finish in})
                                }
                                
                            }
                                
                            else {
                                
                                if moves.last == moves.last{
                                    print("Castling black short")
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        
                                        self.blackKing.frame.origin.x = g
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook2.frame.origin.x = f
                                        self.blackRook2.frame.origin.y = _8
                                        
                                        
                                        }, completion: { finish in})
                                    
                                }
                                
                            }
                        }
                        else if String(moves.last![0]) == xAxisArrStr2[t] {
                            for var p = 0; p < yAxisArrStr2.count; p++ {
                                if String(moves.last![1]) == yAxisArrStr2[p] {
                                    for var i = 0; i < self.pieces.count; i++ {
                                        if self.pieces[i].frame.origin.x == xAxisArr[t] {
                                            if self.pieces[i].frame.origin.y == yAxisArr[p] {
                                                
                                                print("this is complicated")
                                                
                                                for var q = 0; q < xAxisArrStr2.count; q++ {
                                                    if String(moves.last![2]) == xAxisArrStr2[q] {
                                                        for var a = 0; a < yAxisArrStr2.count; a++ {
                                                            if String(moves.last![3]) == yAxisArrStr2[a] {
                                                                
                                                                
                                                                let range = self.notations.last!.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                                
                                                                func checkIfTakenLast() {
                                                                    
                                                                    for var w = 0; w < self.blackPawns.count; w++ {
                                                                        if String(moves.last![1])  == "2" && String(moves.last![3]) == "1"  && self.pieces[i].image == UIImage(named:"blackPawn") && self.pieces[i] == self.blackPawns[w]  {
                                                                            
                                                                            
                                                                            print("Notation promotion")
                                                                            if self.blackPromotionType.last! == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"blackQueen")
                                                                                self.blackQueens += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            } else if self.blackPromotionType.last! == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"blackRook")
                                                                                self.blackRooks += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            } else if self.blackPromotionType.last! == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"blackBishop")
                                                                                self.blackBishops += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            } else if self.blackPromotionType.last! == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"blackKnight")
                                                                                self.blackKnights += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            }
                                                                            self.promotionAtIndex.append(self.movesCap.count-1)
                                                                        }
                                                                    }
                                                                    
                                                                    if  (range != nil) {
                                                                        print("letters  found")
                                                                        
                                                                        for var iy = 0; iy < self.pieces.count - 1; iy++ {
                                                                            
                                                                            if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && self.pieces[i].image == UIImage(named:"blackPawn") && self.pieces[iy].image == UIImage(named:"whitePawn") && self.passantArray[self.movesCap.count-1] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && self.pieces[i].image == UIImage(named:"whitePawn") && self.pieces[iy].image == UIImage(named:"blackPawn") && self.passantArray[self.movesCap.count-1] == true   {
                                                                                
                                                                                for var ty = 0; ty < self.whitePieces.count; ty++ {
                                                                                    if self.whitePieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenWhitePieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenWhitePieces += [self.pieces[iy]]
                                                                                            takenWhitePiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenWhitePiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: whitePiecesTypes[t])) {
                                                                                                whiteCount[t] += 1
                                                                                                if (!self.containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                                                                                    takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenWhitePiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                                                                                if darkMode {
                                                                                                    takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenWhitePiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                
                                                                                                takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenWhitePiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.whitePieces[ty]]
                                                                                        //    self.whitePieces[ty].removeFromSuperview()
                                                                                        self.whitePieces.removeAtIndex(ty)
                                                                                        self.whitePiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        print("TAKEN by black")
                                                                                    }
                                                                                    
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPieces.count; ty++ {
                                                                                    if  self.blackPieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenBlackPieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenBlackPieces += [self.pieces[iy]]
                                                                                            takenBlackPiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenBlackPiecesForInfo += [self.pieces[iy]]
                                                                                        
                                                                                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                                                                            print(blackCount[t])
                                                                                            if (self.pieces[iy].image == UIImage(named: blackPiecesTypes[t])) {
                                                                                                blackCount[t] += 1
                                                                                                print("Taken piece")
                                                                                                if (!self.containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                                                                                    takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenBlackPiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                                                                                if darkMode {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenBlackPiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.blackPieces[ty]]
                                                                                        //      self.blackPieces[ty].removeFromSuperview()
                                                                                        self.blackPieces.removeAtIndex(ty)
                                                                                        self.blackPiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        print("TAKEN by white")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.whitePawns.count; ty++ {
                                                                                    if self.whitePawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        //                                                                                        self.whitePawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN PAWN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPawns.count; ty++ {
                                                                                    if self.blackPawns[ty].frame.origin.x - 1 * pieceSize == self.pieces[iy].frame.origin.x && self.blackPawns[ty].frame.origin.y - 1 * pieceSize == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        //                                                                                        self.blackPawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN PAWN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                
                                                                                self.piecesToDelete.append(self.pieces[iy])
                                                                                
                                                                                self.takenPiecesToReload.append(self.pieces[iy])
                                                                                self.takenPiecesToReloadAtIndex.append(iy)
                                                                                
                                                                                
                                                                                func chartData() {
                                                                                    for var gr = 0; gr < self.whiteRooks.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteRooks[gr]  {
                                                                                            self.points -= 500
                                                                                            self.whiteRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    for var gr = 0; gr < self.blackRooks.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackRooks[gr]  {
                                                                                            self.points += 500
                                                                                            self.blackRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.whiteKnights.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteKnights[gr]  {
                                                                                            self.points -= 300
                                                                                            self.whiteKnights.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.blackKnights.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackKnights[gr]  {
                                                                                            self.points += 300
                                                                                            self.blackKnights.removeAtIndex(gr)
                                                                                            print("blackKnights taken")
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.whiteBishops.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteBishops[gr]  {
                                                                                            self.points -= 300
                                                                                            self.whiteBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.blackBishops.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackBishops[gr]  {
                                                                                            self.points += 300
                                                                                            self.blackBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.whiteQueens.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteQueens[gr]  {
                                                                                            self.points -= 900
                                                                                            self.whiteQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.blackQueens.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackQueens[gr]  {
                                                                                            self.points += 900
                                                                                            self.blackQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                //chartData()
                                                                                
                                                                                UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                                                                                    self.pieces[iy].alpha = 0
                                                                                    }, completion: {finish in
                                                                                        
                                                                                        
                                                                                        
                                                                                })
                                                                                
                                                                            }
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    else {
                                                                        print("letters not found")
                                                                    }
                                                                }

                                                                if moves.last == moves.last {
                                                                    
                                                                    checkIfTakenLast()
                                                                    
                                                                    
                                                                    UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                                        
                                                                        self.pieces[i].frame.origin.x = xAxisArr[q]
                                                                        self.pieces[i].frame.origin.y = yAxisArr[a]
                                                                        
                                                                        self.removeLeftWhiteCastleLogic()
                                                                        self.removeRightWhiteCastleLogic()
                                                                        self.removeLogicOptions()
                                                                        self.removeBishopLogicOptions()
                                                                        self.removeRookLogicOptions()
                                                                        self.removeKnightLogicOptions()
                                                                        self.removePawnLogicOptions()
                                                                        self.removeWhiteCanMoveOptions()
                                                                        self.removeBlackCanMoveOptions()
                                                                        self.checkByQueen = false
                                                                        self.checkByBishop = false
                                                                        self.checkByRook = false
                                                                        self.checkByKnight = false
                                                                        self.checkByPawn = false
                                                                        self.pieceWhiteLogicOptions = []
                                                                        self.pieceBlackLogicOptions = []
                                                                        for var i = 0; i < self.piecesArrs.count; i++ {
                                                                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                                                
                                                                                self.piecesArrs[i][t].userInteractionEnabled = false
                                                                            }
                                                                        }
                                                                        }, completion: { finish in
                                                                            self.deletePiecesAfterLoad()
                                                                            
                                                                            self.updateLogic()
                                                                            
                                                                             //this is checkmate, black won
//                                                                            if self.checkByQueen == true || self.checkByBishop == true || self.checkByRook == true || self.checkByKnight == true || self.checkByPawn == true {
//
//                                                                                var checkMate1 = false
//                                                                                var checkMate2 = false
//                                                                                var checkMate3 = false
//                                                                                var checkMate4 = false
//                                                                                var checkMate5 = false
//                                                                                var checkMate6 = false
//                                                                                
//                                                                                self.removePieceOptions()
//                                                                                for var i = 0; i < self.whiteKnights.count;i++ {
//                                                                                    if self.chessPieceSelected(2, pieceid: 2, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKnights[i]) == 0 {
//                                                                                        checkMate1 = true
//                                                                                    }
//                                                                                }
//                                                                                
//                                                                                for var i = 0; i < self.whiteBishops.count;i++ {
//                                                                                    if self.chessPieceSelected(9, pieceid: 1, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteBishops[i]) == 0 {
//                                                                                        checkMate2 = true
//                                                                                    }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteRooks.count;i++ {
//                                                                                    if self.chessPieceSelected(9, pieceid: 3, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteRooks[i]) == 0 {
//                                                                                        checkMate3 = true
//                                                                                    }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteQueens.count;i++ {
//                                                                                    if self.chessPieceSelected(9, pieceid: 4, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteQueens[i]) == 0 {
//                                                                                        checkMate4 = true
//                                                                                    }
//                                                                                }
//                                                                                if self.chessPieceSelected(2, pieceid: 5, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKing) == 0 {
//                                                                                    checkMate5 = true
//                                                                                }
//                                                                                
//                                                                                for var i = 0; i < self.whitePawns.count;i++ {
//                                                                                        if self.whitePawnSelected(true, chosenPiece: self.whitePawns[i]) == 0 {
//                                                                                            checkMate6 = true
//                                                                                        }
//                                                                                }
//                                                                                
//                                                                                if checkMate1 == true && checkMate2 == true && checkMate3 == true && checkMate4 == true && checkMate5 == true && checkMate6 == true {
//
//                                                                                    self.gameFinishedScreen("lost",statusBy: "chekmate.")
//                                                                                    
//                                                                                }
//                                                                            } else {
//                                                                                 //this is stalemate, draw
//                                                                                var staleMate1 = false
//                                                                                var staleMate2 = false
//                                                                                var staleMate3 = false
//                                                                                var staleMate4 = false
//                                                                                var staleMate5 = false
//
//                                                                                self.removePieceOptions()
//                                                                                for var i = 0; i < self.whiteKnights.count;i++ {
//                                                                                    if self.whiteKnights[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(2, pieceid: 2, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKnights[i]) == 0 {
//                                                                                            staleMate1 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                
//                                                                                for var i = 0; i < self.whiteBishops.count;i++ {
//                                                                                    if self.whiteBishops[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(9, pieceid: 1, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteBishops[i]) == 0 {
//                                                                                            staleMate2 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteRooks.count;i++ {
//                                                                                    if self.whiteRooks[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(9, pieceid: 3, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteRooks[i]) == 0 {
//                                                                                            staleMate3 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteQueens.count;i++ {
//                                                                                    if self.whiteQueens[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(9, pieceid: 4, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteQueens[i]) == 0 {
//                                                                                            staleMate4 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                if self.chessPieceSelected(2, pieceid: 5, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKing) == 0 {
//                                                                                    staleMate5 = true
//                                                                                }
//                                                                                if staleMate1 == true && staleMate2 == true && staleMate3 == true && staleMate4 == true && staleMate5 == true {
//                                                                                    self.gameFinishedScreen("drew",statusBy: "stalemate")
//                                                                                    
//                                                                                }
//                                                                            }
                                                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                                                    
                                                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                                                }
                                                                            }
                                                                    
                                                                    })
                                                                    
                                                                }
 
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    self.isWhiteTurn = true
                    
                    //self.updateLogic()
//                    let lastupdate2 = self.game["timeLeftToMove"] as? NSDate
//                    self.timeLeft = NSDate().timeIntervalSinceDate(lastupdate2!)
//                    let lastupdate = self.game["whiteDate"] as? NSDate
//                    self.timeLeft = NSDate().timeIntervalSinceDate(lastupdate!)
                    
                    //setting rating and won/lost/drawn
                    if r!["status_white"] as! String == "won" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 1, sB: 0).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserWon + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "won")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("won",statusBy: "")
                        }
                    }
                    else if r!["status_white"] as! String == "lost" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0, sB: 1).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserLost + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("lost",statusBy: "")
                            
                        }
                    }
                    else if r!["status_white"] as! String == "draw" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserDrawn + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("drew",statusBy: "")
                            
                        }
                    }

                    
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)

                    
                    if r!["status_white"] as! String == "move" {
                        self.isWhiteTurn = true
                        
                        self.turnLturn = "Your Turn"
                        self.turnIndicatorturn = blue
                        self.turnL.text = self.turnLturn
                        self.turnIndicator.backgroundColor = blue
                        self.turnIndicatorG.backgroundColor = blue
                        
                        self.myTurnAtlaunch = true
                        
                        self.addMyTurnAndTime()
                        
                        
                        
                    }
                    else {
                        self.isWhiteTurn = false
                        
                        self.turnLturn = "Their Turn"
                        self.turnIndicatorturn = UIColor.lightGrayColor()
                        
                        self.myTurnAtlaunch = false
                        self.addMyTurnAndTime()
                        
                        self.myTurnAtlaunch = false
                        self.addMyTurnAndTime()
                        
                        for var i = 0; i < self.piecesArrs.count; i++ {
                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                
                                self.piecesArrs[i][t].userInteractionEnabled = false
                            }
                        }
                    }
                    
                    self.isWhiteTurn = true
                    
                    // self.updateLogic()
                    print(self.piecesToDelete)
                    
                    
                }
                else if self.iamWhite && snapshot.value as! String == "done" {
                    
                    let query = PFQuery(className: "Games")
                    query.whereKey("objectId", equalTo: gameID)
                    let r = query.getFirstObject()
                    self.game = r!
                    
                    //setting rating and won/lost/drawn
                    if r!["status_white"] as! String == "won" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 1, sB: 0).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserWon + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "won")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("won",statusBy: "")
                            
                            for var i = 0; i < self.piecesArrs.count; i++ {
                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                    self.piecesArrs[i][t].userInteractionEnabled = false
                                }
                            }
                        }
                    }
                    else if r!["status_white"] as! String == "lost" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0, sB: 1).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserLost + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("lost",statusBy: "")
                            
                            for var i = 0; i < self.piecesArrs.count; i++ {
                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                    self.piecesArrs[i][t].userInteractionEnabled = false
                                }
                            }
                            
                        }
                    }
                    else if r!["status_white"] as! String == "draw" {
                        if r!["whiteRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserDrawn + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["whiteRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("drew",statusBy: "")
                            
                            for var i = 0; i < self.piecesArrs.count; i++ {
                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                    self.piecesArrs[i][t].userInteractionEnabled = false
                                }
                            }
                            
                        }
                    }
                    
                    if r!["draw_white"] as! String == "drawto" {
                        
                        let drawAlert = UIAlertController(title: "Draw Offered", message: "You have been offered a draw. Do you want to accept it?", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        drawAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                                if self.iamWhite {
                                    
                                    if r!["whiteRatedComplete"] as! Bool == false {
                                        
                                        let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                                        PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                                        
                                        let s = self.meUserDrawn + 1
                                        PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                                        
                                        PFUser.currentUser()!.save()
                                        
                                        r!["status_white"] = "draw"
                                        
                                        r!["status_black"] = "draw"
                                        
                                        
                                        r!["whiteRatedComplete"] = true
                                        r!.save()
                                        
                                        for var i = 0; i < self.piecesArrs.count; i++ {
                                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                
                                                self.piecesArrs[i][t].userInteractionEnabled = false
                                            }
                                        }
                                        
                                        self.gameFinishedScreen("drew",statusBy: "")
                                        
                                        
                                        
                                        
                                        
                                        //firebase
                                        
                                        //add who's turn it is
                                        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                                        var status = ["turn": "done"]
                                        
                                        let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                                        statusRef.setValue(status)
                                        //firebase - end
                                        
                                    }
                                }
                                
                            }
                        }))
                        drawAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                                if self.iamWhite {
                                    
                                    
                                        
                                        
                                        r!["draw_white"] = ""
                                        
                                        r!["draw_black"] = ""
                                        
                                        
                                        r!.save()
                                        
                                    
                                    
                                }
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                            }
                        }))
                        self.presentViewController(drawAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                    
                }
                self.myturnAfterTimeCapsule = true
                }, withCancelBlock: { error in
                    print(error.description)
            })
            //firebase - end
            
        }
        else {
            
            let lastupdate = game["blackDate"] as? NSDate
            timeLeft = NSDate().timeIntervalSinceDate(lastupdate!)
            

            
            if (game["blackTime"] as? Int) < 0 {
                print("I won on time")
            }
            
            colorLcolor = "You are Black"
            colorIndicatorcolor = UIColor.blackColor()
            
            whiteQueen = UIImageView(frame: CGRectMake(e, _1, pieceSize, pieceSize))
            
            whiteKing = UIImageView(frame: CGRectMake(d, _1, pieceSize, pieceSize))
            
            
            blackQueen = UIImageView(frame: CGRectMake(e, _8, pieceSize, pieceSize))
            
            blackKing = UIImageView(frame: CGRectMake(d, _8, pieceSize, pieceSize))
            
            
            blackKnights = [blackKnight1, blackKnight2]
            blackBishops = [blackBishop1, blackBishop2]
            blackRooks = [blackRook1, blackRook2]
            blackPawns = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8]
            blackQueens = [blackQueen]
            blackKings = [blackKing]
            
            blackKnightsM = [blackKnight1, blackKnight2]
            blackBishopsM = [blackBishop1, blackBishop2]
            blackRooksM = [blackRook1, blackRook2]
            blackPawnsM = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8]
            blackQueensM = [blackQueen]
            
            whitePawns  = [whitePawn1, whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8]
            whiteKnights = [whiteKnight1, whiteKnight2]
            whiteBishops = [whiteBishop1, whiteBishop2]
            whiteRooks = [whiteRook1, whiteRook2]
            whiteQueens = [whiteQueen]
            whiteKings = [whiteKing]
            
            whitePawnsM  = [whitePawn1, whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8]
            whiteKnightsM = [whiteKnight1, whiteKnight2]
            whiteBishopsM = [whiteBishop1, whiteBishop2]
            whiteRooksM = [whiteRook1, whiteRook2]
            whiteQueensM = [whiteQueen]
            
            blackPieces = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
            blackPiecesString = ["blackPawn","blackPawn","blackPawn", "blackPawn", "blackPawn", "blackPawn",  "blackPawn", "blackPawn", "blackKnight", "blackKnight", "blackBishop",  "blackBishop", "blackRook", "blackRook", "blackQueen", "blackKing" ]
            whitePieces = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2 ,whiteBishop1, whiteBishop2, whiteRook1, whiteRook2 , whiteQueen, whiteKing]
            whitePiecesString = ["whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whiteKnight","whiteKnight","whiteBishop","whiteBishop","whiteRook", "whiteRook", "whiteQueen","whiteKing"]
            
            
            //Must not be equal!
            piecesArrs = [whiteQueens,whiteKings,whitePawns,blackPawns,whiteKnights,whiteBishops,whiteRooks, blackKnights, blackBishops, blackRooks, blackQueens, blackKings]
            piecesString = ["blackQueen","blackKing","blackPawn","whitePawn","blackKnight","blackBishop","blackRook", "whiteKnight", "whiteBishop", "whiteRook", "whiteQueen", "whiteKing"]
            //
            
            pieces = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen, whiteKing,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
            
            piecesWhiteLogic = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, whiteKing]
            
            piecesBlackLogic = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
            
            //Must be equal!
            //      piecesArrs = [whiteQueens,whiteKings,whitePawns,blackPawns,whiteKnights,whiteBishops,whiteRooks, blackKnights, blackBishops, blackRooks, blackQueens, blackKings]
            //   piecesString = ["whiteQueen","whiteKing","whitePawn","blackPawn","whiteKnight","whiteBishop","whiteRook", "blackKnight", "blackBishop", "blackRook", "blackQueen", "blackKing"]
            xAxisArrStr2 = ["h","g","f","e","d","c","b","a"]
            yAxisArrStr2 = ["8","7","6","5","4","3","2","1"]
            
            
            ////////this is where the magic happens\\\\\\\\
            func magic2() {
                var am = 0
                var count = 0
                var countBlack = 0
                for var o = 0; o < moves.count; o++ {
                    am++
                    
                    for var t = 0; t < xAxisArrStr2.count; t++ {
                        
                        if moves[o].characters.count == 3 {
                            print("Checking castling")
                            if String(moves[o][2])  == "0" {
                                //can return false value??
                                if  moves.indexOf(moves[o])!  % 2 == 0 {
                                    // test
                                    
                                    if moves.last == moves[o] && am == moves.count{
                                        print("Castling white long")
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            
                                            self.blackKing.frame.origin.x = f
                                            self.blackKing.frame.origin.y = _8
                                            self.blackRook2.frame.origin.x = e
                                            self.blackRook2.frame.origin.y = _8
                                            
                                            
                                            }, completion: { finish in
                                                for var i = 0; i < self.piecesArrs.count; i++ {
                                                    for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                        self.piecesArrs[i][t].userInteractionEnabled = true
                                                    }
                                                }
                                                self.deletePiecesAfterLoad()
                                                self.updateLogic()
                                        })
                                        
                                    }
                                    else {
                                        self.blackKing.frame.origin.x = f
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook2.frame.origin.x = e
                                        self.blackRook2.frame.origin.y = _8
                                    }
                                    
                                    
                                }
                                    
                                else {
                                    
                                    if moves.last == moves[o] && am == moves.count{
                                        
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            print("Castling black long")
                                            self.whiteKing.frame.origin.x = f
                                            self.whiteKing.frame.origin.y = _1
                                            self.whiteRook1.frame.origin.x = e
                                            self.whiteRook1.frame.origin.y = _1
                                            
                                            
                                            
                                            }, completion: { finish in
                                                for var i = 0; i < self.piecesArrs.count; i++ {
                                                    for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                        self.piecesArrs[i][t].userInteractionEnabled = true
                                                    }
                                                }
                                                self.deletePiecesAfterLoad()
                                                self.updateLogic()})
                                        
                                    }
                                    else {
                                        self.whiteKing.frame.origin.x = f
                                        self.whiteKing.frame.origin.y = _1
                                        self.whiteRook1.frame.origin.x = e
                                        self.whiteRook1.frame.origin.y = _1
                                    }
                                    
                                    
                                    
                                }
                            }
                           
                        }
                        else if String(moves[o][0])  == "0" && String(moves[o][1])  == "0" {
                            
                            if  o % 2 == 0 {
                                
                                if moves.last == moves[o] && am == moves.count{
                                    print("Castling white short")
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        
                                        self.blackKing.frame.origin.x = b
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook1.frame.origin.x = c
                                        self.blackRook1.frame.origin.y = _8
                                        
                                        
                                        
                                        }, completion: { finish in
                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                }
                                            }
                                            self.deletePiecesAfterLoad()
                                            self.updateLogic()
                                    })
                                    
                                }
                                else {
                                    
                                    blackKing.frame.origin.x = b
                                    blackKing.frame.origin.y = _8
                                    blackRook1.frame.origin.x = c
                                    blackRook1.frame.origin.y = _8
                                }
                                
                            }
                                
                            else {
                                if moves.last == moves[o] && am == moves.count{
                                    print("Castling black short")
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        // Castling white top left
                                        self.whiteKing.frame.origin.x = b
                                        self.whiteKing.frame.origin.y = _1
                                        self.whiteRook2.frame.origin.x = c
                                        self.whiteRook2.frame.origin.y = _1
                                        
                                        }, completion: { finish in
                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                }
                                            }
                                            self.deletePiecesAfterLoad()
                                            self.updateLogic()})
                                    
                                }
                                else {
                                    
                                    self.whiteKing.frame.origin.x = b
                                    self.whiteKing.frame.origin.y = _1
                                    self.whiteRook2.frame.origin.x = c
                                    self.whiteRook2.frame.origin.y = _1
                                }
                                
                            }
                        }
                        else if String(moves[o][0]) == xAxisArrStr2[t] {
                            
                            for var p = 0; p < yAxisArrStr2.count; p++ {
                                if String(moves[o][1]) == yAxisArrStr2[p] {
                                    for var i = 0; i < pieces.count; i++ {
                                        var remove = false
                                        if pieces[i].frame.origin.x == xAxisArr[t] {
                                            if pieces[i].frame.origin.y == yAxisArr[p] {
                                                
                                                print("this is complicated")
                                                
                                                for var q = 0; q < xAxisArrStr2.count; q++ {
                                                    if String(moves[o][2]) == xAxisArrStr2[q] {
                                                        for var a = 0; a < yAxisArrStr2.count; a++ {
                                                            if String(moves[o][3]) == yAxisArrStr2[a] {
                                                                
                                                                let range = notations[o].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                                
                                                                func checkIfTakenLast() {
                                                                    
                                                                    for var w = 0; w < whitePawns.count; w++ {
                                                                        if String(moves[o][1])  == "2" && String(moves[o][3]) == "1" && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == whitePawns[w]  {
                                                                            print("Notation promotion")
                                                                            if blackPromotionType[countBlack] == "Queen"{
                                                                                self.pieces[i].image = UIImage(named:"blackQueen")
                                                                                self.whiteQueens += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"blackRook")
                                                                                self.whiteRooks += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else  if blackPromotionType[countBlack] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"blackBishop")
                                                                                self.whiteBishops += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else  if blackPromotionType[countBlack] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"blackKnight")
                                                                                self.whiteKnights += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    for var w = 0; w < blackPawns.count; w++ {
                                                                        if String(moves[o][1])  == "7" && String(moves[o][3]) == "8"  && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == blackPawns[w] {
                                                                            print("Notation promotion white")
                                                                            print(blackPawns.count)
                                                                            print(w)
                                                                            if whitePromotionType[count] == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                                self.blackQueens += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"whiteRook")
                                                                                self.blackRooks += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                                self.blackBishops += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                                self.blackKnights += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    // range will be nil if no letters is found
                                                                    if  (range != nil) {
                                                                        print("letters  found")
                                                                        self.canPassant = r!["passant"] as! Bool
                                                                        self.canPassantBlack = r!["passantBlack"] as! Bool
                                                                        for var iy = 0; iy < pieces.count; iy++ {
                                                                            
                                                                            if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && passantArray[o] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && passantArray[o] == true  {
                                                                                
                                                                                print("iy is \(iy)")
                                                                                
                                                                                for var ty = 0; ty < self.whitePieces.count; ty++ {
                                                                                    if self.whitePieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenBlackPieces, _image: self.pieces[iy])) {
                                                                                            
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenBlackPieces += [self.pieces[iy]]
                                                                                            takenBlackPiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenBlackPiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: blackPiecesTypes[t])) {
                                                                                                blackCount[t] += 1
                                                                                                if (!self.containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                                                                                    
                                                                                                    takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenBlackPiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                                                                                if darkMode {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenBlackPiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.whitePieces[ty]]
                                                                                        //    self.whitePieces[ty].removeFromSuperview()
                                                                                        self.whitePieces.removeAtIndex(ty)
                                                                                        self.whitePiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPieces.count; ty++ {
                                                                                    if  self.blackPieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenWhitePieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenWhitePieces += [self.pieces[iy]]
                                                                                            takenWhitePiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenWhitePiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: whitePiecesTypes[t])) {
                                                                                                whiteCount[t] += 1
                                                                                                if (!self.containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                                                                                    takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenWhitePiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                                                                                takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                if darkMode {
                                                                                                    takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenWhitePiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenWhitePiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.blackPieces[ty]]
                                                                                        //      self.blackPieces[ty].removeFromSuperview()
                                                                                        self.blackPieces.removeAtIndex(ty)
                                                                                        self.blackPiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.whitePawns.count; ty++ {
                                                                                    if self.whitePawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        //                                                                                        self.whitePawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPawns.count; ty++ {
                                                                                    if self.blackPawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        //                                                                                        self.blackPawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                self.piecesToDelete.append(self.pieces[iy])
                                                                                
                                                                                self.takenPiecesToReload.append(self.pieces[iy])
                                                                                self.takenPiecesToReloadAtIndex.append(iy)
                                                                                
                                                                                func chartData() {
                                                                                    for var gr = 0; gr < whiteRooks.count; gr++ {
                                                                                        if self.pieces[iy] == whiteRooks[gr]  {
                                                                                            points -= 500
                                                                                            whiteRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    for var gr = 0; gr < blackRooks.count; gr++ {
                                                                                        if self.pieces[iy] == blackRooks[gr]  {
                                                                                            points += 500
                                                                                            blackRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteKnights.count; gr++ {
                                                                                        if self.pieces[iy] == whiteKnights[gr]  {
                                                                                            points -= 300
                                                                                            whiteKnights.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackKnights.count; gr++ {
                                                                                        if self.pieces[iy] == blackKnights[gr]  {
                                                                                            points += 300
                                                                                            blackKnights.removeAtIndex(gr)
                                                                                            print("blackKnights taken")
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteBishops.count; gr++ {
                                                                                        if self.pieces[iy] == whiteBishops[gr]  {
                                                                                            points -= 300
                                                                                            whiteBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackBishops.count; gr++ {
                                                                                        if self.pieces[iy] == blackBishops[gr]  {
                                                                                            points += 300
                                                                                            blackBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteQueens.count; gr++ {
                                                                                        if self.pieces[iy] == whiteQueens[gr]  {
                                                                                            points -= 900
                                                                                            whiteQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackQueens.count; gr++ {
                                                                                        if self.pieces[iy] == blackQueens[gr]  {
                                                                                            points += 900
                                                                                            blackQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                //     chartData()
                                                                                
                                                                                UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                                                                                    self.pieces[iy].alpha = 0
                                                                                    }, completion: {finish in
                                                                                        
                                                                                        
                                                                                })
                                                                                
                                                                            }
                                                                        }
                                                                        
                                                                    }
                                                                    else {
                                                                        print("letters not found")
                                                                    }
                                                                }
                                                                func checkIfTaken() {
                                                                    
                                                                    for var w = 0; w < whitePawns.count; w++ {
                                                                        if String(moves[o][1])  == "2" && String(moves[o][3]) == "1" && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == whitePawns[w]  {
                                                                            print("Notation promotion")
                                                                            if blackPromotionType[countBlack] == "Queen"{
                                                                                self.pieces[i].image = UIImage(named:"blackQueen")
                                                                                self.whiteQueens += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else if blackPromotionType[countBlack] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"blackRook")
                                                                                self.whiteRooks += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else  if blackPromotionType[countBlack] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"blackBishop")
                                                                                self.whiteBishops += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            } else  if blackPromotionType[countBlack] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"blackKnight")
                                                                                self.whiteKnights += [pieces[i]]
                                                                                self.whitePawns.removeAtIndex(w)
                                                                                countBlack++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    for var w = 0; w < blackPawns.count; w++ {
                                                                        if String(moves[o][1])  == "7" && String(moves[o][3]) == "8"  && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == blackPawns[w] {
                                                                            print("Notation promotion white")
                                                                            print(blackPawns.count)
                                                                            print(w)
                                                                            if whitePromotionType[count] == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                                self.blackQueens += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"whiteRook")
                                                                                self.blackRooks += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                                self.blackBishops += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            } else if whitePromotionType[count] == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                                self.blackKnights += [pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                                count++
                                                                            }
                                                                            promotionAtIndex.append(o)
                                                                            
                                                                        }
                                                                    }
                                                                    
                                                                    // range will be nil if no letters is found
                                                                    if  (range != nil) {
                                                                        print("letters  found")
                                                                        
                                                                        for var iy = 0; iy < pieces.count; iy++ {

                                                                       if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && passantArray[o] == true ||  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && passantArray[o] == true   {

                                                                            
                                                                      
                                                                                
                                                                                print("iy is \(iy)")
                                                                                
                                                                                for var ty = 0; ty < self.whitePieces.count; ty++ {
                                                                                    if self.whitePieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenBlackPieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenBlackPieces += [self.pieces[iy]]
                                                                                            takenBlackPiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenBlackPiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: blackPiecesTypes[t])) {
                                                                                                blackCount[t] += 1
                                                                                                if (!self.containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                                                                                    takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenBlackPiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                                                                                if darkMode {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenBlackPiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.whitePieces[ty]]
                                                                                        //    self.whitePieces[ty].removeFromSuperview()
                                                                                        self.whitePieces.removeAtIndex(ty)
                                                                                        self.whitePiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPieces.count; ty++ {
                                                                                    if  self.blackPieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenWhitePieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenWhitePieces += [self.pieces[iy]]
                                                                                            takenWhitePiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenWhitePiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: whitePiecesTypes[t])) {
                                                                                                whiteCount[t] += 1
                                                                                                if (!self.containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                                                                                    takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenWhitePiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                                                                                takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                if darkMode {
                                                                                                    takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenWhitePiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenWhitePiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.blackPieces[ty]]
                                                                                        //      self.blackPieces[ty].removeFromSuperview()
                                                                                        self.blackPieces.removeAtIndex(ty)
                                                                                        self.blackPiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                //                                                                                for var ty = 0; ty < self.whitePawns.count; ty++ {
                                                                                //                                                                                    if self.whitePawns[ty] == self.pieces[iy] {
                                                                                //
                                                                                //                                                                                       // self.whitePawns.removeAtIndex(ty)
                                                                                //                                                                                      //  ty--
                                                                                //                                                                                        print("TAKEN")
                                                                                //                                                                                    }
                                                                                //
                                                                                //                                                                                }
                                                                                //                                                                                for var ty = 0; ty < self.blackPawns.count; ty++ {
                                                                                //                                                                                    if self.blackPawns[ty] == self.pieces[iy]{
                                                                                //
                                                                                //                                                                                     //   self.blackPawns.removeAtIndex(ty)
                                                                                //                                                                                     //   ty--
                                                                                //                                                                                        print("TAKEN")
                                                                                //                                                                                    }
                                                                                //
                                                                                //                                                                                }
                                                                                
                                                                                self.pieces[iy].alpha = 0
                                                                                
                                                                                self.piecesToDelete.append(self.pieces[iy])
                                                                                
                                                                                self.takenPiecesToReload.append(self.pieces[iy])
                                                                                self.takenPiecesToReloadAtIndex.append(iy)
                                                                                
                                                                                func chartData() {
                                                                                    for var gr = 0; gr < whiteRooks.count; gr++ {
                                                                                        if self.pieces[iy] == whiteRooks[gr]  {
                                                                                            points -= 500
                                                                                            whiteRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    for var gr = 0; gr < blackRooks.count; gr++ {
                                                                                        if self.pieces[iy] == blackRooks[gr]  {
                                                                                            points += 500
                                                                                            blackRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteKnights.count; gr++ {
                                                                                        if self.pieces[iy] == whiteKnights[gr]  {
                                                                                            points -= 300
                                                                                            whiteKnights.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackKnights.count; gr++ {
                                                                                        if self.pieces[iy] == blackKnights[gr]  {
                                                                                            points += 300
                                                                                            blackKnights.removeAtIndex(gr)
                                                                                            print("blackKnights taken")
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteBishops.count; gr++ {
                                                                                        if self.pieces[iy] == whiteBishops[gr]  {
                                                                                            points -= 300
                                                                                            whiteBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackBishops.count; gr++ {
                                                                                        if self.pieces[iy] == blackBishops[gr]  {
                                                                                            points += 300
                                                                                            blackBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < whiteQueens.count; gr++ {
                                                                                        if self.pieces[iy] == whiteQueens[gr]  {
                                                                                            points -= 900
                                                                                            whiteQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < blackQueens.count; gr++ {
                                                                                        if self.pieces[iy] == blackQueens[gr]  {
                                                                                            points += 900
                                                                                            blackQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                // chartData()
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    else {
                                                                        print("letters not found")
                                                                    }
                                                                }
                                                                
                                                                if moves.last == moves[o] && am == moves.count{
                                                                    
                                                                    checkIfTakenLast()
                                                                    
                                                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                                                        
                                                                        self.pieces[i].frame.origin.x = xAxisArr[q]
                                                                        self.pieces[i].frame.origin.y = yAxisArr[a]
                                                                        
                                                                        
                                                                        
                                                                        }, completion: { finish in
                                                                            self.deletePiecesAfterLoad()
                                                                            self.updateLogic()
                                                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                                                }
                                                                            }
                                                                         
                                                                    })
                                                                   
                                                                    
                                                                }
                                                                else {
                                                                    
                                                                    checkIfTaken()
                                                                    print(pieces[i])
                                                                    
                                                                    self.pieces[i].frame.origin.x = xAxisArr[q]
                                                                    self.pieces[i].frame.origin.y = yAxisArr[a]
                                                                    
                                                                    self.deletePiecesAfterLoad()
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }
                }
            }
            
            iamWhite = false
            
            if r!["status_black"] as! String == "move" {
                isWhiteTurn = true
                
                turnLturn = "Your Turn"
                turnIndicatorturn = blue
                
                
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
                
                
                self.myTurnAtlaunch = true
                
                self.addMyTurnAndTime()
                
                
                for var i = 0; i < piecesArrs.count; i++ {
                    for var t = 0; t < piecesArrs[i].count; t++ {
                        self.piecesArrs[i][t].image = UIImage(named: piecesString[i])
                        self.view.addSubview(self.piecesArrs[i][t])
                        self.piecesArrs[i][t].contentMode = .ScaleAspectFit
                        self.piecesArrs[i][t].userInteractionEnabled = true
                        self.piecesArrs[i][t].multipleTouchEnabled = true
                    }
                }
            }
            else {
                isWhiteTurn = false
                
                turnLturn = "Their Turn"
                turnIndicatorturn = UIColor.lightGrayColor()
                
                myTurnAtlaunch = false
                addMyTurnAndTime()
                
                for var i = 0; i < piecesArrs.count; i++ {
                    for var t = 0; t < piecesArrs[i].count; t++ {
                        piecesArrs[i][t].image = UIImage(named: piecesString[i])
                        self.view.addSubview(piecesArrs[i][t])
                        piecesArrs[i][t].contentMode = .ScaleAspectFit
                        piecesArrs[i][t].userInteractionEnabled = false
                        piecesArrs[i][t].multipleTouchEnabled = true
                    }
                }
            }
            
            magic2()
            
            print("I am black player!")
            canOnlyMoveWhite = true
            self.title = r!["whitePlayer"] as? String
            self.hasBlackRookMoved = r!["hasBlackRookMoved"] as! Bool
            self.hasBlackRookMoved2 = r!["hasBlackRookMoved2"] as! Bool
            self.hasBlackKingMoved = r!["can_Castle_black"] as! Bool
            self.hasWhiteKingMoved = r!["can_Castle_white"] as! Bool
            let un = [r!["blackPlayer"]!,r!["whitePlayer"]!]
            self.passantPiece = (r!["passantPiece"] as? Int)!
            self.canPassant = r!["passant"] as! Bool
            self.canPassantBlack = r!["passantBlack"] as! Bool
            self.promotion = r!["promotion"] as! Bool
            let userQuery = PFQuery(className: "_User")
            userQuery.whereKey("username", containedIn: un )
            userQuery.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    if let result = result as! [PFUser]! {
                        for result in result {
                            
                            let rating = result["rating"] as? Int
                            if (result["username"] as? String)! == r!["blackPlayer"]! as! String {
                                self.meUserRatingInt = result["rating"] as! Int!
                                self.meUserWon = Int(result["won"] as! String!)!
                                self.meUserLost = Int(result["lost"] as! String!)!
                                self.meUserDrawn = Int(result["drawn"] as! String!)!
                                
                            }
                            else {
                                self.otherUserRatingInt = result["rating"] as! Int!
                            }
                            let profilePictureObject = result["profile_picture"] as? PFFile
                            
                            if(profilePictureObject != nil)
                            {
                                profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                                    
                                    if(imageData != nil)
                                    {
                                        images.append(imageData!)
                                        if (result["username"] as? String)! == r!["blackPlayer"]! as! String {
                                            
                                            self.meImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(self.meImage)
                                            
                                            self.meUserImage = UIImage(data: imageData!)!
                                            self.meUserName = (result["username"] as? String)!
                                            self.meUserRating = "\(result["rating"] as! Int)"
                                            
                                            
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                self.meImage.alpha = 1
                                                
                                                if screenHeight == 480.0 {
                                                    self.meImage.alpha = 0
                                                    
                                                }
                                                },completion: { finish in
                                                    // self.addMyTurnAndTime()
                                                    
                                            })
                                            
                                        }
                                        else {
                                            self.otherImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(self.otherImage)
                                            
                                            self.otherUserImage = UIImage(data: imageData!)!
                                            self.otherUserRating = "\(result["rating"] as! Int)"
                                            
                                            self.otherUserName = (result["username"] as? String)!
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                self.otherImage.alpha = 1
                                                if screenHeight == 480.0 {
                                                    self.otherImage.alpha = 0
                                                    
                                                }
                                            })
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                    }
                    //setting rating and won/lost/drawn
                    if r!["status_black"] as! String == "won" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0, sB: 1).1
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserWon + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "won")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
             
                            
                            self.gameFinishedScreen("lost",statusBy: "")

                        }
                    }
                    else if r!["status_black"] as! String == "lost" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 1, sB: 0).1
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserLost + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("won",statusBy: "")

                        }
                    }
                    else if r!["status_black"] as! String == "draw" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserDrawn + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("drew",statusBy: "")

                        }
                        
                    }
                    if r!["draw_black"] as! String == "drawto" {
                        
                        let drawAlert = UIAlertController(title: "Draw Offered", message: "You have been offered a draw. Do you want to accept it?", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        drawAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                                if !self.iamWhite {
                                    
                                    if r!["blackRatedComplete"] as! Bool == false {
                                        
                                        let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0.5, sB: 0.5).1
                                        PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                                        
                                        let s = self.meUserDrawn + 1
                                        PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                                        
                                        PFUser.currentUser()!.save()
                                        
                                        r!["status_white"] = "draw"
                                        
                                        r!["status_black"] = "draw"
                                        
                                        
                                        r!["blackRatedComplete"] = true
                                        r!.save()
                                        
                                        self.gameFinishedScreen("drew",statusBy: "")
                                        
                                        
                                        for var i = 0; i < self.piecesArrs.count; i++ {
                                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                self.piecesArrs[i][t].userInteractionEnabled = false
                                            }
                                        }
                                        
                                        
                                        //firebase
                                        
                                        //add who's turn it is
                                        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                                        var status = ["turn": "done"]
                                        
                                        let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                                        statusRef.setValue(status)
                                        //firebase - end
                                        
                                    }
                                }
                                
                            }
                        }))
                        drawAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                                if !self.iamWhite {
                                    
                                    
                                        
                                        
                                        r!["draw_white"] = ""
                                        
                                        r!["draw_black"] = ""
                                        
                                        
                                        r!.save()
                                        
                                    
                                    
                                }
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                            }
                        }))
                        self.presentViewController(drawAlert, animated: true, completion: nil)
                        
                        
                    }
                }
            })
            
            
            //firebase
            //check for any changes that may have accured at the destined game ≈_≈
            let check = Firebase(url:"https://chess-panber.firebaseio.com/games/\(gameID)")
            check.observeEventType(.ChildChanged, withBlock: { snapshot in
                print(snapshot.value)
                
                if self.didEnterTimeCapsule {
                    self.forwardB.userInteractionEnabled = false
                    self.backwardB.userInteractionEnabled = false
                    self.exitTimeCapsuleB.userInteractionEnabled = false
                    
                    self.magic4(Int(self.slider.value))
                    
                    self.slider.value = self.slider.maximumValue
                    
                    self.didEnterTimeCapsule = false
                    
                    if self.myturnAfterTimeCapsule {
                        
                        for var i = 0; i < self.piecesArrs.count; i++ {
                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                self.piecesArrs[i][t].userInteractionEnabled = true
                                self.piecesArrs[i][t].multipleTouchEnabled = true
                            }
                        }
                    }
                    
                    if self.slider.value == self.slider.maximumValue {
                        self.forwardB.enabled = false
                        
                        
                        
                        UIView.animateWithDuration(0.8, animations: { () -> Void in
                            if self.iamWhite {
                                for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                    takenWhitePiecesLbl[t].frame.origin.y += 100
                                }
                                for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                                    takenWhitePiecesForMove[t].frame.origin.y += 100
                                }
                                for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                    takenBlackPiecesLbl[t].frame.origin.y -= 100
                                }
                                for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                                    takenBlackPiecesForMove[t].frame.origin.y -= 100
                                }
                            }
                            else {
                                for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                    takenWhitePiecesLbl[t].frame.origin.y -= 100
                                }
                                for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                                    takenWhitePiecesForMove[t].frame.origin.y -= 100
                                }
                                for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                    takenBlackPiecesLbl[t].frame.origin.y += 100
                                }
                                for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                                    takenBlackPiecesForMove[t].frame.origin.y += 100
                                }
                            }
                            self.slider.frame.origin.y = screenHeight/2 + 150
                            self.capsuleB.frame.origin.y = screenHeight/2 + 246
                            self.capsuleL.frame.origin.y = 200
                            
                            self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                            self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                            
                            self.collectionView.frame.origin.y  = 86
                            self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 20
                            self.otherImage.frame.origin.y = 64 + 13
                            
                            
                            self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2
                            self.notationsL.frame.origin.y = screenHeight/2 + 150 - 47
                            self.exitTimeCapsuleB.frame.origin.y = screenHeight/2 + 150 - 47
                            
                            
                            
                            self.timeGL.frame.origin.y -= 100
                            self.turnGL.frame.origin.y -= 100
                            self.turnIndicatorG.frame.origin.y -= 100
                            
                            if screenHeight == 667 {
                                self.capsuleB.frame.origin.y = screenHeight/2 + 220
                                self.slider.frame.origin.y = screenHeight/2 + 150
                                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 47
                                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 47
                                self.collectionView.frame.origin.y = 78
                                
                                self.otherImage.frame.origin.y = 64 + 8
                                self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 13
                                
                                
                            }
                            else if screenHeight ==  568 {self.capsuleB.frame.origin.y = screenHeight/2 + 180
                                self.slider.frame.origin.y = screenHeight/2 + 150 - 50
                                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.collectionView.frame.origin.y = 74
                                
                                self.otherImage.frame.origin.y = 64 + 7
                                self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 9
                                
                                
                            }
                            else   if screenHeight == 480 {
                                self.slider.frame.origin.y = screenHeight/2 + 150 - 47
                                self.capsuleB.frame.origin.y = screenHeight/2 + 180
                                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                                self.collectionView.frame.origin.y = 74
                                
                                
                            }
                            
                            }, completion: {finish in
                                //sender.value = 50
                                
                        })
                        
                    }
                    
                }
                if self.game ["blackPlayer"] as? String == PFUser.currentUser()?.username && snapshot.value as! String == "black" {
                    
                    
                    let query = PFQuery(className: "Games")
                    query.whereKey("objectId", equalTo: gameID)
                    let r = query.getFirstObject()
                    self.game = r!
                    var last = r!["piecePosition"] as! Array<String>
                    self.notations.append(last.last!)
                    var lastPromotionType = r!["whitePromotionType"] as! Array<String>
                    if lastPromotionType.count > 0 {
                        self.whitePromotionType.append(lastPromotionType.last!)
                    }
                    self.passantArray = self.game["passantArray"] as! Array<Bool>


                    self.hasBlackKingMoved = r!["can_Castle_black"] as! Bool
                    self.hasWhiteKingMoved = r!["can_Castle_white"] as! Bool
                    self.promotion = r!["promotion"] as! Bool
                    let newIndexPath = NSIndexPath(forItem: self.notations.count - 1, inSection: 0)
                    self.collectionView.insertItemsAtIndexPaths([newIndexPath])
                    self.collectionView.layoutIfNeeded()
                    self.collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .Bottom, animated: true)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionView.reloadData()
                    }
                    print("notations.count is \(self.notations.count)")
                    loadMoves()
                    self.passantPiece = (r!["passantPiece"] as? Int)!
                    self.canPassantBlack = r!["passantBlack"] as! Bool
                    self.canPassant = r!["passant"] as! Bool
                    
                    for var i = 0; i < self.piecesArrs.count; i++ {
                        for var t = 0; t < self.piecesArrs[i].count; t++ {
                            self.piecesArrs[i][t].userInteractionEnabled = false
                        }
                    }
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)

                    for var t = 0; t < xAxisArrStr2.count; t++ {
                        if moves.last!.characters.count == 3 {
                            
                            if String(moves.last![2])  == "0" {
                                //can return false value??
                                if  moves.indexOf(moves.last!)!  % 2 == 0 {
                                    // test
                                    if moves.last == moves.last{
                                        
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            
                                            self.blackKing.frame.origin.x = f
                                            self.blackKing.frame.origin.y = _8
                                            self.blackRook2.frame.origin.x = e
                                            self.blackRook2.frame.origin.y = _8
                                            
                                            }, completion: { finish in})
                                        
                                    }
                                    
                                }
                                    
                                else {
                                    
                                    if moves.last == moves.last{
                                        
                                        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                            // white castle top left
                                            self.blackKing.frame.origin.x = f
                                            self.blackKing.frame.origin.y = _8
                                            self.blackRook2.frame.origin.x = e
                                            self.blackRook2.frame.origin.y = _8
                                            
                                            }, completion: { finish in})
                                        
                                    }
                                    
                                    
                                    
                                }
                            }
                        }
                        else if String(moves.last![0])  == "0" && String(moves.last![1])  == "0" {
                            if  moves.indexOf(moves.last!)!  % 2 == 0  {
                                print("Castling white short")
                                if moves.last == moves.last{
                                    
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        // white castle top right
                                        self.blackKing.frame.origin.x = b
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook1.frame.origin.x = c
                                        self.blackRook1.frame.origin.y = _8
                                        
                                        }, completion: { finish in})
                                    
                                }
                                
                            }
                                
                            else {
                                
                                if moves.last == moves.last{
                                    
                                    UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseInOut, animations:{ () -> Void in
                                        
                                        self.blackKing.frame.origin.x = b
                                        self.blackKing.frame.origin.y = _8
                                        self.blackRook1.frame.origin.x = c
                                        self.blackRook1.frame.origin.y = _8
                                        
                                        
                                        
                                        }, completion: { finish in})
                                    
                                }
                                
                                
                            }
                        }
                        else if String(moves.last![0]) == xAxisArrStr2[t] {
                            for var p = 0; p < yAxisArrStr2.count; p++ {
                                if String(moves.last![1]) == yAxisArrStr2[p] {
                                    for var i = 0; i < self.pieces.count; i++ {
                                        if self.pieces[i].frame.origin.x == xAxisArr[t] {
                                            if self.pieces[i].frame.origin.y == yAxisArr[p] {
                                                
                                                print("this is complicated")
                                                
                                                for var q = 0; q < xAxisArrStr2.count; q++ {
                                                    if String(moves.last![2]) == xAxisArrStr2[q] {
                                                        for var a = 0; a < yAxisArrStr2.count; a++ {
                                                            if String(moves.last![3]) == yAxisArrStr2[a] {
                                                                
                                                                
                                                                let range = self.notations.last!.rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                                
                                                                func checkIfTakenLast() {
                                                                    
                                                                    for var w = 0; w < self.blackPawns.count; w++ {
                                                                        if String(moves.last![1])  == "7" && String(moves.last![3]) == "8"  && self.pieces[i].image == UIImage(named:"whitePawn") && self.pieces[i] == self.blackPawns[w] {
                                                                            if self.whitePromotionType.last! == "Queen" {
                                                                                self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                                self.blackQueens += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            } else if self.whitePromotionType.last! == "Rook" {
                                                                                self.pieces[i].image = UIImage(named:"whiteRook")
                                                                                self.blackRooks += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            } else if self.whitePromotionType.last! == "Bishop" {
                                                                                self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                                self.blackBishops += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            } else if self.whitePromotionType.last! == "Knight" {
                                                                                self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                                self.blackKnights += [self.pieces[i]]
                                                                                self.blackPawns.removeAtIndex(w)
                                                                            }
                                                                            self.promotionAtIndex.append(self.movesCap.count-1)
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                    // range will be nil if no letters is found
                                                                    if  (range != nil) {
                                                                        print("letters  found")
                                                                        for var iy = 0; iy < self.pieces.count; iy++ {
                                                                            
                                                                            if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && self.pieces[i].image == UIImage(named:"blackPawn") && self.pieces[iy].image == UIImage(named:"whitePawn") && self.passantArray[self.movesCap.count-1] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && self.pieces[i].image == UIImage(named:"whitePawn") && self.pieces[iy].image == UIImage(named:"blackPawn") && self.passantArray[self.movesCap.count-1] == true   {
                                                                                
                                                                                print("iy is \(iy)")
                                                                                print(xAxisArr[q])
                                                                                print(yAxisArr[a])
                                                                                
                                                                                for var ty = 0; ty < self.whitePieces.count; ty++ {
                                                                                    if self.whitePieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenBlackPieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenBlackPieces += [self.pieces[iy]]
                                                                                            takenBlackPiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                           // self.view.insertSubview(takenPiece, belowSubview: self.visualEffectViewT)

                                                                                        }
                                                                                        takenBlackPiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: blackPiecesTypes[t])) {
                                                                                                blackCount[t] += 1
                                                                                                if (!self.containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                                                                                    takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenBlackPiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                                                                                }
                                                                                                takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                                                                                if darkMode {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                                                                                }else {
                                                                                                    takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                                                                                    
                                                                                                }
                                                                                                
                                                                                                
                                                                                                takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenBlackPiecesLbl[t])
                                                                                                //self.view.insertSubview(takenBlackPiecesLbl[t], belowSubview: self.visualEffectViewT)
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.whitePieces[ty]]
                                                                                        //    self.whitePieces[ty].removeFromSuperview()
                                                                                        self.whitePieces.removeAtIndex(ty)
                                                                                        self.whitePiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPieces.count; ty++ {
                                                                                    if  self.blackPieces[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPieces[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        if (!self.contains(takenWhitePieces, _image: self.pieces[iy])) {
                                                                                            takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                                                                            takenPiece.image = self.pieces[iy].image
                                                                                            takenWhitePieces += [self.pieces[iy]]
                                                                                            takenWhitePiecesForMove += [takenPiece]
                                                                                            
                                                                                            self.view.addSubview(takenPiece)
                                                                                        }
                                                                                        takenWhitePiecesForInfo += [self.pieces[iy]]
                                                                                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                                                                            if (self.pieces[iy].image == UIImage(named: whitePiecesTypes[t])) {
                                                                                                whiteCount[t] += 1
                                                                                                if (!self.containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                                                                                    takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 - 5.6 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                                                                                    takenWhitePiecesLbl[t].frame.origin.y += 5
                                                                                                    
                                                                                                    takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                                                                                }
                                                                                                takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                                                                                if darkMode {takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()}
                                                                                                else {takenWhitePiecesLbl[t].textColor = UIColor.blackColor()}
                                                                                                takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                                                                                takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                                                                                self.view.addSubview(takenWhitePiecesLbl[t])
                                                                                            }
                                                                                        }
                                                                                        
                                                                                        self.pieceToTake += [self.blackPieces[ty]]
                                                                                        //      self.blackPieces[ty].removeFromSuperview()
                                                                                        self.blackPieces.removeAtIndex(ty)
                                                                                        self.blackPiecesString.removeAtIndex(ty)
                                                                                        ty--
                                                                                        
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.whitePawns.count; ty++ {
                                                                                    if self.whitePawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.whitePawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        //                                                                                        self.whitePawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                for var ty = 0; ty < self.blackPawns.count; ty++ {
                                                                                    if self.blackPawns[ty].frame.origin.x == self.pieces[iy].frame.origin.x && self.blackPawns[ty].frame.origin.y == self.pieces[iy].frame.origin.y {
                                                                                        
                                                                                        //                                                                                        self.blackPawns.removeAtIndex(ty)
                                                                                        //                                                                                        ty--
                                                                                        print("TAKEN")
                                                                                    }
                                                                                    
                                                                                }
                                                                                self.piecesToDelete.append(self.pieces[iy])
                                                                                
                                                                                self.takenPiecesToReload.append(self.pieces[iy])
                                                                                self.takenPiecesToReloadAtIndex.append(iy)
                                                                                
                                                                                func chartData() {
                                                                                    for var gr = 0; gr < self.whiteRooks.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteRooks[gr]  {
                                                                                            self.points -= 500
                                                                                            self.whiteRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    for var gr = 0; gr < self.blackRooks.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackRooks[gr]  {
                                                                                            self.points += 500
                                                                                            self.blackRooks.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.whiteKnights.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteKnights[gr]  {
                                                                                            self.points -= 300
                                                                                            self.whiteKnights.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.blackKnights.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackKnights[gr]  {
                                                                                            self.points += 300
                                                                                            self.blackKnights.removeAtIndex(gr)
                                                                                            print("blackKnights taken")
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.whiteBishops.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteBishops[gr]  {
                                                                                            self.points -= 300
                                                                                            self.whiteBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.blackBishops.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackBishops[gr]  {
                                                                                            self.points += 300
                                                                                            self.blackBishops.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.whiteQueens.count; gr++ {
                                                                                        if self.pieces[iy] == self.whiteQueens[gr]  {
                                                                                            self.points -= 900
                                                                                            self.whiteQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                    for var gr = 0; gr < self.blackQueens.count; gr++ {
                                                                                        if self.pieces[iy] == self.blackQueens[gr]  {
                                                                                            self.points += 900
                                                                                            self.blackQueens.removeAtIndex(gr)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                //   chartData()
                                                                                
                                                                                UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                                                                                    self.pieces[iy].alpha = 0
                                                                                    }, completion: {finish in
                                                                                        
                                                                                        
                                                                                })
                                                                                
                                                                            }
                                                                        }
                                                                        
                                                                        
                                                                    }
                                                                    else {
                                                                        print("letters not found")
                                                                    }
                                                                }
                                                                
                                                                if moves.last == moves.last {
                                                                    
                                                                    checkIfTakenLast()
                                                                    
                                                                    UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                                        self.pieces[i].frame.origin.x = xAxisArr[q]
                                                                        self.pieces[i].frame.origin.y = yAxisArr[a]
                                                                        self.removeLogicOptions()
                                                                        self.removeLeftBlackCastleLogic()
                                                                        self.removeRightBlackCastleLogic()
                                                                        self.removeBishopLogicOptions()
                                                                        self.removeRookLogicOptions()
                                                                        self.removeKnightLogicOptions()
                                                                        self.removePawnLogicOptions()
                                                                        self.removeWhiteCanMoveOptions()
                                                                        self.removeBlackCanMoveOptions()
                                                                        self.checkByQueen = false
                                                                        self.checkByBishop = false
                                                                        self.checkByRook = false
                                                                        self.checkByKnight = false
                                                                        self.checkByPawn = false
                                                                        self.pieceWhiteLogicOptions = []
                                                                        self.pieceBlackLogicOptions = []
                                                                        for var i = 0; i < self.piecesArrs.count; i++ {
                                                                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                                                self.piecesArrs[i][t].userInteractionEnabled = false
                                                                            }
                                                                        }
                                                                        
                                                                        }, completion: { finish in
                                                                            
                                                                            self.deletePiecesAfterLoad()
                                                                            
                                                                            self.updateLogic()
                                                                            
                                                                             //this is checkmate, white won
//                                                                            if self.checkByQueen == true || self.checkByBishop == true || self.checkByRook == true || self.checkByKnight == true || self.checkByPawn == true {
//                                                                                
//                                                                                var checkMate1 = false
//                                                                                var checkMate2 = false
//                                                                                var checkMate3 = false
//                                                                                var checkMate4 = false
//                                                                                var checkMate5 = false
//                                                                                var checkMate6 = false
//                                                                                
//                                                                                self.removePieceOptions()
//                                                                                
//                                                                                for var i = 0; i < self.whiteKnights.count;i++ {
//                                                                                        if self.chessPieceSelected(2, pieceid: 2, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKnights[i]) == 0 {
//                                                                                            checkMate1 = true
//                                                                                        }
//                                                                                }
//                                                                                
//                                                                                for var i = 0; i < self.whiteBishops.count;i++ {
//                                                                                        if self.chessPieceSelected(9, pieceid: 1, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteBishops[i]) == 0 {
//                                                                                            checkMate2 = true
//                                                                                        }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteRooks.count;i++ {
//                                                                                        if self.chessPieceSelected(9, pieceid: 3, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteRooks[i]) == 0 {
//                                                                                            checkMate3 = true
//                                                                                        }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteQueens.count;i++ {
//                                                                                        if self.chessPieceSelected(9, pieceid: 4, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteQueens[i]) == 0 {
//                                                                                            checkMate4 = true
//                                                                                        }
//                                                                                }
//                                                                                if self.chessPieceSelected(2, pieceid: 5, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKing) == 0 {
//                                                                                    checkMate5 = true
//                                                                                }
//                                                                                
//                                                                                for var i = 0; i < self.whitePawns.count;i++ {
//                                                                                        if self.whitePawnSelected(true, chosenPiece: self.whitePawns[i]) == 0 {
//                                                                                            checkMate6 = true
//                                                                                        }
//                                                                                }
//                                                                                
//                                                                                if checkMate1 == true && checkMate2 == true && checkMate3 == true && checkMate4 == true && checkMate5 == true && checkMate6 == true {
// 
//                                                                                    self.gameFinishedScreen("won",statusBy: "chekmate.")
//                                                                                }
//                                                                            }
//                                                                            else {
//                                                                                 //this is stalemate, draw
//                                                                                var staleMate1 = false
//                                                                                var staleMate2 = false
//                                                                                var staleMate3 = false
//                                                                                var staleMate4 = false
//                                                                                var staleMate5 = false
//                                                                                
//                                                                                self.removePieceOptions()
//                                                                                for var i = 0; i < self.whiteKnights.count;i++ {
//                                                                                    if self.whiteKnights[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(2, pieceid: 2, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKnights[i]) == 0 {
//                                                                                            staleMate1 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                
//                                                                                for var i = 0; i < self.whiteBishops.count;i++ {
//                                                                                    if self.whiteBishops[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(9, pieceid: 1, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteBishops[i]) == 0 {
//                                                                                            staleMate2 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteRooks.count;i++ {
//                                                                                    if self.whiteRooks[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(9, pieceid: 3, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteRooks[i]) == 0 {
//                                                                                            staleMate3 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                for var i = 0; i < self.whiteQueens.count;i++ {
//                                                                                    if self.whiteQueens[i].alpha == 1 {
//                                                                                        if self.chessPieceSelected(9, pieceid: 4, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteQueens[i]) == 0 {
//                                                                                            staleMate4 = true
//                                                                                        }
//                                                                                    }
//                                                                                }
//                                                                                if self.chessPieceSelected(2, pieceid: 5, friend: self.whitePieces, enemy: self.blackPieces, hidden: true, chosenPiece: self.whiteKing) == 0 {
//                                                                                    staleMate5 = true
//                                                                                }
//                                                                                if staleMate1 == true && staleMate2 == true && staleMate3 == true && staleMate4 == true && staleMate5 == true {
//                                                                                    self.gameFinishedScreen("drew",statusBy: "stalemate")
//                                                                                    
//                                                                                }
//                                                                                
//                                                                            }
                                                                            for var i = 0; i < self.piecesArrs.count; i++ {
                                                                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                                                    self.piecesArrs[i][t].userInteractionEnabled = true
                                                                                }
                                                                            }
                                                                    })
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    self.isWhiteTurn = true
                    
//                    let lastupdate = self.game["timeLeftToMove"] as? NSDate
//                    self.timeLeft = NSDate().timeIntervalSinceDate(lastupdate!)
//                    let lastupdate = self.game["blackDate"] as? NSDate
//                    self.timeLeft = NSDate().timeIntervalSinceDate(lastupdate!)
                    //setting rating and won/lost/drawn
                    if r!["status_black"] as! String == "won" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0, sB: 1).1
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserWon + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "won")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            
                            
                            self.gameFinishedScreen("lost",statusBy: "")
                            
                        }
                    }
                    else if r!["status_black"] as! String == "lost" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 1, sB: 0).1
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserLost + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("won",statusBy: "")
                            
                        }
                    }
                    else if r!["status_black"] as! String == "draw" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserDrawn + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            self.gameFinishedScreen("drew",statusBy: "")
                            
                        }
                    }

                    self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)

                    if r!["status_black"] as! String == "move" {
                        self.isWhiteTurn = true
                        
                        self.turnLturn = "Your Turn"
                        self.turnIndicatorturn = blue
                        self.turnL.text = self.turnLturn
                        self.turnIndicator.backgroundColor = blue
                        self.turnIndicatorG.backgroundColor = blue
                        
                        self.myTurnAtlaunch = true
                        //self.alreadyloadedTime = false
                        
                        self.addMyTurnAndTime()
                        
                        
   
                    }
                    else {
                        self.isWhiteTurn = false
                        
                        for var i = 0; i < self.piecesArrs.count; i++ {
                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                
                                self.piecesArrs[i][t].userInteractionEnabled = false
                            }
                        }
                    }
                }
                else if snapshot.value as! String == "done" && !self.iamWhite{
                
                    let query = PFQuery(className: "Games")
                    query.whereKey("objectId", equalTo: gameID)
                    let r = query.getFirstObject()
                    self.game = r!
                    
                    if r!["status_black"] as! String == "won" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0, sB: 1).1
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserWon + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "won")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            for var i = 0; i < self.piecesArrs.count; i++ {
                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                    self.piecesArrs[i][t].userInteractionEnabled = false
                                }
                            }
                            
                            
                            self.gameFinishedScreen("lost",statusBy: "")
                            
                        }
                    }
                    else if r!["status_black"] as! String == "lost" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 1, sB: 0).1
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserLost + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            for var i = 0; i < self.piecesArrs.count; i++ {
                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                    self.piecesArrs[i][t].userInteractionEnabled = false
                                }
                            }
                            
                            self.gameFinishedScreen("won",statusBy: "")
                            
                        }
                    }
                    else if r!["status_black"] as! String == "draw" {
                        if r!["blackRatedComplete"] as! Bool == false {
                            let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0.5, sB: 0.5).0
                            PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                            
                            let s = self.meUserDrawn + 1
                            PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                            
                            PFUser.currentUser()!.save()
                            
                            r!["blackRatedComplete"] = true
                            r!.save()
                            
                            for var i = 0; i < self.piecesArrs.count; i++ {
                                for var t = 0; t < self.piecesArrs[i].count; t++ {
                                    self.piecesArrs[i][t].userInteractionEnabled = false
                                }
                            }
                            
                            self.gameFinishedScreen("drew",statusBy: "")
                            
                        }
                    }
                    if r!["draw_black"] as! String == "drawto" {
                        
                        let drawAlert = UIAlertController(title: "Draw Offered", message: "You have been offered a draw. Do you want to accept it?", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        drawAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                                if self.iamWhite {
                                    
                                    if r!["blackRatedComplete"] as! Bool == false {
                                        
                                        let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 0.5, sB: 0.5).1
                                        PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                                        
                                        let s = self.meUserDrawn + 1
                                        PFUser.currentUser()!.setObject("\(s)", forKey: "drawn")
                                        
                                        PFUser.currentUser()!.save()
                                        
                                        r!["status_white"] = "draw"
                                        
                                        r!["status_black"] = "draw"
                                        
                                        
                                        r!["blackRatedComplete"] = true
                                        r!.save()
                                        
                                        self.gameFinishedScreen("drew",statusBy: "")
                                        
                                        
                                        for var i = 0; i < self.piecesArrs.count; i++ {
                                            for var t = 0; t < self.piecesArrs[i].count; t++ {
                                                self.piecesArrs[i][t].userInteractionEnabled = false
                                            }
                                        }
                                        
                                        
                                        //firebase
                                        
                                        //add who's turn it is
                                        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                                        var status = ["turn": "done"]
                                        
                                        let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                                        statusRef.setValue(status)
                                        //firebase - end
                                        
                                    }
                                }
                                
                            }
                        }))
                        drawAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { action in
                            switch action.style{
                                
                            case .Cancel:
                                print("cancel")
                                
                                if !self.iamWhite {
                                    
                                    
                                        
                                        
                                        r!["draw_white"] = ""
                                        
                                        r!["draw_black"] = ""
                                        
                                        
                                        r!.save()
                                        
                                    
                                    
                                }
                                
                            case .Destructive:
                                print("destructive")
                                
                            case .Default:
                                print("default")
                                
                            }
                        }))
                        self.presentViewController(drawAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                }
                self.myturnAfterTimeCapsule = true
                }, withCancelBlock: { error in
                    print(error.description)
            })
            //firebase - end
            
            
        }
        
        func viewDidLoad2() {
            
//            takenBlackPieces = []
//            takenWhitePieces = []
            blackPawnCount = 0
            blackBishopCount = 0
            blackKnightCount = 0
            blackRookCount = 0
            blackQueenCount = 0
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 109, height: 22)
            
            if screenHeight == 736.0 {
                collectionView = UICollectionView(frame: CGRectMake(screenWidth-125, 86, 111, 46), collectionViewLayout: layout)
            } else if screenHeight == 667.0 {
                collectionView = UICollectionView(frame: CGRectMake(screenWidth-108, 78, 111, 46), collectionViewLayout: layout)
            } else if screenHeight == 568.0 {
                collectionView = UICollectionView(frame: CGRectMake(screenWidth-92, 74, 101, 36), collectionViewLayout: layout)
                layout.itemSize = CGSize(width: 99, height: 17)
            } else if screenHeight == 480.0 {
                collectionView = UICollectionView(frame: CGRectMake(screenWidth-92, 74, 101, 36), collectionViewLayout: layout)
                layout.itemSize = CGSize(width: 99, height: 17)
                collectionView.alpha = 0
                collectionView.userInteractionEnabled = false
                
                
            }
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.registerClass(MoveCell.self, forCellWithReuseIdentifier: "Move")
            self.view.addSubview(collectionView)
            
            collectionView.showsVerticalScrollIndicator = false
            if darkMode == true {
                
                collectionView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            } else if darkMode == false {
                collectionView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
            
            super.viewDidLoad()
            
            
            
            
            //slider stuff
            //
            slider = UISlider(frame:CGRectMake(00, screenHeight/2 + 150, screenWidth - 0, 20))
            if screenHeight == 568 {slider.frame.origin.y = screenHeight/2 + 150 - 47}
            slider.minimumValue = 0
            slider.maximumValue = Float(notations.count)
            
            slider.value = slider.maximumValue
            slider.continuous = true
            slider.tintColor = red
            slider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
            //view.addSubview(slider)
            //view.sendSubviewToBack(slider)
            //
            
            capsuleL = UILabel(frame: CGRectMake(0,screenHeight/2 - 150,screenWidth,60))
            capsuleL.text = "TIME CAPSULE"
            capsuleL.font = UIFont(name: "Didot", size: 22)
            capsuleL.textAlignment = .Center
            view.addSubview(capsuleL)
            view.sendSubviewToBack(capsuleL)
            
            notationsL = UILabel(frame: CGRectMake(0,screenHeight/2 + 150 - 47,screenWidth/2 - 60,30))
            notationsL.text = ""
            notationsL.font = UIFont(name: "Times", size: 20)
            notationsL.textAlignment = .Center
            view.addSubview(notationsL)
            view.sendSubviewToBack(notationsL)
            
            
            capsuleB = UIButton(frame: CGRectMake(screenWidth - 60,screenHeight/2 + 246,40,40))
            if screenHeight == 667 { capsuleB.frame.origin.y = screenHeight/2 + 220}
            else if screenHeight ==  568 {capsuleB.frame.origin.y = screenHeight/2 + 180}
            capsuleB.setBackgroundImage(UIImage(named: "capsuleClock.png"), forState: .Normal)
            capsuleB.addTarget(self, action: "capsuleButtonPressed:", forControlEvents: .TouchUpInside)
            view.addSubview(capsuleB)
            
            backwardB = UIButton(frame: CGRectMake(screenWidth/2-60,screenHeight/2 + 150 - 47,40,40))
            backwardB.setBackgroundImage(UIImage(named: "arrow_blueB.png"), forState: .Normal)
            backwardB.addTarget(self, action: "backwardButtonPressed:", forControlEvents: .TouchUpInside)
            view.addSubview(backwardB)
            backwardB.enabled = false
            view.sendSubviewToBack(backwardB)
            
            
            //        let sliderOverlay = UILabel(frame: CGRectMake(0,screenHeight/2 + screenWidth/2 + 12,screenWidth,25))
            //        sliderOverlay.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            //        view.addSubview(sliderOverlay)
            // var uu: CGFloat = screenWidth/CGFloat(notations.count)
            
            forwardB = UIButton(frame: CGRectMake(screenWidth/2+20,screenHeight/2 + 150 - 47,40,40))
            forwardB.setBackgroundImage(UIImage(named: "arrow_blueF.png"), forState: .Normal)
            forwardB.addTarget(self, action: "forwardButtonPressed:", forControlEvents: .TouchUpInside)
            forwardB.enabled = false
            view.addSubview(forwardB)
            view.sendSubviewToBack(forwardB)
            print(screenHeight)
            
            
            exitTimeCapsuleB = UIButton(frame: CGRectMake(screenWidth/2 + 60,screenHeight/2 + 150 - 47,screenWidth/2 - 60,40))
            exitTimeCapsuleB.titleLabel?.font = UIFont(name: "Times", size: 20)
            exitTimeCapsuleB.setTitle("Exit", forState: .Normal)
            exitTimeCapsuleB.setTitleColor(red, forState: .Normal)
            exitTimeCapsuleB.addTarget(self, action: "exitTimeCapsuleBPressed:", forControlEvents: .TouchUpInside)
            exitTimeCapsuleB.titleLabel?.textAlignment = NSTextAlignment.Center
            view.addSubview(exitTimeCapsuleB)
            view.sendSubviewToBack(exitTimeCapsuleB)
            
            
            var uu: CGFloat = CGFloat(Int(screenWidth/CGFloat(movesCap.count + 1) - screenWidth/CGFloat(movesCap.count+1)/CGFloat(movesCap.count + 1)))
            print("uu is \(uu)")
            sliderPointer = UILabel(frame: CGRectMake(screenWidth - uu - CGFloat(((screenWidth/CGFloat(movesCap.count + 1))/CGFloat(movesCap.count + 1))),screenHeight/2 + screenWidth/2 ,uu + CGFloat(((screenWidth/CGFloat(movesCap.count+1))/CGFloat(movesCap.count+1))),7))
            if sliderPointer.frame.size.width < 15 { sliderPointer.frame.size.width = 15; sliderPointer.frame.origin.x = screenWidth - 15}
            sliderPointer.backgroundColor = blue
            sliderPointer.alpha = 0.75
            view.addSubview(sliderPointer)
            view.sendSubviewToBack(sliderPointer)
            
            
            if screenHeight == 480 {
                self.tabBarController?.tabBar.hidden = true
                slider.frame.origin.y = screenHeight/2 + 150 - 47
                capsuleB.frame.origin.y = screenHeight/2 + 180
            }
            
            //print("\(screenHeight) is the height and \(screenWidth) is the width. \(screenSize) is the screensize. \(pieceSize) is the pieceSize")
            
        }
        viewDidLoad2()
        lightOrDarkMode()
    }
        
    
    //last thing i did was to check ewther or noyou can take a peice that was jsut ttaken, remember to add peicetodelete at black
    func deletePiecesAfterLoad () {
        
        for var i = 0; i < piecesToDelete.count ; i++ {
            for var t = 0;  t < pieces.count; t++ {
                if pieces[t].frame.origin.x == piecesToDelete[i].frame.origin.x &&  pieces[t].frame.origin.y == piecesToDelete[i].frame.origin.y  && pieces[t].alpha != 1{
                    pieceToTake += [pieces[t]]
                    pieces[t].removeFromSuperview()
                    pieces.removeAtIndex(t)
                }
            }
        }
        //     updateLogic()
        piecesToDelete = []
    }
    
    override func viewDidDisappear(animated: Bool) {
        notations = []
        whitePromotionType = []
        blackPromotionType = []
        game = PFObject(className: "Games")
        
        timer.invalidate()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {

    if NSUserDefaults.standardUserDefaults().boolForKey("numbered_board") == true {
    
    if iamWhite {
        numbered.image = UIImage(named:"WN")
    }
    else {
        numbered.image = UIImage(named:"BN")
    }
    
    }
    else {
        numbered.image = UIImage(named:"BB")
    
    }
}

    override func viewDidAppear(animated: Bool) {
        var bottomOffset = CGPointMake(0, collectionView.contentSize.height - collectionView.bounds.size.height)
        collectionView.setContentOffset(bottomOffset, animated: false)
        
        forwardB.userInteractionEnabled = false
        backwardB.userInteractionEnabled = false
        exitTimeCapsuleB.userInteractionEnabled = false
        
        self.view.userInteractionEnabled = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        self.view.addGestureRecognizer(longPressRecognizer)
        
        
        
        

        
    }
    
    var numbered = UIImageView()
    
    // MARK: - View did load! 😄
    
    
    var exitTimeCapsuleB = UIButton()
    var sliderPointer = UILabel()
    var notationsL = UILabel()
    var fNum = Double()
    var myturnAfterTimeCapsule = Bool()
    var didEnterTimeCapsule = false
    var visualEffectViewT = UIVisualEffectView()
    // MARK: Focyus
    

    

    
var didLongPress = false
    
    func longPressed(sender: UILongPressGestureRecognizer)
    {
        
        if !didLongPress{
            

            
        visualEffectViewT = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        if darkMode { visualEffectViewT.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectViewT.effect = UIBlurEffect(style: .Light) }
        visualEffectViewT.frame = view.bounds
            let tapPressRecognizer = UITapGestureRecognizer(target: self, action: "visuPressed:")
            self.visualEffectViewT.addGestureRecognizer(tapPressRecognizer)
        visualEffectViewT.alpha = 0
     
            
            
            self.view.addSubview(visualEffectViewT)
           // self.view.sendSubviewToBack(visualEffectViewT)
            for var i = 0; i < pieces.count; i++ {
            self.view.bringSubviewToFront(pieces[i])
            }
            for var i = 0; i < pieceOptions.count; i++ {
                self.view.bringSubviewToFront(pieceOptions[i])
            }
            self.view.bringSubviewToFront(pieceMarked)

                      boardI = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
                    boardI.contentMode = .ScaleAspectFit
                    boardI.image = UIImage(named: "brownChessBoard")
            view.insertSubview(boardI, aboveSubview: visualEffectViewT)
           // view.insertSubview(timeGL, aboveSubview: visualEffectViewT)

            //boardI.userInteractionEnabled = true

            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide) // with animation option.

        
            navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
            setTabBarVisible(!tabBarIsVisible(), animated: true)



                self.view.addSubview(numbered)
            
            

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.visualEffectViewT.alpha = 1
            }, completion: {finish in
                self.visualEffectViewT.userInteractionEnabled = true
        })
        
            didLongPress = true
        print("longpressed")
        }
    }
    
    var  boardI = UIImageView()
    
    func visuPressed(sender: UITapGestureRecognizer)
    {
        
        if didLongPress{
            
     
            

            

            
 
            
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide) // with animation option.
            
            
            navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
            
            setTabBarVisible(!tabBarIsVisible(), animated: true)
            
            
            
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.visualEffectViewT.alpha = 0
                }, completion: {finish in
                    self.visualEffectViewT.userInteractionEnabled = false
                    self.boardI.removeFromSuperview()
                    //self.visualEffectViewT.removeFromSuperview()
                    self.didLongPress = false

            })
            
        }
        
        
        print("tapped")
    }

    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                return
            }
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
    
    

    // MARK: -Time Capsule
    func capsuleButtonPressed(sender: UIButton!) {
        
        removePieceOptions()
        hideMarkedPiece()
        
        
        didEnterTimeCapsule = true
        
        for var i = 0; i < piecesArrs.count; i++ {
            for var t = 0; t < piecesArrs[i].count; t++ {
                piecesArrs[i][t].userInteractionEnabled = false
                piecesArrs[i][t].multipleTouchEnabled = false
            }
        }
        
        if iamWhite {
            if movesCap.count % 2 == 0 {
                myturnAfterTimeCapsule = true
            }
            else {
                myturnAfterTimeCapsule = false
                
            }
        }
        else {
            if movesCap.count % 2 == 0 {
                myturnAfterTimeCapsule = false
            }
            else {
                myturnAfterTimeCapsule = true
                
            }
        }
        
        
        
        forwardB.userInteractionEnabled = true
        backwardB.userInteractionEnabled = true
        exitTimeCapsuleB.userInteractionEnabled = true
        
        
        var uu: CGFloat = CGFloat(Int(screenWidth/CGFloat(movesCap.count + 1) - screenWidth/CGFloat(movesCap.count+1)/CGFloat(movesCap.count + 1)))
        
        
        sliderPointer.frame.origin.x = screenWidth - uu - CGFloat(((screenWidth/CGFloat(movesCap.count + 1))/CGFloat(movesCap.count + 1)))
        sliderPointer.frame.size.width = uu + CGFloat(((screenWidth/CGFloat(movesCap.count+1))/CGFloat(movesCap.count+1)))
        
        
        slider.maximumValue = Float(movesCap.count) - 0
        
        slider.value = slider.maximumValue
        
        //magic3()
        
        forwardB.enabled = false
        backwardB.enabled = true
        
        let n = movesCap.count
        let m = Double(n)
        
        fNum = Double(m/2) - 0.5
        print(fNum)
        
        if floor(fNum) == fNum {
            fNum = Double(movesCap.count/2) + 1
            print(fNum)
        }
        else {
            fNum = Double(movesCap.count/2) + 0.5
            print(fNum)
        }
        
        if floor(fNum) == fNum {
            if Int(slider.value-1) >= 0 {
                notationsL.text = "\(Int(fNum)). \(notations[Int(slider.value)-1])"
            }
            else {
                notationsL.text = ""
                
            }
        }
        else {
            if Int(slider.value-1) >= 0 {
                notationsL.text = "\(Int(fNum-0.5)). \(notations[Int(slider.value)-1])"
            }
            else {
                notationsL.text = ""
                
            }
        }
        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            //self.slider.frame.origin.y = 652
            if self.iamWhite {
                for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                    takenWhitePiecesLbl[t].frame.origin.y -= 100
                }
                for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                    takenWhitePiecesForMove[t].frame.origin.y -= 100
                }
                for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                    takenBlackPiecesLbl[t].frame.origin.y += 100
                }
                for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                    takenBlackPiecesForMove[t].frame.origin.y += 100
                }
            }
            else {
                for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                    takenWhitePiecesLbl[t].frame.origin.y += 100
                }
                for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                    takenWhitePiecesForMove[t].frame.origin.y += 100
                }
                for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                    takenBlackPiecesLbl[t].frame.origin.y -= 100
                }
                for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                    takenBlackPiecesForMove[t].frame.origin.y -= 100
                }
            }
            
            
            
            self.timeGL.frame.origin.y += 100
            self.turnGL.frame.origin.y += 100
            self.turnIndicatorG.frame.origin.y += 100
            
            
            
            self.slider.frame.origin.y = screenHeight/2 + screenWidth/2 + 1
            self.capsuleB.frame.origin.y += 200
            self.capsuleL.frame.origin.y = 78
            self.backwardB.frame.origin.y = 600 + 16
            self.forwardB.frame.origin.y = 600 + 16
            
            self.collectionView.frame.origin.y  = -100
            self.meImage.frame.origin.y = screenHeight + 50
            self.otherImage.frame.origin.y = -100
            
            self.notationsL.frame.origin.y = 600 + 19
            
            self.exitTimeCapsuleB.frame.origin.y = 600 + 16
            
            self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2 + 10
            if self.sliderPointer.frame.size.width < 15 { self.sliderPointer.frame.size.width = 15; self.sliderPointer.frame.origin.x = screenWidth - 15}
            
            if screenHeight == 667 {
                self.capsuleL.frame.origin.y = 72
                self.slider.frame.origin.y = 587
                self.backwardB.frame.origin.y = 552
                self.forwardB.frame.origin.y = 552
                
                self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2 + 8
                self.notationsL.frame.origin.y = 554
                self.exitTimeCapsuleB.frame.origin.y = 552
                
            }
            else if screenHeight == 568 {
                self.capsuleL.frame.origin.y = 62
                self.slider.frame.origin.y = 493
                self.backwardB.frame.origin.y = 465
                self.forwardB.frame.origin.y = 465
                
                self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2 + 6
                self.notationsL.frame.origin.y = 468
                self.exitTimeCapsuleB.frame.origin.y = 465
            }
                
            else if screenHeight == 480 {
                self.slider.frame.origin.y = 450
                self.capsuleB.frame.origin.y = 600
                self.backwardB.frame.origin.y = 409
                self.forwardB.frame.origin.y = 409
            }
            
            
            
            
            }, completion: {finish in
                
        })
        
    }
    
    func sliderValueDidChange(sender:UISlider!)
    {
        forwardB.enabled = true
        if sender.value < 1 {
            backwardB.enabled = false
            
        }
        else {
            backwardB.enabled = true
        }
        
        print("value--\(sender.value)")
        if sender.value == slider.maximumValue  {
            forwardB.enabled = false
            
            
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.slider.frame.origin.y = screenHeight/2 + 150
                self.capsuleB.frame.origin.y = screenHeight/2 + 246
                self.capsuleL.frame.origin.y = 200
                
                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                
                self.collectionView.frame.origin.y  = 86
                self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 30
                self.otherImage.frame.origin.y = 64 + 13
                
                self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2
                self.notationsL.frame.origin.y = screenHeight/2 + 150 - 47
                self.exitTimeCapsuleB.frame.origin.y = screenHeight/2 + 150 - 47
                
                if screenHeight == 667 {
                    self.capsuleB.frame.origin.y = screenHeight/2 + 220
                    self.slider.frame.origin.y = screenHeight/2 + 150
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 47
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 47
                    
                }
                    
                else if screenHeight ==  568 {self.capsuleB.frame.origin.y = screenHeight/2 + 180
                    self.slider.frame.origin.y = screenHeight/2 + 150 - 50
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                }
                    
                else   if screenHeight == 480 {
                    self.slider.frame.origin.y = screenHeight/2 + 150 - 47
                    self.capsuleB.frame.origin.y = screenHeight/2 + 180
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    
                }
                
                }, completion: {finish in
                    //sender.value = 50
                    
            })
            
        }
        
        magic3()
        
        
        
    }
    
    var canPressBackwardButton = true
    
    func forwardButtonPressed(sender:UIButton!) {
        
        if canPressForwardButton == true {
            
            canPressBackwardButton = false
            canPressForwardButton = false
            
            
            slider.value++
            backwardB.enabled = true
            print(slider.value)
            sliderPointer.frame.origin.x += CGFloat((screenWidth/CGFloat(notations.count+1)))
            
            fNum += 0.5
            
            if floor(fNum) == fNum {
                if Int(slider.value-1) >= 0 {
                    notationsL.text = "\(Int(fNum)). \(notations[Int(slider.value)-1])"
                }
            }
            else {
                if Int(slider.value-1) >= 0 {
                    notationsL.text = "\(Int(fNum-0.5)). \(notations[Int(slider.value)-1])"
                }
                else {
                    notationsL.text = ""
                    
                }
            }
            
            magic5(Int(slider.value-1))
            
            if slider.value == slider.maximumValue {
                forwardB.enabled = false
                
                forwardB.userInteractionEnabled = false
                backwardB.userInteractionEnabled = false
                exitTimeCapsuleB.userInteractionEnabled = false
                
                didEnterTimeCapsule = false
                
                if myturnAfterTimeCapsule {
                    
                    for var i = 0; i < piecesArrs.count; i++ {
                        for var t = 0; t < piecesArrs[i].count; t++ {
                            piecesArrs[i][t].userInteractionEnabled = true
                            piecesArrs[i][t].multipleTouchEnabled = true
                        }
                    }
                }
                
                
                self.timeGL.frame.origin.y -= 100
                self.turnGL.frame.origin.y -= 100
                self.turnIndicatorG.frame.origin.y -= 100
                
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    
                    if self.iamWhite {
                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                            takenWhitePiecesLbl[t].frame.origin.y += 100
                        }
                        for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                            takenWhitePiecesForMove[t].frame.origin.y += 100
                        }
                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                            takenBlackPiecesLbl[t].frame.origin.y -= 100
                        }
                        for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                            takenBlackPiecesForMove[t].frame.origin.y -= 100
                        }
                    }
                    else {
                        for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                            takenWhitePiecesLbl[t].frame.origin.y -= 100
                        }
                        for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                            takenWhitePiecesForMove[t].frame.origin.y -= 100
                        }
                        for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                            takenBlackPiecesLbl[t].frame.origin.y += 100
                        }
                        for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                            takenBlackPiecesForMove[t].frame.origin.y += 100
                        }
                    }
                    self.slider.frame.origin.y = screenHeight/2 + 150
                    self.capsuleB.frame.origin.y = screenHeight/2 + 246
                    self.capsuleL.frame.origin.y = 200
                    
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    
                    self.collectionView.frame.origin.y  = 86
                    self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 20
                    self.otherImage.frame.origin.y = 64 + 13
                    
                    
                    self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2
                    self.notationsL.frame.origin.y = screenHeight/2 + 150 - 47
                    self.exitTimeCapsuleB.frame.origin.y = screenHeight/2 + 150 - 47
                    
                    if screenHeight == 667 {
                        self.capsuleB.frame.origin.y = screenHeight/2 + 220
                        self.slider.frame.origin.y = screenHeight/2 + 150
                        self.backwardB.frame.origin.y = screenHeight/2 + 150 - 47
                        self.forwardB.frame.origin.y = screenHeight/2 + 150 - 47
                        self.collectionView.frame.origin.y = 78
                        
                        self.otherImage.frame.origin.y = 64 + 8
                        self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 13
                        
                        
                    }
                    else if screenHeight ==  568 {self.capsuleB.frame.origin.y = screenHeight/2 + 180
                        self.slider.frame.origin.y = screenHeight/2 + 150 - 50
                        self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                        self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                        self.collectionView.frame.origin.y = 74
                        
                        self.otherImage.frame.origin.y = 64 + 7
                        self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 9
                        
                        
                    }
                    else   if screenHeight == 480 {
                        self.slider.frame.origin.y = screenHeight/2 + 150 - 47
                        self.capsuleB.frame.origin.y = screenHeight/2 + 180
                        self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                        self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                        self.collectionView.frame.origin.y = 74
                        
                        
                    }
                    
                    }, completion: {finish in
                        //sender.value = 50
                        
                })
                
            }
            
        }
    }
    
    func backwardButtonPressed(sender:UIButton!) {
        
        
        if canPressBackwardButton == true {
            
            canPressBackwardButton = false
            canPressForwardButton = false
            
            
            
            slider.value--
            print(slider.value)
            sliderPointer.frame.origin.x -= CGFloat((screenWidth/CGFloat(movesCap.count+1)))
            // sliderPointer.frame.origin.x += CGFloat(((screenWidth/CGFloat(notations.count+1))/CGFloat(notations.count+)))
            
            fNum -= 0.5
            
            if floor(fNum) == fNum {
                if Int(slider.value-1) >= 0 {
                    notationsL.text = "\(Int(fNum)). \(notations[Int(slider.value)-1])"
                }
            }
            else {
                if Int(slider.value-1) >= 0 {
                    notationsL.text = "\(Int(fNum-0.5)). \(notations[Int(slider.value)-1])"
                }
                else {
                    notationsL.text = ""
                    
                }
            }
            
            
            if Int(slider.value) == 0 {
                sliderPointer.frame.origin.x = 0
            }
            forwardB.enabled = true
            
            if slider.value == 0 {
                backwardB.enabled = false
                
            }
            //change to false later
            magic3()
        }
    }
    
    
    
    func exitTimeCapsuleBPressed(sender: UIButton!) {
        
        forwardB.userInteractionEnabled = false
        backwardB.userInteractionEnabled = false
        exitTimeCapsuleB.userInteractionEnabled = false
        
        magic4(Int(slider.value))
        
        slider.value = slider.maximumValue
        
        didEnterTimeCapsule = false
        
        if myturnAfterTimeCapsule {
            
            for var i = 0; i < piecesArrs.count; i++ {
                for var t = 0; t < piecesArrs[i].count; t++ {
                    piecesArrs[i][t].userInteractionEnabled = true
                    piecesArrs[i][t].multipleTouchEnabled = true
                }
            }
        }
        
        if slider.value == slider.maximumValue {
            forwardB.enabled = false
            
            
            
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                
                
                if self.iamWhite {
                    for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                        takenWhitePiecesLbl[t].frame.origin.y += 100
                    }
                    for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                        takenWhitePiecesForMove[t].frame.origin.y += 100
                    }
                    for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                        takenBlackPiecesLbl[t].frame.origin.y -= 100
                    }
                    for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                        takenBlackPiecesForMove[t].frame.origin.y -= 100
                    }
                }
                else {
                    for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                        takenWhitePiecesLbl[t].frame.origin.y -= 100
                    }
                    for var t = 0; t < takenWhitePiecesForMove.count; t++ {
                        takenWhitePiecesForMove[t].frame.origin.y -= 100
                    }
                    for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                        takenBlackPiecesLbl[t].frame.origin.y += 100
                    }
                    for var t = 0; t < takenBlackPiecesForMove.count; t++ {
                        takenBlackPiecesForMove[t].frame.origin.y += 100
                    }
                }
                
                self.slider.frame.origin.y = screenHeight/2 + 150
                self.capsuleB.frame.origin.y = screenHeight/2 + 246
                self.capsuleL.frame.origin.y = 200
                
                self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                
                self.collectionView.frame.origin.y  = 86
                self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 20
                self.otherImage.frame.origin.y = 64 + 13
                
                
                self.sliderPointer.frame.origin.y = screenHeight/2 + screenWidth/2
                self.notationsL.frame.origin.y = screenHeight/2 + 150 - 47
                self.exitTimeCapsuleB.frame.origin.y = screenHeight/2 + 150 - 47
                
                
                
                self.timeGL.frame.origin.y -= 100
                self.turnGL.frame.origin.y -= 100
                self.turnIndicatorG.frame.origin.y -= 100
                
                if screenHeight == 667 {
                    self.capsuleB.frame.origin.y = screenHeight/2 + 220
                    self.slider.frame.origin.y = screenHeight/2 + 150
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 47
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 47
                    self.collectionView.frame.origin.y = 78
                    
                    self.otherImage.frame.origin.y = 64 + 8
                    self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 13
                    
                    
                }
                else if screenHeight ==  568 {self.capsuleB.frame.origin.y = screenHeight/2 + 180
                    self.slider.frame.origin.y = screenHeight/2 + 150 - 50
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.collectionView.frame.origin.y = 74
                    
                    self.otherImage.frame.origin.y = 64 + 7
                    self.meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 9
                    
                    
                }
                else   if screenHeight == 480 {
                    self.slider.frame.origin.y = screenHeight/2 + 150 - 47
                    self.capsuleB.frame.origin.y = screenHeight/2 + 180
                    self.forwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.backwardB.frame.origin.y = screenHeight/2 + 150 - 50
                    self.collectionView.frame.origin.y = 74
                    
                    
                }
                
                }, completion: {finish in
                    //sender.value = 50
                    
            })
            
        }
        
    }
    
    var d2 = 0
    //mGIC3
    func magic3() {
        var am = 0
        
        var didIncrease_d2 = false
        
        
        
        var o = Int(slider.value)
        //for var o = movesCap.count-1; o > 1; o-- {
        am++
        
        for var t = 0; t < xAxisArrStr2.count; t++ {
            
            if movesCap[o].characters.count == 3 {
                if String(movesCap[o][2])  == "0" {
                    if  o % 2 == 0 {
                        print("Castling white long")
                        
                        UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                            
                            if self.iamWhite == true {
                                self.whiteKing.frame.origin.x = e
                                self.whiteKing.frame.origin.y = _1
                                self.whiteRook2.frame.origin.x = a
                                self.whiteRook2.frame.origin.y = _1
                            }
                            else {
                                self.blackKing.frame.origin.x = d
                                self.blackKing.frame.origin.y = _8
                                self.blackRook2.frame.origin.x = h
                                self.blackRook2.frame.origin.y = _8
                            }
                            
                            
                            
                            
                            }, completion: { finish in
                                //  self.updateLogic()
                                self.canPressBackwardButton = true
                                self.canPressForwardButton = true
                                
                        })
                        
                        
                        
                    }
                        
                    else {
                        
                        print("Castling black long")
                        UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                            
                            if self.iamWhite == true {
                                self.blackKing.frame.origin.x = e
                                self.blackKing.frame.origin.y = _8
                                self.blackRook1.frame.origin.x = a
                                self.blackRook1.frame.origin.y = _8
                            } else  {
                                self.whiteKing.frame.origin.x = d
                                self.whiteKing.frame.origin.y = _1
                                self.whiteRook1.frame.origin.x = h
                                self.whiteRook1.frame.origin.y = _1
                                
                            }
                            
                            }, completion: { finish in
                                //  self.updateLogic()
                                self.canPressBackwardButton = true
                                self.canPressForwardButton = true
                                
                        })
                        
                        
                        
                        
                    }
                }
            }
                
            else if String(movesCap[o][0])  == "0" && String(movesCap[o][1])  == "0" {
                
                if  o % 2 == 0 {
                    print("Castling white short")
                    
                    UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                        
                        if self.iamWhite == true {
                            self.whiteKing.frame.origin.x = e
                            self.whiteKing.frame.origin.y = _1
                            self.whiteRook1.frame.origin.x = h
                            self.whiteRook1.frame.origin.y = _1
                        }
                        else {
                            self.blackKing.frame.origin.x = d
                            self.blackKing.frame.origin.y = _8
                            self.blackRook1.frame.origin.x = a
                            self.blackRook1.frame.origin.y = _8
                        }
                        
                        
                        }, completion: { finish in
                            //   self.updateLogic()
                            self.canPressBackwardButton = true
                            self.canPressForwardButton = true
                            
                    })
                    
                    
                }
                else {
                    print("Castling black short")
                    UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                        // white castling bottom-right
                        if self.iamWhite == true {
                            self.blackKing.frame.origin.x = e
                            self.blackKing.frame.origin.y = _8
                            self.blackRook2.frame.origin.x = h
                            self.blackRook2.frame.origin.y = _8
                        }
                        else {
                            self.whiteKing.frame.origin.x = d
                            self.whiteKing.frame.origin.y = _1
                            self.whiteRook2.frame.origin.x = a
                            self.whiteRook2.frame.origin.y = _1
                        }
                        }, completion: { finish in
                            //     self.updateLogic()
                            self.canPressBackwardButton = true
                            self.canPressForwardButton = true
                            
                    })
                    
                    
                    
                }
            }
                
            else if String(movesCap[o][2]) == xAxisArrStr2[t] {
                
                for var p = 0; p < yAxisArrStr2.count; p++ {
                    if String(movesCap[o][3]) == yAxisArrStr2[p] {
                        
                        for var i = 0; i < pieces.count; i++ {
                            if pieces[i].frame.origin.x == xAxisArr[t] {
                                if pieces[i].frame.origin.y == yAxisArr[p] {
                                    
                                    print("this is complicated")
                                    
                                    for var q = 0; q < xAxisArrStr2.count; q++ {
                                        if String(movesCap[o][0]) == xAxisArrStr2[q] {
                                            for var a = 0; a < yAxisArrStr2.count; a++ {
                                                if String(movesCap[o][1]) == yAxisArrStr2[a] {
                                                    
                                                    for var pat = 0; pat < promotionAtIndex.count; pat++ {
                                                        //for var elon = 0; elon < pieces.count; elon++ {
                                                        print("promotion at index is \(promotionAtIndex)")
                                                        if promotionAtIndex[pat] == o {
                                                            
                                                            if iamWhite {
                                                                
                                                                if o % 2 == 0 {
                                                                    if pieces[i].image == UIImage(named:"whiteQueen") {
                                                                        for var ram = 0; ram < whiteQueens.count; ram++ {
                                                                            if whiteQueens[ram]  == pieces[i] {
                                                                                whiteQueens.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"whiteRook") {
                                                                        for var ram = 0; ram < whiteRooks.count; ram++ {
                                                                            if whiteRooks[ram]  == pieces[i] {
                                                                                whiteRooks.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"whiteKnight") {
                                                                        for var ram = 0; ram < whiteKnights.count; ram++ {
                                                                            if whiteKnights[ram]  == pieces[i] {
                                                                                whiteKnights.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"whiteBishop") {
                                                                        for var ram = 0; ram < whiteBishops.count; ram++ {
                                                                            if whiteBishops[ram]  == pieces[i] {
                                                                                whiteBishops.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                    print("pat is \(promotionAtIndex[pat])")
                                                                    pieces[i].image = UIImage(named:"whitePawn")
                                                                    whitePawns += [pieces[i]]
                                                                    
                                                                    
                                                                }
                                                                    
                                                                else {
                                                                    if pieces[i].image == UIImage(named:"blackQueen") {
                                                                        for var ram = 0; ram < blackQueens.count; ram++ {
                                                                            if blackQueens[ram]  == pieces[i] {
                                                                                blackQueens.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"blackRook") {
                                                                        for var ram = 0; ram < blackRooks.count; ram++ {
                                                                            if blackRooks[ram]  == pieces[i] {
                                                                                blackRooks.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"blackKnight") {
                                                                        for var ram = 0; ram < blackKnights.count; ram++ {
                                                                            if blackKnights[ram]  == pieces[i] {
                                                                                blackKnights.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"blackBishop") {
                                                                        for var ram = 0; ram < blackBishops.count; ram++ {
                                                                            if blackBishops[ram] == pieces[i] {
                                                                                blackBishops.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                    
                                                                    print("pat is \(promotionAtIndex[pat])")
                                                                    print(iamWhite)
                                                                    print(o)
                                                                    print(movesCap.count)
                                                                    
                                                                    
                                                                    pieces[i].image = UIImage(named:"blackPawn")
                                                                    blackPawns += [pieces[i]]
                                                                    
                                                                }
                                                            }
                                                            else {
                                                                if o % 2 == 0 {
                                                                    if pieces[i].image == UIImage(named:"whiteQueen") {
                                                                        for var ram = 0; ram < blackQueens.count; ram++ {
                                                                            if blackQueens[ram]  == pieces[i] {
                                                                                blackQueens.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"whiteRook") {
                                                                        for var ram = 0; ram < blackRooks.count; ram++ {
                                                                            if blackRooks[ram]  == pieces[i] {
                                                                                blackRooks.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"whiteKnight") {
                                                                        for var ram = 0; ram < blackKnights.count; ram++ {
                                                                            if blackKnights[ram]  == pieces[i] {
                                                                                blackKnights.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"whiteBishop") {
                                                                        for var ram = 0; ram < blackBishops.count; ram++ {
                                                                            if blackBishops[ram]  == pieces[i] {
                                                                                blackBishops.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                    print("pat is \(promotionAtIndex[pat])")
                                                                    pieces[i].image = UIImage(named:"whitePawn")
                                                                    blackPawns += [pieces[i]]
                                                                    
                                                                    
                                                                }
                                                                    
                                                                else {
                                                                    if pieces[i].image == UIImage(named:"blackQueen") {
                                                                        for var ram = 0; ram < whiteQueens.count; ram++ {
                                                                            if whiteQueens[ram]  == pieces[i] {
                                                                                whiteQueens.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"blackRook") {
                                                                        for var ram = 0; ram < whiteRooks.count; ram++ {
                                                                            if whiteRooks[ram]  == pieces[i] {
                                                                                whiteRooks.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"blackKnight") {
                                                                        for var ram = 0; ram < whiteKnights.count; ram++ {
                                                                            if whiteKnights[ram]  == pieces[i] {
                                                                                whiteKnights.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                        
                                                                    else if pieces[i].image == UIImage(named:"blackBishop") {
                                                                        for var ram = 0; ram < whiteBishops.count; ram++ {
                                                                            if whiteBishops[ram]  == pieces[i] {
                                                                                whiteBishops.removeAtIndex(ram)
                                                                                ram--
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                    
                                                                    print("pat is \(promotionAtIndex[pat])")
                                                                    pieces[i].image = UIImage(named:"blackPawn")
                                                                    whitePawns += [pieces[i]]
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                            
                                                            //  }
                                                        }
                                                    }
                                                    
                                                    let range = notations[o].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                    
                                                    func checkIfTakenLast() {
                                                        // range will be nil if no letters is found
                                                        if  (range != nil) {
                                                            print("letters  found")
                                                            print(takenPiecesToReload.count)
                                                            print(takenPiecesToReload.count - 1 - d2)
                                                            
                                                            view.addSubview(takenPiecesToReload[takenPiecesToReload.count - 1 - d2])
                                                            takenPiecesToReload[takenPiecesToReload.count - 1 - d2].alpha = 0
                                                            //  pieces.append(takenPiecesToReload[takenPiecesToReload.count - 1 - d2])
                                                            
                                                            didIncrease_d2 = true
                                                            
                                                        } else {
                                                            print("letters not found")
                                                        }
                                                    }
                                                    
                                                    checkIfTakenLast()
                                                    
                                                    UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                        self.pieces[i].frame.origin.x = xAxisArr[q]
                                                        self.pieces[i].frame.origin.y = yAxisArr[a]
                                                        
                                                        if  didIncrease_d2 == true {
                                                            self.takenPiecesToReload[self.takenPiecesToReload.count - 1 - self.d2].alpha = 1
                                                        }
                                                        
                                                        }, completion: { finish in
                                                            //self.deletePiecesAfterLoad()
                                                            //      self.updateLogic()
                                                            self.canPressBackwardButton = true
                                                            self.canPressForwardButton = true
                                                            
                                                            
                                                            if didIncrease_d2 == true {
                                                                self.pieces.append(self.takenPiecesToReload[self.takenPiecesToReload.count - 1 - self.d2])
                                                                self.takenPiecesToReload.removeAtIndex(self.takenPiecesToReload.count - 1 - self.d2)
                                                                
                                                                
                                                                
                                                            }
                                                    })
                                                    
                                                    
                                                    
                                                }}}}}}}}}}
            
            
        }
        
    }
    
    
    
    func magic4(var fromMoveNumber:Int) {
        var am = 0
        var count = 0
        var countBlack = 0
        for var o = fromMoveNumber; o < movesCap.count; o++ {
            am++
            print("am variable is \(am)")
            for var t = 0; t < xAxisArrStr2.count; t++ {
                
                if movesCap[o].characters.count == 3 {
                    if String(movesCap[o][2])  == "0" {
                        if  o % 2 == 0 {
                            print("Castling white long")
                            UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                                
                                if self.iamWhite {
                                    self.whiteKing.frame.origin.x = c
                                    self.whiteKing.frame.origin.y = _1
                                    self.whiteRook2.frame.origin.x = d
                                    self.whiteRook2.frame.origin.y = _1
                                }
                                else {
                                    self.blackKing.frame.origin.x = f
                                    self.blackKing.frame.origin.y = _8
                                    self.blackRook2.frame.origin.x = e
                                    self.blackRook2.frame.origin.y = _8
                                }
                                }, completion: { finish in
                            })
                            
                            
                            
                        }
                            
                        else {
                            
                            print("Castling black long")
                            UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                                
                                if self.iamWhite {
                                    self.blackKing.frame.origin.x = c
                                    self.blackKing.frame.origin.y = _8
                                    self.blackRook1.frame.origin.x = d
                                    self.blackRook1.frame.origin.y = _8
                                }
                                else {
                                    self.whiteKing.frame.origin.x = f
                                    self.whiteKing.frame.origin.y = _1
                                    self.whiteRook1.frame.origin.x = e
                                    self.whiteRook1.frame.origin.y = _1
                                }
                                
                                }, completion: { finish in})
                            
                            
                            
                            
                        }
                    }
                }
                else if String(movesCap[o][0])  == "0" && String(movesCap[o][1])  == "0" {
                    
                    if  o % 2 == 0 {
                        print("Castling white short")
                        
                        UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                            
                            if self.iamWhite {
                                self.whiteKing.frame.origin.x = g
                                self.whiteKing.frame.origin.y = _1
                                self.whiteRook1.frame.origin.x = f
                                self.whiteRook1.frame.origin.y = _1
                            }
                            else {
                                self.blackKing.frame.origin.x = b
                                self.blackKing.frame.origin.y = _8
                                self.blackRook1.frame.origin.x = c
                                self.blackRook1.frame.origin.y = _8
                                
                            }
                            }, completion: { finish in})
                        
                        
                        
                        
                    } else {
                        print("Castling black short")
                        UIView.animateWithDuration(0.8, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                            // white castling bottom-right
                            
                            if self.iamWhite {
                                self.blackKing.frame.origin.x = g
                                self.blackKing.frame.origin.y = _8
                                self.blackRook2.frame.origin.x = f
                                self.blackRook2.frame.origin.y = _8
                            }
                            else {
                                self.whiteKing.frame.origin.x = b
                                self.whiteKing.frame.origin.y = _1
                                self.whiteRook2.frame.origin.x = c
                                self.whiteRook2.frame.origin.y = _1
                            }
                            }, completion: { finish in})
                        
                        
                        
                    }
                }
                else if String(movesCap[o][0]) == xAxisArrStr2[t] {
                    for var p = 0; p < yAxisArrStr2.count; p++ {
                        if String(movesCap[o][1]) == yAxisArrStr2[p] {
                            for var i = 0; i < pieces.count; i++ {
                                var remove = false
                                if pieces[i].frame.origin.x == xAxisArr[t] {
                                    if pieces[i].frame.origin.y == yAxisArr[p] {
                                        
                                        print("this is complicated")
                                        
                                        for var q = 0; q < xAxisArrStr2.count; q++ {
                                            if String(movesCap[o][2]) == xAxisArrStr2[q] {
                                                for var a = 0; a < yAxisArrStr2.count; a++ {
                                                    if String(movesCap[o][3]) == yAxisArrStr2[a] {
                                                        
                                                        let range = notations[o].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                        
                                                        if iamWhite {
                                                            for var w = 0; w < whitePawns.count; w++ {
                                                                if String(movesCap[o][1])  == "7" && String(movesCap[o][3]) == "8" && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == whitePawns[w]   {
                                                                    print("Notation promotion")
                                                                    if whitePromotionType[count] == "Queen" {
                                                                        self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                        self.whiteQueens += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        count++
                                                                    } else if whitePromotionType[count] == "Rook" {
                                                                        self.pieces[i].image = UIImage(named:"whiteRook")
                                                                        self.whiteRooks += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        count++
                                                                    } else  if whitePromotionType[count] == "Bishop" {
                                                                        self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                        self.whiteBishops += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        count++
                                                                    } else  if whitePromotionType[count] == "Knight" {
                                                                        self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                        self.whiteKnights += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        count++
                                                                    }
                                                                }
                                                            }
                                                            
                                                            for var w = 0; w < blackPawns.count; w++ {
                                                                if String(movesCap[o][1])  == "2" && String(movesCap[o][3]) == "1"  && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == blackPawns[w] {
                                                                    print("Notation promotion")
                                                                    if blackPromotionType[countBlack] == "Queen" {
                                                                        self.pieces[i].image = UIImage(named:"blackQueen")
                                                                        self.blackQueens += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    } else if blackPromotionType[countBlack] == "Rook" {
                                                                        self.pieces[i].image = UIImage(named:"blackRook")
                                                                        self.blackRooks += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    } else if blackPromotionType[countBlack] == "Bishop" {
                                                                        self.pieces[i].image = UIImage(named:"blackBishop")
                                                                        self.blackBishops += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    } else if blackPromotionType[countBlack] == "Knight" {
                                                                        self.pieces[i].image = UIImage(named:"blackKnight")
                                                                        self.blackKnights += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        else {
                                                            for var w = 0; w < whitePawns.count; w++ {
                                                                if String(movesCap[o][1])  == "2" && String(movesCap[o][3]) == "1" && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == whitePawns[w]  {
                                                                    print("Notation promotion")
                                                                    if blackPromotionType[countBlack] == "Queen"{
                                                                        self.pieces[i].image = UIImage(named:"blackQueen")
                                                                        self.whiteQueens += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    } else if blackPromotionType[countBlack] == "Rook" {
                                                                        self.pieces[i].image = UIImage(named:"blackRook")
                                                                        self.whiteRooks += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    } else  if blackPromotionType[countBlack] == "Bishop" {
                                                                        self.pieces[i].image = UIImage(named:"blackBishop")
                                                                        self.whiteBishops += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    } else  if blackPromotionType[countBlack] == "Knight" {
                                                                        self.pieces[i].image = UIImage(named:"blackKnight")
                                                                        self.whiteKnights += [pieces[i]]
                                                                        self.whitePawns.removeAtIndex(w)
                                                                        countBlack++
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                            for var w = 0; w < blackPawns.count; w++ {
                                                                if String(movesCap[o][1])  == "7" && String(movesCap[o][3]) == "8"  && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == blackPawns[w] {
                                                                    print("Notation promotion white")
                                                                    print(blackPawns.count)
                                                                    print(w)
                                                                    if whitePromotionType[count] == "Queen" {
                                                                        self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                        self.blackQueens += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        count++
                                                                    } else if whitePromotionType[count] == "Rook" {
                                                                        self.pieces[i].image = UIImage(named:"whiteRook")
                                                                        self.blackRooks += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        count++
                                                                    } else if whitePromotionType[count] == "Bishop" {
                                                                        self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                        self.blackBishops += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        count++
                                                                    } else if whitePromotionType[count] == "Knight" {
                                                                        self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                        self.blackKnights += [pieces[i]]
                                                                        self.blackPawns.removeAtIndex(w)
                                                                        count++
                                                                    }
                                                                    
                                                                }
                                                            }
                                                        }
                                                        
                                                        func checkIfTaken() {
                                                            // range will be nil if no letters is found
                                                            if  (range != nil) {
                                                                print("letters  found")
                                                                
                                                                for var iy = 0; iy < self.pieces.count; iy++ {
                                                                    
                                                                    
                                                                    if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && self.pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && self.iamWhite == true && passantArray[o] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && self.iamWhite == true && passantArray[o] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && self.iamWhite == false && passantArray[o] == true  || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && self.iamWhite == false && passantArray[o] == true   {
                                                                        
                                                                        
                                                                        self.piecesToDelete.append(pieces[iy])
                                                                        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                                            self.pieces[iy].alpha=0
                                                                            
                                                                            }, completion: { finish in })
                                                                        
                                                                        self.takenPiecesToReload.append(pieces[iy])
                                                                        print("takenPiecesToReload.count - 1 - d3 i \(takenPiecesToReload.count - 1 - self.d3)")
                                                                    }
                                                                }
                                                                
                                                                
                                                            } else {
                                                                print("letters not found")
                                                            }
                                                        }
                                                        
                                                        
                                                        checkIfTaken()
                                                        
                                                        print("pieces[i] is \(pieces[i]) with")
                                                        self.deletePiecesAfterLoad()
                                                        
                                                        UIView.animateWithDuration(0.8, delay: 0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                            self.pieces[i].frame.origin.x = xAxisArr[q]
                                                            self.pieces[i].frame.origin.y = yAxisArr[a]
                                                            
                                                            print("last pieces[i] is \(self.pieces[i])  ")
                                                            
                                                            }, completion: { finish in
                                                                
                                                        })
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
            }
        }
    }
    
    var d3 = 0
    
    
    var canPressForwardButton = true
    //magic 5 is
    func magic5(var moveNumber: Int) {
        
        // movesCap[moveNumber]
        var am = 0
        var count = 0
        var countBlack = 0
        var didIncrease_d3 = false
        
        
        //            am++
        //            print("am variable is \(am)")
        for var t = 0; t < xAxisArrStr2.count; t++ {
            
            if movesCap[moveNumber].characters.count == 3 {
                if String(movesCap[moveNumber][2])  == "0" {
                    if  moveNumber % 2 == 0 {
                        print("Castling white long")
                        UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                            
                            if self.iamWhite {
                                self.whiteKing.frame.origin.x = c
                                self.whiteKing.frame.origin.y = _1
                                self.whiteRook2.frame.origin.x = d
                                self.whiteRook2.frame.origin.y = _1
                            }
                            else {
                                self.blackKing.frame.origin.x = f
                                self.blackKing.frame.origin.y = _8
                                self.blackRook2.frame.origin.x = e
                                self.blackRook2.frame.origin.y = _8
                            }
                            }, completion: { finish in
                                self.canPressForwardButton = true
                                self.canPressBackwardButton = true
                                
                                
                                if didIncrease_d3 == true {
                                    
                                    //self.d3++
                                }
                        })
                        
                        
                        
                    }
                        
                    else {
                        
                        print("Castling black long")
                        UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                            
                            if self.iamWhite {
                                self.blackKing.frame.origin.x = c
                                self.blackKing.frame.origin.y = _8
                                self.blackRook1.frame.origin.x = d
                                self.blackRook1.frame.origin.y = _8
                            }
                            else {
                                self.whiteKing.frame.origin.x = f
                                self.whiteKing.frame.origin.y = _1
                                self.whiteRook1.frame.origin.x = e
                                self.whiteRook1.frame.origin.y = _1
                            }
                            
                            }, completion: { finish in
                                self.canPressForwardButton = true
                                self.canPressBackwardButton = true
                                
                                
                                if didIncrease_d3 == true {
                                    
                                    //self.d3++
                                }
                        })
                        
                        
                        
                        
                    }
                }
            }
                
            else if String(movesCap[moveNumber][0])  == "0" && String(movesCap[moveNumber][1])  == "0" {
                
                if  moveNumber % 2 == 0 {
                    print("Castling white short")
                    
                    UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                        
                        if self.iamWhite {
                            self.whiteKing.frame.origin.x = g
                            self.whiteKing.frame.origin.y = _1
                            self.whiteRook1.frame.origin.x = f
                            self.whiteRook1.frame.origin.y = _1
                        }
                        else {
                            self.blackKing.frame.origin.x = b
                            self.blackKing.frame.origin.y = _8
                            self.blackRook1.frame.origin.x = c
                            self.blackRook1.frame.origin.y = _8
                            
                        }
                        }, completion: { finish in
                            self.canPressForwardButton = true
                            self.canPressBackwardButton = true
                            
                            
                            if didIncrease_d3 == true {
                                
                                //self.d3++
                            }})
                    
                    
                    
                    
                } else {
                    print("Castling black short")
                    UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseInOut, animations:{ () -> Void in
                        // white castling bottom-right
                        
                        if self.iamWhite {
                            self.blackKing.frame.origin.x = g
                            self.blackKing.frame.origin.y = _8
                            self.blackRook2.frame.origin.x = f
                            self.blackRook2.frame.origin.y = _8
                        }
                        else {
                            self.whiteKing.frame.origin.x = b
                            self.whiteKing.frame.origin.y = _1
                            self.whiteRook2.frame.origin.x = c
                            self.whiteRook2.frame.origin.y = _1
                        }
                        }, completion: { finish in
                            self.canPressForwardButton = true
                            self.canPressBackwardButton = true
                            
                            
                            if didIncrease_d3 == true {
                                
                                //self.d3++
                            }})
                    
                    
                    
                }
            }
                
            else if String(movesCap[moveNumber][0]) == xAxisArrStr2[t] {
                for var p = 0; p < yAxisArrStr2.count; p++ {
                    if String(movesCap[moveNumber][1]) == yAxisArrStr2[p] {
                        for var i = 0; i < pieces.count; i++ {
                            var remove = false
                            if pieces[i].frame.origin.x == xAxisArr[t] {
                                if pieces[i].frame.origin.y == yAxisArr[p] {
                                    
                                    print("this is complicated")
                                    
                                    for var q = 0; q < xAxisArrStr2.count; q++ {
                                        if String(movesCap[moveNumber][2]) == xAxisArrStr2[q] {
                                            for var a = 0; a < yAxisArrStr2.count; a++ {
                                                if String(movesCap[moveNumber][3]) == yAxisArrStr2[a] {
                                                    
                                                    let range = notations[moveNumber].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "x"))
                                                    
                                                    if iamWhite {
                                                        for var w = 0; w < whitePawns.count; w++ {
                                                            if String(movesCap[moveNumber][1])  == "7" && String(movesCap[moveNumber][3]) == "8" && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == whitePawns[w]   {
                                                                print("Notation promotion")
                                                                if whitePromotionType[count] == "Queen" {
                                                                    self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                    self.whiteQueens += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    count++
                                                                } else if whitePromotionType[count] == "Rook" {
                                                                    self.pieces[i].image = UIImage(named:"whiteRook")
                                                                    self.whiteRooks += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    count++
                                                                } else  if whitePromotionType[count] == "Bishop" {
                                                                    self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                    self.whiteBishops += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    count++
                                                                } else  if whitePromotionType[count] == "Knight" {
                                                                    self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                    self.whiteKnights += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    count++
                                                                }
                                                            }
                                                        }
                                                        
                                                        for var w = 0; w < blackPawns.count; w++ {
                                                            if String(movesCap[moveNumber][1])  == "2" && String(movesCap[moveNumber][3]) == "1"  && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == blackPawns[w] {
                                                                print("Notation promotion")
                                                                if blackPromotionType[countBlack] == "Queen" {
                                                                    self.pieces[i].image = UIImage(named:"blackQueen")
                                                                    self.blackQueens += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    countBlack++
                                                                } else if blackPromotionType[countBlack] == "Rook" {
                                                                    self.pieces[i].image = UIImage(named:"blackRook")
                                                                    self.blackRooks += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    countBlack++
                                                                } else if blackPromotionType[countBlack] == "Bishop" {
                                                                    self.pieces[i].image = UIImage(named:"blackBishop")
                                                                    self.blackBishops += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    countBlack++
                                                                } else if blackPromotionType[countBlack] == "Knight" {
                                                                    self.pieces[i].image = UIImage(named:"blackKnight")
                                                                    self.blackKnights += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    countBlack++
                                                                }
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        for var w = 0; w < whitePawns.count; w++ {
                                                            if String(movesCap[moveNumber][1])  == "2" && String(movesCap[moveNumber][3]) == "1" && pieces[i].image == UIImage(named:"blackPawn") && pieces[i] == whitePawns[w]  {
                                                                print("Notation promotion")
                                                                if blackPromotionType[countBlack] == "Queen"{
                                                                    self.pieces[i].image = UIImage(named:"blackQueen")
                                                                    self.whiteQueens += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    countBlack++
                                                                } else if blackPromotionType[countBlack] == "Rook" {
                                                                    self.pieces[i].image = UIImage(named:"blackRook")
                                                                    self.whiteRooks += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    countBlack++
                                                                } else  if blackPromotionType[countBlack] == "Bishop" {
                                                                    self.pieces[i].image = UIImage(named:"blackBishop")
                                                                    self.whiteBishops += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    countBlack++
                                                                } else  if blackPromotionType[countBlack] == "Knight" {
                                                                    self.pieces[i].image = UIImage(named:"blackKnight")
                                                                    self.whiteKnights += [pieces[i]]
                                                                    self.whitePawns.removeAtIndex(w)
                                                                    countBlack++
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                        for var w = 0; w < blackPawns.count; w++ {
                                                            if String(movesCap[moveNumber][1])  == "7" && String(movesCap[moveNumber][3]) == "8"  && pieces[i].image == UIImage(named:"whitePawn") && pieces[i] == blackPawns[w] {
                                                                print("Notation promotion white")
                                                                print(blackPawns.count)
                                                                print(w)
                                                                if whitePromotionType[count] == "Queen" {
                                                                    self.pieces[i].image = UIImage(named:"whiteQueen")
                                                                    self.blackQueens += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    count++
                                                                } else if whitePromotionType[count] == "Rook" {
                                                                    self.pieces[i].image = UIImage(named:"whiteRook")
                                                                    self.blackRooks += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    count++
                                                                } else if whitePromotionType[count] == "Bishop" {
                                                                    self.pieces[i].image = UIImage(named:"whiteBishop")
                                                                    self.blackBishops += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    count++
                                                                } else if whitePromotionType[count] == "Knight" {
                                                                    self.pieces[i].image = UIImage(named:"whiteKnight")
                                                                    self.blackKnights += [pieces[i]]
                                                                    self.blackPawns.removeAtIndex(w)
                                                                    count++
                                                                }
                                                                
                                                            }
                                                        }
                                                    }
                                                    
                                                    func checkIfTakenLast() {
                                                        // range will be nil if no letters is found
                                                        if  (range != nil) {
                                                            print("letters  found")
                                                            
                                                            for var iy = 0; iy < pieces.count; iy++ {
                                                                
                                                                
                                                                
                                                                
                                                                if  self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y == yAxisArr[a] || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && self.iamWhite == true && passantArray[moveNumber] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && self.iamWhite == true && passantArray[moveNumber] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y - 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"blackPawn") && pieces[iy].image == UIImage(named:"whitePawn") && self.iamWhite == false && passantArray[moveNumber] == true || self.pieces[iy].frame.origin.x == xAxisArr[q] && self.pieces[iy].frame.origin.y + 1 * pieceSize == yAxisArr[a] && pieces[i].image == UIImage(named:"whitePawn") && pieces[iy].image == UIImage(named:"blackPawn") && self.iamWhite == false && passantArray[moveNumber] == true {
                                                                    
                                                                    
                                                                    piecesToDelete.append(pieces[iy])
                                                                    UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                                        self.pieces[iy].alpha=0
                                                                        
                                                                        }, completion: { finish in })
                                                                    
                                                                    takenPiecesToReload.append(pieces[iy])
                                                                    print("takenPiecesToReload.count - 1 - d3 i \(takenPiecesToReload.count - 1 - d3)")
                                                                    didIncrease_d3 = true
                                                                }
                                                            }
                                                            
                                                            
                                                        } else {
                                                            print("letters not found")
                                                        }
                                                    }
                                                    
                                                    
                                                    checkIfTakenLast()
                                                    
                                                    print("pieces[i] is \(pieces[i]) with")
                                                    self.deletePiecesAfterLoad()
                                                    
                                                    UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseInOut, animations:{ () -> Void in
                                                        self.pieces[i].frame.origin.x = xAxisArr[q]
                                                        self.pieces[i].frame.origin.y = yAxisArr[a]
                                                        
                                                        
                                                        print("last pieces[i] is \(self.pieces[i])  ")
                                                        
                                                        }, completion: { finish in
                                                            
                                                            self.canPressForwardButton = true
                                                            self.canPressBackwardButton = true
                                                            
                                                            
                                                            
                                                    })
 
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
        
        print(moveNumber)
        
        
    }
    // MARK: - whos turn is it?
    
    var turnGL = UILabel()
    var timeGL = UILabel()
    var turnIndicatorG = UILabel()
    
    var myTurnAtlaunch = true
    var alreadyloadedTime = false
    
    var didloadTurnGL = true
    
    
    func addMyTurnAndTime() {
        
        
        if myTurnAtlaunch == true {
            
            
            if alreadyloadedTime == false {
                
                turnGL = UILabel(frame: CGRectMake(screenWidth/2 - 40,screenHeight/2 + screenWidth/2 + 80,80,30))
                
                timeGL = UILabel(frame: CGRectMake(screenWidth/2 - 40,screenHeight/2 + screenWidth/2 + 30,80,30))
                timeGL.font = UIFont(name: "Times", size: 16)
                timeGL.textAlignment = .Center
                
                
                turnGL.text = "Your Turn"
                turnGL.alpha = 0
                turnGL.font = UIFont(name: "Times", size: 16)
                turnGL.textAlignment = .Center
                if darkMode {
                    turnGL.textColor = UIColor.whiteColor() }
                else { turnGL.textColor = UIColor.blackColor()}
                
                if alreadyloadedTime == false {
                    view.addSubview(turnGL)
                    view.sendSubviewToBack(turnGL)
                }
                
                
                if alreadyloadedTime == false {
                    view.addSubview(timeGL)
                    view.sendSubviewToBack(timeGL)
                }
                
                if didloadTurnGL == true {
                    
                    turnIndicatorG = UILabel(frame: CGRectMake(turnGL.frame.origin.x - 10, turnGL.frame.origin.y + 10 , 11, 11))
                    turnIndicatorG.layer.cornerRadius = (turnIndicatorG.frame.size.width)/2
                    turnIndicatorG.clipsToBounds = true
                    turnIndicatorG.backgroundColor = turnIndicatorturn
                    
                    if alreadyloadedTime == false {
                        turnIndicatorG.alpha = 0
                        view.addSubview(turnIndicatorG)
                    }
                    
                    
                    
                    didloadTurnGL = false
                }
                
                if screenHeight == 667 {
                    turnGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 69
                    turnIndicatorG.frame.origin.y = turnGL.frame.origin.y + 10
                    
                }
                else if screenHeight == 568 {
                    turnGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 47
                    timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 70
                    turnIndicatorG.frame.origin.y = turnGL.frame.origin.y + 10
                }
                else if screenHeight == 480 {
                    turnGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 27
                    timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 80
                    meImage.frame.origin.y += 900
                    turnIndicatorG.frame.origin.y = turnGL.frame.origin.y + 10
                }
                
            }
            
            alreadyloadedTime = true
            UIView.animateWithDuration(0.3, delay:0, options: .CurveEaseInOut, animations: { () -> Void in
                self.turnGL.text = "Your Turn"
                
                self.turnGL.alpha = 1
                self.turnIndicatorG.frame.origin.x = self.turnGL.frame.origin.x - 10
                
                
                }, completion: {finish in
                    
                    
                    
            })
            
            UIView.animateWithDuration(0.3, delay: 1.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.turnGL.alpha = 1
                
                self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 80
                self.turnGL.frame.origin.y += 100
                self.turnIndicatorG.frame.origin.x = self.turnGL.frame.origin.x - 10
                
                if screenHeight == 667 {
                    self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 69
                }
                else if screenHeight == 568 {
                    self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 47
                }
                else if screenHeight == 480 {
                    self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 27
                }
                
                }, completion: {finish in
                    
                    UIView.animateWithDuration(0.3, delay:0, options: .CurveEaseInOut, animations: { () -> Void in
                        
                        self.turnIndicatorG.alpha = 1
                        
                        
                        }, completion: {finish in
                            
                            
                            
                    })
                    
            })
        }
        else {
            
            if didloadTurnGL == true {
                
                
                
                
                turnGL = UILabel(frame: CGRectMake(screenWidth/2 - 40,screenHeight/2 + screenWidth/2 + 80,80,30))
                
                turnIndicatorG = UILabel(frame: CGRectMake(turnGL.frame.origin.x - 10, turnGL.frame.origin.y + 10 , 11, 11))
                turnIndicatorG.layer.cornerRadius = (turnIndicatorG.frame.size.width)/2
                turnIndicatorG.clipsToBounds = true
                turnIndicatorG.backgroundColor = turnIndicatorturn
                turnIndicatorG.frame.origin.x = screenWidth/2 - turnIndicatorG.frame.size.width/2
                
                
                
                if screenHeight == 667 {turnIndicatorG.frame.origin.y = screenHeight/2 + screenWidth/2 + 79}
                else if screenHeight == 568 { turnIndicatorG.frame.origin.y = screenHeight/2 + screenWidth/2 + 57}
                else if screenHeight == 480 { turnIndicatorG.frame.origin.y = screenHeight/2 + screenWidth/2 + 37 }
                
                
                
                
                didloadTurnGL = false
            }
            
            if alreadyloadedTime == false {
                turnIndicatorG.alpha = 0
                view.addSubview(turnIndicatorG)
            }
            
            UIView.animateWithDuration(0.3, delay:0, options: .CurveEaseInOut, animations: { () -> Void in
                
                self.turnIndicatorG.alpha = 1
                
                
                }, completion: {finish in
                    
                    
                    
            })
            
            
        }
        
        
    }
    
    
    func gameFinishedScreen(var statusWhite:String, var statusBy:String) {
        
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            visualEffectView.alpha = 1
            }, completion: {finish in
                visualEffectSub.userInteractionEnabled = true
                visualEffectView.userInteractionEnabled = true
        })
        
        var scrollView1 = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        scrollView1.delegate = self
        scrollView1.userInteractionEnabled = true
        scrollView1.scrollEnabled = true
        scrollView1.pagingEnabled = false
        scrollView1.contentSize = CGSizeMake(screenWidth, screenHeight)
        visualEffectSub.addSubview(scrollView1)
        
        
        oppoImage.image = otherUserImage
        oppoImage.frame.size.width = 65
        oppoImage.frame.size.height = 65
        oppoImage.frame.origin.x = screenWidth/2 - 90
        oppoImage.frame.origin.y = -100
        oppoImage.clipsToBounds = true
        oppoImage.contentMode = .ScaleAspectFill
        oppoImage.layer.cornerRadius = oppoImage.frame.size.width/2
        scrollView1.addSubview(oppoImage)
        
        iImage = UIImageView()
        iImage.image = meUserImage
        iImage.frame.size.width = 65
        iImage.frame.size.height = 65
        iImage.frame.origin.x = screenWidth/2 - 90
        iImage.frame.origin.y = screenHeight+100
        iImage.clipsToBounds = true
        iImage.contentMode = .ScaleAspectFill
        iImage.layer.cornerRadius = iImage.frame.size.width/2
        scrollView1.addSubview(iImage)
        
        var wonLabel = UILabel(frame: CGRectMake(20,screenHeight/2-56 - screenHeight/8 - 30 - 10,screenWidth-40, 102))
        
        var by = " by "
        if statusBy == "time" {
        by = " on "
        }
        
        if statusBy == "" {
        by = ""
        }
        
        let sb = (game["blackPlayer"] as? String)!
        let sw = (game["whitePlayer"] as? String)!
        if statusWhite == "won" && iamWhite {
            wonLabel.text = "You won against " + "\(sb)" + by + statusBy
        }
        else if statusWhite == "lost" && iamWhite {
            wonLabel.text = "You lost against " + "\(sb)" + by + statusBy
        }
        if statusWhite == "won" && !iamWhite {
            wonLabel.text = "You lost against " + "\(sw)" + by + statusBy
        }
        else if statusWhite == "lost" && !iamWhite {
            wonLabel.text = "You won against " + "\(sw)" + by + statusBy
        }
        else if statusWhite == "drew" && !iamWhite {
            wonLabel.text = "You drew " + "\(sw)"
        }
        else if statusWhite == "drew" && iamWhite {
            wonLabel.text = "You drew " + "\(sb)"
        }
        
        
        wonLabel.textAlignment = .Center
        if darkMode {wonLabel.textColor = UIColor.whiteColor()}
        else {wonLabel.textColor = UIColor.blackColor() }
        wonLabel.alpha = 0
        wonLabel.numberOfLines = 0
        wonLabel.font = UIFont(name: "Times", size: 25)
        scrollView1.addSubview(wonLabel)
        
        nameOppo = UILabel(frame: CGRectMake(oppoImage.frame.origin.x + oppoImage.frame.size.width + 25,oppoImage.frame.origin.y + 10,screenWidth - (oppoImage.frame.origin.x + oppoImage.frame.size.width + 25),27))
        nameOppo.font = UIFont(name: "Times", size: 22)
        nameOppo.textAlignment = .Left
        if darkMode {nameOppo.textColor = UIColor.whiteColor()}
        else {nameOppo.textColor = UIColor.blackColor() }
        nameOppo.text = otherUserName
        scrollView1.addSubview(nameOppo)
        
        ratingOppo = UILabel(frame: CGRectMake(nameOppo.frame.origin.x,nameOppo.frame.origin.y + nameOppo.frame.size.height,screenWidth - (oppoImage.frame.origin.x + oppoImage.frame.size.width + 25),21))
        ratingOppo.font = UIFont(name: "Times-Italic", size: 15)
        ratingOppo.textColor = UIColor.darkGrayColor()
        if darkMode {ratingOppo.textColor = UIColor.whiteColor()}
        else {ratingL.textColor = UIColor.blackColor() }
        ratingOppo.text = otherUserRating
        scrollView1.addSubview(ratingOppo)
        
        nameI = UILabel(frame: CGRectMake(iImage.frame.origin.x + iImage.frame.size.width + 25,iImage.frame.origin.y + 10,screenWidth - (iImage.frame.origin.x + iImage.frame.size.width + 25),27))
        nameI.font = UIFont(name: "Times", size: 22)
        nameI.textAlignment = .Left
        if darkMode {nameI.textColor = UIColor.whiteColor()}
        else {nameI.textColor = UIColor.blackColor() }
        nameI.text = meUserName
        scrollView1.addSubview(nameI)
        
        ratingI = UILabel(frame: CGRectMake(screenWidth/2,nameI.frame.origin.y + nameI.frame.size.height,200,40))
        ratingI.font = UIFont(name: "Times-Italic", size: 25)
        ratingI.textAlignment = .Left
        ratingI.textColor = UIColor.darkGrayColor()
        if darkMode {self.ratingI.textColor = UIColor.whiteColor()}
        else {self.ratingI.textColor = UIColor.blackColor() }
        
        scrollView1.addSubview(ratingI)
        
        var shareTwitterButton = UIButton(frame: CGRectMake(screenWidth/2 - 50,screenHeight + 200,30,30))
        shareTwitterButton.setBackgroundImage(UIImage(named:"TwitterLogo_#55acee"), forState: .Normal)
        shareTwitterButton.addTarget(self, action: "shareTwitterButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(shareTwitterButton)
        
        var shareFacebookButton = UIButton(frame: CGRectMake(screenWidth/2 + 20,screenHeight + 200,30,30))
        shareFacebookButton.setBackgroundImage(UIImage(named:"facebook_logo"), forState: .Normal)
        shareFacebookButton.addTarget(self, action: "shareFacebookButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(shareFacebookButton)
        
        cancelB = UIButton(frame: CGRectMake(screenWidth - 60, 43,50 ,50))
        cancelB.userInteractionEnabled = true
        if darkMode {cancelB.setBackgroundImage(UIImage(named: "cross-mark1-3S.png"), forState: .Normal)}
        else {cancelB.setBackgroundImage(UIImage(named: "cross-mark1-2S.png"), forState: .Normal) }
        cancelB.addTarget(self, action: "cancelButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(cancelB)
        
        UIView.animateWithDuration(0.8, delay: 0.5, usingSpringWithDamping: 1.3, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
            self.oppoImage.frame.origin.y = screenHeight/2 - screenHeight/4 + 20 - screenHeight/8 - 25 - 10
            self.nameOppo.frame.origin.y = self.oppoImage.frame.origin.y + 10
            self.ratingOppo.frame.origin.y = self.nameOppo.frame.origin.y + self.nameOppo.frame.size.height
            
            self.iImage.frame.origin.y = screenHeight/2 + screenHeight/4 - (65) - 20 - screenHeight/8 - 25 - 20
            self.nameI.frame.origin.y = self.iImage.frame.origin.y + 10
            
            self.ratingI.frame.origin.y = screenHeight/2 + screenHeight/7
            
            self.ratingI.frame.origin.y = self.nameI.frame.origin.y + self.nameI.frame.size.height
            self.ratingI.frame.origin.x = self.nameI.frame.origin.x
            self.ratingI.frame.size.width = screenWidth - (self.iImage.frame.origin.x + self.iImage.frame.size.width + 25)
            self.ratingI.frame.size.height = 21
            self.ratingI.font = UIFont(name: "Times-Italic", size: 15)
            
            
            shareTwitterButton.frame.origin.y = screenHeight - 60
            shareFacebookButton.frame.origin.y = screenHeight - 60
            
            let mR = Int(self.meUserRatingInt)
            let oR = Int(self.otherUserRatingInt)
            
            wonLabel.alpha = 1
            self.ratingI.text = "\(mR)" + "+45"
            self.ratingOppo.text = "\(oR)" + "-45"
            
            
            
        }), completion:  { finish in
            
            self.waitTimerRating = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateWaitNum"), userInfo: nil, repeats: true)
            
            }
        )
        
        
        
        
    }
    
    var nameI = UILabel()
    var iImage = UIImageView()
    var movementTimerRating = NSTimer()
    var waitTimerRating = NSTimer()
    
    var meRating = Int()
    var ratingI = UILabel()
    
    var oppoRating = Int()
    var ratingOppo = UILabel()
    var nameOppo = UILabel()
    var oppoImage = UIImageView()
    
    
    var waitNum = Int()
    
    func updateWaitNum() {
        if waitNum >= 5 {
            self.movementTimerRating = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: Selector("updateCountTimer"), userInfo: nil, repeats: true)
            waitTimerRating.invalidate()
            
        }
        else {
            waitNum++
            
        }
    }
    
    
    
    func updateCountTimer() {
        
        
        
        
        if meRating >= 45 {
            
            UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 1.3, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
                
                
                if darkMode {self.ratingI.textColor = UIColor.lightGrayColor()}
                else {self.ratingI.textColor = UIColor.darkGrayColor() }
                
                
                
            }), completion:
                {finish in
                    
                    //self.movementTimerRating.invalidate()
            })
            
            
        }
        else  {
            meRating++
            ratingI.text = "\(meRating)"
        }
        
        if oppoRating <= -45 {
            if darkMode {self.ratingOppo.textColor = UIColor.lightGrayColor()}
            else {self.ratingOppo.textColor = UIColor.darkGrayColor() }
        }
        else {
            oppoRating--
            ratingOppo.text = "\(oppoRating)"
        }
        
    }
    
    func shareFacebookButtonPressed(sender: UIButton!) {
        removeNewView()
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc.setInitialText("I won against hans at CHESS")
        vc.addURL(NSURL(string: "http://www.nasa.gov"))
        presentViewController(vc, animated: true, completion: nil)
        
    }
    func shareTwitterButtonPressed(sender: UIButton!) {
        removeNewView()
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc.setInitialText("I won against hans at CHESS")
        vc.addURL(NSURL(string: "http://www.nasa.gov"))
        presentViewController(vc, animated: true, completion: nil)
    }
    // MARK: - Setup-functions 🔍
    
    var resignB = UIButton()
    var drawB = UIButton()
    
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        infoButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            visualEffectView.alpha = 1
            }, completion: {finish in
                visualEffectSub.userInteractionEnabled = true
                visualEffectView.userInteractionEnabled = true
        })
        
        //gameFinishedScreen("")
        
        var scrollView1 = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        scrollView1.delegate = self
        scrollView1.userInteractionEnabled = true
        scrollView1.scrollEnabled = true
        scrollView1.pagingEnabled = false
        scrollView1.contentSize = CGSizeMake(screenWidth, 958)
        visualEffectSub.addSubview(scrollView1)
        
        var plusNum: CGFloat = 130
        
        var actions = UILabel(frame: CGRectMake(0,37,screenWidth, 32))
        actions.text = "ACTIONS"
        actions.textAlignment = .Center
        if darkMode {actions.textColor = UIColor.lightGrayColor()}
        else {actions.textColor = UIColor.darkGrayColor() }
        actions.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(actions)
        
        
        resignB = UIButton(frame: CGRectMake(screenWidth/2 + 18, 100,55,25))
        resignB.titleLabel?.font = UIFont(name: "Times", size: 14)
        resignB.setTitle("Resign", forState: .Normal)
        resignB.layer.cornerRadius = cornerRadius - 3
        resignB.userInteractionEnabled = true
        resignB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        resignB.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        resignB.backgroundColor = red
        resignB.addTarget(self, action: "resignButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(resignB)
        
        drawB = UIButton(frame: CGRectMake(screenWidth/2 - 100, 100,82,25))
        drawB.titleLabel?.font = UIFont(name: "Times", size: 14)
        drawB.setTitle("Offer Draw", forState: .Normal)
        drawB.layer.cornerRadius = cornerRadius - 3
        drawB.userInteractionEnabled = true
        drawB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        drawB.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        drawB.backgroundColor = blue
        drawB.addTarget(self, action: "drawButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(drawB)
        
        var info = UILabel(frame: CGRectMake(0,37 + plusNum,screenWidth, 32))
        info.text = "INFORMATION"
        info.textAlignment = .Center
        if darkMode {info.textColor = UIColor.lightGrayColor()}
        else {info.textColor = UIColor.darkGrayColor() }
        info.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(info)
        
        turnL = UILabel(frame: CGRectMake(40,100 - 10 + plusNum,screenWidth, 29))
        print(turnLturn)
        turnL.text = turnLturn
        if darkMode {turnL.textColor = UIColor.whiteColor()}
        else {turnL.textColor = UIColor.blackColor() }
        turnL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(turnL)
        
        colorL = UILabel(frame: CGRectMake(40,129 - 10 + plusNum,screenWidth, 29))
        colorL.text = colorLcolor
        if darkMode {colorL.textColor = UIColor.whiteColor()}
        else {colorL.textColor = UIColor.blackColor() }
        colorL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(colorL)
        
        speedL = UILabel(frame: CGRectMake(40,158 - 10 + plusNum,screenWidth, 29))
        speedL.text = speedLspeed
        if darkMode {speedL.textColor = UIColor.whiteColor()}
        else {speedL.textColor = UIColor.blackColor() }
        speedL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(speedL)
        
        ratedL = UILabel(frame: CGRectMake(40,187 - 10 + plusNum,screenWidth, 29))
        ratedL.text = ratedLrated
        if darkMode {ratedL.textColor = UIColor.whiteColor()}
        else {ratedL.textColor = UIColor.blackColor() }
        ratedL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(ratedL)
        
        turnIndicator = UILabel(frame: CGRectMake(turnL.frame.origin.x - 20, turnL.frame.origin.y + 12 , 11, 11))
        turnIndicator.layer.cornerRadius = (turnIndicator.frame.size.width)/2
        turnIndicator.clipsToBounds = true
        turnIndicator.backgroundColor = turnIndicatorturn
        scrollView1.addSubview(turnIndicator)
        
        colorIndicator = UILabel(frame: CGRectMake(colorL.frame.origin.x - 20, colorL.frame.origin.y + 12 , 11, 11))
        colorIndicator.layer.borderColor = UIColor.blackColor().CGColor
        colorIndicator.layer.borderWidth = 1
        colorIndicator.backgroundColor = colorIndicatorcolor
        scrollView1.addSubview(colorIndicator)
        
        speedImage = UIImageView(frame: CGRectMake(speedL.frame.origin.x - 20, speedL.frame.origin.y, 11, 29))
        speedImage.contentMode = .ScaleAspectFit
        speedImage.image = speedImagespeed
        scrollView1.addSubview(speedImage)
        
        let timeLeftL = UILabel(frame: CGRectMake(40,216 - 10 + plusNum,screenWidth, 29))
        timeLeftL.text = "Time Left To Move:"
        if darkMode {timeLeftL.textColor = UIColor.lightGrayColor()}
        else {timeLeftL.textColor = UIColor.darkGrayColor() }
        timeLeftL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(timeLeftL)
        
        timeL = UILabel(frame: CGRectMake(199,216 - 10 + plusNum,screenWidth-208, 29))
        timeL.text = ""
        if darkMode {timeL.textColor = UIColor.whiteColor()}
        else {timeL.textColor = UIColor.blackColor() }
        timeL.font = UIFont(name: "Times", size: 19)
        scrollView1.addSubview(timeL)
        
        var addSpace: CGFloat = 120
        
        let capturedPieces = UILabel(frame: CGRectMake(0,270 + plusNum,screenWidth, 29))
        capturedPieces.text = "CAPTURED PIECES"
        capturedPieces.textAlignment = .Center
        if darkMode {capturedPieces.textColor = UIColor.lightGrayColor()}
        else {capturedPieces
            .textColor = UIColor.darkGrayColor() }
        capturedPieces.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(capturedPieces)
        
        var capturedWhitePawns: Array<UIImageView> = []
        var capturedWhiteQueens: Array<UIImageView> = []
        var capturedWhiteBishops: Array<UIImageView> = []
        var capturedWhiteRooks: Array<UIImageView> = []
        var capturedWhiteKnights: Array<UIImageView> = []
        for var i = 0; i < takenWhitePiecesForInfo.count; i++ {
            if takenWhitePiecesForInfo[i].image == UIImage(named:"whitePawn") {
                capturedWhitePawns += [takenWhitePiecesForInfo[i]]
            } else if takenWhitePiecesForInfo[i].image == UIImage(named:"whiteQueen") {
                capturedWhiteQueens += [takenWhitePiecesForInfo[i]]
            } else if takenWhitePiecesForInfo[i].image == UIImage(named:"whiteBishop") {
                capturedWhiteBishops += [takenWhitePiecesForInfo[i]]
            } else if takenWhitePiecesForInfo[i].image == UIImage(named:"whiteRook") {
                capturedWhiteRooks += [takenWhitePiecesForInfo[i]]
            } else if takenWhitePiecesForInfo[i].image == UIImage(named:"whiteKnight") {
                capturedWhiteKnights += [takenWhitePiecesForInfo[i]]
            }
        }
        var capturedBlackPawns: Array<UIImageView> = []
        var capturedBlackQueens: Array<UIImageView> = []
        var capturedBlackBishops: Array<UIImageView> = []
        var capturedBlackRooks: Array<UIImageView> = []
        var capturedBlackKnights: Array<UIImageView> = []
        for var i = 0; i < takenBlackPiecesForInfo.count; i++ {
            if takenBlackPiecesForInfo[i].image == UIImage(named:"blackPawn") {
                capturedBlackPawns += [takenBlackPiecesForInfo[i]]
            } else if takenBlackPiecesForInfo[i].image == UIImage(named:"blackQueen") {
                capturedBlackQueens += [takenBlackPiecesForInfo[i]]
            } else if takenBlackPiecesForInfo[i].image == UIImage(named:"blackBishop") {
                capturedBlackBishops += [takenBlackPiecesForInfo[i]]
            } else if takenBlackPiecesForInfo[i].image == UIImage(named:"blackRook") {
                capturedBlackRooks += [takenBlackPiecesForInfo[i]]
            } else if takenBlackPiecesForInfo[i].image == UIImage(named:"blackKnight") {
                capturedBlackKnights += [takenBlackPiecesForInfo[i]]
            }
        }
        var offset: CGFloat = 0
        for var i = 0; i < takenWhitePieces.count; i++ {
            if takenWhitePieces[i].image == UIImage(named:"whitePawn") {
                var i = 0
                for i = 0; i < capturedWhitePawns.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset + 15 + CGFloat(i * 25), 320 + plusNum, 35, 35))
                    capturedPiece.image = capturedWhitePawns[i].image
                    scrollView1.addSubview(capturedPiece)
                }
                offset = offset + CGFloat(i * 25)
            } else  if takenWhitePieces[i].image == UIImage(named:"whiteQueen") {
                var i = 0
                for i = 0; i < capturedWhiteQueens.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset + 15 + CGFloat(i * 25), 320 + plusNum, 35, 35))
                    capturedPiece.image = capturedWhiteQueens[i].image
                    scrollView1.addSubview(capturedPiece)
                }
                offset = offset + CGFloat(i * 25)
            } else  if takenWhitePieces[i].image == UIImage(named:"whiteBishop") {
                var i = 0
                for i = 0; i < capturedWhiteBishops.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset + 15 + CGFloat(i * 25), 320 + plusNum, 35, 35))
                    capturedPiece.image = capturedWhiteBishops[i].image
                    scrollView1.addSubview(capturedPiece)
                    
                }
                offset = offset + CGFloat(i * 25)
            } else  if takenWhitePieces[i].image == UIImage(named:"whiteRook") {
                var i = 0
                for i = 0; i < capturedWhiteRooks.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset + 15 + CGFloat(i * 25), 320 + plusNum, 35, 35))
                    capturedPiece.image = capturedWhiteRooks[i].image
                    scrollView1.addSubview(capturedPiece)
                    
                }
                offset = offset + CGFloat(i * 25)
            } else  if takenWhitePieces[i].image == UIImage(named:"whiteKnight") {
                var i = 0
                for i = 0; i < capturedWhiteKnights.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset + 15 + CGFloat(i * 25), 320 + plusNum, 35, 35))
                    capturedPiece.image = capturedWhiteKnights[i].image
                    scrollView1.addSubview(capturedPiece)
                    
                }
                offset = offset + CGFloat(i * 25)
            }
        }
        var offset2: CGFloat = 0
        for var i = 0; i < takenBlackPieces.count; i++ {
            if takenBlackPieces[i].image == UIImage(named:"blackPawn") {
                var i = 0
                for i = 0; i < capturedBlackPawns.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset2 + 15 + CGFloat(i * 25), 360 + plusNum, 35, 35))
                    capturedPiece.image = capturedBlackPawns[i].image
                    scrollView1.addSubview(capturedPiece)
                }
                offset2 = offset2 + CGFloat(i * 25)
            } else  if takenBlackPieces[i].image == UIImage(named:"blackQueen") {
                var i = 0
                for i = 0; i < capturedBlackQueens.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset2 + 15 + CGFloat(i * 25), 360 + plusNum, 35, 35))
                    capturedPiece.image = capturedBlackQueens[i].image
                    scrollView1.addSubview(capturedPiece)
                }
                offset2 = offset2 + CGFloat(i * 25)
            } else  if takenBlackPieces[i].image == UIImage(named:"blackBishop") {
                var i = 0
                for i = 0; i < capturedBlackBishops.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset2 + 15 + CGFloat(i * 25), 360 + plusNum, 35, 35))
                    capturedPiece.image = capturedBlackBishops[i].image
                    scrollView1.addSubview(capturedPiece)
                    
                }
                offset2 = offset2 + CGFloat(i * 25)
            } else  if takenBlackPieces[i].image == UIImage(named:"blackRook") {
                var i = 0
                for i = 0; i < capturedBlackRooks.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset2 + 15 + CGFloat(i * 25), 360 + plusNum, 35, 35))
                    capturedPiece.image = capturedBlackRooks[i].image
                    scrollView1.addSubview(capturedPiece)
                    
                }
                offset2 = offset2 + CGFloat(i * 25)
            } else  if takenBlackPieces[i].image == UIImage(named:"blackKnight") {
                var i = 0
                for i = 0; i < capturedBlackKnights.count; i++ {
                    let capturedPiece = UIImageView(frame: CGRectMake(offset2 + 15 + CGFloat(i * 25), 360 + plusNum, 35, 35))
                    capturedPiece.image = capturedBlackKnights[i].image
                    scrollView1.addSubview(capturedPiece)
                    
                }
                offset2 = offset2 + CGFloat(i * 25)
            }
        }
        addSpace += 35
        let opponent = UILabel(frame: CGRectMake(0,280 + plusNum + addSpace,screenWidth, 29))
        opponent.text = "OPPONENT"
        opponent.textAlignment = .Center
        if darkMode {opponent.textColor = UIColor.lightGrayColor()}
        else {opponent
            .textColor = UIColor.darkGrayColor() }
        opponent.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(opponent)
        
        pImage = UIImageView(frame: CGRectMake(screenWidth/2 - 90, 330 + plusNum + addSpace, 65, 65))
        pImage.layer.cornerRadius = pImage.frame.size.width/2
        pImage.clipsToBounds = true
        pImage.contentMode = .ScaleAspectFill
        pImage.image = otherUserImage
        scrollView1.addSubview(pImage)
        
        nameL = UILabel(frame: CGRectMake(pImage.frame.origin.x + pImage.frame.size.width + 25,pImage.frame.origin.y + 10,screenWidth - (pImage.frame.origin.x + pImage.frame.size.width + 25),27))
        nameL.font = UIFont(name: "Times", size: 22)
        nameL.textAlignment = .Left
        if darkMode {nameL.textColor = UIColor.whiteColor()}
        else {nameL.textColor = UIColor.blackColor() }
        nameL.text = otherUserName
        scrollView1.addSubview(nameL)
        
        ratingL = UILabel(frame: CGRectMake(nameL.frame.origin.x,nameL.frame.origin.y + nameL.frame.size.height,screenWidth - (pImage.frame.origin.x + pImage.frame.size.width + 25),21))
        ratingL.font = UIFont(name: "Times-Italic", size: 15)
        ratingL.textColor = UIColor.darkGrayColor()
        if darkMode {ratingL.textColor = UIColor.lightGrayColor()}
        else {ratingL.textColor = UIColor.darkGrayColor() }
        ratingL.text = otherUserRating
        scrollView1.addSubview(ratingL)
        
        let moves = UILabel(frame: CGRectMake(0,450 + plusNum + addSpace,screenWidth, 29))
        moves.text = "MOVES"
        moves.textAlignment = .Center
        if darkMode {moves.textColor = UIColor.lightGrayColor()}
        else {moves
            .textColor = UIColor.darkGrayColor() }
        moves.font = UIFont(name: "Didot", size: 19)
        scrollView1.addSubview(moves)
        
        movesField = UITextView(frame: CGRectMake(30,485 + plusNum + addSpace,screenWidth-60,200))
        movesField.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        movesField.text = notationsWithNumber
        movesField.font = UIFont(name: "Times", size: 19)
        movesField.backgroundColor = UIColor.clearColor()
        if darkMode {movesField.textColor = UIColor.whiteColor()}
        else {movesField.textColor = UIColor.blackColor() }
        movesField.userInteractionEnabled = true
        movesField.editable = false
        print(movesField.userActivity)
        scrollView1.addSubview(movesField)
        
        //invite to game btn
        copyB = UIButton(frame: CGRectMake(screenWidth/2 + 75, 450 + plusNum + addSpace,45,25))
        copyB.titleLabel?.font = UIFont(name: "Times", size: 14)
        copyB.setTitle("Copy", forState: .Normal)
        copyB.layer.cornerRadius = cornerRadius - 3
        copyB.userInteractionEnabled = true
        copyB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        copyB.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        copyB.backgroundColor = blue
        copyB.addTarget(self, action: "copyButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(copyB)
        
        cancelB = UIButton(frame: CGRectMake(screenWidth - 60, 43,50 ,50))
        cancelB.userInteractionEnabled = true
        if darkMode {cancelB.setBackgroundImage(UIImage(named: "cross-mark1-3S.png"), forState: .Normal)}
        else {cancelB.setBackgroundImage(UIImage(named: "cross-mark1-2S.png"), forState: .Normal) }
        cancelB.addTarget(self, action: "cancelButtonPressed:", forControlEvents: .TouchUpInside)
        scrollView1.addSubview(cancelB)
        
    }
    
    func resignButtonPressed(sender:UIButton) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.resignB.frame.size.width += 4
            self.resignB.frame.origin.x -= 2
            self.resignB.backgroundColor = red
            
            }, completion: {finish in
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.resignB.frame.size.width -= 4
                    self.resignB.frame.origin.x += 2
                    self.resignB.backgroundColor = red
          
                    }, completion: {finish in
                        
                        
                        
                })
        })
        
        let resignAlert = UIAlertController(title: "Warning", message: "Are you sure you want to resign?", preferredStyle: UIAlertControllerStyle.Alert)
        
        resignAlert.addAction(UIAlertAction(title: "Resign", style: .Destructive, handler: { action in
            switch action.style{
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
                
                if self.iamWhite {
                    
                    if self.game["whiteRatedComplete"] as! Bool == false {
                        
                        let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0, sB: 1).0
                        PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                        
                        let s = self.meUserLost + 1
                        PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                        
                        PFUser.currentUser()!.save()
                        
                        self.game["status_white"] = "lost"
                        self.game["status_black"] = "won"
                        
                        self.game["whiteRatedComplete"] = true
                        self.game.save()
                        
                        self.gameFinishedScreen("lost",statusBy: "resigning")
                        //firebase
                        
                        //add who's turn it is
                        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                        var status = ["turn": "done"]
                        
                        let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                        statusRef.setValue(status)
                        //firebase - end
                        
                    }
                }
                else {
                    if self.game["blackRatedComplete"] as! Bool == false {
                        
                        let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 1, sB: 0).1
                        PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                        
                        let s = self.meUserLost + 1
                        PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                        
                        PFUser.currentUser()!.save()
                        
                        self.game["status_black"] = "lost"
                        self.game["status_white"] = "won"
                        
                        self.game["blackRatedComplete"] = true
                        self.game.save()
                        
                        self.gameFinishedScreen("won",statusBy: "resigning")
                        
                        //firebase
                        
                        //add who's turn it is
                        let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                        var status = ["turn": "done"]
                        
                        let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                        statusRef.setValue(status)
                        //firebase - end
                    }
                    
                }
                

                
            case .Default:
                print("default")
                
            }
        }))
        resignAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            switch action.style{
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
                
            case .Default:
                print("default")
                
            }
        }))
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.removeNewView()
            } , completion: {finish in
                self.presentViewController(resignAlert, animated: true, completion: nil)
                
        })
        
        
    }
    
    func drawButtonPressed(sender:UIButton) {
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.drawB.frame.size.width += 4
            self.drawB.frame.origin.x -= 2
            
            }, completion: {finish in
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.drawB.frame.size.width -= 4
                    self.drawB.frame.origin.x += 2
                    
                    }, completion: {finish in
                        
                        
                        
                })
        })
        
        
        let drawAlert = UIAlertController(title: "Warning", message: "Are you sure you want to offer a draw?", preferredStyle: UIAlertControllerStyle.Alert)
        
        drawAlert.addAction(UIAlertAction(title: "Draw", style: .Default, handler: { action in
            switch action.style{
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
                
            case .Default:
                print("default")
                
                if self.iamWhite {
                    

                        
                        self.game["draw_white"] = "drawfrom"
                        self.game["draw_black"] = "drawto"
                        
                        self.game.save()
                    
                    //firebase
                    
                    //add who's turn it is
                    let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                    var status = ["turn": "done"]
                    
                    let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                    statusRef.setValue(status)
                    //firebase - end
                        
                    
                }
                else {
                    self.game["draw_white"] = "drawto"
                    self.game["draw_black"] = "drawfrom"
                    
                    self.game.save()
                    
                    //firebase
                    
                    //add who's turn it is
                    let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                    var status = ["turn": "done"]
                    
                    let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                    statusRef.setValue(status)
                    //firebase - end
                    
                }
                
            }
        }))
        drawAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            switch action.style{
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
                
            case .Default:
                print("default")
                
            }
        }))
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.removeNewView()
            } , completion: {finish in
                self.presentViewController(drawAlert, animated: true, completion: nil)
                
        })
    }
    
    func copyButtonPressed(sender: UIButton!) {
        
        UIPasteboard.generalPasteboard().string = movesField.text
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.copyB.frame.size.width += 16
            self.copyB.frame.origin.x -= 8
            self.copyB.setTitle("Copied", forState: .Normal)
            self.copyB.backgroundColor = UIColor.lightGrayColor()
            self.copyB.userInteractionEnabled = false
            
            }, completion: {finish in
                
                
        })
        
        
    }
    func cancelButtonPressed(sender:UITapGestureRecognizer){
        removeNewView()
        
    }
    
    func removeNewView() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            visualEffectView.alpha = 0
            
            }, completion: {finish in
                
                for view in visualEffectSub.subviews {
                    view.removeFromSuperview()
                }
                self.infoButton.userInteractionEnabled = true
                
                
        })
        
        visualEffectView.userInteractionEnabled = false
        visualEffectSub.userInteractionEnabled = false
        
    }
    
    //use this to checki fuser lost on time
    func updateTimer() {
        
        
        if notations.count <= 1 {
            
            
        }else {
            timeLeft++
            
        }
        
        
        var timeLeftT = timeLeft * -1
        
        func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
            return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        }
        
        func printSecondsToHoursMinutesSeconds(seconds:Int) -> () {
            let (h, m, s) = secondsToHoursMinutesSeconds(seconds)
            
            var hS = "\(h):"
            var mS = "\(m):"
            var sS = "\(s)"
            if h < 10 {
                hS = "0\(h):"
            }
            if m < 10 {
                mS = "0\(m):"
            }
            if s < 10 {
                sS = "0\(s)"
            }
            
            
            if h >= 24 {
                
                var timeLeftC = h/24
                let sinceOutput = Int(timeLeftC)
                
                if sinceOutput > 1 {
                    timeL.text = "\(sinceOutput) days"
                    timeGL.text = "\(sinceOutput) days"
                }
                else {
                    timeL.text = "\(sinceOutput) day"
                    timeGL.text = "\(sinceOutput) day"
                }
                
            } else {
                timeGL.text = hS + mS + sS
                timeL.text = hS + mS + sS
            }
        }
        
        printSecondsToHoursMinutesSeconds(Int(timeLeftT))
        
        if darkMode {
            timeGL.textColor = UIColor.whiteColor() }
        else { timeGL.textColor = UIColor.blackColor()}
        if darkMode {
            timeGL.textColor = UIColor.whiteColor() }
        else { timeGL.textColor = UIColor.blackColor()}
        
        if timeLeftT < 3600 {
            timeGL.textColor = red
            timeL.textColor = red
        }
        
        if timeLeftT <= 0 {
            timeL.text = "Game Finished"
            timeL.font = UIFont(name: "Times-Italic", size: 19)
            
            
            
            
            timeGL.text = "😒"

            for var i = 0; i < piecesArrs.count; i++ {
                for var t = 0; t < piecesArrs[i].count; t++ {

                    piecesArrs[i][t].userInteractionEnabled = false
                }
            }
            
            if iamWhite {
            
                if game["whiteRatedComplete"] as! Bool == false {
                
                    let myRating = self.calculateRating(Double(self.meUserRatingInt), bR: Double(self.otherUserRatingInt), K: 32, sW: 0, sB: 1).0
                    PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                    
                    let s = self.meUserLost + 1
                    PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                    
                    PFUser.currentUser()!.save()
                    
                    game["status_white"] = "lost"
                    game["status_black"] = "won"

                    game["whiteRatedComplete"] = true
                    game.save()
                    
                    self.gameFinishedScreen("lost",statusBy: "time.")
                    
                }
            }
            else {
                if game["blackRatedComplete"] as! Bool == false {
                    
                    let myRating = self.calculateRating(Double(self.otherUserRatingInt), bR: Double(self.meUserRatingInt), K: 32, sW: 1, sB: 0).1
                    PFUser.currentUser()!.setObject(myRating, forKey: "rating")
                    
                    let s = self.meUserLost + 1
                    PFUser.currentUser()!.setObject("\(s)", forKey: "lost")
                    
                    PFUser.currentUser()!.save()
                    
                    game["status_black"] = "lost"
                    game["status_white"] = "won"

                    game["blackRatedComplete"] = true
                    game.save()
                    
                    self.gameFinishedScreen("won",statusBy: "time.")
                    
                }
            
            }
            
            //firebase
            
            //add who's turn it is
            let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
            var status = ["turn": "done"]
         
            let statusRef = checkstatus.childByAppendingPath("\(gameID)")
            statusRef.setValue(status)
            //firebase - end


            timer.invalidate()
        }

    }
    
    //    override func prefersStatusBarHidden() -> Bool {
    //        return true
    //    }
    
    ///////
    
    // MARK: Calculate the RATING
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
    
    //calculateRating to calculate rating of players
    func calculateRating(wR:Double, bR:Double, K:Double, sW:Double, sB:Double) -> (Int,Int) {
        
        var wR_2 = Double(10^^(Int(wR / 400)))
        var bR_2 = Double(10^^(Int(bR / 400)))
        
        let ExW:Double = wR_2/(wR_2 + bR_2)
        let ExB:Double = bR_2/(wR_2 + bR_2)
        
        wR_2 = wR+(K*(sW - ExW))
        bR_2 = wR+(K*(sB - ExB))
        
        return (Int(wR_2) , Int(bR_2))
    }
    
    ///////
    
    // MARK: - Functions to make life easier 💕
    func movePiece(_moveByAmountx:CGFloat,_moveByAmounty:CGFloat) {
        resetTimer()
        removePieceOptions()
        moveByAmountx = _moveByAmountx
        moveByAmounty = _moveByAmounty
        movementTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateMovementTimer"), userInfo: nil, repeats: true)
        if isWhiteTurn == true {
            
            isWhiteTurn = false
        }
        else if isWhiteTurn == false {
            isWhiteTurn = true
        }
    }
    
    func showMarkedPiece() {
        pieceMarked.hidden = false
        pieceMarked.frame = CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y, pieceSize, pieceSize)
    }
    func hideMarkedPiece() {
        pieceMarked.hidden = true
        
    }
    
    func removePieceOptions() {
        for var p = 0 ; p < pieceOptions.count; p++ {
            pieceMarked.hidden = true
            pieceOptions[p].removeFromSuperview()
        }
        pieceOptions = []
    }
    
    func removeLogicOptions() {
        for var p = 0 ; p < queenLogicOptions.count; p++ {
            queenLogicOptions[p].hidden = true
            queenLogicOptions[p].removeFromSuperview()
        }
        queenLogicOptions = []
    }
    
    func removeBishopLogicOptions() {
        for var p = 0 ; p < bishopLogicOptions.count; p++ {
            bishopLogicOptions[p].hidden = true
            bishopLogicOptions[p].removeFromSuperview()
        }
        bishopLogicOptions = []
    }
    
    func removeRookLogicOptions() {
        for var p = 0 ; p < rookLogicOptions.count; p++ {
            rookLogicOptions[p].hidden = true
            rookLogicOptions[p].removeFromSuperview()
        }
        rookLogicOptions = []
    }
    func removeKnightLogicOptions() {
        for var p = 0 ; p < knightLogicOptions.count; p++ {
            knightLogicOptions[p].hidden = true
            knightLogicOptions[p].removeFromSuperview()
        }
        knightLogicOptions = []
    }
    func removePawnLogicOptions() {
        for var p = 0 ; p < pawnLogicOptions.count; p++ {
            pawnLogicOptions[p].hidden = true
            pawnLogicOptions[p].removeFromSuperview()
        }
        pawnLogicOptions = []
    }
    func removeWhitePieceLogicOptions() {
        for var p = 0 ; p < pieceWhiteLogicOptions.count; p++ {
            pieceWhiteLogicOptions[p].hidden = true
            pieceWhiteLogicOptions[p].removeFromSuperview()
        }
        pieceWhiteLogicOptions = []
    }
    
    func removeBlackPieceLogicOptions() {
        for var p = 0 ; p < pieceBlackLogicOptions.count; p++ {
            pieceBlackLogicOptions[p].hidden = true
            pieceBlackLogicOptions[p].removeFromSuperview()
        }
        pieceBlackLogicOptions = []
    }
    
    func removeWhiteCanMoveOptions() {
        for var p = 0 ; p < pieceWhiteCanMove.count; p++ {
            pieceWhiteCanMove[p].hidden = true
            pieceWhiteCanMove[p].removeFromSuperview()
        }
        pieceWhiteCanMove = []
    }
    func removeBlackCanMoveOptions() {
        for var p = 0 ; p < pieceBlackCanMove.count; p++ {
            pieceBlackCanMove[p].hidden = true
            pieceBlackCanMove[p].removeFromSuperview()
        }
        pieceBlackCanMove = []
    }
    
    func removeLeftWhiteCastleLogic() {
        for var p = 0 ; p < leftBlackCastleLogic.count; p++ {
             leftWhiteCastleLogic[p].hidden = true
            leftWhiteCastleLogic[p].removeFromSuperview()
        }
        leftWhiteCastleLogic = []
    }
    func removeLeftBlackCastleLogic() {
        for var p = 0 ; p < leftBlackCastleLogic.count; p++ {
            leftBlackCastleLogic[p].hidden = true
            leftBlackCastleLogic[p].removeFromSuperview()
        }
        leftBlackCastleLogic = []
    }
    func removeRightWhiteCastleLogic() {
        for var p = 0 ; p < rightWhiteCastleLogic.count; p++ {
            rightWhiteCastleLogic[p].hidden = true
            rightWhiteCastleLogic[p].removeFromSuperview()
        }
        rightWhiteCastleLogic = []
    }
    func removeRightBlackCastleLogic() {
        for var p = 0 ; p < rightBlackCastleLogic.count; p++ {
            rightBlackCastleLogic[p].hidden = true
            rightBlackCastleLogic[p].removeFromSuperview()
        }
        rightBlackCastleLogic = []
    }
    func removeWhiteCastlingLeft() {
        for var p = 0 ; p < whiteCastlingLeft.count; p++ {
            whiteCastlingLeft[p].hidden = true
            whiteCastlingLeft[p].removeFromSuperview()
        }
        whiteCastlingLeft = []
    }
    func removeWhiteCastlingRight() {
        for var p = 0 ; p < whiteCastlingRight.count; p++ {
            whiteCastlingRight[p].hidden = true
            whiteCastlingRight[p].removeFromSuperview()
        }
        whiteCastlingRight = []
    }
    func removeBlackCastlingLeft() {
        for var p = 0 ; p < blackCastlingLeft.count; p++ {
            blackCastlingLeft[p].hidden = true
            blackCastlingLeft[p].removeFromSuperview()
        }
        blackCastlingLeft = []
    }
    func removeBlackCastlingRight() {
        for var p = 0 ; p < blackCastlingRight.count; p++ {
            blackCastlingRight[p].hidden = true
            blackCastlingRight[p].removeFromSuperview()
        }
        blackCastlingRight = []
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Move", forIndexPath: indexPath) as! MoveCell
        
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        
        let move = notations[indexPath.item]
        let moveN =  moveNum[indexPath.item]
        if indexPath.item % 2 == 0 {
            cell.notation.text = String(moveN) + ". " + move
        } else {
            cell.notation.text = move
        }
        cell.configureWithColor()
        cell.notation.frame = CGRectMake(0, 0, cell.frame.width, cell.frame.height)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return notations.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    // MARK: - Pieces selected! 👾
    
    func whitePawnSelected(var hidden: Bool, var chosenPiece: UIImageView) -> Int {
        if hidden == false {
            showMarkedPiece()
        }
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat) {
            var canThePieceGofurther: Bool = true
            
            for var d = byAmounty; byAmounty <= 2; byAmountx += increaserx, byAmounty += increasery {
                
                for var q = 0; q < whitePieces.count; q++ {
                    if whitePieces[q].frame.origin.x == selectedPiece.frame.origin.x && whitePieces[q].frame.origin.y == selectedPiece.frame.origin.y - 1 * pieceSize {
                        canThePieceGofurther = false
                    }
                }
                
                for var q = 0; q < blackPieces.count; q++ {
                    if blackPieces[q].frame.origin.x == selectedPiece.frame.origin.x && blackPieces[q].frame.origin.y + 1 * pieceSize == selectedPiece.frame.origin.y{
                        canThePieceGofurther = false
                    }
                }
                
                if canThePieceGofurther == true && selectedPiece.frame.origin.y == _2  {
                    
                    var logicBool = true
                    
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if hidden == true {
                        pieceOption.hidden = true
                    }
                    if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  whitePieces)  == 2 && verticallyAlignedBlack == false {
                        logicBool = false
                        pieceOption.removeFromSuperview()
                    } else {
                        self.view.addSubview(pieceOption)
                    }
                    // Check if a pawn can move when king is in check
                    if checkByQueen == true {
                        if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByBishop == true {
                        if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByRook == true {
                        if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByPawn == true {
                        if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByKnight == true {
                        if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    }
                    if logicBool == true {
                        pieceOptions += [pieceOption]
                    }
                } else if canThePieceGofurther == true {
                    var logicBool = true
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if hidden == true {
                        pieceOption.hidden = true
                    }
                    if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  whitePieces)  == 2 && verticallyAlignedBlack == false {
                        logicBool = false
                        pieceOption.removeFromSuperview()
                    } else {
                        self.view.addSubview(pieceOption)
                    }
                    // Check if a pawn can move when king is in check
                    if checkByQueen == true {
                        if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByBishop == true {
                        if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByRook == true {
                        if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByPawn == true {
                        if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByKnight == true {
                        if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    }
                    if logicBool == true {
                        pieceOptions += [pieceOption]
                    }
                    
                }
                for var r = 0; r < blackPieces.count; r++ {
                    if blackPieces[r].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && blackPieces[r].frame.origin.y == selectedPiece.frame.origin.y - 1 * pieceSize {
                        
                        var logicBool = true
                        
                        //print("working")
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption.hidden = true
                        }
                        if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  whitePieces)  == 2 && canSaveKing(pieceOption, array: pieceBlackCanMove) == false && canSaveKing(pieceOption, array: blackPieceLogic) == false {
                            pieceOption.removeFromSuperview()
                        } else {
                            self.view.addSubview(pieceOption)
                        }
                        // Check if a pawn can move when king is in check
                        if checkByQueen == true {
                            if canSaveKing(pieceOption, array: queenLogicOptions) == false  {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByBishop == true {
                            if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByRook == true {
                            if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByPawn == true {
                            if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByKnight == true {
                            if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        }
                        if logicBool == true {
                            pieceOptions += [pieceOption]
                        }
                        canThePieceGofurther = false
                        
                    }
                }
                if blackPawns.count - 1 > passantPiece  {
                    var count = blackPawns.count - 1
                    
                    if selectedPiece.frame.origin.y == screenHeight/2 - 1 * pieceSize &&  blackPawns[count-passantPiece].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && blackPawns[count-passantPiece].frame.origin.y == selectedPiece.frame.origin.y && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false && canPassant == true || selectedPiece.frame.origin.y == screenHeight/2 - 1 * pieceSize &&  blackPawns[count-passantPiece].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && blackPawns[count-passantPiece].frame.origin.y == selectedPiece.frame.origin.y && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false && canPassantBlack == true  {
                        print("Passant!")
                        whitePassant = true
                        havePassant = true
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption.hidden = true
                        }
                        self.view.addSubview(pieceOption)
                        pieceOptions += [pieceOption]
                    }
                }
                
                for var o = 0 ; o < pieceOptions.count; o++ {
                    if CGRectContainsPoint(boarderBoard.frame, pieceOptions[o].center) == false {
                        [pieceOptions[o] .removeFromSuperview()]
                        pieceOptions.removeAtIndex(o)
                    }
                }
                
                for var q = 0; q < pieces.count; q++ {
                    for var p = 0; p < pieceOptions.count; p++ {
                        if CGRectContainsPoint(pieces[q].frame, pieceOptions[p].center) && selectedPiece.frame.origin.y == _2 && pieceOptions[p].frame.origin.y == _4  {
                            [pieceOptions[p] .removeFromSuperview()]
                            pieceOptions.removeAtIndex(p)
                            
                        }
                    }
                }
            }
        }
        
        letThemAppear(1, byAmounty: 1, increaserx: 0, increasery: 1)
        letThemAppear(-1, byAmounty: 1, increaserx: 0, increasery: 1)
        
        print(pieceOptions.count)
        return pieceOptions.count
    }
    
    func chessPieceSelected(var movementNumber: CGFloat, var pieceid: Int, var friend: [UIImageView], var enemy: [UIImageView], var hidden: Bool, var chosenPiece: UIImageView) -> Int {
        if hidden == false {
            showMarkedPiece()
        }
        pieceID = pieceid
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat, var byAmountz:CGFloat, increaserz:CGFloat ) {
            var canThePieceGofurther: Bool = true
            var startLogicChecking: Bool = false
            var startLogicCheckingWhite: Bool = false
            var foundImportantPiece: Bool = false
            
            for var d = byAmountz; byAmountz < movementNumber; byAmountx += increaserx, byAmounty += increasery, byAmountz += increaserz {
                
                if canSaveKing(chosenPiece, array: pieceWhiteCanMove) == true && canSaveKing(blackKing, array: pieceWhiteCanMove) && logicCheck(pieces, array:pieceWhiteCanMove, friends:  friend)  == 2 && enemy == whitePieces {
                    startLogicChecking = true
                } else if canSaveKing(chosenPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  friend)  == 2 && enemy == blackPieces {
                    startLogicCheckingWhite = true
                }
                
                for var q = 0; q < friend.count; q++ {
                    if friend[q].frame.origin.x == chosenPiece.frame.origin.x + byAmountx * pieceSize && friend[q].frame.origin.y == chosenPiece.frame.origin.y - byAmounty * pieceSize  {
                        canThePieceGofurther = false
                        if startLogicChecking == true && blackKing.frame.origin.x == chosenPiece.frame.origin.x + byAmountx * pieceSize && blackKing.frame.origin.y == chosenPiece.frame.origin.y - byAmounty * pieceSize {
                            canThePieceGofurther = true
                            
                        }
                    }
                }
                
                if canThePieceGofurther == true {
                    
                    var logicBool = true
                    
                    let pieceOption = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x + byAmountx * pieceSize, chosenPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if hidden == true {
                        pieceOption.hidden = true
                    }
                    self.view.addSubview(pieceOption)
                    // Check if a pawn can move when king is in check
                    if checkByQueen == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                            
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByBishop == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                            
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByRook == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                            
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByPawn == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                            
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    } else if checkByKnight == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                    }
                    if startLogicChecking == true && canSaveKing(pieceOption, array: pieceWhiteCanMove) == false && pieceid != 5 && canSaveKing(pieceOption, array: whitePieceLogic) == false {
                        pieceOption.removeFromSuperview()
                        logicBool = false
                    }
                    if startLogicCheckingWhite == true && canSaveKing(pieceOption, array: pieceBlackCanMove) == false && pieceid != 5 && canSaveKing(pieceOption, array: blackPieceLogic) == false  {
                        pieceOption.removeFromSuperview()
                        logicBool = false
                    }
                    if CGRectContainsPoint(pieceOption.frame, blackKing.center) || CGRectContainsPoint(pieceOption.frame, whiteKing.center) {
                        pieceOption.removeFromSuperview()
                        logicBool = false
                    }
                    if logicBool == true {
                        pieceOptions += [pieceOption]
                    }
                    
                    if hidden == false {
                    // This is for left castling white king
                    for var q = 0; q < friend.count; q++ {
                        for var i = 1; i < 4; i++ {
                            if pieceid == 5 && hasWhiteKingMoved == false && hasWhiteRookMoved == false {
                                print("Castlle white long")
                                let pieceOption2 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x - CGFloat(i) * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceBlackLogicOptions) == false && canSaveKing(pieceOption2, array: leftWhiteCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    leftWhiteCastleLogic += [pieceOption2]
                                }
                            }
                        }
                        for var i = 1; i < 3; i++ {
                            if pieceid == 5 && hasWhiteKingMoved == false && hasWhiteRookMoved2 == false {
                                print("Castlle white short")
                                let pieceOption2 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x + CGFloat(i) * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceBlackLogicOptions) == false && canSaveKing(pieceOption2, array: rightWhiteCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    rightWhiteCastleLogic += [pieceOption2]
                                }
                            }
                        }
                    }
                    for var q = 0; q < friend.count; q++ {
                        for var i = 1; i < 3; i++ {
                            if pieceid == 5 && hasBlackKingMoved == false && hasBlackRookMoved == false {
                                print("Castlle black short")
                                let pieceOption2 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x - CGFloat(i) * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceBlackLogicOptions) == false && canSaveKing(pieceOption2, array: leftBlackCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    leftBlackCastleLogic += [pieceOption2]
                                }
                            }
                        }
                        for var i = 1; i < 4; i++ {
                            if pieceid == 5 && hasBlackKingMoved == false && hasBlackRookMoved2 == false {
                                print("Castlle black long")
                                let pieceOption2 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x + CGFloat(i) * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceBlackLogicOptions) == false && canSaveKing(pieceOption2, array: rightBlackCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    rightBlackCastleLogic += [pieceOption2]
                                }
                            }
                        }
                    }
                    }
                    
                    if leftWhiteCastleLogic.count == 3 && hasWhiteKingMoved == false && hasWhiteRookMoved == false && pieceid == 5 && self.whiteKing.frame.origin.x == e && self.whiteKing.frame.origin.y == _1 && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x - 2 * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption3.hidden = true
                        }
                        self.view.addSubview(pieceOption3)
                        whiteCastlingLeft += [pieceOption3]
                        castlePiece = whiteRook2
                    }
                    if rightWhiteCastleLogic.count == 2 && hasWhiteKingMoved == false && hasWhiteRookMoved2 == false && pieceid == 5 && self.whiteKing.frame.origin.x == e && self.whiteKing.frame.origin.y == _1 && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x + 2 * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption3.hidden = true
                        }
                        self.view.addSubview(pieceOption3)
                        whiteCastlingRight += [pieceOption3]
                        castlePiece = whiteRook1
                    }
                    if leftBlackCastleLogic.count == 2 && hasBlackKingMoved == false && hasBlackRookMoved == false && pieceid == 5 && chosenPiece.image == UIImage(named:"blackKing") && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x - 2 * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption3.hidden = true
                        }
                        self.view.addSubview(pieceOption3)
                        blackCastlingLeft += [pieceOption3]
                        castlePiece = blackRook2
                    }
                    if rightBlackCastleLogic.count == 3 && hasBlackKingMoved == false && hasBlackRookMoved2 == false && pieceid == 5 && chosenPiece.image == UIImage(named:"blackKing") && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x + 2 * pieceSize, chosenPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption3.hidden = true
                        }
                        self.view.addSubview(pieceOption3)
                        blackCastlingRight += [pieceOption3]
                        castlePiece = blackRook1
                    }
                }
                
                for var r = 0; r < enemy.count; r++ {
                    if enemy[r].frame.origin.x == chosenPiece.frame.origin.x + byAmountx * pieceSize && enemy[r].frame.origin.y == chosenPiece.frame.origin.y - byAmounty * pieceSize && canThePieceGofurther == true {
                        
                        var logicBool = true
                        
                        let pieceOption = UIImageView(frame: CGRectMake(chosenPiece.frame.origin.x + byAmountx * pieceSize, chosenPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if hidden == true {
                            pieceOption.hidden = true
                        }
                        self.view.addSubview(pieceOption)
                        // Check if a pawn can move when king is in check
                        if checkByQueen == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByBishop == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByRook == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByPawn == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        } else if checkByKnight == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                                logicBool = false
                            }
                        }
                        if startLogicChecking == true && canSaveKing(pieceOption, array: pieceWhiteCanMove) == false && canSaveKing(pieceOption, array: whitePieceLogic) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                        if startLogicCheckingWhite == true && canSaveKing(pieceOption, array: pieceBlackCanMove) == false && canSaveKing(pieceOption, array: blackPieceLogic) == false {
                            pieceOption.removeFromSuperview()
                            logicBool = false
                        }
                        if logicBool == true {
                            pieceOptions += [pieceOption]
                        }
                        pieceCanTake = pieceOption
                        canThePieceGofurther = false
                        
                    }
                }
                
                //                                                              // Decides which squares the King can go to
                if pieceid == 5 && chosenPiece == whiteKing {
                    for var p = 0 ; p < pieceOptions.count; p++ {
                        if canSaveKing(pieceOptions[p], array: pieceBlackLogicOptions) == true {
                            [pieceOptions[p] .removeFromSuperview()]
                            pieceOptions.removeAtIndex(p)
                        }
                    }
                } else if pieceid == 5 && chosenPiece == blackKing {
                    for var p = 0 ; p < pieceOptions.count; p++ {
                        if canSaveKing(pieceOptions[p], array: pieceWhiteLogicOptions) == true {
                            [pieceOptions[p] .removeFromSuperview()]
                            pieceOptions.removeAtIndex(p)
                        }
                    }
                }
                
                for var o = 0 ; o < pieceOptions.count; o++ {
                    if CGRectContainsPoint(boarderBoard.frame, pieceOptions[o].center) == false {
                        [pieceOptions[o] .removeFromSuperview()]
                        pieceOptions.removeAtIndex(o)
                    }
                }
                for var o = 0 ; o < pieceOptions.count; o++ {
                    if CGRectContainsPoint(pieceOptions[o].frame, blackKing.center){
                        [pieceOptions[o] .removeFromSuperview()]
                        pieceOptions.removeAtIndex(o)
                    }
                }
            }
        }
        // movementNumber = 9
        if pieceid == 1 {
            letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1, byAmountz: 1,increaserz: 1)
            letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1, byAmountz: 1,increaserz: 1)
            letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1, byAmountz: 1,increaserz: 1)
            letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1, byAmountz: 1,increaserz: 1)
        }
        // movemenNumber = 2
        if pieceid == 2 {
            letThemAppear(2, byAmounty: 1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(-2, byAmounty: 1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(1, byAmounty: 2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(1, byAmounty: -2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(-1, byAmounty: 2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(-1, byAmounty: -2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(2, byAmounty: -1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            letThemAppear(-2, byAmounty: -1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
            
        }
        // movementNumber = 9
        if pieceid == 3 {
            letThemAppear(0, byAmounty: 1, increaserx: 0, increasery: 1, byAmountz: 1,increaserz: 1)
            letThemAppear(0, byAmounty: -1, increaserx: 0, increasery: -1, byAmountz: 1,increaserz: 1)
            letThemAppear(1, byAmounty: 0, increaserx: 1, increasery: 0, byAmountz: 1,increaserz: 1)
            letThemAppear(-1, byAmounty: 0, increaserx: -1, increasery: 0, byAmountz: 1,increaserz: 1)
        }
        // movementNumber = 9
        if pieceid == 4 {
            letThemAppear(0, byAmounty: 1, increaserx: 0, increasery: 1, byAmountz: 1, increaserz: 1)
            letThemAppear(0, byAmounty: -1, increaserx: 0, increasery: -1,  byAmountz: 1, increaserz: 1)
            letThemAppear(1, byAmounty: 0, increaserx: 1, increasery: 0,  byAmountz: 1, increaserz: 1)
            letThemAppear(-1, byAmounty: 0, increaserx: -1, increasery: 0,  byAmountz: 1, increaserz: 1)
            letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1,  byAmountz: 1, increaserz: 1)
            letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1,  byAmountz: 1, increaserz: 1)
            letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1,  byAmountz: 1, increaserz: 1)
            letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1,  byAmountz: 1, increaserz: 1)
            
        }
        // movementNumber = 2
        if pieceid == 5 {
            letThemAppear(0, byAmounty: 1, increaserx: 0, increasery: 1, byAmountz: 1, increaserz: 1)
            letThemAppear(0, byAmounty: -1, increaserx: 0, increasery: -1, byAmountz: 1, increaserz: 1)
            letThemAppear(1, byAmounty: 0, increaserx: 1, increasery: 0, byAmountz: 1, increaserz: 1)
            letThemAppear(-1, byAmounty: 0, increaserx: -1, increasery: 0, byAmountz: 1, increaserz: 1)
            letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1, byAmountz: 1, increaserz: 1)
            letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1, byAmountz: 1, increaserz: 1)
            letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1, byAmountz: 1, increaserz: 1)
            letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1, byAmountz: 1, increaserz: 1)
        }
        print(pieceOptions.count)
        return pieceOptions.count
    }
    
    func updateLogic() {
        
        if isWhiteTurn == true {
            
            // Starts logic for all pieces
            
            chessPieceMovementLogic(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, piece: blackKing, logicOptions: piecesWhiteLogic)
            
            for var q = 0; q < blackQueens.count; q++ {
                chessPieceMovementLogic(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, piece: blackQueens[q], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < blackBishops.count; w++ {
                chessPieceMovementLogic(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, piece: blackBishops[w], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < blackRooks.count; w++ {
                chessPieceMovementLogic(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, piece: blackRooks[w], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < blackKnights.count; w++ {
                chessPieceMovementLogic(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, piece: blackKnights[w], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < blackPawns.count; w++ {
                chessPieceMovementLogic(2, pieceid: 7, friend: blackPieces, enemy: whitePieces, piece: blackPawns[w], logicOptions: piecesWhiteLogic)
            }
        } else if isWhiteTurn == false {
            
            chessPieceMovementLogic(2, pieceid: 5, friend: whitePieces, enemy: blackPieces, piece: whiteKing , logicOptions: piecesBlackLogic)
            
            for var q = 0; q < whiteQueens.count; q++ {
                chessPieceMovementLogic(9, pieceid: 4, friend: whitePieces, enemy: blackPieces, piece: whiteQueens[q] , logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < whiteBishops.count; w++ {
                chessPieceMovementLogic(9, pieceid: 1, friend: whitePieces, enemy: blackPieces, piece: whiteBishops[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < whiteRooks.count; w++ {
                chessPieceMovementLogic(9, pieceid: 3, friend: whitePieces, enemy: blackPieces, piece: whiteRooks[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < whiteKnights.count; w++ {
                chessPieceMovementLogic(2, pieceid: 2, friend: whitePieces, enemy: blackPieces, piece: whiteKnights[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < whitePawns.count; w++ {
                chessPieceMovementLogic(2, pieceid: 6, friend: whitePieces, enemy: blackPieces, piece: whitePawns[w], logicOptions: piecesBlackLogic)
            }
        }
    }
    
    func chessPieceMovementLogic(var movementNumber: CGFloat, var pieceid: Int, var friend: [UIImageView], var enemy: [UIImageView], var piece: UIImageView, var logicOptions: [UIImageView])  {
        
        //print(pieceWhiteCanMove.count)
        
        // Check if the piece is taken
        if !hasBeenTaken(piece, array: pieceToTake) {
            
            pieceID = pieceid
            foundKing = false
            var foundKingWhite: Bool = false
            var foundKingBlack: Bool = false
            
            func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat, var byAmountz:CGFloat, increaserz:CGFloat ) {
                var canThePieceGofurther: Bool = true
                var canGoFurtherWhite: Bool = true
                var canGoFurtherBlack: Bool = true
                
                for var d = byAmountz; byAmountz < movementNumber; byAmountx += increaserx, byAmounty += increasery, byAmountz += increaserz {
                    
                    for var q = 0; q < friend.count; q++ {
                        if friend[q].frame.origin.x == piece.frame.origin.x + byAmountx * pieceSize && friend[q].frame.origin.y == piece.frame.origin.y - byAmounty * pieceSize && canThePieceGofurther == true {
                            
                            // This pieceOption is for where the king can move when checked
                            let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                            //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                            self.view.addSubview(pieceOption2)
                            if friend == whitePieces {
                                pieceWhiteLogicOptions += [pieceOption2]
                            } else {
                                pieceBlackLogicOptions += [pieceOption2]
                            }
                            
                            canThePieceGofurther = false
                        }
                    }
                    
                    for var q = 0; q < pieceWhiteCanMove.count; q++ {
                        if CGRectContainsPoint(pieceWhiteCanMove[q].frame , blackKing.center) {
                            foundKingBlack = true
                            canGoFurtherWhite = false
                            
                        }
                    }
                    
                    for var q = 0; q < pieceBlackCanMove.count; q++ {
                        if CGRectContainsPoint(pieceBlackCanMove[q].frame , whiteKing.center) {
                            foundKingWhite = true
                            canGoFurtherBlack = false
                        }
                    }
                    
                    if pieceid == 4 {
                        
                        for var q = 0; q < queenLogicOptions.count; q++ {
                            if CGRectContainsPoint(queenLogicOptions[q].frame , whiteKing.center) || CGRectContainsPoint(queenLogicOptions[q].frame , blackKing.center)  {
                                foundKing = true
                                checkByQueen = true
                                //checkByPiece = piece
                                canThePieceGofurther = false
                                //print("found the King!")
                                //chessNotationCheck = "+"
                            }
                        }
                    } else if pieceid == 1 {
                        for var q = 0; q < bishopLogicOptions.count; q++ {
                            if CGRectContainsPoint(bishopLogicOptions[q].frame , whiteKing.center) || CGRectContainsPoint(bishopLogicOptions[q].frame , blackKing.center) {
                                foundKing = true
                                checkByBishop = true
                                canThePieceGofurther = false
                                //print("found the King!")
                            }
                        }
                        
                    } else if pieceid == 3 {
                        for var q = 0; q < rookLogicOptions.count; q++ {
                            if CGRectContainsPoint(rookLogicOptions[q].frame , whiteKing.center) || CGRectContainsPoint(rookLogicOptions[q].frame , blackKing.center) {
                                foundKing = true
                                checkByRook = true
                                canThePieceGofurther = false
                                //print("found the King!")
                            }
                        }
                    }
                    if foundKing == true {
     
                        let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                        //pieceOption.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption)
                        
                        if  pieceid == 4  {
                            queenLogicOptions += [pieceOption]
                        } else if pieceid == 1 {
                            bishopLogicOptions += [pieceOption]
                        } else if pieceid == 3 {
                            rookLogicOptions += [pieceOption]
                        }
                        
                        // This pieceOption is for where the king can move when checked
                        let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption2)
                        if friend == whitePieces {
                            pieceWhiteLogicOptions += [pieceOption2]
                        } else {
                            pieceBlackLogicOptions += [pieceOption2]
                        }
                    }
                    
                    if canThePieceGofurther == true {
                        
                        if pieceid == 1 || pieceid == 3 || pieceid == 4 || pieceid == 2 || pieceid == 6 || pieceid == 7  {
                            let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                            //pieceOption.image = UIImage(named: "piecePossibilities.png")
                            self.view.addSubview(pieceOption)
                            
                            if  pieceid == 4  {
                                queenLogicOptions += [pieceOption]
                            } else if pieceid == 1 {
                                bishopLogicOptions += [pieceOption]
                            } else if pieceid == 3 {
                                rookLogicOptions += [pieceOption]
                            } else if pieceid == 6 || pieceid == 7 {
                                if CGRectContainsPoint(pieceOption.frame , whiteKing.center) || CGRectContainsPoint(pieceOption.frame , blackKing.center) {
                                    let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                                    //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                    self.view.addSubview(pieceOption2)
                                    pawnLogicOptions += [pieceOption, pieceOption2 ]
                                    checkByPawn = true
                                } else {
                                    pieceOption.removeFromSuperview()
                                }
                            } else if pieceid == 2 {
                                if CGRectContainsPoint(pieceOption.frame , whiteKing.center) || CGRectContainsPoint(pieceOption.frame , blackKing.center) {
                                    let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                                    //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                    self.view.addSubview(pieceOption2)
                                    knightLogicOptions += [pieceOption, pieceOption2 ]
                                    checkByKnight = true
                                } else {
                                    pieceOption.removeFromSuperview()
                                }
                            }
                        }
                        
                        // This pieceOption is for where the king can move when checked
                        let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption2)
                        if friend == whitePieces {
                            pieceWhiteLogicOptions += [pieceOption2]
                        } else {
                            pieceBlackLogicOptions += [pieceOption2]
                        }
                    }
                    
                    
                    for var r = 0; r < enemy.count; r++ {
                        if enemy[r].frame.origin.x == piece.frame.origin.x + byAmountx * pieceSize && enemy[r].frame.origin.y == piece.frame.origin.y - byAmounty * pieceSize && canThePieceGofurther == true {
                            
                            if pieceid == 1 || pieceid == 3 || pieceid == 4 || pieceid == 2 || pieceid == 6 || pieceid == 7  {
                                let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                                //pieceOption.image = UIImage(named: "piecePossibilities.png")
                                self.view.addSubview(pieceOption)
                                
                                if  pieceid == 4  {
                                    queenLogicOptions += [pieceOption]
                                } else if pieceid == 1 {
                                    bishopLogicOptions += [pieceOption]
                                } else if pieceid == 3 {
                                    rookLogicOptions += [pieceOption]
                                } else if pieceid == 6 || pieceid == 7 {
                                    if CGRectContainsPoint(pieceOption.frame , whiteKing.center) || CGRectContainsPoint(pieceOption.frame , blackKing.center) {
                                        let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                        self.view.addSubview(pieceOption2)
                                        pawnLogicOptions += [pieceOption, pieceOption2 ]
                                        checkByPawn = true
                                    } else {
                                        pieceOption.removeFromSuperview()
                                    }
                                } else if pieceid == 2 {
                                    if CGRectContainsPoint(pieceOption.frame , whiteKing.center) || CGRectContainsPoint(pieceOption.frame , blackKing.center) {
                                        let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                        self.view.addSubview(pieceOption2)
                                        knightLogicOptions += [pieceOption, pieceOption2 ]
                                        checkByKnight = true
                                    } else {
                                        pieceOption.removeFromSuperview()
                                    }
                                }
                            }
                            
                            // This pieceOption is for where the king can move when checked
                            let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                            //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                            self.view.addSubview(pieceOption2)
                            
                            if friend == whitePieces {
                                pieceWhiteLogicOptions += [pieceOption2]
                            } else {
                                pieceBlackLogicOptions += [pieceOption2]
                            }
                            
                            canThePieceGofurther = false
                        }
                    }
                    
                    if canGoFurtherWhite == true && enemy == blackPieces {
                        let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        //pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(pieceOption, array: pieceWhiteCanMove) {
                            pieceOption.removeFromSuperview()
                        } else {
                            self.view.addSubview(pieceOption)
                            pieceWhiteCanMove += [pieceOption]
                        }
                        let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(pieceOption2, array: pieceWhiteCanMove) {
                            pieceOption2.removeFromSuperview()
                        } else {
                            whitePieceLogic += [piece]
                        }
                        if blackKing.frame.origin.x == piece.frame.origin.x && pieceWhiteCanMove.count == 3   {
                            print("Vertically alligned")
                            verticallyAlignedWhite = true
                        }
                        if blackKing.frame.origin.y == piece.frame.origin.y && pieceWhiteCanMove.count == 3   {
                            print("Vertically alligned")
                            horizontallyAlignedWhite = true
                        }
                    }
                    
                    if canGoFurtherBlack == true && enemy == whitePieces {
                        
                        let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        //pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(pieceOption, array: pieceBlackCanMove) {
                            pieceOption.removeFromSuperview()
                        } else {
                            self.view.addSubview(pieceOption)
                            pieceBlackCanMove += [pieceOption]
                        }
                        let pieceOption2 = UIImageView(frame: CGRectMake(piece.frame.origin.x, piece.frame.origin.y, pieceSize, pieceSize))
                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(pieceOption2, array: pieceBlackCanMove) {
                            pieceOption2.removeFromSuperview()
                        } else {
                            blackPieceLogic += [piece]
                        }
                        if whiteKing.frame.origin.x == piece.frame.origin.x && pieceBlackCanMove.count == 3  {
                            print("Vertically alligned")
                            verticallyAlignedBlack = true
                        }
                        if whiteKing.frame.origin.y == piece.frame.origin.y && pieceBlackCanMove.count == 3 {
                            print("Vertically alligned")
                            horizontallyAlignedBlack = true
                        }
                        
                    }
                    
                    if friend == whitePieces {
                        for var o = 0 ; o < pieceWhiteLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, pieceWhiteLogicOptions[o].center) == false {
                                [pieceWhiteLogicOptions[o] .removeFromSuperview()]
                                pieceWhiteLogicOptions.removeAtIndex(o)
                            }
                        }
                    } else {
                        for var o = 0 ; o < pieceBlackLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, pieceBlackLogicOptions[o].center) == false {
                                [pieceBlackLogicOptions[o] .removeFromSuperview()]
                                pieceBlackLogicOptions.removeAtIndex(o)
                            }
                        }
                    }
                    
                    if pieceid == 4  {
                        for var o = 0 ; o < queenLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, queenLogicOptions[o].center) == false {
                                [queenLogicOptions[o] .removeFromSuperview()]
                                queenLogicOptions.removeAtIndex(o)
                            }
                        }
                    } else if pieceid == 1 {
                        for var o = 0 ; o < bishopLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, bishopLogicOptions[o].center) == false {
                                [bishopLogicOptions[o] .removeFromSuperview()]
                                bishopLogicOptions.removeAtIndex(o)
                            }
                        }
                    } else if pieceid == 3 {
                        for var o = 0 ; o < rookLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, rookLogicOptions[o].center) == false {
                                [rookLogicOptions[o] .removeFromSuperview()]
                                rookLogicOptions.removeAtIndex(o)
                            }
                        }
                    } else if pieceid == 6 || pieceid == 7  {
                        for var o = 0 ; o < pawnLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, pawnLogicOptions[o].center) == false {
                                [pawnLogicOptions[o] .removeFromSuperview()]
                                pawnLogicOptions.removeAtIndex(o)
                            }
                        }
                    } else if pieceid == 2  {
                        for var o = 0 ; o < knightLogicOptions.count; o++ {
                            if CGRectContainsPoint(boarderBoard.frame, knightLogicOptions[o].center) == false {
                                [knightLogicOptions[o] .removeFromSuperview()]
                                knightLogicOptions.removeAtIndex(o)
                            }
                        }
                    }
                }
                if foundKingBlack == false {
                    
                    for var o = 0 ; o < pieceWhiteCanMove.count; o++ {
                        [pieceWhiteCanMove[o] .removeFromSuperview()]
                    }
                    
                    pieceWhiteCanMove.removeAll()
                    pieceWhiteCanMove = []
                    
                    whitePieceLogic.removeAll()
                    whitePieceLogic = []
                }
                
                if foundKingWhite == false {
                    
                    for var o = 0 ; o < pieceBlackCanMove.count; o++ {
                        [pieceBlackCanMove[o] .removeFromSuperview()]
                    }
                    
                    pieceBlackCanMove.removeAll()
                    pieceBlackCanMove = []
                    
                    blackPieceLogic.removeAll()
                    blackPieceLogic = []
                }
                
                if foundKing == false && pieceid == 4 {
                    
                    for var o = 0 ; o < queenLogicOptions.count; o++ {
                        [queenLogicOptions[o] .removeFromSuperview()]
                    }
                    
                    queenLogicOptions.removeAll()
                    queenLogicOptions = []
                } else if foundKing == false && pieceid == 1 {
                    
                    for var o = 0 ; o < bishopLogicOptions.count; o++ {
                        [bishopLogicOptions[o] .removeFromSuperview()]
                    }
                    
                    bishopLogicOptions.removeAll()
                    bishopLogicOptions = []
                } else if foundKing == false && pieceid == 3 {
                    
                    for var o = 0 ; o < rookLogicOptions.count; o++ {
                        [rookLogicOptions[o] .removeFromSuperview()]
                    }
                    
                    rookLogicOptions.removeAll()
                    rookLogicOptions = []
                }
                //print(queenLogicOptions.count)
            }
            
            // movementNumber = 2
            if pieceid == 6 {
                letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1, byAmountz: 1, increaserz: 1)
                letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1, byAmountz: 1, increaserz: 1)
            }
            
            if pieceid == 7 {
                letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1, byAmountz: 1, increaserz: 1)
                letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1, byAmountz: 1, increaserz: 1)
            }
            
            // movementNumber = 9
            if pieceid == 1 {
                letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1, byAmountz: 1,increaserz: 1)
                letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1, byAmountz: 1,increaserz: 1)
                letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1, byAmountz: 1,increaserz: 1)
                letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1, byAmountz: 1,increaserz: 1)
            }
            // movemenNumber = 2
            if pieceid == 2 {
                letThemAppear(2, byAmounty: 1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(-2, byAmounty: 1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(1, byAmounty: 2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(1, byAmounty: -2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(-1, byAmounty: 2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(-1, byAmounty: -2, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(2, byAmounty: -1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                letThemAppear(-2, byAmounty: -1, increaserx: 0, increasery: 0, byAmountz: 1 ,increaserz: 1)
                
            }
            // movementNumber = 9
            if pieceid == 3 {
                letThemAppear(0, byAmounty: 1, increaserx: 0, increasery: 1, byAmountz: 1,increaserz: 1)
                letThemAppear(0, byAmounty: -1, increaserx: 0, increasery: -1, byAmountz: 1,increaserz: 1)
                letThemAppear(1, byAmounty: 0, increaserx: 1, increasery: 0, byAmountz: 1,increaserz: 1)
                letThemAppear(-1, byAmounty: 0, increaserx: -1, increasery: 0, byAmountz: 1,increaserz: 1)
            }
            // movementNumber = 9
            if pieceid == 4 {
                letThemAppear(0, byAmounty: 1, increaserx: 0, increasery: 1, byAmountz: 1, increaserz: 1)
                letThemAppear(0, byAmounty: -1, increaserx: 0, increasery: -1,  byAmountz: 1, increaserz: 1)
                letThemAppear(1, byAmounty: 0, increaserx: 1, increasery: 0,  byAmountz: 1, increaserz: 1)
                letThemAppear(-1, byAmounty: 0, increaserx: -1, increasery: 0,  byAmountz: 1, increaserz: 1)
                letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1,  byAmountz: 1, increaserz: 1)
                letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1,  byAmountz: 1, increaserz: 1)
                letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1,  byAmountz: 1, increaserz: 1)
                letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1,  byAmountz: 1, increaserz: 1)
                
            }
            // movementNumber = 2
            if pieceid == 5 {
                letThemAppear(0, byAmounty: 1, increaserx: 0, increasery: 1, byAmountz: 1, increaserz: 1)
                letThemAppear(0, byAmounty: -1, increaserx: 0, increasery: -1, byAmountz: 1, increaserz: 1)
                letThemAppear(1, byAmounty: 0, increaserx: 1, increasery: 0, byAmountz: 1, increaserz: 1)
                letThemAppear(-1, byAmounty: 0, increaserx: -1, increasery: 0, byAmountz: 1, increaserz: 1)
                letThemAppear(1, byAmounty: 1, increaserx: 1, increasery: 1, byAmountz: 1, increaserz: 1)
                letThemAppear(1,byAmounty: -1,increaserx: 1,increasery: -1, byAmountz: 1, increaserz: 1)
                letThemAppear(-1,byAmounty: 1,increaserx: -1,increasery: 1, byAmountz: 1, increaserz: 1)
                letThemAppear(-1,byAmounty: -1,increaserx: -1,increasery: -1, byAmountz: 1, increaserz: 1)
            }
        }
    }
    
    func blackPawnSelected(var _event:UIEvent, var _touch:UITouch) {
        showMarkedPiece()
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat) {
            var canThePieceGofurther: Bool = true
            
            for var d = byAmounty;  byAmounty <= 2 ; byAmountx += increaserx, byAmounty += increasery {
                
                for var q = 0; q < blackPieces.count; q++ {
                    if blackPieces[q].frame.origin.x == selectedPiece.frame.origin.x && blackPieces[q].frame.origin.y == selectedPiece.frame.origin.y + 1 * pieceSize{
                        canThePieceGofurther = false
                    }
                }
                
                for var q = 0; q < whitePieces.count; q++ {
                    if whitePieces[q].frame.origin.x == selectedPiece.frame.origin.x && whitePieces[q].frame.origin.y - 1 * pieceSize == selectedPiece.frame.origin.y{
                        canThePieceGofurther = false
                    }
                }
                
                if canThePieceGofurther == true && selectedPiece.frame.origin.y == _7 {
                    
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y + byAmounty * pieceSize, size, size))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if canSaveKing(selectedPiece, array: pieceWhiteCanMove) == true && canSaveKing(blackKing, array: pieceWhiteCanMove) && logicCheck(pieces, array:pieceWhiteCanMove, friends:  blackPieces)  == 2 && verticallyAlignedWhite == false {
                        pieceOption.removeFromSuperview()
                    } else {
                        self.view.addSubview(pieceOption)
                    }
                    // Check if a pawn can move when king is in check
                    if checkByQueen == true {
                        if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByBishop == true {
                        if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByRook == true {
                        if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByPawn == true {
                        if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByKnight == true {
                        if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    }
                    //                    for var q = 0; q < blackPieces.count; q++ {
                    //                        if blackPieces[q] == selectedPiece {
                    //                            game.setObject(q, forKey: "passantPiece")
                    //                        }
                    //                    }
                    //                    game.setObject(true, forKey: "passant")
                    pieceOptions += [pieceOption]
                } else if canThePieceGofurther == true {
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y + 1 * pieceSize, size, size))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if canSaveKing(selectedPiece, array: pieceWhiteCanMove) == true && canSaveKing(blackKing, array: pieceWhiteCanMove) && logicCheck(pieces, array:pieceWhiteCanMove, friends:  blackPieces)  == 2 && verticallyAlignedWhite == false {
                        pieceOption.removeFromSuperview()
                        //print("Cant move!")
                    } else {
                        self.view.addSubview(pieceOption)
                    }
                    // Check if a pawn can move when king is in check
                    if checkByQueen == true {
                        if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByBishop == true {
                        if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByRook == true {
                        if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByPawn == true {
                        if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByKnight == true {
                        if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    }
                    pieceOptions += [pieceOption]
                }
                for var r = 0; r < whitePieces.count; r++ {
                    if whitePieces[r].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && whitePieces[r].frame.origin.y == selectedPiece.frame.origin.y + 1 * pieceSize && canTake == true {
                        
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y + 1 * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(selectedPiece, array: pieceWhiteCanMove) == true && canSaveKing(blackKing, array: pieceWhiteCanMove) && logicCheck(pieces, array:pieceWhiteCanMove, friends:  blackPieces)  == 2 && canSaveKing(pieceOption, array: pieceWhiteCanMove) == false && canSaveKing(pieceOption, array: whitePieceLogic) == false  {
                            pieceOption.removeFromSuperview()
                            //print("Cant move!")
                        } else {
                            self.view.addSubview(pieceOption)
                        }
                        // Check if a pawn can move when king is in check
                        if checkByQueen == true {
                            if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByBishop == true {
                            if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByRook == true {
                            if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByPawn == true {
                            if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByKnight == true {
                            if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        }
                        pieceOptions += [pieceOption]
                        canThePieceGofurther = false
                        
                    }
                }
                
                if selectedPiece.frame.origin.y == screenHeight/2 && whitePieces[passantPiece].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && whitePieces[passantPiece].frame.origin.y == selectedPiece.frame.origin.y && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                    //print("Passant!")
                    blackPassant = true
                    havePassant = true
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y + 1 * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    self.view.addSubview(pieceOption)
                    pieceOptions += [pieceOption]
                }
                
                for var o = 0 ; o < pieceOptions.count; o++ {
                    if CGRectContainsPoint(boarderBoard.frame, pieceOptions[o].center) == false {
                        [pieceOptions[o] .removeFromSuperview()]
                        pieceOptions.removeAtIndex(o)
                    }
                }
                
                
                for var q = 0; q < pieces.count; q++ {
                    for var p = 0; p < pieceOptions.count; p++ {
                        if CGRectContainsPoint(pieces[q].frame, pieceOptions[p].center) && selectedPiece.frame.origin.y == _7 && pieceOptions[p].frame.origin.y == _5 {
                            [pieceOptions[p] .removeFromSuperview()]
                        }
                    }
                }
                
            }
        }
        letThemAppear(1, byAmounty: 1, increaserx: 0, increasery: 1)
        letThemAppear(-1, byAmounty: 1, increaserx: 0, increasery: 1)
    }
    
    // MARK: - Timer-functions ⏳
    func resetTimer() {
        movementTimer.invalidate()
        timerNumber = 0
        
    }
    var havePassant = false
    
    func updateMovementTimer() {
        
        timerNumber++
        if timerNumber > 10 {
            movementTimer.invalidate()
            
            for var i = 0 ; i < pieces.count; i++ {
                for var o = 0 ; o < piecePos.count; o++ {
                    if CGRectContainsPoint(pieces[i].frame, piecePos[o].center) {
                        pieces[i].frame.origin = piecePos[o].frame.origin
                    }
                }
            }
            
            chessPieceMovementLogic(2, pieceid: 5, friend: whitePieces, enemy: blackPieces, piece: whiteKing , logicOptions: piecesBlackLogic)
            chessPieceMovementLogic(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, piece: blackKing, logicOptions: piecesWhiteLogic)
            
            // Starts logic for all pieces
            for var q = 0; q < whiteQueens.count; q++ {
                chessPieceMovementLogic(9, pieceid: 4, friend: whitePieces, enemy: blackPieces, piece: whiteQueens[q] , logicOptions: piecesBlackLogic)
            }
            for var q = 0; q < blackQueens.count; q++ {
                chessPieceMovementLogic(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, piece: blackQueens[q], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < whiteBishops.count; w++ {
                chessPieceMovementLogic(9, pieceid: 1, friend: whitePieces, enemy: blackPieces, piece: whiteBishops[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < blackBishops.count; w++ {
                chessPieceMovementLogic(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, piece: blackBishops[w], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < whiteRooks.count; w++ {
                chessPieceMovementLogic(9, pieceid: 3, friend: whitePieces, enemy: blackPieces, piece: whiteRooks[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < blackRooks.count; w++ {
                chessPieceMovementLogic(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, piece: blackRooks[w], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < whiteKnights.count; w++ {
                chessPieceMovementLogic(2, pieceid: 2, friend: whitePieces, enemy: blackPieces, piece: whiteKnights[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < blackKnights.count; w++ {
                chessPieceMovementLogic(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, piece: blackKnights[w], logicOptions: piecesWhiteLogic)
            }
            for var w = 0; w < whitePawns.count; w++ {
                chessPieceMovementLogic(2, pieceid: 6, friend: whitePieces, enemy: blackPieces, piece: whitePawns[w], logicOptions: piecesBlackLogic)
            }
            for var w = 0; w < blackPawns.count; w++ {
                chessPieceMovementLogic(2, pieceid: 7, friend: blackPieces, enemy: whitePieces, piece: blackPawns[w], logicOptions: piecesWhiteLogic)
            }
            
            //this is checkmate, black won
            if self.colorLcolor == "You are Black" {
                if self.checkByQueen == true || self.checkByBishop == true || self.checkByRook == true || self.checkByKnight == true || self.checkByPawn == true {
                    var checkMate1 = false
                    var checkMate2 = false
                    var checkMate3 = false
                    var checkMate4 = false
                    var checkMate5 = false
                    var checkMate6 = false

                    for var i = 0; i < blackKnights.count;i++ {
                        if chessPieceSelected(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKnights[i]) == 0 {
                            checkMate1 = true
                        }
                    }
                    for var i = 0; i < blackBishops.count;i++ {
                        if chessPieceSelected(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackBishops[i]) == 0 {
                            checkMate2 = true
                        }
                    }
                    for var i = 0; i < blackRooks.count;i++ {
                        if chessPieceSelected(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackRooks[i]) == 0 {
                            checkMate3 = true
                        }
                    }
                    for var i = 0; i < blackQueens.count;i++ {
                        if chessPieceSelected(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackQueens[i]) == 0 {
                            checkMate4 = true
                        }
                    }
                    if chessPieceSelected(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKing) == 0 {
                        checkMate5 = true
                    }
                    
                    for var i = 0; i < blackPawns.count;i++ {
                            if whitePawnSelected(true, chosenPiece: blackPawns[i]) == 0 {
                                checkMate6 = true
                            }
                    }
                    
                    if checkMate1 == true && checkMate2 == true && checkMate3 == true && checkMate4 == true && checkMate5 == true && checkMate6 == true {

                        self.gameFinishedScreen("lost",statusBy: "chekmate.")
                        
                        print("Check mate!")
                        
                    }
                }
                else {
                    print("this is salemate, draw")
                    //this is salemate, draw
                    var staleMate1 = false
                    var staleMate2 = false
                    var staleMate3 = false
                    var staleMate4 = false
                    var staleMate5 = false
                    var staleMate6 = false
                    
                    
                    for var i = 0; i < blackKnights.count;i++ {
                        if blackKnights[i].alpha == 1 {
                            if chessPieceSelected(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKnights[i]) == 0 {
                                staleMate1 = true
                            }
                        } else if blackKnights[i].alpha == 0 {
                            staleMate1 = true
                        } else {
                            staleMate1 = false
                        }
                    }
                    for var i = 0; i < blackBishops.count;i++ {
                        if blackBishops[i].alpha == 1 {
                            if chessPieceSelected(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackBishops[i]) == 0 {
                                staleMate2 = true
                            }
                        } else if blackBishops[i].alpha == 0 {
                            staleMate2 = true
                        } else {
                            staleMate2 = false
                        }
                    }
                    for var i = 0; i < blackRooks.count;i++ {
                        if blackRooks[i].alpha == 1 {
                            if chessPieceSelected(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackRooks[i]) == 0 {
                                staleMate3 = true
                            }
                        } else if blackRooks[i].alpha == 0 {
                            staleMate3 = true
                        } else {
                            staleMate3 = false
                        }
                    }
                    for var i = 0; i < blackQueens.count;i++ {
                        if blackQueens[i].alpha == 1 {
                            if chessPieceSelected(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackQueens[i]) == 0 {
                                staleMate4 = true
                            }
                        } else if blackQueens[i].alpha == 0 {
                            staleMate4 = true
                        } else {
                            staleMate4 = false
                        }
                    }
                    if chessPieceSelected(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKing) == 0 {
                        staleMate5 = true
                    }
                    
                    for var i = 0; i < blackPawns.count;i++ {
                        if blackPawns[i].alpha == 1 {
                            if whitePawnSelected(true, chosenPiece: blackPawns[i]) == 0 {
                                staleMate6 = true
                            }
                        } else if blackPawns[i].alpha == 0 {
                            staleMate6 = true
                        } else {
                            staleMate6 = false
                        }
                    }
                    
                    if staleMate1 == true && staleMate2 == true && staleMate3 == true && staleMate4 == true && staleMate5 == true && staleMate6 == true {
                        self.gameFinishedScreen("drew",statusBy: "stalemate")
                    }
                }
            }
            
            if self.colorLcolor == "You are White" {
                
                //this is checkmate, white won
                
                if self.checkByQueen == true || self.checkByBishop == true || self.checkByRook == true || self.checkByKnight == true || self.checkByPawn == true {
                    
                    print("this is checkmate, white won")
                    
                    var checkMate1 = false
                    var checkMate2 = false
                    var checkMate3 = false
                    var checkMate4 = false
                    var checkMate5 = false
                    var checkMate6 = false
                    
                    
                    for var i = 0; i < blackKnights.count;i++ {
                            print("blackKnights")
                            if chessPieceSelected(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKnights[i]) == 0 {
                                checkMate1 = true
                            }
                    }
                    for var i = 0; i < blackBishops.count;i++ {
                            print("blackBishops")
                            if chessPieceSelected(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackBishops[i]) == 0 {
                                checkMate2 = true
                            }
                    }
                    for var i = 0; i < blackRooks.count;i++ {
                            print("blackRooks")
                            if chessPieceSelected(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackRooks[i]) == 0 {
                                checkMate3 = true
                            }
                    }
                    for var i = 0; i < blackQueens.count;i++ {
                            print("blackQueens")
                            if chessPieceSelected(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackQueens[i]) == 0 {
                                checkMate4 = true
                            }
                    }
                    if chessPieceSelected(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKing) == 0 {
                        print("blackKnights")
                        checkMate5 = true
                    }
                    
                    for var i = 0; i < blackPawns.count;i++ {
                            print("blackPawns")
                            if whitePawnSelected(true, chosenPiece: blackPawns[i]) == 0 {
                                checkMate6 = true
                            }
                    }
                    
                    if checkMate1 == true && checkMate2 == true && checkMate3 == true && checkMate4 == true && checkMate5 == true && checkMate6 == true {
                        self.gameFinishedScreen("won",statusBy: "chekmate.")
                        
                        print("Check mate!")
                    }
                } else {
                    
                    //this is stalemate, draw
                    var staleMate1 = false
                    var staleMate2 = false
                    var staleMate3 = false
                    var staleMate4 = false
                    var staleMate5 = false
                    var staleMate6 = false
                    
                    
                    for var i = 0; i < blackKnights.count;i++ {
                        if blackKnights[i].alpha == 1 {
                            if chessPieceSelected(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKnights[i]) == 0 {
                                staleMate1 = true
                            }
                        } else if blackKnights[i].alpha == 0 {
                            staleMate1 = true
                        } else {
                            staleMate1 = false
                        }
                    }
                    for var i = 0; i < blackBishops.count;i++ {
                        if blackBishops[i].alpha == 1 {
                            if chessPieceSelected(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackBishops[i]) == 0 {
                                staleMate2 = true
                            }
                        } else if blackBishops[i].alpha == 0 {
                            staleMate2 = true
                        } else {
                            staleMate2 = false
                        }
                    }
                    for var i = 0; i < blackRooks.count;i++ {
                        if blackRooks[i].alpha == 1 {
                            if chessPieceSelected(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackRooks[i]) == 0 {
                                staleMate3 = true
                            }
                        } else if blackRooks[i].alpha == 0 {
                            staleMate3 = true
                        } else {
                            staleMate3 = false
                        }
                    }
                    for var i = 0; i < blackQueens.count;i++ {
                        if blackQueens[i].alpha == 1 {
                            if chessPieceSelected(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackQueens[i]) == 0 {
                                staleMate4 = true
                            }
                        } else if blackQueens[i].alpha == 0 {
                            staleMate4 = true
                        } else {
                            staleMate4 = false
                        }
                    }
                    if chessPieceSelected(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, hidden: true, chosenPiece: blackKing) == 0 {
                        staleMate5 = true
                    }
                    
                    for var i = 0; i < blackPawns.count;i++ {
                        if blackPawns[i].alpha == 1 {
                        if whitePawnSelected(true, chosenPiece: blackPawns[i]) == 0 {
                            staleMate6 = true
                        }
                        } else if blackPawns[i].alpha == 0 {
                            staleMate6 = true
                        } else {
                            staleMate6 = false
                        }
                    }
                    
                    if staleMate1 == true && staleMate2 == true && staleMate3 == true && staleMate4 == true && staleMate5 == true && staleMate6 == true {
                        
                        
                        
                        
                        
                        self.gameFinishedScreen("drew",statusBy: "stalemate")
                    }
                }
            }
            
            if checkByQueen == true || checkByBishop == true || checkByRook == true || checkByKnight == true || checkByPawn == true {
                chessNotationCheck = "+"
            }
            var LAN = ""
            if castleLeft == true && selectedPiece == whiteKing && selectedPiece.image == UIImage(named:"whiteKing") {
                print("0-0-0")
                LAN = "0-0-0"
                game.setObject(true, forKey: "can_Castle_white")
                //game["status_white"] = "notmove"
            }
            else if castleLeft == true && selectedPiece == whiteKing && selectedPiece.image == UIImage(named:"blackKing"){
                print("0-0-0")
                LAN = "0-0-0"
                game.setObject(true, forKey: "can_Castle_black")
            }
            else if castleRight == true && selectedPiece == whiteKing && selectedPiece.image == UIImage(named:"whiteKing") {
                print("0-0")
                LAN = "0-0"
                game.setObject(true, forKey: "can_Castle_white")
                
            }
            else if castleRight == true && selectedPiece == whiteKing && selectedPiece.image == UIImage(named:"blackKing"){
                print("0-0")
                LAN = "0-0"
                game.setObject(true, forKey: "can_Castle_black")
            }
            else {
                //Must be equal!
                
                print(pieceString + pieceStringPos + piecesNotationSeperator + chessNotationx + chessNotationy + chessNotationCheck)
                LAN = pieceString + pieceStringPos + piecesNotationSeperator + chessNotationx + chessNotationy + chessNotationCheck
                piecesNotationSeperator = "-"
                chessNotationCheck = ""
                
                
            }
            notations.append(LAN)
            moveNum = []
            for var i = 0; i < notations.count; i++ {
                var t = (i+1)
                for var q = 0; q < 2; q++ {
                    moveNum.append(t)
                }
            }
            
            print(notations.last)
            print("collectionview")
            print(notations.count - 1)
            let newIndexPath = NSIndexPath(forItem: notations.count - 1, inSection: 0)
            collectionView.insertItemsAtIndexPaths([newIndexPath])
            collectionView.layoutIfNeeded()
            collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .Bottom, animated: true)
            dispatch_async(dispatch_get_main_queue()) {
                self.collectionView.reloadData()
            }
            game.addObject(notations.last!, forKey: "piecePosition")
            
            var uuser = ""
            if game["whitePlayer"] as? String == PFUser.currentUser()?.username {
                
                notationsWithNumber +=  "\(notations.count / 2 + 1). "
                
                notationsWithNumber += "\(notations.last!) "
                
                game["status_white"] = "notmove"
                game["status_black"] = "move"
                uuser = (game["blackPlayer"] as? String)!
                
            }
            else {
                notationsWithNumber += "\(notations.last!) "
                
                game["status_white"] = "move"
                game["status_black"] = "notmove"
                uuser = (game["whitePlayer"] as? String)!
            }
            movesField.text = notationsWithNumber
            
            var moves: Array<String> = []
            func loadMoves() {
                moves = []
                notationsWithNumber = ""
                var t = 1
                for var i = 0; i < notations.count; i++ {
                    
                    
                    if i % 2 == 0{
                        notationsWithNumber +=  "\(t). "
                        t++
                    }
                    notationsWithNumber += "\(notations[i]) "
                    
                    
                    print("\(i+1).")
                    var t = (i+1)
                    for var q = 0; q < 2; q++ {
                        moveNum.append(t)
                    }
                    var putIntoMoves = ""
                    for var o = 0; o < notations[i].characters.count; o++ {
                        let output = notations[i][o]
                        let letter = String(output)
                        
                        if letter.lowercaseString == String(output){
                            
                            if output != "-" && output != "x" {
                                //print(output)
                                putIntoMoves.append(output)
                                
                            }
                            
                        }
                    }
                    print(putIntoMoves)
                    moves.append(putIntoMoves)
                }
                print(moves)
                movesCap.append(moves.last!)
            }
            loadMoves()
            
            
            var now = game["timeLeftToMove"] as? NSDate
            var newDate = now!.dateByAddingTimeInterval(60*60*24*multiplySpeedWith)
            
            
            if notations.count <= 2 {
                print(notations.count)
                newDate = NSDate().dateByAddingTimeInterval(60*60*24*(multiplySpeedWithIfNew + multiplySpeedWith))
            }
            
            
            game["timeLeftToMove"] = newDate
            
            if iamWhite {
                let timeToAdd = game["blackTime"] as? Double
                newDate = NSDate().dateByAddingTimeInterval(timeToAdd!)
                game["blackDate"] = newDate
                
                game["whiteTime"] = -timeLeft - 2
            }
            else {
                let timeToAdd = game["whiteTime"] as? Double
                newDate = NSDate().dateByAddingTimeInterval(timeToAdd!)
                game["whiteDate"] = newDate
                
                game["blackTime"] = -timeLeft - 2
            }

            timer.invalidate()
            
            
            print(notations.count)

            if self.colorLcolor == "You are White" {
                self.game.setObject(false, forKey: "promotionBlack")
                //self.game.setObject(false, forKey: "passantBlack")
            } else {
                self.game.setObject(false, forKey: "promotion")
                //self.game.setObject(false, forKey: "passant")
            }
            
            let safetyTest = PFQuery(className: "Games")
            safetyTest.whereKey("objectId", equalTo: gameID)
            let safety = safetyTest.getFirstObject()
            
            //            if iamWhite{
            //                if safety!["status_white"] as? String == "notmove"{
            //
            //                    self.navigationController!.popViewControllerAnimated(true)
            //
            //
            //                    let alert = UIAlertController(title: "Oops!", message: "It seems like we encountered an error while trying to save your game. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            //
            //                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            //                        switch action.style{
            //                        case .Default:
            //                            print("default")
            //                        case .Cancel:
            //                            print("cancel")
            //                        case .Destructive:
            //                            print("destructive")
            //                        }
            //                    }))
            //                    self.presentViewController(alert, animated: true, completion: nil)
            //                }
            //                else {
            //                    return
            //                }
            //            }
            //            else  {
            //                if safety!["status_black"] as? String == "notmove"{
            //                    self.navigationController!.popViewControllerAnimated(true)
            //
            //                    let alert = UIAlertController(title: "Oops!", message: "It seems like we encountered an error while trying to save your game. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            //
            //                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            //                        switch action.style{
            //                        case .Default:
            //                            print("default")
            //                        case .Cancel:
            //                            print("cancel")
            //                        case .Destructive:
            //                            print("destructive")
            //                        }
            //                    }))
            //                    self.presentViewController(alert, animated: true, completion: nil)
            //                }
            //                else {
            //                    return
            //                }
            //            }
            
            
            if havePassant == true {
                game.addObject(true, forKey: "passantArray")
            }
            else {
                game.addObject(false, forKey: "passantArray")
            }
            havePassant = false

            game.saveInBackgroundWithBlock({ (bool:Bool, error:NSError?) -> Void in
                if error == nil {
                    
                    // Create our Installation query
                    let pushQuery = PFInstallation.query()
                    pushQuery!.whereKey("username", equalTo: uuser)
                    
                    // Send push notification to query
                    let push = PFPush()
                    push.setQuery(pushQuery) // Set our Installation query
                    push.setMessage("\(PFUser.currentUser()!.username!) made a move!")
                    //    push.setData(<#T##data: [NSObject : AnyObject]?##[NSObject : AnyObject]?#>)
                    push.sendPushInBackground()
                    
                    //firebase
           
                    //add who's turn it is
                    let checkstatus = Firebase(url:"https://chess-panber.firebaseio.com/games/")
                    var status = ["turn": "black"]
                    if self.game ["whitePlayer"] as? String == PFUser.currentUser()?.username {
                        status = ["turn": "black"]
                    }
                    else if self.game ["blackPlayer"] as? String == PFUser.currentUser()?.username {
                        status = ["turn": "white"]
                    }
                    let statusRef = checkstatus.childByAppendingPath("\(gameID)")
                    statusRef.setValue(status)
                    //firebase - end
                    
                    self.turnLturn = "Their Turn"
                    self.turnIndicatorturn = UIColor.lightGrayColor()
                    
                    
                    
                    
                    
                    UIView.animateWithDuration(0.3, delay:0, options: .CurveEaseInOut, animations: { () -> Void in
                        
                        self.turnIndicatorG.backgroundColor = UIColor.lightGrayColor()
                        self.turnIndicatorG.frame.origin.x = screenWidth/2 - self.turnIndicatorG.frame.size.width/2
                        self.turnGL.text = ""
                        
                        self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 30
                        self.turnGL.frame.origin.y -= 100
                        
                        
                        if screenHeight == 568 {
                            self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 70
                        }
                        else if screenHeight == 480 {
                            self.timeGL.frame.origin.y = screenHeight/2 + screenWidth/2 + 80
                        }
                        
                        }, completion: {finish in
                            
                            self.timeGL.text = ""
                            
                            
                    })
                    
                    
                    
                }
            })
            
            castleLeft = false
            castleRight = false
        }
            
            
        else {
            var positionx = selectedPiece.frame.origin.x
            var positiony = selectedPiece.frame.origin.y
            positiony +=  moveByAmounty / 10
            positionx += moveByAmountx / 10
            selectedPiece.frame = CGRect(x: positionx, y: positiony, width: pieceSize, height: pieceSize)
            if whiteCastle == true {
                var positionx = castlePiece.frame.origin.x
                var positiony = castlePiece.frame.origin.y
                positiony +=  moveByAmounty / 10
                if castlePiece == whiteRook2  {
                    positionx -= (moveByAmountx - 1 * pieceSize) / 10
                } else if castlePiece == whiteRook1 {
                    positionx -= (moveByAmountx) / 10
                }
                castlePiece.frame = CGRect(x: positionx, y: positiony, width: pieceSize, height: pieceSize)
            } else if blackCastle == true {
                var positionx = castlePiece.frame.origin.x
                var positiony = castlePiece.frame.origin.y
                positiony +=  moveByAmounty / 10
                if castlePiece == whiteRook2  {
                    print("Black castle 1")
                    positionx -= (moveByAmountx) / 10
                } else if castlePiece == whiteRook1 {
                    positionx -= (moveByAmountx + 1 * pieceSize) / 10
                    print("Black castle 2")
                }
                castlePiece.frame = CGRect(x: positionx, y: positiony, width: pieceSize, height: pieceSize)
            }
            
            promoted = false
            canTake = true
            checkByQueen = false
            checkByBishop = false
            checkByRook = false
            checkByPawn = false
            checkByKnight = false
            verticallyAlignedWhite = false
            horizontallyAlignedWhite = false
            verticallyAlignedBlack = false
            horizontallyAlignedBlack = false
            removeLogicOptions()
            removeBishopLogicOptions()
            removeRookLogicOptions()
            removeWhitePieceLogicOptions()
            removeBlackPieceLogicOptions()
            removeKnightLogicOptions()
            removePawnLogicOptions()
            removeWhiteCanMoveOptions()
            removeBlackCanMoveOptions()
            
            removeWhiteCastlingLeft()
            removeWhiteCastlingRight()
            removeBlackCastlingLeft()
            removeBlackCastlingRight()
            
            removeLeftBlackCastleLogic()
            removeRightBlackCastleLogic()
            
            // Castle Logic
            removeLeftWhiteCastleLogic()
            removeRightWhiteCastleLogic()
            
        }
        
        //        if selectedPiece == whiteKing {
        //            hasWhiteKingMoved = true
        //        }
        //        if selectedPiece == whiteRook1 {
        //            hasWhiteRookMoved2 = true
        //        }
        //        if selectedPiece == whiteRook2 {
        //            hasWhiteRookMoved = true
        //        }
        //        if selectedPiece == blackKing {
        //            hasBlackKingMoved = true
        //        }
        //        if selectedPiece == blackRook1 {
        //            hasBlackRookMoved = true
        //        }
        //        if selectedPiece == blackRook2 {
        //            hasBlackRookMoved2 = true
        //        }
    }
    
    func dissablePieceOptions(var options: Array<UIImageView>) {
        for var o = 0 ; o < options.count; o++ {
            options[o].userInteractionEnabled = false
            options[o].multipleTouchEnabled = false
        }
    }
    
    func hasBeenTaken(var image: UIImageView, var array: Array<UIImageView>) -> Bool {
        
        var bool = false
        for var i = 0; i < array.count; i++ {
            if image == array[i] {
                bool = true
            }
        }
        return bool
    }
    
    func canSaveKing(var image: UIImageView, var array: Array<UIImageView>) -> Bool {
        
        var bool = false
        for var i = 0; i < array.count; i++ {
            if CGRectContainsPoint(image.frame, array[i].center) {
                bool = true
            }
        }
        return bool
    }
    
    func logicCheck(var pieces: Array<UIImageView>, var array: Array<UIImageView>, var friends: Array<UIImageView>) -> Int {
        
        var count = 0
        for var p = 0; p < pieces.count; p++ {
            for var i = 0; i < array.count; i++ {
                if CGRectContainsPoint(pieces[p].frame, array[i].center) {
                    count++
                }
            }
        }
        
        if friends == whitePieces {
            for var p = 0; p < blackQueens.count; p++ {
                for var i = 0; i < array.count; i++ {
                    if CGRectContainsPoint(blackQueens[p].frame, array[i].center) && !hasBeenTaken(blackQueens[p], array: pieceToTake) {
                        count--
                    }
                }
            }
            
            for var p = 0; p < blackBishops.count; p++ {
                for var i = 0; i < array.count; i++ {
                    if CGRectContainsPoint(blackBishops[p].frame, array[i].center) && !hasBeenTaken(blackBishops[p], array: pieceToTake) && verticallyAlignedBlack == false && horizontallyAlignedBlack == false {
                        count--
                    }
                }
            }
            for var p = 0; p < blackRooks.count; p++ {
                for var i = 0; i < array.count; i++ {
                    if CGRectContainsPoint(blackRooks[p].frame, array[i].center) && !hasBeenTaken(blackRooks[p], array: pieceToTake) && horizontallyAlignedBlack == true || CGRectContainsPoint(blackRooks[p].frame, array[i].center) && !hasBeenTaken(blackRooks[p], array: pieceToTake) && verticallyAlignedBlack == true{
                        count--
                    }
                }
            }
        } else if friends == blackPieces {
            for var p = 0; p < whiteQueens.count; p++ {
                for var i = 0; i < array.count; i++ {
                    if CGRectContainsPoint(whiteQueens[p].frame, array[i].center) && !hasBeenTaken(whiteQueens[p], array: pieceToTake) {
                        count--
                    }
                }
            }
            
            for var p = 0; p < whiteBishops.count; p++ {
                for var i = 0; i < array.count; i++ {
                    if CGRectContainsPoint(whiteBishops[p].frame, array[i].center) && !hasBeenTaken(whiteBishops[p], array: pieceToTake) && verticallyAlignedWhite == false && horizontallyAlignedWhite == false {
                        count--
                    }
                }
            }
            for var p = 0; p < whiteRooks.count; p++ {
                for var i = 0; i < array.count; i++ {
                    if CGRectContainsPoint(whiteRooks[p].frame, array[i].center) && !hasBeenTaken(whiteRooks[p], array: pieceToTake) && horizontallyAlignedWhite == true || CGRectContainsPoint(whiteRooks[p].frame, array[i].center) && !hasBeenTaken(whiteRooks[p], array: pieceToTake) && verticallyAlignedWhite == true {
                        count--
                    }
                }
            }
        }
        
        //print(count)
        return count
    }
    
    func contains(var _imageArray:Array<UIImageView>, _image: UIImageView) -> Bool {
        
        var bool = false
        for var i = 0; i < _imageArray.count; i++ {
            
            if (_imageArray[i].image == _image.image) {
                bool = true
            }
        }
        
        return bool
    }
    
    func containsLabel(var _labelArray:Array<UILabel>, _label: UILabel) -> Bool {
        
        var bool = false
        for var i = 0; i < _labelArray.count; i++ {
            
            if (_labelArray[i] == _label) {
                bool = true
            }
        }
        
        return bool
    }
    
    
    // MARK: - Touches began! 👆
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first as UITouch!
        
        for var o = 0 ; o < piecePos.count; o++ {
            if CGRectContainsPoint(selectedPiece.frame, piecePos[o].center) {
                selectedPiece.frame.origin.x = piecePos[o].frame.origin.x
                selectedPiece.frame.origin.y = piecePos[o].frame.origin.y
                
            }
        }
        
        for var o = 0 ; o < pieceOptions.count ; o++ {
            for var t = 0; t < 8; t++ {
                for var g = 0; g < 8; g++ {
                    if (selectedPiece.frame.origin.x == xAxisArr[t] && selectedPiece.frame.origin.y == yAxisArr[g]) {
                        
                        
                        if game["blackPlayer"]  as? String == PFUser.currentUser()?.username {
                            //Must not be equal!
                            piecesArrs = [whiteQueens,whiteKings,whitePawns,blackPawns,whiteKnights,whiteBishops,whiteRooks, blackKnights, blackBishops, blackRooks, blackQueens, blackKings]
                            piecesString = ["whiteQueen","whiteKing","whitePawn","blackPawn","whiteKnight","whiteBishop","whiteRook", "blackKnight", "blackBishop", "blackRook", "blackQueen", "blackKing"]
                            xAxisArrStr2 = ["h","g","f","e","d","c","b","a"]
                            yAxisArrStr2 = ["8","7","6","5","4","3","2","1"]
                            pieceStringPos = xAxisArrStr2[t] + yAxisArrStr2[g]
                            
                        }
                        else {
                            xAxisArrStr2 = ["a","b","c","d","e","f","g","h"]
                            yAxisArrStr2 = ["1","2","3","4","5","6","7","8"]
                            
                            pieceStringPos = xAxisArrStr[t] + yAxisArrStr[g]
                            
                        }
                        
                    }
                }
            }
        }
        
        for var o = 0 ; o < pieceOptions.count ; o++ {
            
            if touch.view == pieceOptions[o] {
                touchPosition = pieceOptions[o].frame
                // This is for showing which square the pieces are in
                for var t = 0; t < 8; t++ {
                    for var g = 0; g < 8; g++ {
                        if (pieceOptions[o].frame.origin.x == xAxisArr[t] && pieceOptions[o].frame.origin.y == yAxisArr[g] && touch.view == pieceOptions[o]) {
                            if hasBeenTaken(selectedPiece, array: whiteKnights) || hasBeenTaken(selectedPiece, array: blackKnights) {
                                pieceString = "N"
                            } else if hasBeenTaken(selectedPiece, array: whiteBishops) || hasBeenTaken(selectedPiece, array: blackBishops) {
                                pieceString = "B"
                            } else if hasBeenTaken(selectedPiece, array: whiteRooks) || hasBeenTaken(selectedPiece, array: blackRooks)  {
                                pieceString = "R"
                            } else if hasBeenTaken(selectedPiece, array: whiteQueens) || hasBeenTaken(selectedPiece, array: blackQueens) {
                                pieceString = "Q"
                            } else if hasBeenTaken(selectedPiece, array: whiteKings) || hasBeenTaken(selectedPiece, array: blackKings)  {
                                pieceString = "K"
                            } else if hasBeenTaken(selectedPiece, array: whitePawns) || hasBeenTaken(selectedPiece, array: blackPawns) {
                                pieceString = ""
                            }
                            for var i = 0; i < pieces.count; i++ {
                                if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == pieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == pieces[i].frame.origin.y || whitePassant == true || blackPassant == true  {
                                    piecesNotationSeperator = "x"
                                    
                                }
                            }
                            
                            if game["blackPlayer"] as? String == PFUser.currentUser()?.username {
                                chessNotationx = xAxisArrStr2[t]
                                chessNotationy = yAxisArrStr2[g]
                            }
                            else {
                                chessNotationx = xAxisArrStr[t]
                                chessNotationy = yAxisArrStr[g]
                            }
                        }
                    }
                }
                
                
                for var i = 0; i < whitePawns.count; i++ {
                    if selectedPiece == whitePawns[i] && selectedPiece.frame.origin.y == _7 {
                        let promotionPiece = i
                        self.promoted = true
                        self.promotionAtIndex.append(self.movesCap.count)
                        let actionSheet = UIAlertController(title: nil, message: "Promote pawn to:", preferredStyle: UIAlertControllerStyle.ActionSheet)
                        
                        let promoteToQueen = UIAlertAction(title: "Queen", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            self.movePiece(self.touchPosition.origin.x - self.selectedPiece.frame.origin.x, _moveByAmounty: self.touchPosition.origin.y - self.selectedPiece.frame.origin.y)
                            if self.colorLcolor == "You are White" {
                                self.selectedPiece.image = UIImage(named:"whiteQueen")
                                self.game.addObject("Queen", forKey: "whitePromotionType")
                            } else if self.colorLcolor == "You are Black" {
                                self.selectedPiece.image = UIImage(named:"blackQueen")
                                self.game.addObject("Queen", forKey: "blackPromotionType")
                            }
                            self.whitePawns.removeAtIndex(promotionPiece)
                            self.whiteQueens += [self.selectedPiece]
                            print("White queen promotion")
                            print(promotionPiece)
                            for var q = 0; q < self.whiteQueens.count; q++ {
                                self.chessPieceMovementLogic(9, pieceid: 4, friend: self.whitePieces, enemy: self.blackPieces, piece: self.whiteQueens[q] , logicOptions: self.piecesBlackLogic)
                            }
                            
                            self.game.saveInBackgroundWithBlock({ (bool:Bool, error:NSError?) -> Void in
                                if error == nil {
                                }
                            })
                            
                            
                        })
                        let promoteToRook = UIAlertAction(title: "Rook", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            self.movePiece(self.touchPosition.origin.x - self.selectedPiece.frame.origin.x, _moveByAmounty: self.touchPosition.origin.y - self.selectedPiece.frame.origin.y)
                            if self.colorLcolor == "You are White" {
                                self.selectedPiece.image = UIImage(named:"whiteRook")
                                self.game.addObject("Rook", forKey: "whitePromotionType")
                            } else if self.colorLcolor == "You are Black" {
                                self.selectedPiece.image = UIImage(named:"blackRook")
                                self.game.addObject("Rook", forKey: "blackPromotionType")
                            }
                            self.whitePawns.removeAtIndex(promotionPiece)
                            self.whiteRooks += [self.selectedPiece]
                            for var w = 0; w < self.whiteRooks.count; w++ {
                                self.chessPieceMovementLogic(9, pieceid: 3, friend: self.whitePieces, enemy: self.blackPieces, piece: self.whiteRooks[w], logicOptions: self.piecesBlackLogic)
                            }
                            self.game.saveInBackgroundWithBlock({ (bool:Bool, error:NSError?) -> Void in
                                if error == nil {
                                }
                            })
                        })
                        let promoteToBishop = UIAlertAction(title: "Bishop", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            self.movePiece(self.touchPosition.origin.x - self.selectedPiece.frame.origin.x, _moveByAmounty: self.touchPosition.origin.y - self.selectedPiece.frame.origin.y)
                            if self.colorLcolor == "You are White" {
                                self.selectedPiece.image = UIImage(named:"whiteBishop")
                                self.game.addObject("Bishop", forKey: "whitePromotionType")
                            } else if self.colorLcolor == "You are Black" {
                                self.selectedPiece.image = UIImage(named:"blackBishop")
                                self.game.addObject("Bishop", forKey: "blackPromotionType")
                            }
                            self.whitePawns.removeAtIndex(promotionPiece)
                            self.whiteBishops += [self.selectedPiece]
                            for var w = 0; w < self.whiteBishops.count; w++ {
                                self.chessPieceMovementLogic(9, pieceid: 1, friend: self.whitePieces, enemy: self.blackPieces, piece: self.whiteBishops[w], logicOptions: self.piecesBlackLogic)
                            }
                            self.game.saveInBackgroundWithBlock({ (bool:Bool, error:NSError?) -> Void in
                                if error == nil {
                                }
                            })
                        })
                        let promoteToKnight = UIAlertAction(title: "Knight", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            self.movePiece(self.touchPosition.origin.x - self.selectedPiece.frame.origin.x, _moveByAmounty: self.touchPosition.origin.y - self.selectedPiece.frame.origin.y)
                            if self.colorLcolor == "You are White" {
                                self.selectedPiece.image = UIImage(named:"whiteKnight")
                                self.game.addObject("Knight", forKey: "whitePromotionType")
                            } else if self.colorLcolor == "You are Black" {
                                self.selectedPiece.image = UIImage(named:"blackKnight")
                                self.game.addObject("Knight", forKey: "blackPromotionType")
                            }
                            self.whitePawns.removeAtIndex(promotionPiece)
                            self.whiteKnights += [self.selectedPiece]
                            for var w = 0; w < self.whiteKnights.count; w++ {
                                self.chessPieceMovementLogic(2, pieceid: 2, friend: self.whitePieces, enemy: self.blackPieces, piece: self.whiteKnights[w], logicOptions: self.piecesBlackLogic)
                            }
                            self.game.saveInBackgroundWithBlock({ (bool:Bool, error:NSError?) -> Void in
                                if error == nil {
                                }
                            })
                        })
                        
                        
                        actionSheet.addAction(promoteToQueen)
                        actionSheet.addAction(promoteToRook)
                        actionSheet.addAction(promoteToBishop)
                        actionSheet.addAction(promoteToKnight)
                        self.presentViewController(actionSheet, animated: true, completion: nil)
                    }
                }
                
                
                for var i = 0; i < whitePieces.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == whitePieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == whitePieces[i].frame.origin.y  {
                        pieceToTake += [whitePieces[i]]
                        whitePieces[i].removeFromSuperview()
                        whitePieces.removeAtIndex(i)
                        whitePiecesString.removeAtIndex(i)
                    }
                }
                
                for var i = 0; i < blackPawns.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackPawns[i].frame.origin.x && pieceOptions[o].frame.origin.y == blackPawns[i].frame.origin.y  {
                        //blackPawns.removeAtIndex(i)
                        print("PAWN TAKEN")
                    }
                }
                
                for var i = 0; i < blackQueens.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackQueens[i].frame.origin.x && pieceOptions[o].frame.origin.y == blackQueens[i].frame.origin.y  {
                        //blackQueens.removeAtIndex(i)
                        print("QUEEN TAKEN")
                    }
                }
                
                for var i = 0; i < blackBishops.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackBishops[i].frame.origin.x && pieceOptions[o].frame.origin.y == blackBishops[i].frame.origin.y  {
                        //blackBishops.removeAtIndex(i)
                        print("BISHOP TAKEN")
                    }
                }
                
                for var i = 0; i < blackRooks.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackRooks[i].frame.origin.x && pieceOptions[o].frame.origin.y == blackRooks[i].frame.origin.y  {
                        //blackRooks.removeAtIndex(i)
                        print("BISHOP TAKEN")
                    }
                }
                
                for var i = 0; i < blackKnights.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackKnights[i].frame.origin.x && pieceOptions[o].frame.origin.y == blackKnights[i].frame.origin.y  {
                        //blackKnights.removeAtIndex(i)
                        //takenPiecesToReload.append(blackKnights[i])
                        print("KNIGHT TAKEN")
                    }
                }
                
                for var i = 0; i < pieces.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == pieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == pieces[i].frame.origin.y  {
                        
                        
                        
                        if self.colorLcolor == "You are White" {
                            if (!self.contains(takenBlackPieces, _image: pieces[i])) {
                                takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                takenPiece.image = pieces[i].image
                                takenBlackPieces += [pieces[i]]
                                takenBlackPiecesForMove += [takenPiece]
                                
                                view.addSubview(takenPiece)
                            }
                            takenBlackPiecesForInfo += [takenPiece]
                            for var t = 0; t < takenBlackPiecesLbl.count; t++ {
                                if (pieces[i].image == UIImage(named: blackPiecesTypes[t])) {
                                    blackCount[t] += 1
                                    if (!containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[t])) {
                                        takenBlackPiecesLbl[t].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                        takenBlackPiecesLbl[t].frame.origin.y += 5

                                        takenBlackPiecesShow += [takenBlackPiecesLbl[t]]
                                    }
                                    takenBlackPiecesLbl[t].text = "" + blackCount[t].description
                                    if darkMode {
                                        takenBlackPiecesLbl[t].textColor = UIColor.whiteColor()
                                    }else {
                                        takenBlackPiecesLbl[t].textColor = UIColor.blackColor()
                                        
                                    }
                                    
                                    takenBlackPiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                    takenBlackPiecesLbl[t].textAlignment = NSTextAlignment.Center
                                    view.addSubview(takenBlackPiecesLbl[t])
                                }
                            }
                        } else if self.colorLcolor == "You are Black" {
                            if (!self.contains(takenWhitePieces, _image: pieces[i])) {
                                takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                takenPiece.image = pieces[i].image
                                takenWhitePieces += [pieces[i]]
                                takenWhitePiecesForMove += [takenPiece]
                                
                                view.addSubview(takenPiece)
                            }
                            takenWhitePiecesForInfo += [takenPiece]
                            for var t = 0; t < takenWhitePiecesLbl.count; t++ {
                                if (pieces[i].image == UIImage(named: whitePiecesTypes[t])) {
                                    whiteCount[t] += 1
                                    if (!containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[t])) {
                                        takenWhitePiecesLbl[t].frame = CGRectMake(CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                        takenWhitePiecesLbl[t].frame.origin.y += 5
                                        takenWhitePiecesShow += [takenWhitePiecesLbl[t]]
                                    }
                                    takenWhitePiecesLbl[t].text = "" + whiteCount[t].description
                                    if darkMode {
                                        takenWhitePiecesLbl[t].textColor = UIColor.whiteColor()
                                    }else {
                                        takenWhitePiecesLbl[t].textColor = UIColor.blackColor()
                                    }
                                    takenWhitePiecesLbl[t].font = UIFont(name: "Times", size: 18)
                                    takenWhitePiecesLbl[t].textAlignment = NSTextAlignment.Center
                                    view.addSubview(takenWhitePiecesLbl[t])
                                }
                            }
                        }
                        
                        pieceToTake += [pieces[i]]
                        takenPiecesToReload.append(pieces[i])
                        takenPiecesToReloadAtIndex.append(i)
                        pieces[i].alpha = 0
                        pieces[i].removeFromSuperview()
                        pieces.removeAtIndex(i)
                        print(pieceToTake.count)
                        
                    }
                }
                
                for var t = 0; t < blackPieces.count; t++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackPieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == blackPieces[t].frame.origin.y  {
                        pieceToTake += [blackPieces[t]]
                        blackPieces[t].removeFromSuperview()
                        blackPieces.removeAtIndex(t)
                        blackPiecesString.removeAtIndex(t)
                        
                    }
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackPieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == blackPieces[t].frame.origin.y - 1 * pieceSize && whitePassant == true && hasBeenTaken(selectedPiece, array: whitePieces)  {
                        
                        
                        takenPiecesToReload.append(blackPieces[t])
                        for var o = 0; o < pieces.count; o++ {
                            if pieces[o] == blackPieces[t] {
                                takenPiecesToReloadAtIndex.append(o)
                            }
                        }
                        blackPieces[t].removeFromSuperview()
                        blackPieces.removeAtIndex(t)
                        
                        if self.colorLcolor == "You are White" {
                            if (!self.contains(takenBlackPieces, _image: blackPieces[t])) {
                                takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenBlackPieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                takenPiece.image = blackPieces[t].image
                                takenBlackPieces += [blackPieces[t]]
                                takenBlackPiecesForMove += [takenPiece]
                                
                                view.addSubview(takenPiece)
                            }
                             takenBlackPiecesForInfo += [takenPiece]
                            for var b = 0; b < takenBlackPiecesLbl.count; b++ {
                                if (blackPieces[t].image == UIImage(named: blackPiecesTypes[b])) {
                                    blackCount[b] += 1
                                    if (!containsLabel(takenBlackPiecesShow, _label: takenBlackPiecesLbl[b])) {
                                        takenBlackPiecesLbl[b].frame = CGRectMake(CGFloat(takenBlackPieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                        takenBlackPiecesLbl[b].frame.origin.y += 5

                                        takenBlackPiecesShow += [takenBlackPiecesLbl[b]]
                                    }
                                    takenBlackPiecesLbl[b].text = "" + blackCount[b].description
                                    if darkMode {
                                        takenBlackPiecesLbl[b].textColor = UIColor.whiteColor()
                                    }else {
                                        takenBlackPiecesLbl[b].textColor = UIColor.blackColor()
                                        
                                    }
                                    takenBlackPiecesLbl[b].font = UIFont(name: "Times", size: 18)
                                    takenBlackPiecesLbl[b].textAlignment = NSTextAlignment.Center
                                    view.addSubview(takenBlackPiecesLbl[b])
                                }
                            }
                        } else if self.colorLcolor == "You are Black" {
                            if (!self.contains(takenWhitePieces, _image: blackPieces[t])) {
                                takenPiece = UIImageView(frame: CGRectMake(CGFloat(takenWhitePieces.count) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.5 * pieceSize + pieceSize * 0.05, pieceSize * 0.65, pieceSize * 0.65))
                                takenPiece.image = blackPieces[t].image
                                takenWhitePieces += [blackPieces[t]]
                                takenWhitePiecesForMove += [takenPiece]
                                
                                view.addSubview(takenPiece)
                            }
                            takenWhitePiecesForInfo += [takenPiece]
                            for var b = 0; b < takenWhitePiecesLbl.count; b++ {
                                if (blackPieces[t].image == UIImage(named: whitePiecesTypes[b])) {
                                    whiteCount[b] += 1
                                    if (!containsLabel(takenWhitePiecesShow, _label: takenWhitePiecesLbl[b])) {
                                        takenWhitePiecesLbl[b].frame = CGRectMake( CGFloat(takenWhitePieces.count - 1) * pieceSize * 0.50 + 15, screenHeight / 2 + 4.45 * pieceSize + pieceSize * 0.5, pieceSize * 0.65, pieceSize * 0.65)
                                        takenWhitePiecesLbl[b].frame.origin.y += 5
                                        takenWhitePiecesShow += [takenWhitePiecesLbl[b]]
                                    }
                                    takenWhitePiecesLbl[b].text = "" + whiteCount[b].description
                                    if darkMode {
                                        takenWhitePiecesLbl[b].textColor = UIColor.whiteColor()
                                    }else {
                                        takenWhitePiecesLbl[b].textColor = UIColor.blackColor()
                                        
                                    }
                                    takenWhitePiecesLbl[b].font = UIFont(name: "Times", size: 18)
                                    takenWhitePiecesLbl[b].textAlignment = NSTextAlignment.Center
                                    view.addSubview(takenWhitePiecesLbl[b])
                                }
                            }
                        }

                        whitePassant = false
                        //game.setObject(false, forKey: "passant")
                    }
                }
            }
        }
        
        for var o = 0 ; o < pieceOptions.count ; o++ {
            whiteCastle = false
            blackCastle = false
            
            for var t = 0; t < whitePieces.count; t++ {
                
                if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == whitePieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == whitePieces[t].frame.origin.y  {
                    whitePieces[t].removeFromSuperview()
                    whitePieces.removeAtIndex(t)
                }
                if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == whitePieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == whitePieces[t].frame.origin.y + 1 * pieceSize && blackPassant == true && hasBeenTaken(selectedPiece, array: blackPieces) && canPassant == true  {
                    whitePieces[t].removeFromSuperview()
                    whitePieces.removeAtIndex(t)

                    blackPassant = false
                    
                
                    //game.setObject(false, forKey: "passant")
                }
                if touch.view == pieceOptions[o] &&  hasBeenTaken(selectedPiece, array: whitePieces)   {
                    //game.setObject(false, forKey: "passant")
                }
                
            }
        }
        
        for var i = 0; i < whitePawns.count;i++ {
            if touch.view == whitePawns[i] && isWhiteTurn == true && canOnlyMoveWhite == true {
                selectedPiece = whitePawns[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                selectedPawn = i
                //updateLogic()
                whitePawnSelected(false, chosenPiece: selectedPiece)
            }
            
        }
        
        for var i = 0; i < whiteKnights.count;i++ {
            if touch.view == whiteKnights[i] && isWhiteTurn == true && canOnlyMoveWhite == true {
                selectedPiece = whiteKnights[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(2, pieceid: 2, friend: whitePieces, enemy: blackPieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        for var i = 0; i < whiteBishops.count; i++ {
            if touch.view == whiteBishops[i] && isWhiteTurn == true && canOnlyMoveWhite == true {
                selectedPiece = whiteBishops[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(9, pieceid: 1, friend: whitePieces, enemy: blackPieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        for var i = 0; i < whiteRooks.count; i++ {
            if touch.view == whiteRooks[i] && isWhiteTurn == true && canOnlyMoveWhite == true {
                removePieceOptions()
                selectedPiece = whiteRooks[i]
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(9, pieceid: 3, friend: whitePieces, enemy: blackPieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        for var i = 0; i < whiteQueens.count; i++ {
            if touch.view == whiteQueens[i] && isWhiteTurn == true && canOnlyMoveWhite == true {
                selectedPiece = whiteQueens[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(9, pieceid: 4, friend: whitePieces, enemy: blackPieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        if touch.view == whiteKing && isWhiteTurn == true && canOnlyMoveWhite == true {
            selectedPiece = whiteKing
            removePieceOptions()
            //updateLogic()
            chessPieceSelected(2, pieceid: 5, friend: whitePieces, enemy: blackPieces, hidden: false, chosenPiece: selectedPiece)
            print("whiteKing selected")
        }
        
        
        
        for var i = 0; i < blackBishops.count;i++ {
            if touch.view == blackBishops[i] && isWhiteTurn == false && canOnlyMoveWhite == false {
                selectedPiece = blackBishops[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        for var i = 0; i < blackKnights.count;i++ {
            if touch.view == blackKnights[i] && isWhiteTurn == false && canOnlyMoveWhite == false {
                selectedPiece = blackKnights[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        for var i = 0; i < blackRooks.count;i++ {
            if touch.view == blackRooks[i] && isWhiteTurn == false && canOnlyMoveWhite == false {
                selectedPiece = blackRooks[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceMovementLogic(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, piece: blackRooks[i], logicOptions: piecesWhiteLogic)
            }
        }
        
        for var i = 0; i < blackQueens.count; i++ {
            if touch.view == blackQueens[i] && isWhiteTurn == false && canOnlyMoveWhite == false {
                selectedPiece = blackQueens[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                //updateLogic()
                chessPieceSelected(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, hidden: false, chosenPiece: selectedPiece)
            }
        }
        
        if touch.view == blackKing && isWhiteTurn == false && canOnlyMoveWhite == false {
            selectedPiece = blackKing
            removePieceOptions()
            removeBlackCastlingLeft()
            removeBlackCastlingRight()
            //updateLogic()
            chessPieceSelected(2, pieceid: 5, friend: blackPieces, enemy: whitePieces, hidden: false, chosenPiece: selectedPiece)
            print("blackKing selected")
        }
        
        //check pieceOptions
        for var o = 0 ; o < pieceOptions.count; o++ {
            pieceOptions[o].userInteractionEnabled = true
            pieceOptions[o].multipleTouchEnabled = true
            
            if touch.view == pieceOptions[o] {
                if self.colorLcolor == "You are White" {
                    self.game.setObject(false, forKey: "passantBlack")
                } else if self.colorLcolor == "You are Black" {
                    self.game.setObject(false, forKey: "passant")
                }
            }
            
            if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.y == _4 && hasBeenTaken(selectedPiece, array: whitePawns) && selectedPiece.frame.origin.y == _2 {
                for var q = 0; q < whitePawns.count; q++ {
                    if whitePawns[q] == selectedPiece {
                        game.setObject(q, forKey: "passantPiece")
                        print(whitePawns.count)
                    }
                }
                game.setObject(true, forKey: "passant")
                game.setObject(true, forKey: "passantBlack")
                
            }
            
            if touch.view == pieceOptions[o] && promoted == false {
                dissablePieceOptions(pieceOptions)
                movePiece(pieceOptions[o].frame.origin.x - selectedPiece.frame.origin.x, _moveByAmounty: pieceOptions[o].frame.origin.y - selectedPiece.frame.origin.y)
                if selectedPiece.image == UIImage(named:"whiteKing") {
                    game.setObject(true, forKey: "can_Castle_white")
                } else if selectedPiece.image == UIImage(named:"blackKing") {
                    game.setObject(true, forKey: "can_Castle_black")
                }
                if selectedPiece == whiteRook1 && selectedPiece.image == UIImage(named:"whiteRook") {
                    game.setObject(true, forKey: "hasWhiteRookMoved2")
                } else if selectedPiece == whiteRook2 && selectedPiece.image == UIImage(named:"whiteRook") {
                    game.setObject(true, forKey: "hasWhiteRookMoved")
                }
                if selectedPiece == whiteRook1 && selectedPiece.image == UIImage(named:"blackRook") {
                    game.setObject(true, forKey: "hasBlackRookMoved2")
                } else if selectedPiece == whiteRook2 && selectedPiece.image == UIImage(named:"blackRook") {
                    game.setObject(true, forKey: "hasBlackRookMoved")
                }
            }
        }
        for var o = 0 ; o < whiteCastlingLeft.count; o++ {
            whiteCastlingLeft[o].userInteractionEnabled = true
            whiteCastlingLeft[o].multipleTouchEnabled = true
            
            
            if touch.view == whiteCastlingLeft[o] {
                dissablePieceOptions(whiteCastlingLeft)
                castlePiece = whiteRook2
                whiteCastle = true
                movePiece(whiteCastlingLeft[o].frame.origin.x - whiteKing.frame.origin.x, _moveByAmounty: whiteCastlingLeft[o].frame.origin.y - whiteKing.frame.origin.y)
                hasWhiteKingMoved = true
                game.setObject(true, forKey: "hasWhiteRookMoved")
                castleLeft = true
            }
        }
        for var o = 0 ; o < whiteCastlingRight.count; o++ {
            whiteCastlingRight[o].userInteractionEnabled = true
            whiteCastlingRight[o].multipleTouchEnabled = true
            
            
            if touch.view == whiteCastlingRight[o] {
                dissablePieceOptions(whiteCastlingRight)
                castlePiece = whiteRook1
                whiteCastle = true
                movePiece(whiteCastlingRight[o].frame.origin.x - whiteKing.frame.origin.x, _moveByAmounty: whiteCastlingRight[o].frame.origin.y - whiteKing.frame.origin.y)
                hasWhiteKingMoved = true
                game.setObject(true, forKey: "hasWhiteRookMoved2")
                castleRight = true
            }
        }
        for var o = 0 ; o < blackCastlingLeft.count; o++ {
            blackCastlingLeft[o].userInteractionEnabled = true
            blackCastlingLeft[o].multipleTouchEnabled = true
            
            if touch.view == blackCastlingLeft[o] {
                dissablePieceOptions(blackCastlingLeft)
                castlePiece = whiteRook2
                blackCastle = true
                movePiece(blackCastlingLeft[o].frame.origin.x - whiteKing.frame.origin.x, _moveByAmounty: blackCastlingLeft[o].frame.origin.y - whiteKing.frame.origin.y)
                hasBlackKingMoved = true
                game.setObject(true, forKey: "hasBlackRookMoved")
                castleRight = true
            }
        }
        for var o = 0 ; o < blackCastlingRight.count; o++ {
            blackCastlingRight[o].userInteractionEnabled = true
            blackCastlingRight[o].multipleTouchEnabled = true
            
            
            if touch.view == blackCastlingRight[o] {
                dissablePieceOptions(blackCastlingRight)
                castlePiece = whiteRook1
                blackCastle = true
                movePiece(blackCastlingRight[o].frame.origin.x - whiteKing.frame.origin.x, _moveByAmounty: blackCastlingRight[o].frame.origin.y - whiteKing.frame.origin.y)
                hasBlackKingMoved = true
                game.setObject(true, forKey: "hasBlackRookMoved2")
                castleLeft = true
            }
        }
    }
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        if darkMode == true {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            
            self.view.backgroundColor =  UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            
            self.capsuleL.textColor = UIColor.whiteColor()
            self.notationsL.textColor = UIColor.whiteColor()
            self.timeGL.textColor = UIColor.whiteColor()
            self.turnGL.textColor = UIColor.whiteColor()
            
            UIApplication.sharedApplication().statusBarStyle = .LightContent

        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()
            
            self.capsuleL.textColor = UIColor.blackColor()
            self.notationsL.textColor = UIColor.blackColor()
            self.timeGL.textColor = UIColor.blackColor()
            self.turnGL.textColor = UIColor.blackColor()
            
            UIApplication.sharedApplication().statusBarStyle = .Default
            
            
        }
        
    }
        }

