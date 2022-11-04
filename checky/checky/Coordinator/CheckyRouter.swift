//
//  File.swift
//  checky
//
//  Created by song on 2022/10/26.
//

import SwiftUI
import EventKit

enum checkyRouter: NavigationRouter {
  case main
  case create
  case createEvent
  case createReminder
  case daily(Date, [Event], [Reminder], [Reminder], EventManager, ReminderManager)
  case editEvent(Event, EventManager)
  case editReminder(Reminder, ReminderManager)
  case eventSetting
  case reminderSetting
  case eventSettingButton(category: EKCalendar)
  case reminderSettingButton(category: EKCalendar)
  
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
        return .push
      case .editEvent:
        return .presentModally
      case .editReminder:
        return .presentModally
       case .eventSetting:
      return .push
    case .reminderSetting:
      return .push
    case .eventSettingButton:
      return .push
    case .reminderSettingButton:
      return .push
    }
  }
  
  @ViewBuilder
  func view() -> some View {
    
    let eventManager = EventManager()
    let reminderManager = ReminderManager()
    switch self {

      case .main:
        checkyApp()
      case .create:
        CreateSelectorView()
      case .createEvent:
        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create, eventManager: EventManager()))
      case .createReminder:
        ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create, reminderManager: ReminderManager()))
      case let .daily(date, events, reminders, clearedReminders, eventManager, reminderManager):
        DailyView(viewModel: DailyViewModel(date: date, events: events, reminders: reminders, clearedReminders: clearedReminders, eventManager: eventManager, reminderManager: reminderManager))
      case let .editEvent(event, eventManager):
        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(event: event, eventManager: eventManager))
      case let .editReminder(reminder, reminderManager):
        ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(reminder: reminder, reminderManager: reminderManager))
      case .eventSetting:
      EventCategoriListView(viewModel: EventCategoriListViewModel(eventManager: eventManager))
    case .reminderSetting:
      ReminderCategoriListView(viewModel: ReminderCategoriListViewModel(reminderManager: reminderManager))
    case let .eventSettingButton(category):
      EventCategoriSettingView(viewModel: EventCategoriSettingViewModel(category: category, eventManager: eventManager))
    case let .reminderSettingButton(category):
      ReminderCategoriSettingView(viewModel: ReminderCategoriSettingViewModel(category: category, reminderManager: reminderManager))

    }
  }
}
