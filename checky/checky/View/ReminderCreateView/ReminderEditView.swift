//
//  ReminderEditView.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import SwiftUI

struct ReminderEditView: View {
  @ObservedObject var viewModel = ReminderEditViewModel()
  
    var body: some View {
      VStack {
        headerView
        ReminderMenuView(viewModel: viewModel.reminderMenuViewModel)
        deleteButtonView
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

          Text("미리알림 수정")
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
  
  var deleteButtonView: some View {
    Button {
      // 삭제
    } label: {
      HStack {
        Image(systemName: "trash.fill")
        Text("미리 알림 삭제")
          .fontWeight(.heavy)
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color("pointRed"))
      .cornerRadius(4)
      .foregroundColor(Color("basicWhite"))
    }
    .padding(.horizontal)
  }
}
