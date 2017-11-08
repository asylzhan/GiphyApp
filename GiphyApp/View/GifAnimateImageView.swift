//
//  GifAnimateImageView.swift
//  GiphyApp
//
//  Created by asylzhan on 11/8/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//

import UIKit
import FLAnimatedImage

let imageCache = NSCache<AnyObject, AnyObject>()

class GIFAnimateImageView: FLAnimatedImageView {
    var imageUrlString: String?
    
    func loadImage(_ mediaURL: String, completion: @escaping (Data) -> Void ) {
        imageUrlString = mediaURL
        
        let url = URL(string: "\(mediaURL)")
        
        animatedImage = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? FLAnimatedImage {
            self.animatedImage = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            completion(data!)
            DispatchQueue.main.async(execute: {
                
                let imageToCache = FLAnimatedImage(animatedGIFData: data, optimalFrameCacheSize: 160, predrawingEnabled: false)
                
                if self.imageUrlString == mediaURL {
                    self.animatedImage = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: url as AnyObject)
            })
            
        }).resume()
    }
    
    func loadImage(_ mediaURL: String) {
        imageUrlString = mediaURL
        
        let url = URL(string: "\(mediaURL)")
        
        animatedImage = nil
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? FLAnimatedImage {
            self.animatedImage = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                let imageToCache = FLAnimatedImage(animatedGIFData: data, optimalFrameCacheSize: 160, predrawingEnabled: false)
                
                if self.imageUrlString == mediaURL {
                    self.animatedImage = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: url as AnyObject)
            })
            
        }).resume()
    }
}

class GifAnimatedManager {
    
    static let shared = GifAnimatedManager()
    private init() {}
    
    func loadImage(_ mediaURL: String, completion: @escaping () -> FLAnimatedImage) {
        let url = URL(string: "\(mediaURL)")
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            let imageData = FLAnimatedImage(animatedGIFData: data, optimalFrameCacheSize: 1, predrawingEnabled: false)
            
        }).resume()
    }
    
}

