//
//  EpisodeViewCell.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import TraktKit

class EpisodeViewCell: UITableViewCell {
    
    @IBOutlet weak var imageEpisode: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with item: TraktEpisode) {
    
        imageEpisode.download(image: "/search/imdb/\(String(describing: item.ids.imdb))" )
        titleLabel.text = item.title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
