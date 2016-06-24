import Foundation

struct DateComponents {
  
  static func sharedDateComponents() -> NSDateComponents {
    let dateComponents = NSDateComponents()
    dateComponents.calendar = self.sharedCalendar()
    return dateComponents
  }
  
  private static func sharedCalendar() -> NSCalendar? {
    return NSCalendar(identifier: NSCalendarIdentifierGregorian)
  }
  
}

