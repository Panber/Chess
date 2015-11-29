//
//  ViewController.swift
//  ChessNow
//
//  Created by Johannes Berge on 21/11/14.
//  Copyright (c) 2014 Johannes Berge & Alexander Panayotov. All rights reserved.
//

import UIKit
import SpriteKit




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



var game = PFObject(className: "Games")
var notations: Array<String> = []


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

let xAxisArrStr = ["a","b","c","d","e","f","g","h"]

var canTake: Bool = true

var size : CGFloat = pieceSize

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

let yAxisArrStr = ["1","2","3","4","5","6","7","8"]
var pieceString = ""
let xAxisArrStr2 = ["a","b","c","d","e","f","g","h"]
let yAxisArrStr2 = ["1","2","3","4","5","6","7","8"]
var pieceStringPos = ""
var piecesNotationSeperator = "-"
var chessNotationCheck = ""
var chessNotationx = ""
var chessNotationy = ""


//BOARDER
let boarderBoard = UIImageView(frame: CGRectMake(-0.01*pieceSize, _1 - 7*pieceSize, 8*pieceSize, 8*pieceSize))

//size-properties
let pieceSize = sqrt(screenWidth * screenWidth / 64)
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

var castlePiece: UIImageView = whitePawn1

// En Passant
var blackPassant: Bool = false
var canPassant: Bool = false

var whitePassant: Bool = false

var whitePassantPieces: UIImageView = whitePawn1
var blackPassantPieces: UIImageView = whitePawn1

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

var selectedPawn = 0
var pieceOpt = whitePawn1

// Check piece
var checkByPiece : UIImageView = whitePawn1

//chesspieces:
var whitePawn1 = UIImageView(frame: CGRectMake(a, _2, pieceSize , pieceSize))
var whitePawn2 = UIImageView(frame: CGRectMake(b, _2, pieceSize, pieceSize))
var whitePawn3 = UIImageView(frame: CGRectMake(c, _2, pieceSize , pieceSize))
var whitePawn4 = UIImageView(frame: CGRectMake(d, _2, pieceSize, pieceSize))
var whitePawn5 = UIImageView(frame: CGRectMake(e, _2, pieceSize , pieceSize))
var whitePawn6 = UIImageView(frame: CGRectMake(f, _2, pieceSize, pieceSize))
var whitePawn7 = UIImageView(frame: CGRectMake(g, _2, pieceSize , pieceSize))
var whitePawn8 = UIImageView(frame: CGRectMake(h, _2, pieceSize, pieceSize))


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
var blackPawn3 = UIImageView(frame: CGRectMake(c, _7, pieceSize, pieceSize))
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


var blackKnights = [blackKnight1, blackKnight2]
var blackBishops = [blackBishop1, blackBishop2]
var blackRooks = [blackRook1, blackRook2]
var blackPawns = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8]
var blackQueens = [blackQueen]
var blackKings = [blackKing]

var whitePawns  = [whitePawn1, whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8]
var whiteKnights = [whiteKnight1, whiteKnight2]
var whiteBishops = [whiteBishop1, whiteBishop2]
var whiteRooks = [whiteRook1, whiteRook2]
var whiteQueens = [whiteQueen]
var whiteKings = [whiteKing]

var blackPieces = [blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]
var blackPiecesString = ["blackPawn","blackPawn","blackPawn", "blackPawn", "blackPawn", "blackPawn",  "blackPawn", "blackPawn", "blackKnight", "blackKnight", "blackBishop",  "blackBishop", "blackRook", "blackRook", "blackQueen", "blackKing" ]
var whitePieces = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2 ,whiteBishop1, whiteBishop2, whiteRook1, whiteRook2 , whiteQueen, whiteKing]
var whitePiecesString = ["whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whitePawn","whiteKnight","whiteKnight","whiteBishop","whiteBishop","whiteRook", "whiteRook", "whiteQueen","whiteKing"]


//Must be equal!
var piecesArrs = [whiteQueens,whiteKings,whitePawns,blackPawns,whiteKnights,whiteBishops,whiteRooks, blackKnights, blackBishops, blackRooks, blackQueens, blackKings]
var piecesString = ["whiteQueen","whiteKing","whitePawn","blackPawn","whiteKnight","whiteBishop","whiteRook", "blackKnight", "blackBishop", "blackRook", "blackQueen", "blackKing"]
//

var pieces = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen, whiteKing,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]

var piecesWhiteLogic = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, whiteKing]

var piecesBlackLogic = [whitePawn1,whitePawn2, whitePawn3, whitePawn4, whitePawn5, whitePawn6, whitePawn7, whitePawn8, whiteKnight1, whiteKnight2, whiteBishop1, whiteBishop2, whiteRook1, whiteRook2, whiteQueen,blackPawn1, blackPawn2, blackPawn3, blackPawn4, blackPawn5, blackPawn6, blackPawn7, blackPawn8, blackKnight1, blackKnight2, blackBishop1, blackBishop2, blackRook1, blackRook2, blackQueen, blackKing]

var moveByAmounty: CGFloat = 0.0
var moveByAmountx: CGFloat = 0.0

// Must be assigned to a UIImageView when created
var selectedPiece: UIImageView = whitePawn1
var eatenPieces = UIImageView(frame: CGRectMake(a, _2, pieceSize , pieceSize))
var pieceCanTake : UIImageView = whitePawn1
var pieceToTake : Array<UIImageView> = []

var takenWhitePieces : Array<UIImageView> = []
var takenBlackPieces : Array<UIImageView> = []


var increasey : CGFloat = 1;
var increasex : CGFloat = 1;
var piecePos : Array<UIImageView> = []

var isWhiteTurn = true

// bishop = 1, knight = 2, rook = 3, queen = 4, king = 5
var pieceID = 0

class Game: UIViewController {
    
    @IBOutlet weak var chessBoard: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        lightOrDarkMode()
    }
    
    // MARK: - View did load! 😄
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        //load marker
        pieceMarked.image = UIImage(named: "pieceMarked.png")
        self.view.addSubview(pieceMarked)
        pieceMarked.hidden = true
        
        //chesspieces loading - REMEMBER TO ADD PIECES TO ARRAYS!! Right order as well!!
        
        for var i = 0; i < piecesArrs.count; i++ {
            for var t = 0; t < piecesArrs[i].count; t++ {
                piecesArrs[i][t].image = UIImage(named: piecesString[i])
                self.view.addSubview(piecesArrs[i][t])
                piecesArrs[i][t].contentMode = .ScaleAspectFit
                piecesArrs[i][t].userInteractionEnabled = true
                piecesArrs[i][t].multipleTouchEnabled = true
            }
        }
        
        

        let otherImage = UIImageView(frame: CGRectMake((screenWidth/2) - 30, 0, 60, 60))
        otherImage.contentMode = .ScaleAspectFill
        otherImage.clipsToBounds = true
        otherImage.alpha = 0
        otherImage.layer.cornerRadius = otherImage.frame.size.width/2
        
        let meImage = UIImageView(frame: CGRectMake((screenWidth/2) - 30, (screenHeight/2) + (screenWidth/2) + 30, 60, 60))
        meImage.contentMode = .ScaleAspectFill
        meImage.clipsToBounds = true
        meImage.alpha = 0
        meImage.layer.cornerRadius = meImage.frame.size.width/2
        
        var images:Array<NSData> = []
        
        print(screenHeight)
        if screenHeight == 667.0 {
            otherImage.frame.origin.y = 64 + 8
            meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 22

            
        }
        else if screenHeight == 736.0 {
            otherImage.frame.origin.y = 64 + 13
            meImage.frame.origin.y = (screenHeight/2) + (screenWidth/2) + 30
            
        }
        
        
        let query = PFQuery(className: "Games")
        query.whereKey("objectId", equalTo: gameID)
        let r = query.getFirstObject()
        game = r!

        
        notations = r!["piecePosition"] as! Array<String>
        
        
        for var i = 0; i < notations.count; i++ {
            
            let output = notations[i][0]
            

            if output.lowe =
            
            print(output)
        }
        
        
        
        if r!["whitePlayer"] as? String == PFUser.currentUser()?.username {
        
            self.title = r!["blackPlayer"] as? String
            
            let un = [r!["blackPlayer"]!,r!["whitePlayer"]!]
            
            let userQuery = PFQuery(className: "_User")
            userQuery.whereKey("username", containedIn: un )
            userQuery.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    if let result = result as! [PFUser]! {
                        for result in result {
                            
                            let rating = result["rating"] as? Int
                            
                            
                            
                            let profilePictureObject = result["profile_picture"] as? PFFile
                            
                            if(profilePictureObject != nil)
                            {
                                profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                                    
                                    if(imageData != nil)
                                    {
                                        images.append(imageData!)
                                        if (result["username"] as? String)! == r!["whitePlayer"]! as! String {
                                            
                                            meImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(meImage)
                                            
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                meImage.alpha = 1
                                            })

                                        }
                                        else {
                                            otherImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(otherImage)
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                otherImage.alpha = 1
                                            })
                                        }
                                    }
                                    
                                }
                   

                            }
                        
                        }
                    }


                }
            })
            

            
            
            
        }
        else {
            self.title = r!["whitePlayer"] as? String

            let un = [r!["blackPlayer"]!,r!["whitePlayer"]!]
            
            let userQuery = PFQuery(className: "_User")
            userQuery.whereKey("username", containedIn: un )
            userQuery.findObjectsInBackgroundWithBlock({ (result:[AnyObject]?, error:NSError?) -> Void in
                if error == nil {
                    if let result = result as! [PFUser]! {
                        for result in result {
                            
                            let rating = result["rating"] as? Int
                            
                            
                            
                            let profilePictureObject = result["profile_picture"] as? PFFile
                            
                            if(profilePictureObject != nil)
                            {
                                profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                                    
                                    if(imageData != nil)
                                    {
                                        images.append(imageData!)
                                        if (result["username"] as? String)! == r!["blackPlayer"]! as! String {
                                            
                                            meImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(meImage)
                                            
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                meImage.alpha = 1
                                            })
                                            
                                        }
                                        else {
                                            otherImage.image = UIImage(data: imageData!)
                                            self.view.addSubview(otherImage)
                                            
                                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                                otherImage.alpha = 1
                                            })
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                    
                }
            })

            
            
        }
        
        
        
        
        //print("\(screenHeight) is the height and \(screenWidth) is the width. \(screenSize) is the screensize. \(pieceSize) is the pieceSize")
        
    }
    
    
    
    // MARK: - Setup-functions 🔍
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
//    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
//        return UIStatusBarAnimation.Slide
//    }
    
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
    
    func removePieceOptions() {
        for var p = 0 ; p < pieceOptions.count; p++ {
            pieceOptions[p].hidden = true
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
            leftBlackCastleLogic[p].hidden = true
            leftBlackCastleLogic[p].removeFromSuperview()
        }
        leftBlackCastleLogic = []
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
    
    
    
    // MARK: - Pieces selected! 👾
    
    func whitePawnSelected(var _event:UIEvent, var _touch:UITouch) {
        showMarkedPiece()
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat) {
            var canThePieceGofurther: Bool = true
            
            for byAmounty; byAmounty <= 2; byAmountx += increaserx, byAmounty += increasery {
                
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
                    
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  whitePieces)  == 2 && verticallyAlignedBlack == false {
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
                    pieceOptions += [pieceOption]
                } else if canThePieceGofurther == true {
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  whitePieces)  == 2 && verticallyAlignedBlack == false {
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
                    pieceOptions += [pieceOption]
                    
                }
                for var r = 0; r < blackPieces.count; r++ {
                    if blackPieces[r].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && blackPieces[r].frame.origin.y == selectedPiece.frame.origin.y - 1 * pieceSize {
                        
                        //print("working")
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  whitePieces)  == 2 && canSaveKing(pieceOption, array: pieceBlackCanMove) == false && canSaveKing(pieceOption, array: blackPieceLogic) == false {
                            pieceOption.removeFromSuperview()
                        } else {
                            self.view.addSubview(pieceOption)
                        }
                        // Check if a pawn can move when king is in check
                        if checkByQueen == true {
                            if canSaveKing(pieceOption, array: queenLogicOptions) == false  {
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
                
                    if selectedPiece.frame.origin.y == screenHeight/2 - 1 * pieceSize && blackPassantPieces.frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && blackPassantPieces.frame.origin.y == selectedPiece.frame.origin.y && canPassant == true && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                        //print("Passant!")
                        whitePassant = true
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
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
                        if CGRectContainsPoint(pieces[q].frame, pieceOptions[p].center) && selectedPiece.frame.origin.y == _2 && pieceOptions[p].frame.origin.y == _4  {
                            [pieceOptions[p] .removeFromSuperview()]
                            
                        }
                    }
                }
            }
        }
        
        letThemAppear(1, byAmounty: 1, increaserx: 0, increasery: 1)
        letThemAppear(-1, byAmounty: 1, increaserx: 0, increasery: 1)
    }
    
    func chessPieceSelected(var _event:UIEvent, var _touch:UITouch, var movementNumber: CGFloat, var pieceid: Int, var friend: [UIImageView], var enemy: [UIImageView]) {
        showMarkedPiece()
        pieceID = pieceid
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat, var byAmountz:CGFloat, increaserz:CGFloat ) {
            var canThePieceGofurther: Bool = true
            var startLogicChecking: Bool = false
            var startLogicCheckingWhite: Bool = false
            var foundImportantPiece: Bool = false
            
            for byAmountz; byAmountz < movementNumber; byAmountx += increaserx, byAmounty += increasery, byAmountz += increaserz {
                
               if canSaveKing(selectedPiece, array: pieceWhiteCanMove) == true && canSaveKing(blackKing, array: pieceWhiteCanMove) && logicCheck(pieces, array:pieceWhiteCanMove, friends:  friend)  == 2 && enemy == whitePieces {
                startLogicChecking = true
               } else if canSaveKing(selectedPiece, array: pieceBlackCanMove) == true && canSaveKing(whiteKing, array: pieceBlackCanMove) && logicCheck(pieces, array:pieceBlackCanMove, friends:  friend)  == 2 && enemy == blackPieces {
                startLogicCheckingWhite = true
                }
                
                for var q = 0; q < friend.count; q++ {
                    if friend[q].frame.origin.x == selectedPiece.frame.origin.x + byAmountx * pieceSize && friend[q].frame.origin.y == selectedPiece.frame.origin.y - byAmounty * pieceSize  {
                        canThePieceGofurther = false
                        if startLogicChecking == true && blackKing.frame.origin.x == selectedPiece.frame.origin.x + byAmountx * pieceSize && blackKing.frame.origin.y == selectedPiece.frame.origin.y - byAmounty * pieceSize {
                            canThePieceGofurther = true

                        }
                    }
                }
                
                if canThePieceGofurther == true {
                    
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + byAmountx * pieceSize, selectedPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    self.view.addSubview(pieceOption)
                    // Check if a pawn can move when king is in check
                    // Check if a pawn can move when king is in check
                    if checkByQueen == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByBishop == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByRook == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByPawn == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    } else if checkByKnight == true && pieceid != 5 {
                        if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                            pieceOption.removeFromSuperview()
                        }
                    }
                    if startLogicChecking == true && canSaveKing(pieceOption, array: pieceWhiteCanMove) == false && pieceid != 5 && canSaveKing(pieceOption, array: whitePieceLogic) == false {
                        pieceOption.removeFromSuperview()
                    } else {
                        pieceOptions += [pieceOption]
                        }
                    if startLogicCheckingWhite == true && canSaveKing(pieceOption, array: pieceBlackCanMove) == false && pieceid != 5 && canSaveKing(pieceOption, array: blackPieceLogic) == false  {
                        pieceOption.removeFromSuperview()
                    } else {
                        pieceOptions += [pieceOption]
                    }
                    if CGRectContainsPoint(pieceOption.frame, blackKing.center) || CGRectContainsPoint(pieceOption.frame, whiteKing.center) {
                        pieceOption.removeFromSuperview()
                    }
                    pieceOptions += [pieceOption]
                
                    // This is for left castling white king
                    for var q = 0; q < friend.count; q++ {
                        for var i = 1; i < 4; i++ {
                    if pieceid == 5 && hasWhiteKingMoved == false && hasWhiteRookMoved == false {
                        let pieceOption2 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - CGFloat(i) * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                        //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                        if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceBlackLogicOptions) == false && canSaveKing(pieceOption2, array: leftWhiteCastleLogic) == false  {
                        self.view.addSubview(pieceOption2)
                        leftWhiteCastleLogic += [pieceOption2]
                                }
                            }
                        }
                        for var i = 1; i < 3; i++ {
                            if pieceid == 5 && hasWhiteKingMoved == false && hasWhiteRookMoved2 == false {
                                let pieceOption2 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + CGFloat(i) * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceBlackLogicOptions) == false && canSaveKing(pieceOption2, array: rightWhiteCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    rightWhiteCastleLogic += [pieceOption2]
                                }
                            }
                        }
                    }
                    for var q = 0; q < friend.count; q++ {
                        for var i = 1; i < 4; i++ {
                            if pieceid == 5 && hasBlackKingMoved == false && hasBlackRookMoved == false {
                                let pieceOption2 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - CGFloat(i) * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceWhiteLogicOptions) == false && canSaveKing(pieceOption2, array: leftBlackCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    leftBlackCastleLogic += [pieceOption2]
                                }
                            }
                        }
                        for var i = 1; i < 3; i++ {
                            if pieceid == 5 && hasBlackKingMoved == false && hasBlackRookMoved2 == false {
                                let pieceOption2 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + CGFloat(i) * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                                //pieceOption2.image = UIImage(named: "piecePossibilities.png")
                                if canSaveKing(pieceOption2, array: friend) == false && canSaveKing(pieceOption2, array: pieceWhiteLogicOptions) == false && canSaveKing(pieceOption2, array: rightBlackCastleLogic) == false  {
                                    self.view.addSubview(pieceOption2)
                                    rightBlackCastleLogic += [pieceOption2]
                                }
                            }
                        }
                    }

                    if leftWhiteCastleLogic.count == 3 && hasWhiteKingMoved == false && hasWhiteRookMoved == false && pieceid == 5  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - 2 * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption3)
                        whiteCastlingLeft += [pieceOption3]
                        castlePiece = whiteRook2
                    }
                    if rightWhiteCastleLogic.count == 2 && hasWhiteKingMoved == false && hasWhiteRookMoved2 == false && pieceid == 5  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + 2 * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption3)
                        whiteCastlingRight += [pieceOption3]
                        castlePiece = whiteRook1
                    }
                    if leftBlackCastleLogic.count == 3 && hasBlackKingMoved == false && hasBlackRookMoved == false && pieceid == 5  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - 2 * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption3)
                        blackCastlingLeft += [pieceOption3]
                        castlePiece = blackRook2
                    }
                    if rightBlackCastleLogic.count == 2 && hasBlackKingMoved == false && hasBlackRookMoved2 == false && pieceid == 5  {
                        let pieceOption3 = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + 2 * pieceSize, selectedPiece.frame.origin.y, pieceSize, pieceSize))
                        pieceOption3.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption3)
                        blackCastlingRight += [pieceOption3]
                        castlePiece = blackRook1
                    }
                }
                    
                for var r = 0; r < enemy.count; r++ {
                    if enemy[r].frame.origin.x == selectedPiece.frame.origin.x + byAmountx * pieceSize && enemy[r].frame.origin.y == selectedPiece.frame.origin.y - byAmounty * pieceSize && canThePieceGofurther == true {
                        
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + byAmountx * pieceSize, selectedPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption)
                        // Check if a pawn can move when king is in check
                        if checkByQueen == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: queenLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByBishop == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: bishopLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByRook == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: rookLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByPawn == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: pawnLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        } else if checkByKnight == true && pieceid != 5 {
                            if canSaveKing(pieceOption, array: knightLogicOptions) == false {
                                pieceOption.removeFromSuperview()
                            }
                        }
                        if startLogicChecking == true && canSaveKing(pieceOption, array: pieceWhiteCanMove) == false && canSaveKing(pieceOption, array: whitePieceLogic) == false {
                            pieceOption.removeFromSuperview()
                        } else {
                            pieceOptions += [pieceOption]
                        }
                        if startLogicCheckingWhite == true && canSaveKing(pieceOption, array: pieceBlackCanMove) == false && canSaveKing(pieceOption, array: blackPieceLogic) == false {
                            pieceOption.removeFromSuperview()
                        } else {
                            pieceOptions += [pieceOption]
                        }
                        pieceOptions += [pieceOption]
                        pieceCanTake = pieceOption
                        //pieceToTake = blackPieces[r]
                        canThePieceGofurther = false
                        
                    }
                }
                
                //								// Decides which squares the King can go to
                if pieceid == 5 && selectedPiece == whiteKing {
                    for var p = 0 ; p < pieceOptions.count; p++ {
                            if canSaveKing(pieceOptions[p], array: pieceBlackLogicOptions) == true {
                                pieceOptions[p].hidden = true
                            }
                    }
                } else if pieceid == 5 && selectedPiece == blackKing {
                    for var p = 0 ; p < pieceOptions.count; p++ {
                            if canSaveKing(pieceOptions[p], array: pieceWhiteLogicOptions) == true {
                                pieceOptions[p].hidden = true
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
                        pieceOptions[o].hidden == true
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
    }
    
    func chessPieceMovementLogic(var movementNumber: CGFloat, var pieceid: Int, var friend: [UIImageView], var enemy: [UIImageView], var piece: UIImageView, var logicOptions: [UIImageView])  {
        
        //print(pieceWhiteCanMove.count)
        
        // Check if the piece is taken
        if !hasBeenTaken(piece, array: pieceToTake) {
            
            pieceID = pieceid
            var foundKing: Bool = false
            var foundKingWhite: Bool = false
            var foundKingBlack: Bool = false
            
            func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat, var byAmountz:CGFloat, increaserz:CGFloat ) {
                var canThePieceGofurther: Bool = true
                var canGoFurtherWhite: Bool = true
                var canGoFurtherBlack: Bool = true
                
                for byAmountz; byAmountz < movementNumber; byAmountx += increaserx, byAmounty += increasery, byAmountz += increaserz {
                    
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
            
            for byAmounty;  byAmounty <= 2 ; byAmountx += increaserx, byAmounty += increasery {
                
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
                
                if selectedPiece.frame.origin.y == screenHeight/2 && whitePassantPieces.frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && whitePassantPieces.frame.origin.y == selectedPiece.frame.origin.y && canPassant == true && checkByQueen == false && checkByBishop == false && checkByRook == false && checkByKnight == false && checkByPawn == false  {
                    //print("Passant!")
                    blackPassant = true
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
            if checkByQueen == true {
                chessNotationCheck = "+"
            }
            var LAN = ""
            if castleLeft == true {
                print("0-0-0")
                LAN = "0-0-0"
                
                
            } else if castleRight == true {
                print("0-0")
                
                LAN = "0-0"
                
                
            } else {
            print(pieceString + pieceStringPos + piecesNotationSeperator + chessNotationx + chessNotationy + chessNotationCheck)
                LAN = pieceString + pieceStringPos + piecesNotationSeperator + chessNotationx + chessNotationy + chessNotationCheck
            piecesNotationSeperator = "-"
            chessNotationCheck = ""
                


                
            }
            notations.append(LAN)
            game["piecePosition"] = notations
            game.saveEventually()
            
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
                if castlePiece == blackRook2  {
                    positionx -= (moveByAmountx) / 10
                } else if castlePiece == blackRook1 {
                    positionx -= (moveByAmountx - 1 * pieceSize) / 10
                }
                castlePiece.frame = CGRect(x: positionx, y: positiony, width: pieceSize, height: pieceSize)
            }
            
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
        
        if selectedPiece == whiteKing {
            hasWhiteKingMoved = true
        }
        if selectedPiece == whiteRook1 {
            hasWhiteRookMoved2 = true
        }
        if selectedPiece == whiteRook2 {
            hasWhiteRookMoved = true
        }
        if selectedPiece == blackKing {
            hasBlackKingMoved = true
        }
        if selectedPiece == blackRook1 {
            hasBlackRookMoved = true
        }
        if selectedPiece == blackRook2 {
            hasBlackRookMoved2 = true
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
    
    
    // MARK: - Touches began! 👆
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first as UITouch!
        
        for var o = 0 ; o < piecePos.count; o++ {
            if CGRectContainsPoint(selectedPiece.frame, piecePos[o].center) {
                selectedPiece.frame.origin.x = piecePos[o].frame.origin.x
                selectedPiece.frame.origin.y = piecePos[o].frame.origin.y
                
            }
        }
        
        for var i = 0; i < whitePawns.count;i++ {
            if touch.view == whitePawns[i] && isWhiteTurn == true {
                selectedPiece = whitePawns[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                whitePawnSelected(event!, _touch: touch)
                selectedPawn = i
                
            }
            
        }
        
         for var o = 0 ; o < pieceOptions.count ; o++ {
        for var t = 0; t < 8; t++ {
            for var g = 0; g < 8; g++ {
                if (selectedPiece.frame.origin.x == xAxisArr[t] && selectedPiece.frame.origin.y == yAxisArr[g]) {
                    pieceStringPos = xAxisArrStr2[t] + yAxisArrStr2[g]
                }
            }
        }
        }
        
        for var o = 0 ; o < pieceOptions.count ; o++ {
            
            if touch.view == pieceOptions[o] {
                
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
                                if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == pieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == pieces[i].frame.origin.y || canPassant == true  {
                                    piecesNotationSeperator = "x"
                                }
                            }
                            chessNotationx = xAxisArrStr[t]
                            chessNotationy = yAxisArrStr[g]
                        }
                    }
                }
                
                
                for var i = 0; i < whitePawns.count;i++ {
                if selectedPiece == whitePawns[i] && selectedPiece.frame.origin.y == _7 {
                    let actionSheet = UIAlertController(title: nil, message: "Promote pawn to:", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    
                    let promoteToQueen = UIAlertAction(title: "Queen", style: .Default, handler: {
                        (alert: UIAlertAction!) -> Void in
                        selectedPiece.image = UIImage(named:"whiteQueen")
                        whitePawns.removeAtIndex(i-1)
                        whiteQueens += [selectedPiece]
                       // print(whitePawns.count)
                        for var q = 0; q < whiteQueens.count; q++ {
                            self.chessPieceMovementLogic(9, pieceid: 4, friend: whitePieces, enemy: blackPieces, piece: whiteQueens[q] , logicOptions: piecesBlackLogic)
                        }
                    })
                    let promoteToRook = UIAlertAction(title: "Rook", style: .Default, handler: {
                        (alert: UIAlertAction!) -> Void in
                        selectedPiece.image = UIImage(named:"whiteRook")
                        whiteRooks += [selectedPiece]
                        for var w = 0; w < whiteRooks.count; w++ {
                            self.chessPieceMovementLogic(9, pieceid: 3, friend: whitePieces, enemy: blackPieces, piece: whiteRooks[w], logicOptions: piecesBlackLogic)
                        }
                    })
                    let promoteToBishop = UIAlertAction(title: "Bishop", style: .Default, handler: {
                        (alert: UIAlertAction!) -> Void in
                        selectedPiece.image = UIImage(named:"whiteBishop")
                        whiteBishops += [selectedPiece]
                        for var w = 0; w < whiteBishops.count; w++ {
                            self.chessPieceMovementLogic(9, pieceid: 1, friend: whitePieces, enemy: blackPieces, piece: whiteBishops[w], logicOptions: piecesBlackLogic)
                        }
                    })
                    let promoteToKnight = UIAlertAction(title: "Knight", style: .Default, handler: {
                        (alert: UIAlertAction!) -> Void in
                        selectedPiece.image = UIImage(named:"whiteKnight")
                        whiteKnights += [selectedPiece]
                        for var w = 0; w < whiteKnights.count; w++ {
                            self.chessPieceMovementLogic(2, pieceid: 2, friend: whitePieces, enemy: blackPieces, piece: whiteKnights[w], logicOptions: piecesBlackLogic)
                        }
                    })
                    
                    actionSheet.addAction(promoteToQueen)
                    actionSheet.addAction(promoteToRook)
                    actionSheet.addAction(promoteToBishop)
                    actionSheet.addAction(promoteToKnight)
                    self.presentViewController(actionSheet, animated: true, completion: nil)
                        }
                    }
                for var i = 0; i < blackPawns.count;i++ {
                    if selectedPiece == blackPawns[i] && selectedPiece.frame.origin.y == _2 {
                        let actionSheet = UIAlertController(title: nil, message: "Promote pawn to:", preferredStyle: UIAlertControllerStyle.ActionSheet)
                        
                        let promoteToQueen = UIAlertAction(title: "Queen", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            selectedPiece.image = UIImage(named:"blackQueen")
                            blackPawns.removeAtIndex(i-1)
                            blackQueens += [selectedPiece]
                            //print(blackPawns.count)
                            for var q = 0; q < blackQueens.count; q++ {
                                self.chessPieceMovementLogic(9, pieceid: 4, friend: blackPieces, enemy: whitePieces, piece: blackQueens[q], logicOptions: piecesWhiteLogic)
                            }
                        })
                        let promoteToRook = UIAlertAction(title: "Rook", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            selectedPiece.image = UIImage(named:"blackRook")
                            blackRooks += [selectedPiece]
                            for var w = 0; w < blackRooks.count; w++ {
                                self.chessPieceMovementLogic(9, pieceid: 3, friend: blackPieces, enemy: whitePieces, piece: blackRooks[w], logicOptions: piecesWhiteLogic)
                            }
                        })
                        let promoteToBishop = UIAlertAction(title: "Bishop", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            selectedPiece.image = UIImage(named:"blackBishop")
                            blackBishops += [selectedPiece]
                            for var w = 0; w < blackBishops.count; w++ {
                                self.chessPieceMovementLogic(9, pieceid: 1, friend: blackPieces, enemy: whitePieces, piece: blackBishops[w], logicOptions: piecesWhiteLogic)
                            }
                        })
                        let promoteToKnight = UIAlertAction(title: "Knight", style: .Default, handler: {
                            (alert: UIAlertAction!) -> Void in
                            selectedPiece.image = UIImage(named:"blackKnight")
                            blackKnights += [selectedPiece]
                            for var w = 0; w < blackKnights.count; w++ {
                                self.chessPieceMovementLogic(2, pieceid: 2, friend: blackPieces, enemy: whitePieces, piece: blackKnights[w], logicOptions: piecesWhiteLogic)
                            }
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
                
                for var i = 0; i < pieces.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == pieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == pieces[i].frame.origin.y  {
                        pieceToTake += [pieces[i]]
                        pieces[i].removeFromSuperview()
                        pieces.removeAtIndex(i)
                    }
                }
                
                for var t = 0; t < blackPieces.count; t++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackPieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == blackPieces[t].frame.origin.y  {
                        pieceToTake += [blackPieces[t]]
                        blackPieces[t].removeFromSuperview()
                        blackPieces.removeAtIndex(t)
                        blackPiecesString.removeAtIndex(t)
                        
                    }
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackPieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == blackPieces[t].frame.origin.y - 1 * pieceSize && whitePassant == true && hasBeenTaken(selectedPiece, array: whitePieces) && canPassant == true  {
                        blackPieces[t].removeFromSuperview()
                        blackPieces.removeAtIndex(t)
                        
                        whitePassant = false
                        canPassant = false
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
                    canPassant = false
                }
                if touch.view == pieceOptions[o] &&  hasBeenTaken(selectedPiece, array: whitePieces)   {
                    canPassant = false
                }
                if touch.view == pieceOptions[o] &&  hasBeenTaken(selectedPiece, array: blackPieces)   {
                    canPassant = false
                }
                
            }
        }
        
        for var i = 0; i < whiteKnights.count;i++ {
            if touch.view == whiteKnights[i] && isWhiteTurn == true {
                selectedPiece = whiteKnights[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 2, friend: whitePieces, enemy: blackPieces)
            }
        }
        
        for var i = 0; i < whiteBishops.count; i++ {
            if touch.view == whiteBishops[i] && isWhiteTurn == true {
                selectedPiece = whiteBishops[i]
                removePieceOptions()
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 1, friend: whitePieces, enemy: blackPieces)
            }
        }
        
        for var i = 0; i < whiteRooks.count; i++ {
            if touch.view == whiteRooks[i] && isWhiteTurn == true {
                removePieceOptions()
                selectedPiece = whiteRooks[i]
                removeWhiteCastlingLeft()
                removeWhiteCastlingRight()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 3, friend: whitePieces, enemy: blackPieces)
            }
        }
     
        for var i = 0; i < whiteQueens.count; i++ {
        if touch.view == whiteQueens[i] && isWhiteTurn == true {
            selectedPiece = whiteQueens[i]
            removePieceOptions()
            removeWhiteCastlingLeft()
            removeWhiteCastlingRight()
            chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 4, friend: whitePieces, enemy: blackPieces)
        }
        }
        
        if touch.view == whiteKing && isWhiteTurn == true {
            selectedPiece = whiteKing
            removePieceOptions()
            chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 5, friend: whitePieces, enemy: blackPieces)
        }
        
        
        for var i = 0; i < blackPawns.count;i++ {
            if touch.view == blackPawns[i] && isWhiteTurn == false {
                selectedPiece = blackPawns[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                blackPawnSelected(event!, _touch: touch)
            }
        }
        
        for var i = 0; i < blackBishops.count;i++ {
            if touch.view == blackBishops[i] && isWhiteTurn == false {
                selectedPiece = blackBishops[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 1, friend: blackPieces, enemy: whitePieces)
            }
        }
        
        for var i = 0; i < blackKnights.count;i++ {
            if touch.view == blackKnights[i] && isWhiteTurn == false {
                selectedPiece = blackKnights[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 2, friend: blackPieces, enemy: whitePieces)
            }
        }
        
        for var i = 0; i < blackRooks.count;i++ {
            if touch.view == blackRooks[i] && isWhiteTurn == false {
                selectedPiece = blackRooks[i]
                removePieceOptions()
                removeBlackCastlingLeft()
                removeBlackCastlingRight()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 3, friend: blackPieces, enemy: whitePieces)
            }
        }
        
        for var i = 0; i < blackQueens.count; i++ {
        if touch.view == blackQueens[i] && isWhiteTurn == false {
            selectedPiece = blackQueens[i]
            removePieceOptions()
            removeBlackCastlingLeft()
            removeBlackCastlingRight()
            chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 4, friend: blackPieces, enemy: whitePieces)
        }
        }
        
        if touch.view == blackKing && isWhiteTurn == false {
            selectedPiece = blackKing
            removePieceOptions()
            removeBlackCastlingLeft()
            removeBlackCastlingRight()
            chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 5, friend: blackPieces, enemy: whitePieces)
        }
        
        //check pieceOptions
        for var o = 0 ; o < pieceOptions.count; o++ {
            pieceOptions[o].userInteractionEnabled = true
            pieceOptions[o].multipleTouchEnabled = true
            
            if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.y == _4 && hasBeenTaken(selectedPiece, array: whitePieces) && selectedPiece.frame.origin.y == _2   {
                canPassant = true
                //print("can passant!")
                whitePassantPieces = selectedPiece
            }
            
            if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.y == _5 && hasBeenTaken(selectedPiece, array: blackPieces) && selectedPiece.frame.origin.y == _7   {
                canPassant = true
                //print("can passant white!")
                blackPassantPieces = selectedPiece
            }
          
            if touch.view == pieceOptions[o] {
                movePiece(pieceOptions[o].frame.origin.x - selectedPiece.frame.origin.x, _moveByAmounty: pieceOptions[o].frame.origin.y - selectedPiece.frame.origin.y)
            }
        }
        for var o = 0 ; o < whiteCastlingLeft.count; o++ {
            whiteCastlingLeft[o].userInteractionEnabled = true
            whiteCastlingLeft[o].multipleTouchEnabled = true
            
            
            if touch.view == whiteCastlingLeft[o] {
                castlePiece = whiteRook2
                whiteCastle = true
                movePiece(whiteCastlingLeft[o].frame.origin.x - whiteKing.frame.origin.x, _moveByAmounty: whiteCastlingLeft[o].frame.origin.y - whiteKing.frame.origin.y)
                hasWhiteKingMoved = true
                hasWhiteRookMoved = true
                castleLeft = true
            }
        }
        for var o = 0 ; o < whiteCastlingRight.count; o++ {
            whiteCastlingRight[o].userInteractionEnabled = true
            whiteCastlingRight[o].multipleTouchEnabled = true
            
            
            if touch.view == whiteCastlingRight[o] {
                castlePiece = whiteRook1
                whiteCastle = true
                movePiece(whiteCastlingRight[o].frame.origin.x - whiteKing.frame.origin.x, _moveByAmounty: whiteCastlingRight[o].frame.origin.y - whiteKing.frame.origin.y)
                hasWhiteKingMoved = true
                hasWhiteRookMoved2 = true
                castleRight = true
            }
        }
        for var o = 0 ; o < blackCastlingLeft.count; o++ {
            blackCastlingLeft[o].userInteractionEnabled = true
            blackCastlingLeft[o].multipleTouchEnabled = true
            
            
            if touch.view == blackCastlingLeft[o] {
                castlePiece = blackRook1
                blackCastle = true
                movePiece(blackCastlingLeft[o].frame.origin.x - blackKing.frame.origin.x, _moveByAmounty: blackCastlingLeft[o].frame.origin.y - blackKing.frame.origin.y)
                hasBlackKingMoved = true
                hasBlackRookMoved = true
                castleLeft = true
            }
        }
        for var o = 0 ; o < blackCastlingRight.count; o++ {
            blackCastlingRight[o].userInteractionEnabled = true
            blackCastlingRight[o].multipleTouchEnabled = true
            
            
            if touch.view == blackCastlingRight[o] {
                castlePiece = blackRook2
                blackCastle = true
                movePiece(blackCastlingRight[o].frame.origin.x - blackKing.frame.origin.x, _moveByAmounty: blackCastlingRight[o].frame.origin.y - blackKing.frame.origin.y)
                hasBlackKingMoved = true
                hasBlackRookMoved2 = true
                castleRight = true
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

        }

    }
}