////  Copyright © 2020 Evgeniy Lubaev. All rights reserved.


public extension Clock {

  var today: DayMonthYear {
    now.date
  }

  var tomorrow: DayMonthYear {
    today.nextDay
  }

  var yesterday: DayMonthYear {
    today.previousDay
  }
}
