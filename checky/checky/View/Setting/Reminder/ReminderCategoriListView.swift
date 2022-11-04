//
//  ReminderSettingView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI

struct ReminderCategoriListView: View {
  @ObservedObject var viewModel: ReminderCategoriListViewModel
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(viewModel.categories) { category in
          CategoriListCellView(category: category, mode: .reminder) {
            coordinator.show(.reminderSettingButton(category: category))
          }
        }
      }
      .padding(.horizontal, 15)
    }
    .background(Color.backgroundGray)
  }
}
