import Foundation

typealias TimeInterval = (startTime: TimeOfDay, endTime: TimeOfDay)

enum ActivityTime: Int {

  case earlyMorning = 1
  case morning = 2 // Start of the day is assumed to be early morning by default
  case lateMorning = 3
  case afternoon = 4
  case lateAfternoon = 5
  case earlyEvening = 6
  case evening = 7
  case night = 8
  case latenight = 9
  case midnight = 10
  case afterMidnight = 11

  static func allActivityTimes() ->[ActivityTime] {
    return [
      .earlyMorning,
      .morning, // Start of the day is assumed to be early morning by default
      .lateMorning,
      .afternoon,
      .lateAfternoon,
      .earlyEvening,
      .evening,
      .night,
      .latenight,
      .midnight,
      .afterMidnight
    ]
  }

  func stringValue() -> String {
    switch self {
    case .earlyMorning:
      return "Early Morning"
    case .morning:
      return "Morning"
    case .lateMorning:
      return "Late Morning"
    case .afternoon:
      return "Afternoon"
    case .lateAfternoon:
      return "Late Afternoon"
    case .earlyEvening:
      return "Early Evening"
    case .evening:
      return "Evening"
    case .night:
      return "Night"
    case .latenight:
      return "Late Night"
    case .midnight:
      return "Midnight"
    case .afterMidnight:
      return "After Midnight"
    }
  }

  func timeIntervalString() -> String {
    switch self {
    case .earlyMorning: return "6am - 8am"
    case .morning: return "8am - 10am"
    case .lateMorning: return "10am - 12pm"
    case .afternoon: return "12pm - 2pm"
    case .lateAfternoon: return "2pm - 4pm"
    case .earlyEvening: return "4pm - 6pm"
    case .evening: return "6pm - 8pm"
    case .night: return "8pm - 10pm"
    case .latenight: return "10pm - 12am"
    case .midnight: return "12am - 2am"
    case .afterMidnight: return "2am - 6am"
    }
  }
  
  static func activityTime(fromTimeInterval interval: TimeInterval) -> ActivityTime {
    let activityTimes = ActivityTime.allActivityTimes().filter({
      $0.timeInterval() == interval
    
    }).map({ $0 })
    return activityTimes[0]
  }
  
  static func timeIntervalFromCurrentTime() -> TimeInterval? {
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    
    let hourComponent = calendar.component(.Hour, fromDate: NSDate())
    let minuteComponent = calendar.component(.Minute, fromDate: NSDate())
    
    let timeOfDay = TimeOfDay(hour: hourComponent, minute: minuteComponent)
    let activityTime = ActivityTime.allActivityTimes().filter {
      return timeOfDay <= $0.timeInterval().endTime
      }.map{ $0 }
    return activityTime.first?.timeInterval()
  }
  
  static func activityTimeFromCurrentTime() -> ActivityTime? {
    guard let currentTmeIterval = timeIntervalFromCurrentTime() else { return nil }
    return activityTime(fromTimeInterval: currentTmeIterval)
  }

  func timeInterval() -> TimeInterval {

    switch self {
    case .earlyMorning:
      return 6•00 -- 8•00
    case .morning:
      return 8•00 -- 10•00
    case .lateMorning:
      return 10•00 -- 12•00
    case .afternoon:
      return 12•00 -- 14•00
    case .lateAfternoon:
      return 14•00 -- 16•00
    case .earlyEvening:
      return 16•00 -- 18•00
    case .evening:
      return 18•00 -- 20•00
    case .night:
      return 20•00 -- 22•00
    case .latenight:
      return 22•00 -- 00•00
    case .midnight:
      return 00•00 -- 2•00
    case .afterMidnight:
      return 2•00 -- 6•00
    }
  }

  typealias DateInterval = (startDate: NSDate, endDate: NSDate)
  
  func dateInterval() -> DateInterval {
    let start = self.timeInterval().startTime.toNSDate()
    let end = self.timeInterval().endTime.toNSDate()
    return (start, end)
  }
  
  func sortIndex() -> Int {
    switch self {
    case .earlyMorning: return 0
    case .morning: return 1
    case .lateMorning: return 2
    case .afternoon: return 3
    case .lateAfternoon: return 4
    case .earlyEvening: return 5
    case .evening: return 6
    case .night: return 7
    case .latenight: return 8
    case .midnight: return 9
    case .afterMidnight: return 10
    }
  }

}
