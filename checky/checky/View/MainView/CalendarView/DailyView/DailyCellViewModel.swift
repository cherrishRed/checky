//
//  DailyCellViewModel.swift
//  checky
//
//  Created by RED on 2022/10/31.
//

import Foundation

class DailyCellViewModel: ViewModelable {
  @Published var events: [Event]
  @Published var allDayEvents: [Event]
  @Published var timeEvents: [Event]
  
  @Published var reminders: [Reminder]
//  @State var dayReminders: [Event]
//  @State var timeReminders: [Event]
  var eventManager: EventManager
  var reminderManager: ReminderManager
  
  init(events: [Event],
       reminders: [Reminder],
       eventManager: EventManager,
       reminderManager: ReminderManager) {
    self.events = events
    self.allDayEvents = events.filter { $0.ekevent.isAllDay == true }
    self.timeEvents = events.filter { $0.ekevent.isAllDay == false }
    self.reminders = reminders
    self.eventManager = eventManager
    self.reminderManager = reminderManager
  }
  
  enum Action {
    case none
  }
  
  func action(_ action: Action) {
    
  }
}
