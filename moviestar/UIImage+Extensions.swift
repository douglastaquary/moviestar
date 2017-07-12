//
//  UIImage+Extensions.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//
import UIKit
import Kingfisher

extension UIImageView {
    
    func download(image url: String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        
        self.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}

