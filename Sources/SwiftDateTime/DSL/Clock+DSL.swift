////  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Clock {

  var today: DayMonthYear {
    return now.date
  }

  var tomorrow: DayMonthYear {
    return today.nextDay
  }

  var yesterday: DayMonthYear {
    return today.previousDay
  }
}
