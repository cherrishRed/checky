//
//  EventButtonView.swift
//  checky
//
//  Created by song on 2022/11/01.
//

import SwiftUI
import EventKit

struct ReminderCategoriSettingView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @ObservedObject var viewModel: ReminderCategoriSettingViewModel
  
  var body: some View {
      VStack {
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
        VStack(spacing: 30) {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.white)
              .frame(height: 30)
              .frame(maxWidth: .infinity)
            
            HStack {
              Text("색상")
              
              Spacer()
              
              RoundedRectangle(cornerRadius: 4)
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
      coordinator.navigationController.isNavigationBarHidden = true
    }
    .background(Color.backgroundGray)
  }
}

