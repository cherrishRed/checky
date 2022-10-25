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
  
  private func saveWeek(targetDate: DateValue) -> Week {
    let firstDayOfWeekday = calendar.component(.weekday, from: targetDate.date)
    
    guard let firstWeekday = Week(rawValue: firstDayOfWeekday) else {
      return Week.sunday
    }
    
    return firstWeekday
  }
  
  private func previousDates(currentday: DateValue) -> [DateValue] {
    var previousDays: [DateValue] = []
    let previousMonthDayCount = savePreviousDateCount(targetDate: currentday)

    guard previousMonthDayCount != 0 else {
      return previousDays
    }

    for number in 1...previousMonthDayCount {
      let day = calendar.date(byAdding: .day, value: -number, to: currentday.date)
      previousDays.insert(DateValue(date: day ?? Date(), isCurrentMonth: false), at: 0)
    }

    return previousDays
  }
  
  private func nextDates(currentday: DateValue) -> [DateValue] {
    var nextDays: [DateValue] = []
    let nextMonthDayCount = saveNextDateCount(targetDate: currentday)

    guard nextMonthDayCount != 0 else {
      return nextDays
    }

    for number in 1...nextMonthDayCount {
      let day = calendar.date(byAdding: .day, value: number, to: currentday.date)
      nextDays.append(DateValue(date: day ?? Date(), isCurrentMonth: false))
    }

    return nextDays
  }
  
  private func savePreviousDateCount(targetDate: DateValue) -> Int {
    guard startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay >= 0 else {
      return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay + 7
    }
    return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay
  }
  
  private func saveNextDateCount(targetDate: DateValue) -> Int {
    return 6 - savePreviousDateCount(targetDate: targetDate)
  }
  
  private func getThisWeek(targetDate: DateValue) -> Int {
    if startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay >= 0 {
      return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay
    } else {
      return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay + 7
    }
  }
}
