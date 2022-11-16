//
//  CalendarCanDoProtocol.swift
//  checky
//
//  Created by song on 2022/10/25.
//

import Foundation

protocol CalendarProtocol {
  var weekOption: WeekOption { get set }
  var startingWeek: Week { get set }
  var calendar: Calendar { get set }
  
  func plusDate(_ date: Date) -> Date
  func minusDate(_ date: Date) -> Date
  func extractDates(_ date: Date) -> [DateValue]
  func extractPastCurrentFutureDates(_ date: Date) -> [Date]
}

extension CalendarProtocol {
  func monthYearString(_ date: Date) -> String {
    let dataFormatter = DateFormatter()
    dataFormatter.dateFormat = "LLL YYYY"
    return dataFormatter.string(from: date)
  }
  
  func monthYearDayString(_ date: Date) -> String {
    let dataFormatter = DateFormatter()
    dataFormatter.dateFormat = "YYYY년 M월 d일"
    return dataFormatter.string(from: date)
  }
  
  func previousDates(currentday: DateValue) -> [DateValue] {
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
  
  func nextDates(currentday: DateValue) -> [DateValue] {
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
  
  private func saveWeek(targetDate: DateValue) -> Week {
    let firstDayOfWeekday = calendar.component(.weekday, from: targetDate.date)
    
    guard let firstWeekday = Week(rawValue: firstDayOfWeekday) else {
      return Week.sunday
    }
    
    return firstWeekday
  }
  
  private func savePreviousDateCount(targetDate: DateValue) -> Int {
    let firstWeekday = saveWeek(targetDate: targetDate)
    
    guard startingWeek.WeekDay > firstWeekday.WeekDay else {
      return firstWeekday.WeekDay - startingWeek.WeekDay
    }
    
    return 7 - startingWeek.WeekDay + firstWeekday.WeekDay
  }
  
  private func saveNextDateCount(targetDate: DateValue) -> Int {
    let lastWeekday = saveWeek(targetDate: targetDate)
    
    guard startingWeek.WeekDay <= lastWeekday.WeekDay else {
      return startingWeek.WeekDay - lastWeekday.WeekDay - 1
    }
    
    return 6 - lastWeekday.rawValue + startingWeek.rawValue
  }
  
  func extractMonthDates(_ date: Date) -> [DateValue] {
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
  
  private func saveDaysOfCurrentMonth(_ date: Date) -> [DateValue] {
    guard let currentMonth = calendar.date(byAdding: .month, value: 0, to: date) else {
      return []
    }
    
    return currentMonth.getAllDates().map { DateValue(date: $0, isCurrentMonth: true) }
  }
}
