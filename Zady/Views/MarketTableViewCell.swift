//
//  MarketTableViewCell.swift
//  Zady
//
//  Created by khaled mohamed el morabea on 8/8/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit

class MarketTableViewCell: UITableViewCell {
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var logoContanierView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openHoursLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var accuracyImageView: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyTheme()
    }
    
    func applyTheme() {
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width/2.0
        self.logoImageView.layer.masksToBounds = true
        
        self.logoContanierView.layer.cornerRadius = 5.0
        self.logoContanierView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
