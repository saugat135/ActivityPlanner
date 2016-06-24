import Foundation
import CoreData

enum CoreDataEntity: String {
    case Video = "Video"

    func shortDescriptor() -> NSSortDescriptor {
        let key: String
        switch self {
        case Video:
            key = "videoID"
        }
        return NSSortDescriptor(key: key, ascending: true)
    }
}

class Video {
    // Dummy class
}

class CoreDataHelper: CoreDataStack {

    // Singleton
    static let sharedInstance = CoreDataHelper()

    // MARK: - Entity Description

    func videoEntity() -> NSEntityDescription? {
        if let entity = NSEntityDescription.entityForName(CoreDataEntity.Video.rawValue, inManagedObjectContext: managedObjectContext) {
            return entity
        }
        return nil
    }

    // MARK: - Fetched Results and FRController

    func videoForID(videoID: Int) -> Video? {
        let fetchRequest = NSFetchRequest(entityName: CoreDataEntity.Video.rawValue)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "orderID", ascending: true)
        ]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchRequest.predicate = NSPredicate(format: "videoID == \(videoID)")
        do {
            try fetchedResultsController.performFetch()
        } catch let fetchError as NSError {
            print("fetchError ", fetchError)
        }
        return fetchedResultsController.fetchedObjects?.first as? Video
    }

    func videoFetchRC() -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(entityName: CoreDataEntity.Video.rawValue)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "orderID", ascending: true)
        ]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        fetchRequest.predicate = NSPredicate(format: "deleteFlag == 0")
        do {
            try fetchedResultsController.performFetch()
        } catch let fetchError as NSError {
            print("fetchError ", fetchError)
        }
        return fetchedResultsController
    }

    func videoFetchObjects() -> NSArray? {
        return videoFetchRC()?.fetchedObjects
    }

    /**
     This method will insert Video Object from WebService
     - parameter dictionary: NSDictionary
     */
    func insertVideo(dictionary: NSDictionary) {
        if let videoID = Int(dictionary.objectForKey("id") as! String) {
            let video: Video!
            if let oldVideo = videoForID(videoID) {
                video = oldVideo
            } else {
//                video = Video(entity: videoEntity()!, insertIntoManagedObjectContext: managedObjectContext)
                /* Only add or update TimeStamp if its a new video */
//                video.addedDate = TimeStamp
            }
//            video.videoFromDictionary(dictionary)

            saveMainContext()
        }
    }

}
