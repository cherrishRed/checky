//
//  ReminderSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct ReminderSettingView: View {
  @ObservedObject var viewModel: ReminderSettingViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(viewModel.categories) { category in
          SettingButtonView(category: category) {
            coordinator.show(.ReminderSettingButton(category: category))
          }
        }
      }
      .padding(.horizontal, 15)
    }
    .background(Color.backgroundGray)
  }
}
