//
//  ReminderView.swift
//  checky
//
//  Created by RED on 2022/11/08.
//

import SwiftUI

struct ReminderView: View {
  @ObservedObject var viewModel: ReminderViewModel
  
  var body: some View {
    VStack {
      header
      eventView
      
      Button("toggle") {
        // toggle
      }
      .buttonStyle(ToggleButtonStyle())
      
      

    }
    .background(Color.backgroundGray)
  }
}

extension ReminderView {
  var header: some View {
    ZStack {
      Rectangle()
        .fill(.white)
        .frame(height: 50)
      Text(Date().dateKoreanWithYear)
        .font(.title)
    }
  }
  
  var eventView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 4)
        .fill(.white)
      VStack {
        ForEach(viewModel.events, id: \.self) { event in
          let _ = print(event)
          ReminderViewEventBlockView(event: event)
            .frame(height: 30)
        }
      }
      .padding()
    }
    .padding()
    .fixedSize(horizontal: false, vertical: true)
  }
}

