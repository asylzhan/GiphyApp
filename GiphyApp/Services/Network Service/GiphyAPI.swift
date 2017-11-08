//
//  GiphyAPI.swift
//  GiphyApp
//
//  Created by asylzhan on 11/5/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//

import Foundation
import FLAnimatedImage

//typealias responseHandler = (_ response: @escaping ([Gif], Error?) -> Void)
protocol GiphyAPIProtocol
{
    func searchGifs(phrase: String, completion: @escaping ([Gif], Error?) -> Void)
}


// MARK: - GiphyAPI

/// _GiphyAPI_ is a struct responsible for general Giphy API configurations

struct GiphyAPI {
    static let key = "yi7GzFEfeWbLB7zRq04HJti8tRhnzHB3"
    static let baseURLString = "https://api.giphy.com"
    static let searchPath = "/v1/gifs/search"
}

// MARK: - GiphyAPIError

/// _GiphyAPIError_ is an enumeration for gifs errors
///
/// - generic:         Generic error
/// - invalidURL:      Invalid URL error
/// - invalidResponse: Invalid response
enum GiphyAPIError: Error {
    case generic
    case invalidURL
    case invalidResponse
}

// MARK: - GiphyAPIEndPoint

/// _GiphyAPIEndPoint_ is an enumeration of all Giphy gif types of API requests
///
/// - searchGif:  Search all GIPHY GIFs for a word or phrase request
enum GiphyAPIEndPoint {
    case searchGif(String)
}

// MARK: - URLConvertible

/// _URLConvertible_ is a protocol to implement urls
protocol URLConvertible {
    
    func url() -> URL?
}


extension GiphyAPIEndPoint: URLConvertible {
    func url() -> URL? {
        switch self {
        case .searchGif(let phrase):
            return URL(string: "\(GiphyAPI.baseURLString)\(GiphyAPI.searchPath)?api_key=\(GiphyAPI.key)&q=\(phrase)")
        }
    }
}
