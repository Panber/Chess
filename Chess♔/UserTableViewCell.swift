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

///////Fornøyd???