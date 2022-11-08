//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct EventCategoriSettingView: View {
  @ObservedObject var viewModel: EventCategoriSettingViewModel
  
  var body: some View {
    HStack {
      VStack(spacing: 10) {
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.white)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
          
          HStack {
            Text("이모지")
            Spacer()
            Text(viewModel.emoji)
          }
          .padding(.horizontal, 15)
        }
        
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(Color.white)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
          
          HStack {
            Text("색상")
            Spacer()
            
            RoundedRectangle(cornerRadius: 2)
              .fill(viewModel.color)
              .frame(width: 16, height: 16)
          }
          .padding(.horizontal, 17)
        }
        Spacer()
        ColorView(color: $viewModel.color, calendarIdentifier: viewModel.category.calendarIdentifier)
        EmojiView(txt: $viewModel.emoji, calendarIdentifier: viewModel.category.calendarIdentifier, firstUnicode: 0x1F600, lastUnicode: 0x1F64F)
        Spacer()
      }
      .padding(.horizontal, 15)
    }
    .onAppear {
      viewModel.emoji = fetchUserDefaultEmoji(calendarIdentifier: viewModel.category.calendarIdentifier)
      viewModel.color = fetchUserDefaultColor(calendarIdentifier: viewModel.category.calendarIdentifier)
    }
    .background(Color.backgroundGray)
  }
}

