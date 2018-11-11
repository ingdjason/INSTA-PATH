//
//  PhotoCellTableViewCell.swift
//  INSTA-PATH
//
//  Created by Djason  Sylvaince on 11/4/18.
//  Copyright © 2018 Djason I. SYLVAINCE. All rights reserved.
//

import UIKit

class PhotoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var labelpost: UILabel!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var datelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
