//
//  MonthlyCalendarHelper.swift
//  checky
//
//  Created by song on 2022/10/25.
//

import Foundation

struct MonthyCalendarHelper: CalendarCanDo {
  var weekOption: WeekOption
  var startingWeek: Week
  var calendar: Calendar
  
  init(calendar: Calendar = Calendar.current,
       weekOption: WeekOption = WeekOption.KoreanShort,
       startingWeek: Week = Week.sunday
  ) {
    self.calendar = calendar
    self.weekOption = weekOption
    self.startingWeek = startingWeek
  }
  
  func plusDate(_ date: Date) -> Date {
    guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: date) else {
      return Date()
    }
    return nextMonth
  }
  
  func minusDate(_ date: Date) -> Date {
    guard let frontMonth = calendar.date(byAdding: .month, value: -1, to: date) else {
      return Date()
    }
    return frontMonth
  }
  
  func extractDates(_ date: Date) -> [DateValue] {
    var currentCalendar: [DateValue] = []
    
    let days = saveDaysOfCurrentMonth(date)
    
    guard let firstDayOfMonth = days.first, let lastDayOfMonth = days.last else {
      return []
    }
    
    let previousDays = previousDates(currentday: firstDayOfMonth)
    let nextDays = nextDates(currentday: lastDayOfMonth)
    
    previousDays.forEach { currentCalendar.append($0) }
    days.forEach { currentCalendar.append($0) }
    nextDays.forEach{ currentCalendar.append($0) }
    
    return currentCalendar
  }
}
