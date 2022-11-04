//
//  WeeklyViewModel.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import Foundation
import Combine

class WeeklyViewModel: ViewModelable {
  @Published var date: Date
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetY: CGSize
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarCanDo
  
  init(
    date: Date,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarCanDo,
    currentOffsetY: CGSize = .zero,
    events: [Event] = [],
    reminders: [Reminder] = []
  ) {
    self.date = date
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.currentOffsetY = currentOffsetY
    self.events = events
    self.reminders = reminders
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(date)
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
    self.getPermission()
    self.fetchEvents()
    self.fetchReminder()
  }
  
  private func getPermission() {
    eventManager.getPermission()
  }
  
  private func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        self?.events = eventList
      }
    })
  }
  
  private func fetchReminder() {
    reminderManager.getAllTaskforThisMonth(date: date, completionHandler: { [weak self] reminderList in
      DispatchQueue.main.async {
        self?.reminders = reminderList
      }
    })
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
    return CGFloat(calendarHelper.extractDates(date).count + 1)
  }
  
}

protocol ViewModelable: ObservableObject {
  associatedtype Action
  
  func action(_ action: Action)
}
