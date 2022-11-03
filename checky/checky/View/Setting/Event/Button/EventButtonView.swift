//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit
import Combine

struct EventButtonView: View {
  @ObservedObject var viewModel: EventButtonViewModel
  
  var body: some View {
    
    SettingView(emoji: $viewModel.imoji, color: $viewModel.color, calendarIdentifier: viewModel.category.calendarIdentifier)
    .onAppear {
      viewModel.imoji = fetchUserDefaultEmoji(calendarIdentifier: viewModel.category.calendarIdentifier)
      viewModel.color = fetchUserDefaultColor(calendarIdentifier: viewModel.category.calendarIdentifier)
    }
    .background(Color.backgroundGray)
  }
}

