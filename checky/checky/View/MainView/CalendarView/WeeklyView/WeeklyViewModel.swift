//
//  WeeklyViewModel.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

class WeeklyViewModel: ViewModelable {
  @Published var dateHolder: DateHolder
  @Published var minicarOffset: CGFloat
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarProtocol
  var moveToMonthly: () -> ()
  
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarProtocol,
    moveToMonthly: @escaping () -> ()
  ) {
    self.moveToMonthly = moveToMonthly
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.minicarOffset = .zero
  }
  
  var pastCurrentFutureDates: [Date] {
    return calendarHelper.extractPastCurrentFutureDates(dateHolder.date)
  }
  
  func minimunCalendarWeekheight(_ date: Date) -> CGFloat {
    let dates = calendarHelper.extractMonthDates(date)
      .map { (dateValue) -> String in
        let isThisMonth = dateValue.isCurrentMonth ? "ThisMonth" : ""
        let dayString = dateValue.date.day
        return isThisMonth + dayString
      }

    let date = "ThisMonth" + date.day
    
    guard let index = dates.firstIndex(of: date) else {
      return CGFloat(0)
    }
    
    return CGFloat(index / 7) * CGFloat(16)
  }
  
  enum Action {
    case moveToMonthly
    case moveToPreviousWeek
    case moveToNextWeek
    case changeMinicarOffset
  }
  
  func action(_ action: Action) {
    switch action {
    case .moveToMonthly:
      moveToMonthly()
      case .moveToPreviousWeek:
        moveToPreviousWeek()
      case .moveToNextWeek:
        moveToNextWeek()
      case .changeMinicarOffset:
        minicarOffset = minimunCalendarWeekheight(dateHolder.date)
    }
  }
  
  var currentWeek: Bool {
    let year = dateHolder.date.year == Date().year
    let month = dateHolder.date.month == Date().month
    let week = minimunCalendarWeekheight(dateHolder.date) == minimunCalendarWeekheight(Date())
    return year && month && week
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(dateHolder.date)
  }
  
  var gridCloumnsCount: CGFloat {
    return CGFloat(calendarHelper.extractDates(dateHolder.date).count + 1)
  }

  private func moveToPreviousWeek() {
    dateHolder.date = calendarHelper.minusDate(dateHolder.date)
  }
  
  private func moveToNextWeek() {
    dateHolder.date = calendarHelper.plusDate(dateHolder.date)
  }
  
  func extractMonthDates() -> [DateValue] {
    calendarHelper.extractMonthDates(dateHolder.date)
  }
}
