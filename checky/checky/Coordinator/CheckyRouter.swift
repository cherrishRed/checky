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
      EventCategoriListView(viewModel: EventCategoriListViewModel(eventManager: eventManager))
    case .ReminderSetting:
      ReminderCategoriListView(viewModel: ReminderCategoriListViewModel(reminderManager: reminderManager))
    case let .EventSettingButton(category):
      EventCategoriSettingView(viewModel: EventCategoriSettingViewModel(category: category, eventManager: eventManager))
    case let .ReminderSettingButton(category):
      ReminderCategoriSettingView(viewModel: ReminderCategoriSettingViewModel(category: category, reminderManager: reminderManager))
    }
  }
}
