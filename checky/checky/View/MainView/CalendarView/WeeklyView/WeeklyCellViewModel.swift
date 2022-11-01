//
//  WeeklyCellViewModel.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import Foundation

class WeeklyCellViewModel: ObservableObject {
  @Published var dateValue: DateValue
  @Published var allEvnets: [Event] = []
  @Published var dueDateReminders: [Reminder] = []
  @Published var clearedReminders: [Reminder] = []
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  
  init(
    dateValue: DateValue,
    allEvnets: [Event] = [],
    dueDateReminders: [Reminder] = [],
    clearedReminders: [Reminder] = [],
    eventManager: EventManager,
    reminderManager: ReminderManager
  ) {
    self.dateValue = dateValue
    self.allEvnets = allEvnets
    self.dueDateReminders = dueDateReminders
    self.clearedReminders = clearedReminders
    
    self.eventManager = eventManager
    self.reminderManager = reminderManager
  }
  
  func filteredHightPriorityDuedateReminder() -> [Reminder] {
    reminderManager.filterHighPriorityTask(dueDateReminders, dateValue.date)
      .filter { $0.ekreminder.isCompleted == false }
  }
  
  func filteredHightPriorityClearedReminder() -> [Reminder] {
    return reminderManager.filterHighPriorityTask(clearedReminders, dateValue.date)
  }
}
