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
      EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create, eventManager: eventManager))
    case .createReminder:
      ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create, reminderManager: reminderManager))
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
