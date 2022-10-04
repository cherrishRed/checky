//
//  CalenderHelper.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

struct CalendarHelper {
  var date: Date
  let calendar: Calendar
  var weekOption: String
  var startingWeek: Week
  var plusMinusMonth: Int
  
  init(date: Date,
       calendar: Calendar = Calendar.current,
       weekOption: String = "KoreanShot",
       startingWeek: Week = Week.sunday,
       plusMinusMonth: Int = 0
  ) {
    self.date = date
    self.calendar = calendar
    self.weekOption = weekOption
    self.startingWeek = startingWeek
    self.plusMinusMonth = plusMinusMonth
  }
  
  func monthYearString(_ date: Date) -> String {
    let dataFormatter = DateFormatter()
    dataFormatter.dateFormat = "LLL YYYY"
    return dataFormatter.string(from: date)
  }
  
  func plusMonth() -> Date {
    guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: date) else {
      return Date()
    }
    return nextMonth
  }
  
  func minusMonth() -> Date {
    guard let frontMonth = calendar.date(byAdding: .month, value: -1, to: date) else {
      return Date()
    }
    return frontMonth
  }
  
  private func saveDaysOfCurrentMonth() -> [DateValue] {
    guard let currentMonth = calendar.date(byAdding: .month, value: plusMinusMonth, to: date) else {
      return []
    }
    
    return currentMonth.getAllDates().map { DateValue(date: $0, isCurrentMonth: true) }
  }
  
  func extractDates() -> [DateValue] {
    var currentCalendar: [DateValue] = []
    
    let days = saveDaysOfCurrentMonth()
    
    guard let firstDayOfMonth = days.first, let lastDayOfMonth = days.last else {
      return []
    }
    
    let previousDays = previousDates(firstDayOfCurrentMonth: firstDayOfMonth)
    let nextDays = nextDates(lastDayOfCurrentMonth: lastDayOfMonth)
    
    previousDays.forEach { currentCalendar.append($0) }
    days.forEach { currentCalendar.append($0) }
    nextDays.forEach{ currentCalendar.append($0) }
    
    return currentCalendar
  }
  
  private func saveWeek(targetDate: DateValue) -> Week {
    let firstDayOfWeekday = calendar.component(.weekday, from: targetDate.date)
    
    guard let firstWeekday = Week(rawValue: firstDayOfWeekday) else {
      return Week.sunday
    }
    
    return firstWeekday
  }
  
  private func savepreviousMonthDayCount(targetDate: DateValue) -> Int {
    let firstWeekday = saveWeek(targetDate: targetDate)
    var previousMonthDayCount: Int = 0
    
    guard startingWeek.rawValue > firstWeekday.rawValue else {
      previousMonthDayCount = firstWeekday.rawValue - startingWeek.rawValue
      return previousMonthDayCount
    }
    
    previousMonthDayCount = 7 - startingWeek.rawValue + firstWeekday.rawValue
    return previousMonthDayCount
  }
  
  private func previousDates(firstDayOfCurrentMonth: DateValue) -> [DateValue] {
    var previousDays: [DateValue] = []
    let previousMonthDayCount = savepreviousMonthDayCount(targetDate: firstDayOfCurrentMonth)
    
    guard previousMonthDayCount != 0 else {
      return previousDays
    }
    
    for number in 1...previousMonthDayCount {
      let day = calendar.date(byAdding: .day, value: -number, to: firstDayOfCurrentMonth.date)
      previousDays.insert(DateValue(date: day ?? Date(), isCurrentMonth: false), at: 0)
    }
    
    return previousDays
  }
  
  private func saveNextMonthDayCount(targetDate: DateValue) -> Int {
    let lastWeekday = saveWeek(targetDate: targetDate)
    var nextMonthDayCount: Int = 0
    
    guard startingWeek.rawValue >= lastWeekday.rawValue else {
      nextMonthDayCount = 7 - lastWeekday.rawValue
      return nextMonthDayCount
    }
    
    guard lastWeekday.rawValue - lastWeekday.rawValue == 0 else {
      nextMonthDayCount = lastWeekday.rawValue - lastWeekday.rawValue
      return nextMonthDayCount
    }
    
    nextMonthDayCount = 6
    return nextMonthDayCount
  }
  
  private func nextDates(lastDayOfCurrentMonth: DateValue) -> [DateValue] {
    var nextDays: [DateValue] = []
    let nextMonthDayCount = saveNextMonthDayCount(targetDate: lastDayOfCurrentMonth)
    
    guard nextMonthDayCount != 0 else {
      return nextDays
    }

    for number in 1...nextMonthDayCount {
      let day = calendar.date(byAdding: .day, value: number, to: lastDayOfCurrentMonth.date)
      nextDays.append(DateValue(date: day ?? Date(), isCurrentMonth: false))
    }
    
    return nextDays
  }
}
