//
//  NetworkService.swift
//  GiphyApp
//
//  Created by asylzhan on 11/5/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FLAnimatedImage

struct APIService: GiphyAPIProtocol {
    /// Fetches all gifs by searching phrase
    ///
    /// - phrase: searching word query or phrase
    /// - completion: The completion block
    
    func searchGifs(phrase: String, completion: @escaping ([Gif], Error?) -> Void) {
        guard let url = GiphyAPIEndPoint.searchGif(phrase).url() else {
            completion([], GiphyAPIError.invalidURL)
            return
        }
        let queue = DispatchQueue(label: "com.giphy.api.searching", qos: .background, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
        Alamofire.request(url).responseJSON(queue: queue, options: []) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)["data"].arrayValue
                let gifs = json.map { Gif(json: $0) }
                
//                let _ = gifs.map { FLAnimatedImage(animatedGIFData: try! Data(contentsOf: URL(string: $0.url)!), optimalFrameCacheSize: 1, predrawingEnabled: false) }
                    completion(gifs, nil)
            case .failure(_):
                completion([], GiphyAPIError.invalidResponse)
            }
        }
    }
    
    /// Fetches trending gifs
    ///
    /// - completion: The completion block
    
    func fetchTrendingGifs(completion: @escaping ([Gif], Error?) -> Void) {
        guard let url = GiphyAPIEndPoint.fetchTrendingGifs().url() else {
            completion([], GiphyAPIError.invalidURL)
            return
        }
        
        let queue = DispatchQueue(label: "com.giphy.api.trending", qos: .background, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
        
        Alamofire.request(url).responseJSON(queue: queue, options: []) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)["data"].arrayValue
                let gifs = json.map { Gif(json: $0) }
                completion(gifs, nil)
            case .failure(_):
                completion([], GiphyAPIError.invalidResponse)
            }
        }
    }
    
    func fetchAnimatedImages(urls: [String], completion: @escaping ([FLAnimatedImage], Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let imagesData = urls.flatMap {  FLAnimatedImage(animatedGIFData: try! Data(contentsOf: URL(string: $0)!), optimalFrameCacheSize: 1, predrawingEnabled: false) }
            completion(imagesData, nil)
        }
    }
    
    func fetchImagesData(urls: [String], completion: @escaping ([Data], Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imagesData = urls.flatMap { try? Data(contentsOf: URL(string: $0)!) }
            completion(imagesData, nil)
        }
    }
    
}

// MARK: Reachability of network connection

class Reachability {
    /// Checks connection of internet. Returns true if connected to the internet, otherwise false.
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
