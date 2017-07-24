//
//  ViewController.swift
//  GoogleImages
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let networking = Networking()
    var images = [Int:UIImage]()
    var jsonArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        networking.getJsonData(url: "http://125.209.194.123/doodle.php")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(saveImageData), name: NSNotification.Name("getImage"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveJsonData(_:)), name: NSNotification.Name("getJsonData"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveJsonData(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:NSArray] {
            jsonArray = userInfo["jsonData"]!
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
//    var indexPaths = [IndexPath]()
//    func saveImageData(_ notification: Notification) {
//        if let userInfo = notification.userInfo as? [String:Data] {
//            DispatchQueue.main.async {
//                let image = UIImage(data: userInfo["image"]!)
//                self.images.append(image!)
//            }
//        }
////        self.collectionView.reloadData()
//    }
    
    var size = CGSize(width: 128, height: 50)

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.numberLabel.text = String(indexPath.row+1)
        DispatchQueue.global().async {
            self.networking.getImageData(url: (self.jsonArray[indexPath.row] as! [String:String])["image"]!, callback: { (imageData) in
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.images[indexPath.row] = image
                    //                self.collectionView.reloadItems(at: [indexPath])
                    cell.imageView.image = self.images[indexPath.row]
                }
                
                
            })            
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        size = CGSize(width: 128*3, height: 50*3)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            self.networking.getImageData(url: (self.jsonArray[indexPath.row] as! [String:String])["image"]!, callback: { (imageData) in
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.images[indexPath.row] = image
                    self.collectionView.reloadItems(at: [indexPath])
                }
                
                
            })
        }
    }
    
}

