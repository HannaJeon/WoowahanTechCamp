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
    var jsonArray = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self

        networking.getJsonData(url: "http://125.209.194.123/doodle.php")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(saveImageData), name: NSNotification.Name("getImage"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(saveJsonData(_:)), name: NSNotification.Name("getJsonData"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveJsonData(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String:[[String:Any]]] {
            jsonArray = userInfo["jsonData"]!
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        cell.numberLabel.text = String(indexPath.row+1)

        self.networking.getImageData(url: self.jsonArray[indexPath.row]["image"]! as! String, callback: { (imageData) in
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.imageView.image =  image
            }
        })
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 50)
    }
    
}

