//
//  DetailViewController.swift
//  BeaminFresh
//
//  Created by HannaJeon on 2017. 7. 19..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    var orderButton = UIButton()
    
    var detailHash = String()
    var detailTitle = String()
    var foodDetail = FoodDetail()
    let networking = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.getFoodDetail(hash: detailHash)
        viewinit()
        makeOderButton()
        orderButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(finishedGetFoodDetail(_:)), name: NSNotification.Name("getFoodDetail"), object: networking)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishedGetFoodDetail(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:FoodDetail] {
            foodDetail = userInfo["foodDetail"]!
        }
        setMainScrollView()
        makeDetailImage()
        makeContainerView()
    }
    
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
        var yPoint = mainScrollView.frame.height + containerView.frame.height
        for i in 0..<foodDetail.detailSection.count {
            let imageView = UIImageView()
            
            imageView.af_setImage(withURL: URL(string: foodDetail.detailSection[i])!, completion: { (response) in
                if let image = response.result.value {
                    let imageHeight = (image.size.height) / ((image.size.width) / (self.view.frame.width-10))
                    imageView.frame = CGRect(x: 5, y: yPoint, width: self.view.frame.width-10, height: imageHeight)
                    imageView.contentMode = .scaleAspectFit
                    
                    self.containerScrollView.addSubview(imageView)
                    
                    yPoint += imageView.frame.height
                    self.containerScrollView.contentSize.height = imageView.frame.maxY + self.orderButton.frame.height
                }
            })
        }
    }
    
    func makeOderButton() {
        orderButton.frame = CGRect(x: 0, y: self.view.frame.maxY-50, width: self.view.frame.width, height: 50)
        orderButton.setTitle("주문하기", for: .normal)
        orderButton.setTitleColor(UIColor.white, for: .normal)
        orderButton.backgroundColor = UIColor(red: 112/255, green: 198/255, blue: 188/255, alpha: 1)
        self.view.addSubview(orderButton)
    }
    
    func orderButtonAction() {
        let message = ["username" : "한나", "text" : "\(salePriceLabel.text!)-\(titleLabel.text!)"]
        networking.postMessage(message: message)
    }
    
    func viewinit() {
        let textColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        salePriceLabel.textColor = UIColor(red: 112/255, green: 198/255, blue: 188/255, alpha: 1)
        normalPriceLabel.textAlignment = .center
        descriptionLabel.textColor = textColor
        pointLabel.textColor = textColor
        deliveryInfoLabel.textColor = textColor
        deliveryFeeLabel.textColor = textColor
    }
    
    func makeContainerView() {
        let textColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        
        titleLabel.text = detailTitle
        descriptionLabel.text = foodDetail.productDescription
        pointLabel.text = foodDetail.point
        deliveryInfoLabel.text = foodDetail.deliveryInfo
        deliveryFeeLabel.text = foodDetail.deliveryFee
        
        if foodDetail.prices.count == 2 {
            normalPriceLabel.text = foodDetail.prices.max()
            salePriceLabel.text = foodDetail.prices.min()
            
            let attrString = NSMutableAttributedString(string: normalPriceLabel.text!)
            let attributes = [NSBaselineOffsetAttributeName: 0, NSForegroundColorAttributeName: textColor, NSStrikethroughStyleAttributeName: 1] as [String : Any]
            attrString.addAttributes(attributes, range: NSMakeRange(0, attrString.length))
            normalPriceLabel.attributedText = attrString
        } else {
            normalPriceLabel.isHidden = true
            salePriceLabel.text = foodDetail.prices[0]
        }
    }

}
