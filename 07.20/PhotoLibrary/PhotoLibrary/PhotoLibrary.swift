//
//  PhotoLibrary.swift
//  PhotoLibrary
//
//  Created by HannaJeon on 2017. 7. 20..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation
import Photos

class PhotoLibrary {
    private var imageManager: PHImageManager
    private var requestOptions: PHImageRequestOptions
    private var fetchOptions: PHFetchOptions
    private var fetchResult: PHFetchResult<PHAsset>
    private var videoRequestOptions: PHVideoRequestOptions
    internal private(set) var count: Int
    
    init() {
        imageManager = PHImageManager.default()
        requestOptions = PHImageRequestOptions()
        videoRequestOptions = PHVideoRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        count = fetchResult.count
    }
    
    func setPhoto(at index: Int, callback: @escaping (UIImage?) -> Void) {
        if index < fetchResult.count {
            imageManager.requestImage(for: fetchResult.object(at: index), targetSize: CGSize(width: 200, height: 300), contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, _) in
                callback(image)
            })
        }
    }
    
    func setVideo(at index: Int, callback: @escaping (AVPlayerItem?) -> Void) {
        let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        imageManager.requestPlayerItem(forVideo: fetchResult.object(at: index), options: videoRequestOptions, resultHandler: { (item, _) in
            callback(item)
        })
    }
    
}
