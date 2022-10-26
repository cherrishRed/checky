//
//  File.swift
//  checky
//
//  Created by song on 2022/10/26.
//

import SwiftUI

enum checkyRouter: NavigationRouter {
  
  case main
  case setting
  
  var transition: NavigationTranisitionStyle {
    switch self {
    case .main:
      return .push
    case .setting:
      return .presentModally
    }
  }
  
  @ViewBuilder
  func view() -> some View {
    switch self {
    case .main:
      checkyApp()
    case .setting:
        EventCreateAndEditView(viewModel: EventCreateAndEditViewModel(mode: .create))
//      ReminderCreateAndEditView(viewModel: ReminderCreateAndEditViewModel(mode: .create))
    }
  }
}
