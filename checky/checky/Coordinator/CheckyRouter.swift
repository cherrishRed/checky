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
    }
  }
  
  @ViewBuilder
  func view() -> some View {
    switch self {
      case .main:
        checkyApp()
      case .create:
        CreateSelectorView()
        //        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create))
        //      ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create))
      case .createEvent:
        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create))
      case .createReminder:
        ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create, reminderManager: ReminderManager()))
    }
  }
}
