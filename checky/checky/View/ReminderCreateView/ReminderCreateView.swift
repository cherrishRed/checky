//
//  ReminderCreateView.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import SwiftUI

struct ReminderCreateView: View {
  @ObservedObject var viewModel = ReminderCreateViewModel()
    var body: some View {
      VStack {
        headerView
        ReminderMenuView(viewModel: viewModel.reminderMenuViewModel)
      }
    }
  
  var headerView: some View {
      HStack {
          Button {
            viewModel.tappedCloseButton()
            hideKeyboard()
          } label: {
              Image(systemName: "xmark")
                  .foregroundColor(.red)
                  .padding()
          }

          Text("새로운 미리알림 추가")
              .font(.title2)
              .frame(maxWidth: .infinity)
          
          Button {
            viewModel.tappedCreateButton()
            hideKeyboard()
          } label: {
              Image(systemName: "checkmark")
                  .foregroundColor(.green)
                  .padding()
          }
      }
  }
}
