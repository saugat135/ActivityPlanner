import Foundation

struct ActivityPlan {
  
  var sundayActivity: WeeklyActivity = WeeklyActivity.Sunday([])
  var mondayActivity: WeeklyActivity = WeeklyActivity.Monday([])
  var tuesdayActivity: WeeklyActivity = WeeklyActivity.Tuesday([])
  var wednesdayActivity: WeeklyActivity = WeeklyActivity.Wednesday([])
  var thursdayActivity: WeeklyActivity = WeeklyActivity.Thursday([])
  var fridayActivity: WeeklyActivity = WeeklyActivity.Friday([])
  var saturdayActivity: WeeklyActivity = WeeklyActivity.Saturday([])
  
  let activityName: String
  let activityID: Int
  var shouldEnableNotification = true
  
  init(activityID: Int, activityName: String, shouldEnableNotification: Bool = true) {
    self.activityName = activityName
    self.activityID = activityID
    self.shouldEnableNotification = shouldEnableNotification
  }
  
  init(activityID: Int, activityName: String, shouldEnableNotification: Bool = true, activitiesInWeek: [[TimeOfDay]]) {
    self.activityName = activityName
    self.activityID = activityID
    self.shouldEnableNotification = shouldEnableNotification

    sundayActivity = WeeklyActivity.Sunday(activitiesInWeek[0])
    mondayActivity = WeeklyActivity.Monday(activitiesInWeek[1])
    tuesdayActivity = WeeklyActivity.Tuesday(activitiesInWeek[2])
    wednesdayActivity = WeeklyActivity.Wednesday(activitiesInWeek[3])
    thursdayActivity = WeeklyActivity.Thursday(activitiesInWeek[4])
    fridayActivity = WeeklyActivity.Friday(activitiesInWeek[5])
    saturdayActivity = WeeklyActivity.Saturday(activitiesInWeek[6])
  }
  
  func activateNotification() {
    
  }
  
}
