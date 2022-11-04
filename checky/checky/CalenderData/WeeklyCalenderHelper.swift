//
//  CalenderHelper.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

struct WeeklyCalendarHelper: CalendarCanDo {
  
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
    guard let nextWeek = calendar.date(byAdding: .day, value: 7, to: date) else {
      return Date()
    }
    return nextWeek
  }
  
  func minusDate(_ date: Date) -> Date {
    guard let frontWeek = calendar.date(byAdding: .day, value: -7, to: date) else {
      return Date()
    }
    return frontWeek
  }
  
  func extractDates(_ date: Date) -> [DateValue] {
    
    var currentWeek: [DateValue] = []
    
    let today = [DateValue(date: date, isCurrentMonth: true)]
    
    guard let todays = today.first else {
      return []
    }
    
    let previousDays = previousDates(currentday: todays)
    let nextDays = nextDates(currentday: todays)
    
    previousDays.forEach { currentWeek.append($0) }
    today.forEach { currentWeek.append($0) }
    nextDays.forEach{ currentWeek.append($0) }
    
    return currentWeek
  }
  
  func extractPastCurrentFutureDates(_ date: Date) -> [Date] {
    var dates: [Date] = []
    
    guard let currentMonth = calendar.date(byAdding: .day, value: 0, to: date) else {
      return []
    }
    
    let preMonth = plusDate(date)
    let nextMonth = minusDate(date)
    
    dates.append(preMonth)
    dates.append(currentMonth)
    dates.append(nextMonth)
    
    print(dates)
    
    return dates
  }
}
