//
//  WeeklyBlockViewModel.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import Foundation
import Combine

class WeeklyBlockViewModel: ViewModelable {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetY: CGSize
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarProtocol
  
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarProtocol,
    currentOffsetY: CGSize = .zero,
    events: [Event] = [],
    reminders: [Reminder] = []
  ) {
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.currentOffsetY = currentOffsetY
    self.events = events
    self.reminders = reminders
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(dateHolder.date)
  }
  
  enum Action {
    case actionOnAppear
  }
  
  func action(_ action: Action) {
    switch action {
    case .actionOnAppear:
      onAppear()
    }
  }
  
  func onAppear() {
    self.fetchEvents()
    self.fetchReminder()
  }
  
  func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: dateHolder.date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        guard let eventList = eventList as? [Event] else { return }
        self?.events = eventList
      }
    })
  }
  
  private func fetchReminder() {
    reminderManager.getAllTaskforThisMonth(date: dateHolder.date, completionHandler: { [weak self] reminderList in
      DispatchQueue.main.async {
        guard let reminderList = reminderList as? [Reminder] else { return }
        self?.reminders = reminderList
      }
    })
  }
    
  func filteredEvent(_ date: Date) -> [Event] {
    guard let filtetedEvents = eventManager.filterTask(events, date) as? [Event] else {
      return []
    }
    return filtetedEvents
  }
  
  func filteredReminder(_ date: Date) -> [Reminder] {
    guard let filtetedReminders = reminderManager.filterTask(reminders, date) as? [Reminder] else {
      return []
    }
    return filtetedReminders
  }
  
  func filteredClearedReminder(_ date: Date) -> [Reminder] {
    reminderManager.filterClearTask(reminders, date)
  }
  
  var gridCloumnsCount: CGFloat {
    return CGFloat(calendarHelper.extractDates(dateHolder.date).count + 1)
  }
  
}

protocol ViewModelable: ObservableObject {
  associatedtype Action
  
  func action(_ action: Action)
}
