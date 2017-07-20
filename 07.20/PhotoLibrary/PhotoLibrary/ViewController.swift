            //
//  ViewController.swift
//  PhotoLibrary
//
//  Created by HannaJeon on 2017. 7. 20..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let photoLibrary = PhotoLibrary()
    var images = [Int:UIImage]()
    var selectedImage = [UIImage]()
    var videoItems = [AVPlayerItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true

        NotificationCenter.default.addObserver(self, selector: #selector(getVideo), name: NSNotification.Name("savedVideo"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        let settings = RenderSettings(imagesCount: selectedImage.count)
        let imageAnimator = ImageAnimator(renderSettings: settings, image: selectedImage)
        imageAnimator.render()
    }
    
    func getVideo() {
        photoLibrary.setVideo(at: 0) { (item) in
            if let video = item {
                self.videoItems.append(video)
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        photoLibrary.setPhoto(at: indexPath.row) { (image) in
            if let _image = image {
                cell.imageView.image = _image
                self.images[indexPath.row] = _image
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoLibrary.count + videoItems.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage.append(images[indexPath.row]!)
        
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let index = selectedImage.index(of: images[indexPath.row]!)
        selectedImage.remove(at: index!)
    }
    
}
