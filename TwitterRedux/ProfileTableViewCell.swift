//
//  ProfileTableViewCell.swift
//  TwitterRedux
//
//  Created by Nag Varun Chunduru on 10/5/14.
//  Copyright (c) 2014 cnv. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImage: CustomImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.layer.cornerRadius = 10
        self.profileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(user: User!) {
        displayNameLabel?.text = user.name!
        screenNameLabel?.text = "@\(user.screen_name!)"
        profileImage.loadImage(user.profile_image_url!)
    }

}
