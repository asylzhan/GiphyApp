//
//  ListGifsInteractor.swift
//  GiphyApp
//
//  Created by asylzhan on 11/4/17.
//  Copyright (c) 2017 asylzhan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import FLAnimatedImage

protocol ListGifsBusinessLogic {
    func fetchTrendingGifs(request: ListGifs.FetchGifs.Request)
    func searchGif(request: ListGifs.FetchGifs.Request)
    func fetchManagedGifs(request: ListGifs.FetchManagedGifs.Request)
    func fetchImagesData(request: ListGifs.FetchGifs.Request)
}

protocol ListGifsDataStore {
    var gifs: [Gif]? { get }
    var gifData: [Data]? { get }
}

class ListGifsInteractor: ListGifsBusinessLogic, ListGifsDataStore {
    var presenter: ListGifsPresentationLogic?
    var worker: ListGifsWorker?
    var coreDataWorker: GifWorkerAPI?
    var gifs: [Gif]?
    var gifData: [Data]?
    
    
    /// Fetches trending gifs
    ///
    /// - request: Request of model
    func fetchTrendingGifs(request: ListGifs.FetchGifs.Request) {
        worker = ListGifsWorker()
        
        worker?.fetchTrendingGifs(completion: { gifs, error in
            self.gifs = gifs
            let response = ListGifs.FetchGifs.Response(gifs: gifs)
            self.presenter?.presentFetchedTrendingGifs(response: response)
        })
    }
    
    /// Fetches gifs by searching phrase
    ///
    /// - request: Request of model
    func searchGif(request: ListGifs.FetchGifs.Request) {
        worker = ListGifsWorker()
        
        worker?.searchGif(phrase: request.phrase, completion: { gifs, error in
            self.gifs = gifs
            let response = ListGifs.FetchGifs.Response(gifs: gifs)
            self.presenter?.presentFetchedSearchedGifs(response: response)
        })
    }
    
    /// Fetches all gifs from CoreData
    ///
    /// - request: Request of model
    func fetchManagedGifs(request: ListGifs.FetchManagedGifs.Request) {
        coreDataWorker = GifCoreDataWorker()
        
        coreDataWorker?.getGifs(completion: { data in
            self.gifData = data
            let response = ListGifs.FetchManagedGifs.Response(gifImages: data)
            self.presenter?.presentFetchedManagedGifs(response: response)
        })
        
    }
    
    func fetchImagesData(request: ListGifs.FetchGifs.Request) {
        worker = ListGifsWorker()
        coreDataWorker = GifCoreDataWorker()
        worker?.fetchImagesData(urls: request.urls, completion: { imagesData, error in
            self.coreDataWorker?.add(imagesData: imagesData)
        })
    }
}
