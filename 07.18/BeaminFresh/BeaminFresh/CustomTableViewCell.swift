//
//  CustomTableViewCell.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 18..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var badgeLabels = [UILabel]()

    let normalPriceLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 118, y: 59, width: 75, height: 21)
        label.font = UIFont(name: label.font.fontName, size: 13)
        label.isHidden = false
        return label
    }()
    let salePriceLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 170, y: 59, width: 200, height: 21)
        label.textColor = UIColor(red: 95/255, green: 192/255, blue: 189/255, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(17))
        label.isHidden = false
        return label
    }()
    
    var labelXPoint = 118
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImageView.layer.cornerRadius = foodImageView.frame.size.height / 2
        foodImageView.layer.masksToBounds = true
        
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 13)
        descriptionLabel.textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)

        self.contentView.addSubview(salePriceLabel)
        self.contentView.addSubview(normalPriceLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        let textColor = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)

        let attrString = NSMutableAttributedString(string: normalPriceLabel.text ?? "")
        let attributes = [NSBaselineOffsetAttributeName: 0, NSForegroundColorAttributeName: textColor, NSStrikethroughStyleAttributeName: 1] as [String : Any]
        attrString.addAttributes(attributes, range: NSMakeRange(0, attrString.length))
        normalPriceLabel.attributedText = attrString
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        salePriceLabel.isHidden = false
        normalPriceLabel.isHidden = false
        salePriceLabel.frame = CGRect(x: 170, y: 59, width: 200, height: 21)
        normalPriceLabel.frame = CGRect(x: 118, y: 59, width: 75, height: 21)
        for badgeLabel in badgeLabels {
            badgeLabel.removeFromSuperview()
        }
        labelXPoint = 118
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
        let badgeLabel = UILabel()
        badgeLabel.backgroundColor = UIColor(red: 162/255, green: 120/255, blue: 186/255, alpha: 1)
        badgeLabel.frame = CGRect(x: labelXPoint, y: 83, width: 47, height: 18)
        labelXPoint += Int(badgeLabel.bounds.width + 5)
        badgeLabel.text = badge
        badgeLabel.textAlignment = .center
        badgeLabel.textColor = UIColor.white
        badgeLabel.font = UIFont(name: badgeLabel.font.fontName, size: 10)
        self.contentView.addSubview(badgeLabel)
        badgeLabels.append(badgeLabel)
    }

}
