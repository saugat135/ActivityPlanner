//
//  PlannedActivity.swift
//  ActivityPlanner
//
//  Created by Anmol on 6/25/16.
//  Copyright © 2016 Saugat Gautam. All rights reserved.
//

import Foundation
import CoreData

/*

 Use Case
 let plannedActivity = CoreDataHelper.sharedInstance.createOrUpdatePlannedActivity(1)
 print(plannedActivity.sevenDays[3].dayName)
 plannedActivity.sevenDays[3].addDateToDay(NSDate())
 CoreDataHelper.sharedInstance.saveMainContext()

*/

@objc(PlannedActivity)
class PlannedActivity: NSManagedObject {

    var sevenDays: [WeekDay] {
        guard let daysArray = self.days!.allObjects as? [WeekDay] else { return [] }
        let sortedDays = daysArray.sort { $0.0.dayID?.intValue < $0.1.dayID?.intValue }
        return sortedDays
    }


// Insert code here to add functionality to your managed object subclass

}
