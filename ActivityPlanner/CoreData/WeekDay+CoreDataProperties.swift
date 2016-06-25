//
//  WeekDay+CoreDataProperties.swift
//  ActivityPlanner
//
//  Created by Anmol on 6/25/16.
//  Copyright © 2016 Saugat Gautam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WeekDay {

    @NSManaged var dayID: NSNumber?
    @NSManaged var dayName: String?
    @NSManaged var time: NSSet?
    @NSManaged var forPlannedActivity: PlannedActivity?
    
}
