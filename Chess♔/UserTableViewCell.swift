//
//  UserTableViewCell.swift
//  Chess♔
//
//  Created by Johannes Berge on 22/09/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
                
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state /
    }

}

class UserTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        
    }
    

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state /
    }
    
}

class UserTableViewCell3: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state /
    }
    
}

class UserTableViewCell4: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var position: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state /
    }
    
}

class UserTableViewCell5: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var position: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state /
    }
    
}

class GameMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileImageBC: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var updated: UILabel!
    @IBOutlet weak var timeleft: UILabel!
    @IBOutlet weak var colorIndicator: UILabel!
    @IBOutlet weak var content: UIView!



    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.content.layer.cornerRadius = cornerRadius
//        self.contentView.layer.shadowColor = UIColor.blackColor().CGColor
//                self.contentView.layer.shadowOpacity = 0.05
//                //self.contentView.layer.shadowRadius = cornerRadius
//               self.contentView.layer.shadowOffset = CGSizeZero
//        
        self.content.clipsToBounds = true
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        self.userProfileImage.layer.borderColor = UIColor.whiteColor().CGColor
        self.userProfileImage.layer.borderWidth = 3
        
        self.userProfileImageBC.clipsToBounds = true
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        if darkMode { visualEffectView.effect = UIBlurEffect(style: .Dark) }
        else { visualEffectView.effect = UIBlurEffect(style: .ExtraLight) }
        visualEffectView.frame = self.userProfileImageBC.bounds
//        visualEffectView.frame.size.height += 20
//        visualEffectView.frame.size.width += 20
//        visualEffectView.frame.origin.y -= 10
//        visualEffectView.frame.origin.x -= 10
       // self.userProfileImageBC.insertSubview(visualEffectView, atIndex: 0)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state /
    }
    
}

class NewGameFriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        
        
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state /
    }
    
}


///////Fornøyd???