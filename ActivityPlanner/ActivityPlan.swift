import Foundation

struct ActivityPlan {
  
  var sundayActivity: WeeklyActivity = WeeklyActivity.Sunday([])
  var mondayActivity: WeeklyActivity = WeeklyActivity.Monday([])
  var tuesdayActivity: WeeklyActivity = WeeklyActivity.Tuesday([])
  var wednesdayActivity: WeeklyActivity = WeeklyActivity.Wednesday([])
  var thursdayActivity: WeeklyActivity = WeeklyActivity.Thursday([])
  var fridayActivity: WeeklyActivity = WeeklyActivity.Friday([])
  var saturdayActivity: WeeklyActivity = WeeklyActivity.Saturday([])
  
  var weeklyActivities: [WeeklyActivity] {
    get {return [sundayActivity, mondayActivity, tuesdayActivity, wednesdayActivity, thursdayActivity, fridayActivity, saturdayActivity]
    }
    set {
      self.weeklyActivities = newValue
    }
  }
  
  let activityName: String
  let activityID: Int
  var shouldEnableNotification = true
  private var notificationItems: [TodoItem] = []
  
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
    
    if shouldEnableNotification {
      for i in 0..<7 {
        for timeOfDay in activitiesInWeek[i] {
          let item = TodoItem(deadline: timeOfDay.toNSDate(), title: self.activityName, UUID: String(self.activityID))
          self.notificationItems.append(item)
          TodoList.sharedInstance.addItem(item)
        }
      }
    }
  }
  
  func removeNotifications() {
    for item in self.notificationItems {
      TodoList.sharedInstance.removeItem(item)
    }
  }
  
}
