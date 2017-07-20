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
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    var detailHash = String()
    var foodDetail = FoodDetail()
    let networking = Networking()
    
//    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//    var pageControl: UIPageControl!

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
        mainScrollView.contentSize.width = width
        
//        let width = mainImageView.bounds.width * CGFloat(foodDetail.thumbImage.count)
//        let height = mainImageView.bounds.height
//        mainScrollView.contentSize = CGSize(width: width, height: height)
//        mainImageView.af_setImage(withURL: <#T##URL#>)
    }

}
