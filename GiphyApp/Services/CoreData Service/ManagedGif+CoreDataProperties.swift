//
//  ManagedGif+CoreDataProperties.swift
//  GiphyApp
//
//  Created by asylzhan on 11/7/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedGif {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedGif> {
        return NSFetchRequest<ManagedGif>(entityName: "ManagedGif")
    }

    @NSManaged public var gifImage: NSData?

}
