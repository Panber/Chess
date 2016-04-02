//
//  Chat.swift
//  Chess♔
//
//  Created by Alexander Panayotov on 01/04/16.
//  Copyright © 2016 Panber. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class Chat: JSQMessagesViewController {
    
     var ref: Firebase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Firebase(url:"https://chess-panber.firebaseio.com/games/")
        self.senderId = ""
        self.senderDisplayName = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
