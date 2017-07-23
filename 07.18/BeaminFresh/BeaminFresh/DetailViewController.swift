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
    
    var detailHash = String()
    var foodDetail = FoodDetail()
    let networking = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.getFoodDetail(hash: detailHash)
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
        var height = CGFloat()
        var yPoint = mainScrollView.frame.height + containerView.frame.height
        for i in 0..<foodDetail.detailSection.count {
            let imageView = UIImageView()
//            imageView.af_setImage(withURL: URL(string: foodDetail.detailSection[i])!)
            let data = try? Data(contentsOf: URL(string: foodDetail.detailSection[i])!)
            guard let imageData = data else { return }
            
            let image = UIImage(data: imageData)
            let imageHeight = (image?.size.height)! / ((image?.size.width)! / self.view.frame.width)
            imageView.image = image
            imageView.frame = CGRect(x: 0, y: yPoint, width: self.view.frame.width, height: imageHeight)
            imageView.contentMode = .scaleAspectFit
            
            containerScrollView.addSubview(imageView)
            yPoint += imageView.frame.height
            height = imageView.frame.maxY
        }
        containerScrollView.contentSize.height = height
//        button.setTitle("주문하기", for: .normal)
//        button.backgroundColor = UIColor.red
//        button.frame = CGRect(x: 0, y: self.view.frame.maxY-50, width: self.view.frame.width, height: 50)
    }

}
