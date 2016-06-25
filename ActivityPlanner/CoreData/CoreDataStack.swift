import Foundation
import CoreData

class CoreDataStack: NSObject {
    static let moduleName = "Activity_Planner"

    func saveMainContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("Error saving main managed object context! \(error)")
            }
        }
    }

    // The managed object model for the application. This property is not optional.
    // It is a fatal error for the application not to be able to find and load its model.
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    // The directory the application uses to store the Core Data store file.
    // This code uses a directory named "com.supercarehealth.Video_Library" in
    // the application's documents Application Support directory.
    lazy var applicationDocumentsDirectory: NSURL = {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }()

    // The persistent store coordinator for the application.
    // This implementation creates and returns a coordinator, having added the store for the application to it.
    // This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    // Create the coordinator and store
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let persistentStoreURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(moduleName).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                configuration: nil,
                URL: persistentStoreURL,
                options: [NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true])
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            //* Replace this with code to handle the error appropriately.
            //* abort() causes the application to generate a crash log and terminate.
            //* We should not use this function in a shipping application,
            //* although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")

            //* If you encounter schema incompatibility errors during development,
            //* we can reduce their frequency by:
            //* Simply deleting the existing store:
            do {
                try NSFileManager.defaultManager().removeItemAtURL(persistentStoreURL)
            } catch {
                NSLog("Unresolved error \(error)")
            }
            fatalError("Persistent store error! \(error)")
        }
        return coordinator
    }()

    // Returns the managed object context for the application
    // (which is already bound to the persistent store coordinator for the application.)
    // This property is optional since there are legitimate error conditions that
    // could cause the creation of the context to fail.
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()

    var TimeStamp: NSTimeInterval {
        // return NSDate().timeIntervalSince1970
        return NSDate.timeIntervalSinceReferenceDate()
    }

}
