//
//  GifWorkerAPI.swift
//  GiphyApp
//
//  Created by asylzhan on 11/8/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//

import Foundation
import FLAnimatedImage

protocol GifWorkerAPI {
    func allGifLists(completion: ([Data]) -> Void)
    func addNew(gifData: Data)
}
