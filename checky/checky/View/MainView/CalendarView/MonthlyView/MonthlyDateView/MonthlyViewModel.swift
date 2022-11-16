//
//  CalendarViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI
import Combine

class MonthlyViewModel: ViewModelable {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  
  let eventManager: any ManagerProtocol
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
  }
  
  enum Action {
    case actionOnAppear
    case onChangeDate
    case moveToWeekly
    case moveToPreviousMonth
    case moveToNextMonth
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
    }
  }
  
  func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: dateHolder.date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        guard let eventList = eventList as? [Event] else { return }
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
    guard let result = eventManager.filterTask(events, date) as? [Event] else { return [] }
    
    return result
  }
  
  func filteredReminder(_ date: Date) -> [Reminder] {
    guard let result = reminderManager.filterTask(reminders, date) as? [Reminder] else { return [] }
    return result
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

}
