//
//  ReminderViewModel.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import Foundation
import EventKit

class ReminderViewModel: ViewModelable {
  @Published var events: [Event]
  let eventManager: EventManager
  let reminderManager: ReminderManager
  
  init(eventManager: EventManager, reminderManager: ReminderManager) {
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.events = []
    eventManager.getAllTaskforThisDay(date: Date()) { event in
      DispatchQueue.main.async {
        self.events = event
      }
    }
  }
  
  enum Action {
    case onAppear
  }
  
  var categories: [EKCalendar] {
    return reminderManager.getTaskCategories()
  }
  
  func action(_ action:Action) {
    switch action {
      case .onAppear:
        print("")
    }
  }
  
}

