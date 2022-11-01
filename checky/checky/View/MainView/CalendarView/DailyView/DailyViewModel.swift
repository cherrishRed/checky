//
//  DailyViewModel.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import Foundation

class DailyViewModel: ViewModelable {
  @Published var events: [Event]
  @Published var allDayEvents: [Event]
  @Published var timeEvents: [Event]
  
  @Published var reminders: [Reminder]
  @Published var dayReminders: [Reminder]
  @Published var timeReminders: [Reminder]
  
  @Published var clearedReminders: [Reminder]
  
  var eventManager: EventManager
  var reminderManager: ReminderManager
  
  init(events: [Event],
       reminders: [Reminder],
       clearedReminders: [Reminder],
       eventManager: EventManager,
       reminderManager: ReminderManager) {
    self.events = events
    self.allDayEvents = events.filter { $0.ekevent.isAllDay == true }
    
    self.reminders = reminders
    self.dayReminders = reminders.filter { $0.ekreminder.dueDateComponents?.day != nil && $0.ekreminder.dueDateComponents?.hour == nil }
    self.timeEvents = events.filter { $0.ekevent.isAllDay == false }
    self.timeReminders = reminders.filter { $0.ekreminder.dueDateComponents?.hour != nil }
    self.clearedReminders = clearedReminders
    self.eventManager = eventManager
    self.reminderManager = reminderManager
  }
  
  enum Action {
    case none
  }
  
  func action(_ action: Action) {
    
  }
}
