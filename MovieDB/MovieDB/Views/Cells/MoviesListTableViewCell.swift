//
//  MoviesListTableViewCell.swift
//  MovieDB
//
//  Created by Parth Adroja on 30/04/18.
//  Copyright © 2018 Anil Kukadeja. All rights reserved.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovieThumbnail: UIImageView!
    
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
