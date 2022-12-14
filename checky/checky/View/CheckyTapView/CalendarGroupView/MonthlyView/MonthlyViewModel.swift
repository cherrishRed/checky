//
//  CalendarViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI
import Combine

final class MonthlyViewModel: ViewModelable {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetX: CGSize
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarProtocol
  let moveToWeekly: () -> ()
  
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarProtocol,
    events: [Event] = [],
    reminders: [Reminder] = [],
    currentOffsetX: CGSize = .zero,
    moveToWeekly: @escaping () -> ()
  ) {
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.events = events
    self.reminders = reminders
    self.moveToWeekly = moveToWeekly
    self.currentOffsetX = currentOffsetX
  }
  
  enum Action {
    case actionOnAppear
    case onChangeDate
    case moveToWeekly
    case moveToPreviousMonth
    case moveToNextMonth
    case dragGestur
    case resetCurrentOffsetX
  }
  
  func action(_ action: Action) {
    switch action {
    case .actionOnAppear:
      fetchEvents()
      fetchReminder()
    case .onChangeDate:
      fetchEvents()
      fetchReminder()
    case .moveToWeekly:
      moveToWeekly()
    case .moveToPreviousMonth:
      moveToPreviousMonth()
    case .moveToNextMonth:
      moveToNextMonth()
    case .dragGestur:
      dragGestureonEnded()
    case .resetCurrentOffsetX:
      resetCurrentOffsetX()
    }
  }
  
  func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: dateHolder.date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        self?.events = eventList
      }
    })
  }
  
  func fetchReminder() {
    reminderManager.getAllTaskforThisMonth(date: dateHolder.date) { [weak self] reminderList in
      DispatchQueue.main.async {
        self?.reminders = reminderList
      }
    }
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(dateHolder.date)
  }
  
  func filteredEvent(_ date: Date) -> [Event] {
    eventManager.filterTask(events, date)
  }
  
  func filteredReminder(_ date: Date) -> [Reminder] {
    reminderManager.filterTask(reminders, date)
  }
  
  func filteredClearedReminder(_ date: Date) -> [Reminder] {
    reminderManager.filterClearTask(reminders, date)
  }
  
  var gridCloumnsCount: CGFloat {
    return calendarHelper.extractDates(dateHolder.date).count > 35 ? CGFloat(6) : CGFloat(5)
  }
  
  var currentMonth: Bool {
    return dateHolder.date.month == Date().month && dateHolder.date.year == Date().year
  }
  
  
  func moveToPreviousMonth() {
    dateHolder.date = calendarHelper.minusDate(dateHolder.date)
  }
  
  func moveToNextMonth() {
    dateHolder.date = calendarHelper.plusDate(dateHolder.date)
  }
  
  func dragGestureonEnded() {
    guard currentOffsetX.width < 0 else {
      dateHolder.date = calendarHelper.minusDate(dateHolder.date)
      return
    }
    dateHolder.date = calendarHelper.plusDate(dateHolder.date)
  }

  func resetCurrentOffsetX() {
    currentOffsetX = .zero
  }

  
}
