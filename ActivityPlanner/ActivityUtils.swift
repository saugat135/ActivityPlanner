import Foundation

struct ActivityUtils {

   static func activityTimesAccordingToFrequency(frequency: Int) -> [ActivityTime] {
      // Start with morning time
      // Divide the default activity times with the current frequency.
      // Map the activity times
      // Return
      guard frequency > 0 else { return [] }
      let totalActivityTime = ActivityTime.allActivityTimes().count + 1
      var activityTimes: [ActivityTime] = []
      let interval = totalActivityTime / frequency
      var currentInterval: Int = 0

      for _ in 1...frequency {
        if currentInterval > 10 {
          currentInterval = 10
        } else if currentInterval < 0 {
          currentInterval = 0
        }
        activityTimes.append(ActivityTime.allActivityTimes()[currentInterval])
        print(currentInterval)
        currentInterval = interval + currentInterval
      }
      return activityTimes
  }
  
}
