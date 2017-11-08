//
//  DataService.swift
//  GiphyApp
//
//  Created by asylzhan on 11/5/17.
//  Copyright © 2017 asylzhan. All rights reserved.
//

import Foundation
import FLAnimatedImage
import CoreData

extension ManagedGif {
    
    func fromGif(imageData: Data) {
        gifImage = imageData as NSData
    }
    
    func toGif() -> Data {
        return gifImage! as Data
    }
}

final class GifCoreDataWorker: GifWorkerAPI {
    
    // MARK: - Object lifecycle
    
    let entityName = "ManagedGif"
    let persistentContainerName = "GiphyApp"
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer =
        {
            let container = NSPersistentContainer(name: persistentContainerName)
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
    }()
    
    var managedObjectContext: NSManagedObjectContext
    {
        return persistentContainer.viewContext
    }
    
    // MARK: CRUD
    
    func save() {
        let fetch = NSFetchRequest<ManagedGif>(entityName: entityName)

        fetch.predicate = NSPredicate(format: "gifImage != nil")
        
        let count = try! managedObjectContext.count(for: fetch)
        
//        if count > 0 {
//            deleteAllRecords()
//        }
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addNew(gifData: Data) {
        let managedEvent = ManagedGif(context: managedObjectContext)
        managedEvent.gifImage = gifData as NSData
        save()
    }
    
    func allGifLists(completion: ([Data]) -> Void) {
        let request = NSFetchRequest<ManagedGif>(entityName: entityName)
        do {
            let results = try managedObjectContext.fetch(request)
            let data = results.map { $0.toGif() }
            completion(data)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            print ("There was an error while deleting!")
        }
    }
    
    //    func show(at indexPath: IndexPath) -> Gif
    //    {
    //        return fetchedResultsController.object(at: indexPath).toEvent()
    //    }
}
