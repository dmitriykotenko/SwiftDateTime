//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.

import Foundation


public class TestClock: Clock {
  
  public private(set) var now: DateTime
  
  private let datesManipulator = DatesManipulator()
  private let dateTimesManipulator = DateTimesManipulator()
  
  init(_ dateTime: DateTime) {
    now = dateTime
  }
  
  func add(_ duration: Duration) {
    now = dateTimesManipulator.dateTime(now, plus: duration)
  }
  
  func add(_ duration: CalendarDuration) {
    let newDate = datesManipulator.date(now.date, plus: duration)
    
    now = now.copy(date: newDate)
  }
  
  func set(_ dateTime: DateTime) {
    self.now = dateTime
  }
}
