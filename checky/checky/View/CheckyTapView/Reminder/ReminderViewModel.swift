//
//  ReminderViewModel.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import SwiftUI
import EventKit

final class ReminderViewModel: ViewModelable {
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
  
  var categoriesFirstLine: [EKCalendar] {
    var categoriesLine: [EKCalendar] = []
    
    let categoriesCount = categories.count
    let mockCategoris = categories
    
    for i in stride(from: 0 , to: categoriesCount-1, by: 2) {
      let category = mockCategoris[i]
      categoriesLine.append(category)
    }
    
    return categoriesLine
  }
  
  var categoriesSecondLine: [EKCalendar] {
    var categoriesLine: [EKCalendar] = []
    
    let categoriesCount = categories.count
    let mockCategoris = categories
    
    for i in stride(from: 1 , to: categoriesCount, by: 2) {
      let category = mockCategoris[i]
      categoriesLine.append(category)
    }
    
    return categoriesLine
  }
  
  func action(_ action:Action) {
    switch action {
      case .onAppear:
        break
    }
  }
  
}

