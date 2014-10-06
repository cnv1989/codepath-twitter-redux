//
//  MenuItemTableViewCell.swift
//  TwitterRedux
//
//  Created by Nag Varun Chunduru on 10/5/14.
//  Copyright (c) 2014 cnv. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemIcon: CustomImageView!
    @IBOutlet weak var itemDisplayName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: NSString!, icon: UIImage!){
        itemIcon.image = icon
        itemDisplayName.text = name
    }
}
