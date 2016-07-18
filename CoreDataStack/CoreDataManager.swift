//
//  CoreDataManager.swift
//  CoreDataStack
//
//  Created by Bart Jacobs on 17/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import CoreData
import Foundation

public class CoreDataManager {

    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data Stack

    public private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel? = {
        // Fetch Model URL
        guard let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd") else {
            return nil
        }

        // Initialize Managed Object Model
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)

        return managedObjectModel
    }()

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = self.managedObjectModel else {
            return nil
        }

        // Helper
        let persistentStoreURL = self.persistentStoreURL

        // Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistentStoreURL, options: options)

        } catch {
            let addPersistentStoreError = error as NSError

            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }

        return persistentStoreCoordinator
    }()

    // MARK: - Computed Properties

    private var persistentStoreURL: NSURL {
        // Helpers
        let storeName = "\(modelName).sqlite"
        let fileManager = NSFileManager.defaultManager()

        let documentsDirectoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]

        return documentsDirectoryURL.URLByAppendingPathComponent(storeName)
    }

}
