//
//  EventCreateView.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import SwiftUI


struct EventCreateView: View {
  @ObservedObject var viewModel = EventCreateViewModel()
  
  var body: some View {
    VStack {
      headerView
      EventMenuView(viewModel: viewModel.eventMenuViewModel)
    }
    .onTapGesture {
      hideKeyboard()
      viewModel.tappedOutOfButton()
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

          Text("새로운 이벤트 추가")
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
      
