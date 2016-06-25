//
//  PlannedActivity+CoreDataProperties.swift
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

extension PlannedActivity {

    @NSManaged var activityID: NSNumber?
    @NSManaged var descriptor: String?
    @NSManaged var days: NSSet?

}
