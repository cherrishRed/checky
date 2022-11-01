//
//  File.swift
//  checky
//
//  Created by song on 2022/10/26.
//

import SwiftUI

enum checkyRouter: NavigationRouter {
  
  
  case main
  case create
  case createEvent
  case createReminder
  case daily(Date, [Event], [Reminder], [Reminder], EventManager, ReminderManager)
  case editEvent(Event, EventManager)
  case editReminder(Reminder, ReminderManager)
  
  var transition: NavigationTranisitionStyle {
    switch self {
      case .main:
        return .push
      case .create:
        return .presentHalfModally
      case .createEvent:
        return .presentModally
      case .createReminder:
        return .presentModally
      case .daily:
        return .presentModally
      case .editEvent:
        return .presentModally
      case .editReminder:
        return .presentModally
    }
  }
  
  @ViewBuilder
  func view() -> some View {
    switch self {
      case .main:
        checkyApp()
      case .create:
        CreateSelectorView()
      case .createEvent:
        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create, eventManager: EventManager()))
      case .createReminder:
        ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create, reminderManager: ReminderManager()))
      case .daily(let date, let events, let reminders, let clearedReminders, let eventManager, let reminderManager):
        DailyView(viewModel: DailyViewModel(date: date, events: events, reminders: reminders, clearedReminders: clearedReminders, eventManager: eventManager, reminderManager: reminderManager))
      case .editEvent(let event, let eventManager):
        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(event: event, eventManager: eventManager))
      case .editReminder(let reminder, let reminderManager):
        ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(reminder: reminder, reminderManager: reminderManager))
        
    }
  }
}
