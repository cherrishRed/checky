//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit
import Combine

struct EventCategoriSettingView: View {
  @ObservedObject var viewModel: EventCategoriSettingViewModel
  
  var body: some View {
    HStack {
      VStack(spacing: 30) {
        ZStack {
          Rectangle()
            .fill(Color.white)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
          
          HStack {
            Text("이모지")
            Spacer()
            Text(viewModel.imoji)
          }
          .padding(.horizontal, 15)
        }
        
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
        EmojiView(txt: $viewModel.imoji, calendarIdentifier: viewModel.category.calendarIdentifier, firstUnicode: 0x1F600, lastUnicode: 0x1F64F)
        Spacer()
      }
      .padding(.horizontal, 15)
    }
    .onAppear {
      viewModel.imoji = fetchUserDefaultEmoji(calendarIdentifier: viewModel.category.calendarIdentifier)
      viewModel.color = fetchUserDefaultColor(calendarIdentifier: viewModel.category.calendarIdentifier)
    }
    .background(Color.backgroundGray)
  }
}

