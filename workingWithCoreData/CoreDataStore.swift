//
//  CoreDataStore.swift
//  workingWithCoreData
//
//  Created by Johann Kerr on 3/15/17.
//  Copyright © 2017 Johann Kerr. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataStore {
    static let shared = CoreDataStore()
    private init(){}
    
    var savedTaskArray = [Task]()
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "workingWithCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func saveTask(_ taskString: String) {
        let context = persistentContainer.viewContext
        let task = Task(context: context)
        task.content = taskString
        getTasks()
        
    }
    
    func getTasks() {
        let context = persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
        do {
            self.savedTaskArray = try context.fetch(fetchRequest)

        } catch {
            
        }
        
    }
    
    
    func deleteTask(_ task:Task) {
        let context = self.persistentContainer.viewContext
        
        context.delete(task)
        saveContext()
        getTasks()
        
    }


    
    
    
    
    
}
