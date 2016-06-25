import Foundation

public enum WeeklyActivity {
  
  case Sunday([TimeOfDay])
  case Monday([TimeOfDay])
  case Tuesday([TimeOfDay])
  case Wednesday([TimeOfDay])
  case Thursday([TimeOfDay])
  case Friday([TimeOfDay])
  case Saturday([TimeOfDay])
  
  static func activityDates(fromActivityTimes activityTimes: [TimeOfDay], forWeekDay weekDay: Int) -> [NSDate]{
    var activityDates: [NSDate] = []
    for activityTime in activityTimes {
      activityTime.dateComponents.weekday = 1
      activityDates.append(activityTime.toNSDate())
    }
  return activityDates
  }
  
  static func allActivityDates(fromActivityTimes: [TimeOfDay]) {
    
  }
  
  func weekDayNumber() -> Int {
    switch self {
    case .Sunday:
      return 1
    case .Monday:
      return 2
    case .Tuesday:
      return 3
    case .Wednesday:
      return 4
    case .Thursday:
      return 5
    case .Friday:
      return 6
    case .Saturday:
      return 7
    }
  }
  
  func activityDates() -> [NSDate] {
  
    switch self {
    case .Sunday(let activityTimes):
     return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 1)
    case .Monday(let activityTimes):
      return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 2)
    case .Tuesday(let activityTimes):
      return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 3)
    case .Wednesday(let activityTimes):
      return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 4)
    case .Thursday(let activityTimes):
      return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 5)
    case .Friday(let activityTimes):
      return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 6)
    case .Saturday(let activityTimes):
      return WeeklyActivity.activityDates(fromActivityTimes: activityTimes, forWeekDay: 7)
    }
  }
  
  func notificationsForActivityTimes(activityTimes: [TimeOfDay]) {
    
  }
  
}
