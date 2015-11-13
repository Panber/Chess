//
//  ViewController.swift
//  ChessNow
//
//  Created by Johannes Berge on 21/11/14.
//  Copyright (c) 2014 Johannes Berge & Alexander Panayotov. All rights reserved.
//

import UIKit
import SpriteKit

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

// Logic options for Queen, Bishop and Rook
var QBRLogicOptions : Array<UIImageView> = []

var selectedPawn = 0
var pieceOpt = whitePawn1

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

var moveByAmounty: CGFloat = 0.0
var moveByAmountx: CGFloat = 0.0

// Must be assigned to a UIImageView when created
var selectedPiece: UIImageView = whitePawn1
var eatenPieces = UIImageView(frame: CGRectMake(a, _2, pieceSize , pieceSize))
var pieceCanTake : UIImageView = whitePawn1
var pieceToTake : UIImageView = whitePawn1

var takenWhitePieces : Array<UIImageView> = []
var takenBlackPieces : Array<UIImageView> = []


var increasey : CGFloat = 1;
var increasex : CGFloat = 1;
var piecePos : Array<UIImageView> = []

var isWhiteTurn = true

// bishop = 1, knight = 2, rook = 3, queen = 4, king = 5
var pieceID = 0

class GameInterFace3: UIViewController {
    
    @IBOutlet weak var chessBoard: UIImageView!
    
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
        self.tabBarController?.tabBar.hidden = true
        let nav = self.navigationController?.navigationBar
        
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
        
        print("\(screenHeight) is the height and \(screenWidth) is the width. \(screenSize) is the screensize. \(pieceSize) is the pieceSize")
        
    }
    
    
    
    // MARK: - Setup-functions 🔍
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    
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
        for var p = 0 ; p < QBRLogicOptions.count; p++ {
            QBRLogicOptions[p].hidden = true
            QBRLogicOptions[p].removeFromSuperview()
        }
        QBRLogicOptions = []
    }
    
    
    // MARK: - Pieces selected! 👾
    
    func whitePawnSelected(var _event:UIEvent, var _touch:UITouch) {
        showMarkedPiece()
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat) {
            var canThePieceGofurther: Bool = true
            
            for byAmounty; byAmounty <= 2; byAmountx += increaserx, byAmounty += increasery {
                
                for var q = 0; q < whitePieces.count; q++ {
                    if whitePieces[q].frame.origin.x == selectedPiece.frame.origin.x && whitePieces[q].frame.origin.y == selectedPiece.frame.origin.y - 1 * pieceSize{
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
                    self.view.addSubview(pieceOption)
                    pieceOptions += [pieceOption]
                } else if canThePieceGofurther == true {
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    self.view.addSubview(pieceOption)
                    pieceOptions += [pieceOption]
                    
                }
                for var r = 0; r < blackPieces.count; r++ {
                    if blackPieces[r].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && blackPieces[r].frame.origin.y == selectedPiece.frame.origin.y - 1 * pieceSize {
                        
                        print("working")
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y - 1 * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption)
                        if containsDanger(pieceOptions, image: pieceOption) {
                            pieceOption.removeFromSuperview()
                        }
                        pieceOptions += [pieceOption]
                        canThePieceGofurther = false
                        
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
            
            for byAmountz; byAmountz < movementNumber; byAmountx += increaserx, byAmounty += increasery, byAmountz += increaserz {
                
                for var q = 0; q < friend.count; q++ {
                    if friend[q].frame.origin.x == selectedPiece.frame.origin.x + byAmountx * pieceSize && friend[q].frame.origin.y == selectedPiece.frame.origin.y - byAmounty * pieceSize{
                        canThePieceGofurther = false
                    }
                }
                
                if canThePieceGofurther == true {
                    
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + byAmountx * pieceSize, selectedPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    self.view.addSubview(pieceOption)
                    pieceOptions += [pieceOption]
                }
                
                
                for var r = 0; r < enemy.count; r++ {
                    if enemy[r].frame.origin.x == selectedPiece.frame.origin.x + byAmountx * pieceSize && enemy[r].frame.origin.y == selectedPiece.frame.origin.y - byAmounty * pieceSize && canThePieceGofurther == true {
                        
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x + byAmountx * pieceSize, selectedPiece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption)
                        pieceOptions += [pieceOption]
                        pieceCanTake = pieceOption
                        pieceToTake = blackPieces[r]
                        canThePieceGofurther = false
                        
                    }
                }
                
                //				// Decides which squares the King can go to
                //				if pieceid == 5 {
                //					for var p = 0 ; p < pieceOptions.count; p++ {
                //					for var o = 0 ; o < QBRLogicOptions.count; o++ {
                //						if CGRectContainsPoint(pieceOptions[p].frame, QBRLogicOptions[o].center){
                //							pieceOptions[p].hidden = true
                //						}
                //					}
                //					}
                //				}
                
                for var o = 0 ; o < pieceOptions.count; o++ {
                    if CGRectContainsPoint(boarderBoard.frame, pieceOptions[o].center) == false {
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
    }
    
    func chessPieceMovementLogic(var movementNumber: CGFloat, var pieceid: Int, var friend: [UIImageView], var enemy: [UIImageView], var piece: UIImageView) {
        pieceID = pieceid
        var lastArrayCount = 0
        var foundKing: Bool = false
        
        func letThemAppear(var byAmountx:CGFloat, var byAmounty:CGFloat, increaserx:CGFloat, increasery:CGFloat, var byAmountz:CGFloat, increaserz:CGFloat ) {
            var canThePieceGofurther: Bool = true
            
            for byAmountz; byAmountz < movementNumber; byAmountx += increaserx, byAmounty += increasery, byAmountz += increaserz {
                
                for var q = 0; q < friend.count; q++ {
                    if friend[q].frame.origin.x == piece.frame.origin.x + byAmountx * pieceSize && friend[q].frame.origin.y == piece.frame.origin.y - byAmounty * pieceSize{
                        canThePieceGofurther = false
                    }
                }
                
                for var q = 0; q < QBRLogicOptions.count; q++ {
                    if CGRectContainsPoint(QBRLogicOptions[q].frame , blackKing.center) {
                        foundKing = true
                        canThePieceGofurther = false
                        print("found the King!")
                    }
                }
                
                if canThePieceGofurther == true {
                    
                    let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    self.view.addSubview(pieceOption)
                    if pieceid == 1 || pieceid == 3 || pieceid == 4  {
                        QBRLogicOptions += [pieceOption]
                    }
                }
                
                
                for var r = 0; r < enemy.count; r++ {
                    if enemy[r].frame.origin.x == piece.frame.origin.x + byAmountx * pieceSize && enemy[r].frame.origin.y == piece.frame.origin.y - byAmounty * pieceSize && canThePieceGofurther == true {
                        
                        let pieceOption = UIImageView(frame: CGRectMake(piece.frame.origin.x + byAmountx * pieceSize, piece.frame.origin.y - byAmounty * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption)
                        if pieceid == 1 || pieceid == 3 || pieceid == 4  {
                            QBRLogicOptions += [pieceOption]
                        }
                        canThePieceGofurther = false
                        
                    }
                }
                
                if pieceid == 1 || pieceid == 3 || pieceid == 4  {
                    for var o = 0 ; o < QBRLogicOptions.count; o++ {
                        if CGRectContainsPoint(boarderBoard.frame, QBRLogicOptions[o].center) == false {
                            [QBRLogicOptions[o] .removeFromSuperview()]
                            QBRLogicOptions.removeAtIndex(o)
                        }
                    }
                }
            }
            if foundKing == false {
                for var o = 0 ; o < QBRLogicOptions.count; o++ {
                    [QBRLogicOptions[o] .removeFromSuperview()]
                }
                
                QBRLogicOptions.removeAll()
                QBRLogicOptions = []
            }
            print(QBRLogicOptions.count)
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
                    self.view.addSubview(pieceOption)
                    if containsDanger(pieceOptions, image: pieceOption) {
                        pieceOption.removeFromSuperview()
                    }
                    
                    pieceOptions += [pieceOption]
                } else if canThePieceGofurther == true {
                    let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x, selectedPiece.frame.origin.y + 1 * pieceSize, size, size))
                    pieceOption.image = UIImage(named: "piecePossibilities.png")
                    self.view.addSubview(pieceOption)
                    if containsDanger(pieceOptions, image: pieceOption) {
                        pieceOption.removeFromSuperview()
                    }
                    
                    pieceOptions += [pieceOption]
                }
                for var r = 0; r < whitePieces.count; r++ {
                    if whitePieces[r].frame.origin.x == selectedPiece.frame.origin.x - byAmountx * pieceSize && whitePieces[r].frame.origin.y == selectedPiece.frame.origin.y + 1 * pieceSize && canTake == true {
                        
                        let pieceOption = UIImageView(frame: CGRectMake(selectedPiece.frame.origin.x - byAmountx * pieceSize, selectedPiece.frame.origin.y + 1 * pieceSize, pieceSize, pieceSize))
                        pieceOption.image = UIImage(named: "piecePossibilities.png")
                        self.view.addSubview(pieceOption)
                        if containsDanger(pieceOptions, image: pieceOption) {
                            pieceOption.removeFromSuperview()
                        }
                        pieceOptions += [pieceOption]
                        canThePieceGofurther = false
                        
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
            
            chessPieceMovementLogic(9, pieceid: 4, friend: whitePieces, enemy: blackPieces, piece: whiteQueen)
        }
            
        else {
            var positionx = selectedPiece.frame.origin.x
            var positiony = selectedPiece.frame.origin.y
            positiony +=  moveByAmounty / 10
            positionx += moveByAmountx / 10
            selectedPiece.frame = CGRect(x: positionx, y: positiony, width: pieceSize, height: pieceSize)
            canTake = true
            removeLogicOptions()
        }
        
    }
    
    func containsDanger(var array: Array<UIImageView>, image: UIImageView) -> Bool {
        
        var bool = false
        for var o = 0 ; o < array.count; o++ {
            if CGRectContainsPoint(array[o].frame, image.center) {
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
        
        for var i = 0; i < whitePawns.count;i++ {
            if touch.view == whitePawns[i] && isWhiteTurn == true {
                selectedPiece = whitePawns[i]
                removePieceOptions()
                whitePawnSelected(event!, _touch: touch)
                selectedPawn = i
                
            }
            
        }
        
        
        for var o = 0 ; o < pieceOptions.count ; o++ {
            
            if touch.view == pieceOptions[o] {
                for var i = 0; i < whitePieces.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == whitePieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == whitePieces[i].frame.origin.y  {
                        pieceToTake = whitePieces[i]
                        whitePieces[i].removeFromSuperview()
                        whitePieces.removeAtIndex(i)
                        whitePiecesString.removeAtIndex(i)
                    }
                }
                
                for var i = 0; i < pieces.count; i++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == pieces[i].frame.origin.x && pieceOptions[o].frame.origin.y == pieces[i].frame.origin.y  {
                        pieceToTake = pieces[i]
                        pieces[i].removeFromSuperview()
                        pieces.removeAtIndex(i)
                        
                    }
                }
                
                for var t = 0; t < blackPieces.count; t++ {
                    if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == blackPieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == blackPieces[t].frame.origin.y  {
                        pieceToTake = blackPieces[t]
                        blackPieces[t].removeFromSuperview()
                        blackPieces.removeAtIndex(t)
                        blackPiecesString.removeAtIndex(t)
                        
                    }
                }
            }
        }
        
        
        for var o = 0 ; o < pieceOptions.count ; o++ {
            for var t = 0; t < whitePieces.count; t++ {
                
                if touch.view == pieceOptions[o] && pieceOptions[o].frame.origin.x == whitePieces[t].frame.origin.x && pieceOptions[o].frame.origin.y == whitePieces[t].frame.origin.y  {
                    whitePieces[t].removeFromSuperview()
                    whitePieces.removeAtIndex(t)
                }
                
                
            }
        }
        
        for var i = 0; i < whiteKnights.count;i++ {
            if touch.view == whiteKnights[i] && isWhiteTurn == true {
                selectedPiece = whiteKnights[i]
                removePieceOptions()
                chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 2, friend: whitePieces, enemy: blackPieces)
            }
        }
        
        for var i = 0; i < whiteBishops.count; i++ {
            if touch.view == whiteBishops[i] && isWhiteTurn == true {
                selectedPiece = whiteBishops[i]
                removePieceOptions()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 1, friend: whitePieces, enemy: blackPieces)
            }
        }
        
        for var i = 0; i < whiteRooks.count; i++ {
            if touch.view == whiteRooks[i] && isWhiteTurn == true {
                removePieceOptions()
                selectedPiece = whiteRooks[i]
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 3, friend: whitePieces, enemy: blackPieces)
            }
        }
        
        if touch.view == whiteQueen && isWhiteTurn == true {
            selectedPiece = whiteQueen
            removePieceOptions()
            chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 4, friend: whitePieces, enemy: blackPieces)
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
                blackPawnSelected(event!, _touch: touch)
            }
        }
        
        for var i = 0; i < blackBishops.count;i++ {
            if touch.view == blackBishops[i] && isWhiteTurn == false {
                selectedPiece = blackBishops[i]
                removePieceOptions()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 1, friend: blackPieces, enemy: whitePieces)
            }
        }
        
        for var i = 0; i < blackKnights.count;i++ {
            if touch.view == blackKnights[i] && isWhiteTurn == false {
                selectedPiece = blackKnights[i]
                removePieceOptions()
                chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 2, friend: blackPieces, enemy: whitePieces)
            }
        }
        
        for var i = 0; i < blackRooks.count;i++ {
            if touch.view == blackRooks[i] && isWhiteTurn == false {
                selectedPiece = blackRooks[i]
                removePieceOptions()
                chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 3, friend: blackPieces, enemy: whitePieces)
            }
        }
        
        if touch.view == blackQueen && isWhiteTurn == false {
            selectedPiece = blackQueen
            removePieceOptions()
            chessPieceSelected(event!, _touch: touch, movementNumber: 9, pieceid: 4, friend: blackPieces, enemy: whitePieces)
        }
        
        if touch.view == blackKing && isWhiteTurn == false {
            selectedPiece = blackKing
            removePieceOptions()
            chessPieceSelected(event!, _touch: touch, movementNumber: 2, pieceid: 5, friend: blackPieces, enemy: whitePieces)
        }
        
        //check pieceOptions
        for var o = 0 ; o < pieceOptions.count; o++ {
            pieceOptions[o].userInteractionEnabled = true
            pieceOptions[o].multipleTouchEnabled = true
            
            if touch.view == pieceOptions[o] {
                movePiece(pieceOptions[o].frame.origin.x - selectedPiece.frame.origin.x, _moveByAmounty: pieceOptions[o].frame.origin.y - selectedPiece.frame.origin.y)
                
            }
        }
    }
    
}