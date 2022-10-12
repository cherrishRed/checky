//
//  EventEditView.swift
//  checky
//
//  Created by RED on 2022/10/13.
//

import SwiftUI

struct EventEditView: View {
  @ObservedObject var viewModel = EventEditViewModel()
  
  var body: some View {
    VStack {
      headerView
      EventMenuView(viewModel: viewModel.eventMenuViewModel)
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
      
      Text("이벤트 수정")
        .font(.title2)
        .frame(maxWidth: .infinity)
      
      Button {
        viewModel.tappedEditButton()
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
        Text("이벤트 삭제")
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
