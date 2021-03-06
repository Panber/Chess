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

class UserTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    
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

class UserTableViewCell3: UITableViewCell {
    
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
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var updated: UILabel!
    @IBOutlet weak var timeleft: UILabel!
    @IBOutlet weak var colorIndicator: UILabel!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var speedIndicator: UIImageView!
    @IBOutlet weak var pieceIndicator: UILabel!
    @IBOutlet weak var analyzeButton: UIButton!


    
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
        
        self.colorIndicator.layer.cornerRadius = (self.colorIndicator.frame.size.width)/2
        self.colorIndicator.clipsToBounds = true
        
        self.pieceIndicator.layer.borderColor = UIColor.blackColor().CGColor
        self.pieceIndicator.layer.borderWidth = 1
        self.pieceIndicator.backgroundColor = UIColor.whiteColor()
        
        self.analyzeButton.hidden = true

//        visualEffectView.frame.size.height += 20
//        visualEffectView.frame.size.width += 20
//        visualEffectView.frame.origin.y -= 10
//        visualEffectView.frame.origin.x -= 10
       // self.userProfileImageBC.insertSubview(visualEffectView, atIndex: 0)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        let color = self.colorIndicator.backgroundColor
        let color2 = self.pieceIndicator.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        self.colorIndicator.backgroundColor = color
        self.pieceIndicator.backgroundColor = color2
        
      //  self.contentView.backgroundColor = blue

    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        let color = self.colorIndicator.backgroundColor
        let color2 = self.pieceIndicator.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        self.colorIndicator.backgroundColor = color
        self.pieceIndicator.backgroundColor = color2
        
     //   self.contentView.backgroundColor = blue
    }
    
}

class NewGameRatingTableViewCell: UITableViewCell {
    
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

class NewGameUsernameTableViewCell: UITableViewCell {
    
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

class NewGameNearbyTableViewCell: UITableViewCell {
    
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

class GameInvitesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var speedIndicator: UIImageView!
    @IBOutlet weak var pieceIndicator: UILabel!
    @IBOutlet weak var ratedOrUnrated: UILabel!
    @IBOutlet weak var whichColorText: UILabel!
    @IBOutlet weak var speedmodeText: UILabel!



    
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //changing profileImage
        self.userProfileImage.layer.cornerRadius = (self.userProfileImage.frame.size.width / 2)
        self.userProfileImage.clipsToBounds = true
        
        self.pieceIndicator.layer.borderColor = UIColor.blackColor().CGColor
        self.pieceIndicator.layer.borderWidth = 1
        self.pieceIndicator.backgroundColor = UIColor.whiteColor()
    }
    
    

    
}

import Charts

class AnalyzeMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var updated: UILabel!
    @IBOutlet weak var content: UIView!
    
    @IBOutlet weak var notations: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // self.content.layer.cornerRadius = cornerRadius
//                self.lineChartView.layer.shadowColor = UIColor.blackColor().CGColor
//                        self.lineChartView.layer.shadowOpacity = 0.3
//                        self.lineChartView.layer.shadowRadius = 7
//                       self.lineChartView.layer.shadowOffset = CGSizeZero


        //
        self.content.clipsToBounds = true
        
        
        

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
        super.setHighlighted(highlighted, animated: animated)
        
    }
    
}

///////Fornøyd???