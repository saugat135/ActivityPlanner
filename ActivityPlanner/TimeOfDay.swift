import Foundation

infix operator -- { associativity left precedence 139 }

func -- (startTime: TimeOfDay, endTime: TimeOfDay) -> TimeInterval {
  return (startTime, endTime)
}

infix operator • { associativity left precedence 140 }
func •(hour: Int, minute: Int) -> TimeOfDay {
  return TimeOfDay(hour: hour, minute: minute)
}

// Operator overloading for conformance with Comparable protocol
public func ==(lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
  return lhs.hour == rhs.hour &&
         lhs.minute == rhs.minute
}

public func <(lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
  return lhs.hour < rhs.hour
}

public func >(lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
  return lhs.hour > rhs.hour
}

public struct TimeOfDay: Comparable {
  
  enum Meridian: String {
    case AM = "am"
    case PM = "pm"
  }
  
  var hour: Int
  var minute: Int
  lazy var meridian: Meridian = {
    if self.hour == 0 {
      return .PM
    } else if self.hour > 12 {
      return .PM
    } else {
      return .AM
    }
  }()
  var dateComponents: NSDateComponents
  
  func toNSDate() -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    return calendar.dateFromComponents(self.dateComponents)!
  }
  
  init(fromDate date: NSDate) {
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    
    let hourComponent = calendar.component(.Hour, fromDate: date)
    let minuteComponent = calendar.component(.Minute, fromDate: date)
    
    self.hour = hourComponent
    self.minute = minuteComponent
    
    self.dateComponents = NSDateComponents(date: date, calendar: calendar)
    
  }
  
  init(hour: Int, minute: Int) {
    
    let component = NSDateComponents()
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    component.calendar = calendar
    component.hour = hour
    component.minute = minute
    component.second = 0
    
    let date = calendar.dateFromComponents(component)
    let hour = calendar.component(.Hour, fromDate: date!)
    let min = calendar.component(.Minute, fromDate: date!)
    
    self.hour = hour
    self.minute = min
    
    self.dateComponents = component
  }
}
