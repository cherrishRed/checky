//
//  CalenderHelper.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

struct CalendarHelper {
  let calendar: Calendar
  var weekOption: WeekOption
  var startingWeek: Week
  var plusMinusMonth: Int
  
  init(calendar: Calendar = Calendar.current,
       weekOption: WeekOption = WeekOption.KoreanShort,
       startingWeek: Week = Week.sunday,
       plusMinusMonth: Int = 0
  ) {
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
  
  func plusMonth(_ date: Date) -> Date {
    guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: date) else {
      return Date()
    }
    return nextMonth
  }
  
  func minusMonth(_ date: Date) -> Date {
    guard let frontMonth = calendar.date(byAdding: .month, value: -1, to: date) else {
      return Date()
    }
    return frontMonth
  }
  
  func minusWeek(_ date: Date) -> Date {
    guard let frontWeek = calendar.date(byAdding: .day , value: -7, to: date) else {
      return Date()
    }
    return frontWeek
  }
  
  func plusWeek(_ date: Date) -> Date {
    guard let nextWeek = calendar.date(byAdding: .day, value: 7, to: date) else {
      return Date()
    }
    return nextWeek
  }
  
  private func saveWeek(targetDate: DateValue) -> Week {
    let firstDayOfWeekday = calendar.component(.weekday, from: targetDate.date)
    
    guard let firstWeekday = Week(rawValue: firstDayOfWeekday) else {
      return Week.sunday
    }
    
    return firstWeekday
  }
}

// MARK: - Weekly

extension CalendarHelper {
  func savePreviousWeekDayCount(targetDate: DateValue) -> Int {
    guard startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay >= 0 else {
      return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay + 7
    }
    return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay
  }
  
  func saveNextWeekDayCount(targetDate: DateValue) -> Int {
   return 6 - savePreviousWeekDayCount(targetDate: targetDate)
  }
  
  func getThisWeek(targetDate: DateValue) -> Int {
    if startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay >= 0 {
      return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay
    } else {
      return startingWeek.WeekDay - saveWeek(targetDate: targetDate).WeekDay + 7
    }
  }
  
  func previousWeekDates(currentday: DateValue) -> [DateValue] {
    var previousDays: [DateValue] = []
    let previousMonthDayCount = savePreviousWeekDayCount(targetDate: currentday)
    
    guard previousMonthDayCount != 0 else {
      return previousDays
    }
    
    for number in 1...previousMonthDayCount {
      let day = calendar.date(byAdding: .day, value: -number, to: currentday.date)
      previousDays.insert(DateValue(date: day ?? Date(), isCurrentMonth: false), at: 0)
    }
    
    return previousDays
  }
  
  func nextWeekDates(currentday: DateValue) -> [DateValue] {
    var nextDays: [DateValue] = []
    let nextMonthDayCount = saveNextWeekDayCount(targetDate: currentday)
    
    guard nextMonthDayCount != 0 else {
      return nextDays
    }
    
    for number in 1...nextMonthDayCount {
      let day = calendar.date(byAdding: .day, value: number, to: currentday.date)
      nextDays.append(DateValue(date: day ?? Date(), isCurrentMonth: false))
    }
    
    return nextDays
  }
  
  func extractWeekDates(_ date: Date) -> [DateValue] {
    var currentWeek: [DateValue] = []
    
    let today = [DateValue(date: date, isCurrentMonth: true)]
    
    guard let todays = today.first else {
      return []
    }
    
    let previousDays = previousDates(firstDayOfCurrentMonth: todays)
    let nextDays = nextDates(lastDayOfCurrentMonth: todays)
    
    previousDays.forEach { currentWeek.append($0) }
    today.forEach { currentWeek.append($0) }
    nextDays.forEach{ currentWeek.append($0) }
    
    return currentWeek
  }
}

// MARK: - Monthly

extension CalendarHelper {
  
  private func saveDaysOfCurrentMonth(_ date: Date) -> [DateValue] {
    guard let currentMonth = calendar.date(byAdding: .month, value: plusMinusMonth, to: date) else {
      return []
    }
    
    return currentMonth.getAllDates().map { DateValue(date: $0, isCurrentMonth: true) }
  }
  
  func extractDates(_ date: Date) -> [DateValue] {
    var currentCalendar: [DateValue] = []
    
    let days = saveDaysOfCurrentMonth(date)
    
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
  
  private func savepreviousMonthDayCount(targetDate: DateValue) -> Int {
    let firstWeekday = saveWeek(targetDate: targetDate)
    
    guard startingWeek.WeekDay > firstWeekday.WeekDay else {
      return firstWeekday.WeekDay - startingWeek.WeekDay
    }
    
    return 7 - startingWeek.WeekDay + firstWeekday.WeekDay
  }
  
  private func saveNextMonthDayCount(targetDate: DateValue) -> Int {
    let lastWeekday = saveWeek(targetDate: targetDate)
    
    guard startingWeek.WeekDay <= lastWeekday.WeekDay else {
      return startingWeek.WeekDay - lastWeekday.WeekDay - 1
    }
    
    return 6 - lastWeekday.rawValue + startingWeek.rawValue
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
}
