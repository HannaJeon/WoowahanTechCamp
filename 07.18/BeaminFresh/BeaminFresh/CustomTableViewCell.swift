//
//  CustomTableViewCell.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    
    var labelXPoint = 118
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 15)
        descriptionLabel.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)
        salePriceLabel.textColor = UIColor(red: 95/255, green: 192/255, blue: 189/255, alpha: 1)
        normalPriceLabel.font = UIFont(name: normalPriceLabel.font.fontName, size: 15)
        normalPriceLabel.lineBreakMode = .byTruncatingMiddle
        normalPriceLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        let attrString = NSMutableAttributedString(string: normalPriceLabel.text!)
        attrString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attrString.length))
        
        normalPriceLabel.attributedText = attrString
    }
    
    func emptySalePrice() {
        normalPriceLabel.font = salePriceLabel.font
        normalPriceLabel.textColor = salePriceLabel.textColor
        salePriceLabel.isHidden = true
    }
    
    func emptyNormalPrice() {
        salePriceLabel.frame = normalPriceLabel.frame
        normalPriceLabel.isHidden = true
    }
    
    func makeBadgeLabel(badge: String) {
        let label = UILabel()
        
        label.backgroundColor = UIColor(red: 162/255, green: 120/255, blue: 186/255, alpha: 1)
        label.frame = CGRect(x: labelXPoint, y: 83, width: 49, height: 21)
        labelXPoint += Int(label.bounds.width + 5)
        label.text = badge
    }
    
}
