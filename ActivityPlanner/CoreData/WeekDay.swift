//
//  WeekDay.swift
//  ActivityPlanner
//
//  Created by Anmol on 6/25/16.
//  Copyright © 2016 Saugat Gautam. All rights reserved.
//

import Foundation
import CoreData

enum DayOfWeek: Int {
    case Sunday = 1, Monday, Tuesday, Wednesday, Thrusday, Friday, Saturday

    var name: String {
        return "\(self)"
    }

    static func dayName(index: Int) -> String? {
        return DayOfWeek.init(rawValue: index)?.name
    }
}

@objc(WeekDay)
class WeekDay: NSManagedObject {

    func addDateToDay(date: NSDate) {
        let dateTimeOfDay = CoreDataHelper.sharedInstance.createDateTimeOfDay(date)
        self.time = self.time?.setByAddingObject(dateTimeOfDay)
        CoreDataHelper.sharedInstance.saveMainContext()
    }

    func getAllTimes() -> [DateTimeOfDay] {
        guard let timeArray = self.time!.allObjects as? [DateTimeOfDay] else { return [] }
        let sortedTime = timeArray.sort { $0.0.dateTime!.compare(($0.1.dateTime!)) == NSComparisonResult.OrderedAscending }
        return sortedTime
    }

// Insert code here to add functionality to your managed object subclass

}
