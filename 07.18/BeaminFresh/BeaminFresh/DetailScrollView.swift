//
//  DetailScrollView.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 23..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit

class DetailScrollView: UIScrollView {
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var userPointLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var userdeliveryFeeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var orderButton = UIButton()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setMainScrollView() {
        var width = CGFloat()
        for i in 0..<foodDetail.thumbImage.count {
            let imageView = UIImageView()
            imageView.af_setImage(withURL: URL(string: foodDetail.thumbImage[i])!)
            let xPoint = self.view.frame.maxX * CGFloat(i)
            imageView.frame = CGRect(x: xPoint, y: 0, width: self.view.frame.width, height: mainScrollView.frame.height)
            imageView.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            imageView.contentMode = .scaleAspectFit
            width += imageView.bounds.width
            mainScrollView.addSubview(imageView)
        }
        mainScrollView.isPagingEnabled = true
        mainScrollView.contentSize.width = width
    }
    
    func makeDetailImage() {
        var height = CGFloat()
        var yPoint = mainScrollView.frame.height + containerView.frame.height
        for i in 0..<foodDetail.detailSection.count {
            let imageView = UIImageView()
            //            imageView.af_setImage(withURL: URL(string: foodDetail.detailSection[i])!)
            let data = try? Data(contentsOf: URL(string: foodDetail.detailSection[i])!)
            guard let imageData = data else { return }
            
            let image = UIImage(data: imageData)
            let imageHeight = (image?.size.height)! / ((image?.size.width)! / (self.view.frame.width-10))
            imageView.image = image
            imageView.frame = CGRect(x: 5, y: yPoint, width: self.view.frame.width-10, height: imageHeight)
            imageView.contentMode = .scaleAspectFit
            
            containerScrollView.addSubview(imageView)
            yPoint += imageView.frame.height
            height = imageView.frame.maxY
        }
        containerScrollView.contentSize.height = height + orderButton.frame.height
    }
    
    func makeOderButton() {
        orderButton.frame = CGRect(x: 0, y: self.view.frame.maxY-50, width: self.view.frame.width, height: 50)
        orderButton.setTitle("주문하기", for: .normal)
        orderButton.setTitleColor(UIColor.white, for: .normal)
        orderButton.backgroundColor = UIColor(red: 112/255, green: 198/255, blue: 188/255, alpha: 1)
        self.view.addSubview(orderButton)
    }
    
    func makeContainerView() {
        titleLabel.text = detailTitle
        descriptionLabel.text = foodDetail.productDescription
        if foodDetail.prices.count == 2 {
            normalPriceLabel.text = foodDetail.prices.max()
            salePriceLabel.text = foodDetail.prices.min()
            
        } else {
            normalPriceLabel.isHidden = true
            salePriceLabel.text = foodDetail.prices[0]
        }
        print(foodDetail.prices)
    }

}
