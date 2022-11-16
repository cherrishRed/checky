//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct EventCategoriSettingView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var viewModel: EventCategoriSettingViewModel
  
  var body: some View {
    VStack(spacing: 10) {
        ZStack(alignment: .leading) {
          Text(viewModel.category.title)
              .font(.title)
              .bold()
              .foregroundColor(Color.fontBlack)
              .frame(maxWidth: .infinity)
          
          Button {
            coordinator.pop()
          } label: {
            Image(systemName: "chevron.backward")
              .foregroundColor(Color.fontBlack)
              .padding(.horizontal)
          }
        }
        .background(Color.basicWhite)
      
        VStack(spacing: 10) {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.basicWhite)
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
              .fill(Color.basicWhite)
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
      
      coordinator.navigationController.isNavigationBarHidden = true
    }
    .background(Color.backgroundGray)
  }
}

