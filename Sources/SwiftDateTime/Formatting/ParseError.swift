//  Copyright © 2018 Evgeniy Lubaev. All rights reserved.


enum ParseError: Error {
    
    case invalidNonNegativeInteger(String)
    case invalidDayMonthYear(String)
    case invalidHoursMinutesSeconds(String)
    case invalidTimeZoneOffset(String)
    case invalidDateTime(String)
}
