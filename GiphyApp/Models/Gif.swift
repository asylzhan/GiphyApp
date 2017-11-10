//
//  Gif.swift
//  GiphyApp
//
//  Created by asylzhan on 11/5/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//

import Foundation
import SwiftyJSON
import FLAnimatedImage
import Alamofire


struct Gif {
    let id: String
    let url: String
}

extension Gif {
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.url = json["images"]["fixed_width"]["url"].stringValue
    }
}
