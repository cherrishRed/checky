//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct ReminderCategoriSettingView: View {
  @ObservedObject var viewModel: ReminderCategoriSettingViewModel
  
  var body: some View {
    HStack {
      VStack(spacing: 30) {
        ZStack {
          Rectangle()
            .fill(Color.white)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
          
          HStack {
            Text("색상")
            
            Spacer()
            
            Rectangle()
              .fill(viewModel.color)
              .frame(width: 15, height: 15)
          }
          .padding(.horizontal, 17)
        }
        Spacer()
        ColorView(color: $viewModel.color, calendarIdentifier: viewModel.category.calendarIdentifier)
        Spacer()
      }
      .padding(.horizontal, 15)
    }
    .onAppear {
      viewModel.color = fetchUserDefaultColor(calendarIdentifier: viewModel.category.calendarIdentifier)
    }
    .background(Color.backgroundGray)
  }
}

