//
//  ShowListViewCell.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import TraktKit

class ShowListViewCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var year: UILabel!
    
    static func height() -> CGFloat {
        return 195
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func setup(with item: TraktShow) {
        showImage.download(image: "/search/tmdb/\(String(describing: item.ids.tmdb!))")
        titleLabel.text = item.title
        year.text = String(Int(item.year!))
        
    }
    
    func configure() {

    }

}
