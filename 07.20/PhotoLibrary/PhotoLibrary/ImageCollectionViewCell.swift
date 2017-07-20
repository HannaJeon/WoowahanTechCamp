//
//  ImageCollectionViewCell.swift
//  PhotoLibrary
//
//  Created by HannaJeon on 2017. 7. 20..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            iconImageView.isHidden = self.isSelected ? false : true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.image = #imageLiteral(resourceName: "greencheck")
        self.iconImageView.isHidden = true
    }
}
