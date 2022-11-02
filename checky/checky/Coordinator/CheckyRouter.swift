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
  case EventSetting
  case ReminderSetting
  case EventSettingButton(category: EKCalendar)
  case ReminderSettingButton(category: EKCalendar)
  
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
    case .EventSetting:
      return .push
    case .ReminderSetting:
      return .push
    case .EventSettingButton:
      return .push
    case .ReminderSettingButton:
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
      EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create, eventManager: eventManager))
    case .createReminder:
      ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create, reminderManager: reminderManager))
    case .EventSetting:
      EventSettingView(viewModel: EventSettingViewModel(eventManager: eventManager))
    case .ReminderSetting:
      ReminderSettingView(viewModel: ReminderSettingViewModel(reminderManager: reminderManager))
    case let .EventSettingButton(category):
      EventButtonView(viewModel: EventButtonViewModel(category: category, eventManager: eventManager))
    case let .ReminderSettingButton(category):
      ReminderButtonView(viewModel: ReminderButtonViewModel(category: category, reminderManager: reminderManager))
    }
  }
}
