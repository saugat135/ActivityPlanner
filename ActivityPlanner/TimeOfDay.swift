import Foundation

enum Hour: Int {
  case one = 1
  case two
  case three
  case four
  case five
  case six
  case seven
  case eight
  case nine
  case ten
  case eleven
  case twelve
  
}

typealias Minute = Int

infix operator -- { associativity left precedence 139 }

func -- (startTime: TimeOfDay, endTime: TimeOfDay) -> TimeInterval {
  return (startTime, endTime)
}

//infix operator ^ { associativity left precedence 140 }
//
//func ^(hour: Int, meridian: Meridian) -> TimeOfDay! {
//  guard let hour = Hour(rawValue: hour) else { return nil }
//  return TimeOfDay(hour: hour, minute: minute, meridian: meridian)
//}

infix operator • { associativity left precedence 140 }
func •(hour: Int, minute: Int) -> TimeOfDay {
  return TimeOfDay(hour: hour, minute: minute)
}

// Operator overloading for conformance with Comparable protocol
func ==(lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
  return lhs.hashValue() == rhs.hashValue()
}

func <(lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
  return lhs.hashValue() < rhs.hashValue()
}

func >(lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
  return lhs.hashValue() > rhs.hashValue()
}

struct TimeOfDay: Comparable {
  
  enum Meridian: String {
    case AM = "am"
    case PM = "pm"
  }
  
  var hour: Int
  var minute: Int
  var meridian: Meridian
  
  private func dateComponents() -> NSDateComponents {
    let component = NSDateComponents()
    let calendar = NSCalendar.currentCalendar()
    
    component.calendar = calendar
    
    component.hour = self.convertTo24Hour()
    component.minute = 0
    component.second = 0
    return component
  }
  
  func toNSDate() -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    return calendar.dateFromComponents(self.dateComponents())!
  }
  
  func hashValue() -> Int {
    return self.convertTo24Hour()
  }
  
  func convertTo24Hour() -> Int {
    switch self.meridian {
    case .PM:
      if hour != 12 {
        return hour + 12
      } else {
        return hour
      }
    case .AM:
      if hour == 12 {
        return 0
      } else {
        return hour
      }
    }
  }
  
  init(hour: Int, minute: Minute) {
    
    let component = NSDateComponents()
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    component.calendar = calendar
    component.hour = hour
    component.minute = minute
    component.second = 0
    
    let date = calendar.dateFromComponents(component)
    let hour = calendar.component(.Hour, fromDate: date!)
    let min = calendar.component(.Minute, fromDate: date!)
    let sec = calendar.component(.Second, fromDate: date!)
    
    self.hour = hour
    self.minute = min
    if hour == 0 {
      self.meridian = .PM
    } else if hour > 12 {
      self.meridian = .PM
    } else {
      self.meridian = .AM
    }
  }
}
