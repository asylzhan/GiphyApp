//
//  ShowGifRouter.swift
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

@objc protocol ShowGifRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowGifDataPassing {
    var dataStore: ShowGifDataStore? { get }
}

class ShowGifRouter: NSObject, ShowGifRoutingLogic, ShowGifDataPassing {
    weak var viewController: ShowGifViewController?
    var dataStore: ShowGifDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ShowGifViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ShowGifDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}