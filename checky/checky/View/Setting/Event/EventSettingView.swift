//
//  EventSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import Combine
import EventKit

struct EventSettingView: View {
  @ObservedObject var viewModel: EventSettingViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(viewModel.categories) { category in
          SettingButtonView(category: category) {
            coordinator.show(.EventSettingButton(category: category))
          }
        }
      }
      .padding(.horizontal, 15)
    }
    .background(Color.backgroundGray)
  }
}

