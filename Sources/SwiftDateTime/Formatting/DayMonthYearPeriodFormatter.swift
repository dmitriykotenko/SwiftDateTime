////
////  Copyright © 2018 Evgeniy Lubaev. All rights reserved.
////
//
//
//import Foundation
//
//
//class DayMonthYearPeriodFormatter {
//
//  private let now: DateTime
//  private let period: DayMonthYearPeriod
//  private let newLine = "\n"
//
//
//  init(now: DateTime, period: DayMonthYearPeriod) {
//    self.now = now
//    self.period = period
//  }
//
//  var formattedPeriod: String {
//    return
//        period.isYear ? yearTitle :
//        period.isMonth ? monthTitle :
//        period.isSingleDay ? singleDayTitle :
//        weekTitle
//  }
//
//  private var singleDayTitle: String {
//    let start = period.start
//
//    if startIsToday { return Texts().today }
//    if startIsYesterday { return Texts().yesterday }
//
//    switch (start.month, start.day, isCurrentYear(start)) {
//    case (12, 31, false): return dayAndMonthAndYear(start)
//    default: return dayAndMonth(start)
//    }
//  }
//
//  private var startIsToday: Bool {
//    return period.start == now.date
//  }
//
//  private var startIsYesterday: Bool {
//    return period.start == DatesManipulator().date(now.date, minusDays: 1)
//  }
//
//  private var weekTitle: String {
//    let firstDay = period.start
//    let lastDay = DatesManipulator().previousDay(period.end)
//
//    let differentMonths = firstDay.month != lastDay.month
//    let lastFullWeekOfYear = lastDay.month == 12 && lastDay.day >= 25
//
//    if differentMonths {
//      return dayAndMonth(firstDay) + " — " + dayAndMonth(lastDay)
//    }
//
//    if lastFullWeekOfYear {
//      return dayAndMonth(firstDay) + "–" + day(lastDay) + newLine + year(lastDay)
//    }
//
//    return dayAndMonth(firstDay) + "–" + day(lastDay)
//  }
//
//  private func isCurrentYear(_ dayMonthYear: DayMonthYear) -> Bool {
//    return now.date.year == dayMonthYear.year
//  }
//
//  private var monthTitle: String {
//    let start = period.start
//
//    switch (start.month, isCurrentYear(start)) {
//    case (12, false): return monthAndYear(start)
//    default: return month(start)
//    }
//  }
//
//  private var yearTitle: String {
//    return year(period.start)
//  }
//
//  private func dayAndMonthAndYear(_ dayMonthYear: DayMonthYear) -> String {
//    return formattedDate(dayMonthYear, format: "MMM d" + newLine + "yyyy")
//  }
//
//  private func dayAndMonth(_ dayMonthYear: DayMonthYear) -> String {
//    return formattedDate(dayMonthYear, format: "MMM d")
//  }
//
//  private func month(_ dayMonthYear: DayMonthYear) -> String {
//    return formattedDate(dayMonthYear, format: "MMMM")
//  }
//
//  private func monthAndYear(_ dayMonthYear: DayMonthYear) -> String {
//    return formattedDate(dayMonthYear, format: "MMMM" + newLine + "yyyy")
//  }
//
//  private func year(_ dayMonthYear: DayMonthYear) -> String {
//    return formattedDate(dayMonthYear, format: "yyyy")
//  }
//
//  private func day(_ dayMonthYear: DayMonthYear) -> String {
//    return formattedDate(dayMonthYear, format: "d")
//  }
//
//  private func formattedDate(_ dayMonthYear: DayMonthYear,
//                             format: String) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = format
//
//    let dateComponents = DateComponents(
//      calendar: Calendar(identifier: .gregorian),
//      year: dayMonthYear.year,
//      month: dayMonthYear.month,
//      day: dayMonthYear.day
//    )
//
//    let date = dateComponents.date!
//
//    return dateFormatter.string(from: date)
//  }
//}
//
//
//private extension DayMonthYearPeriod {
//
//  var isSingleDay: Bool {
//    return DatesManipulator().days(from: start, to: end) == 1
//  }
//
//  var isMonth: Bool {
//    let monthsBetween = end.year * 12 + end.month - (start.year * 12 + start.month)
//
//    return start.day == 1
//      && end.day == 1
//      && monthsBetween == 1
//  }
//
//  var isYear: Bool {
//    return start.month == 1 && start.day == 1
//      && end.month == 1 && end.day == 1
//      && end.year == start.year + 1
//  }
//}
