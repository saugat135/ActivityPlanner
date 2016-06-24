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
        let timeOfDay = CoreDataHelper.sharedInstance.createTimeOfDay(date)
        self.time?.setByAddingObject(timeOfDay)
    }

// Insert code here to add functionality to your managed object subclass

}
