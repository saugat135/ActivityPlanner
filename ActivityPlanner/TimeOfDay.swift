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

enum Meridian: String {
  case AM = "am"
  case PM = "pm"
}

infix operator -- { associativity left precedence 139 }

func -- (startTime: TimeOfDay, endTime: TimeOfDay) -> TimeInterval {
  return (startTime, endTime)
}

infix operator ^ { associativity left precedence 140 }

func ^ (hour: Int, meridian: Meridian) -> TimeOfDay! {
  guard let hour = Hour(rawValue: hour) else { return nil }
  return TimeOfDay(hour: hour, meridian: meridian)
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
  
  var hour: Hour
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
      if hour.rawValue != 12 {
        return hour.rawValue + 12
      } else {
        return hour.rawValue
      }
    case .AM:
      if hour.rawValue == 12 {
        return 0
      } else {
        return hour.rawValue
      }
    }
  }
  
  init(hour: Hour, meridian: Meridian) {
    self.hour = hour
    self.meridian = meridian
  }
  
  subscript(hour: String, meridian: String) -> TimeOfDay {
    get {
      assert((hour == "hour" && meridian == "meridian"), "The provided key does not match")
      return TimeOfDay(hour: self.hour, meridian: self.meridian)
    }
    set {
      self.hour = newValue.hour
      self.meridian = newValue.meridian
    }
  }
}
