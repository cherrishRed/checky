//
//  CalendarViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI
import Combine

class MonthlyViewModel: ViewModelable {
  @Published var date: Date
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarCanDo
    
  init(
    date: Date,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarCanDo,
    events: [Event] = [],
    reminders: [Reminder] = [],
    currentOffsetX: CGSize = .zero
  ) {
    self.date = date
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.events = events
    self.reminders = reminders
  }
  
  enum Action {
    case actionOnAppear
    case onChangeDate
  }
  
  func action(_ action: Action) {
    switch action {
      case .actionOnAppear:
        fetchEvents()
        fetchReminder()
      case .onChangeDate:
        fetchEvents()
        fetchReminder()
    }
  }
  
  func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        self?.events = eventList
      }
    })
  }
  
  func fetchReminder() {
    reminderManager.getAllTaskforThisMonth(date: date) { [weak self] reminderList in
      DispatchQueue.main.async {
        self?.reminders = reminderList
      }
    }
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(date)
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
    return calendarHelper.extractDates(date).count > 35 ? CGFloat(6) : CGFloat(5)
  }

}
