//
//  MonthlyCalendarHelper.swift
//  checky
//
//  Created by song on 2022/10/25.
//

import Foundation

struct MonthyCalendarHelper: CalendarProtocol {
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
    extractMonthDates(date)
  }
  
  private func saveDaysOfCurrentMonth(_ date: Date) -> [DateValue] {
    guard let currentMonth = calendar.date(byAdding: .month, value: 0, to: date) else {
      return []
    }
    
    return currentMonth.getAllDates().map { DateValue(date: $0, isCurrentMonth: true) }
  }
  
  func extractPastCurrentFutureDates(_ date: Date) -> [Date] {
    var dates: [Date] = []
    
    guard let currentMonth = calendar.date(byAdding: .month, value: 0, to: date) else {
      return []
    }
    
    guard let preMonth = calendar.date(byAdding: .month, value: -1, to: date) else {
      return []
    }
    
    guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: date) else {
      return []
    }
    
    dates.append(preMonth)
    dates.append(currentMonth)
    dates.append(nextMonth)
    
    return dates
  }
}
