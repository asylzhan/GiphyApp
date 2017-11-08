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
    private var manager: GifAnimatedManager = GifAnimatedManager.shared

    /// Fetches all gifs by searching phrase
    ///
    /// - phrase: searching word query or phrase
    /// - completion: The completion block
    
    func searchGifs(phrase: String, completion: @escaping ([Gif], Error?) -> Void) {
        guard let url = GiphyAPIEndPoint.searchGif(phrase).url() else {
            completion([], GiphyAPIError.invalidURL)
            return
        }
        
        Alamofire.request(url).responseJSON { response in
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
    
}

// MARK: Reachability of network connection

class Reachability {
    /// Checks connection of internet. Returns true if connected to the internet, otherwise false.
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
