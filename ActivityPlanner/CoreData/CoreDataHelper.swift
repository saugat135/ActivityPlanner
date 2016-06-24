import Foundation
import CoreData

enum CoreDataEntity: String {
    case PlannedActivity = "PlannedActivity"
    case WeekDay = "WeekDay"
    case DateTimeOfDay = "DateTimeOfDay"
}

class CoreDataHelper: CoreDataStack {

    // Singleton
    static let sharedInstance = CoreDataHelper()

    // MARK: - Entity Description

    func plannedActivityEntity() -> NSEntityDescription? {
        if let entity = NSEntityDescription.entityForName(CoreDataEntity.PlannedActivity.rawValue, inManagedObjectContext: managedObjectContext) {
            return entity
        }
        return nil
    }

    func weekDayEntity() -> NSEntityDescription? {
        if let entity = NSEntityDescription.entityForName(CoreDataEntity.WeekDay.rawValue, inManagedObjectContext: managedObjectContext) {
            return entity
        }
        return nil
    }

    func DateTimeOfDayEntity() -> NSEntityDescription? {
        if let entity = NSEntityDescription.entityForName(CoreDataEntity.DateTimeOfDay.rawValue, inManagedObjectContext: managedObjectContext) {
            return entity
        }
        return nil
    }

    // MARK: - Fetched Results and FRController

    func plannedActivityForID(activityID: Int) -> PlannedActivity? {
        let fetchRequest = NSFetchRequest(entityName: CoreDataEntity.PlannedActivity.rawValue)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "activityID", ascending: true)
        ]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchRequest.predicate = NSPredicate(format: "activityID == \(activityID)")
        do {
            try fetchedResultsController.performFetch()
        } catch let fetchError as NSError {
            print("fetchError ", fetchError)
        }
        return fetchedResultsController.fetchedObjects?.first as? PlannedActivity
    }

    func plannedActivityFetchRC() -> NSFetchedResultsController? {
        let fetchRequest = NSFetchRequest(entityName: CoreDataEntity.PlannedActivity.rawValue)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "activityID", ascending: true)
        ]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let fetchError as NSError {
            print("fetchError ", fetchError)
        }
        return fetchedResultsController
    }

    func plannedActivityFetchObjects() -> NSArray? {
        return plannedActivityFetchRC()?.fetchedObjects
    }

    func allPlannedActivity() -> [PlannedActivity]? {
        return plannedActivityFetchObjects() as? [PlannedActivity]
    }

    private func create7DaysOfAWeek() -> [WeekDay] {
        var weekDays = [WeekDay]()

        for i in 1...7 {
            let weekDay = WeekDay(entity: weekDayEntity()!, insertIntoManagedObjectContext: managedObjectContext)
            weekDay.dayID = i
            weekDay.dayName = DayOfWeek.dayName(i)
            weekDays.append(weekDay)
        }

        return weekDays

    }

    func createDateTimeOfDay(dateTime: NSDate) -> DateTimeOfDay {
        let timeOfDay = DateTimeOfDay(entity: DateTimeOfDayEntity()!, insertIntoManagedObjectContext: managedObjectContext)
        timeOfDay.dateTime = dateTime
        return timeOfDay
    }

    func createOrUpdatePlannedActivity(activityID: Int) {

        if let oldPlannedActivity = plannedActivityForID(activityID) {

        } else {
            let plannedActivity = PlannedActivity(entity: plannedActivityEntity()!, insertIntoManagedObjectContext: managedObjectContext)
            plannedActivity.activityID = activityID
            plannedActivity.days = NSSet(array: create7DaysOfAWeek())
        }

        saveMainContext()
    }

}
