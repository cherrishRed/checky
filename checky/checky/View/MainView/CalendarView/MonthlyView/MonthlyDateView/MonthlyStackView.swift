//
//  MonthlyStackView.swift
//  checky
//
//  Created by RED on 2022/10/28.
//

import SwiftUI

struct MonthlyStackView: View {
  @StateObject var viewModel: MonthlyStackViewModel
  
  var body: some View {
    VStack(spacing: 1) {
      HeaderView(viewModel: HeaderViewModel(dateHolder: viewModel.dateHolder, calendarHelper: viewModel.calendarHelper))
      HStack {
        Spacer()
        
        Button("Weekly") { viewModel.action(.moveToWeekly) }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
          .padding(.horizontal, 10)
      }
      
      GeometryReader { geo in
        VStack {
            LazyHStack {
                ForEach(viewModel.pastCurrentFutureDates, id: \.self) { date in
                    let _ = print(date)
                  VStack {
                    DayOfWeekStackView(viewModel: DayOfWeekStackViewModel())
                      .frame(width: geo.size.width, height: 30)
                    MonthlyView(viewModel: MonthlyViewModel(date: date, eventManager: viewModel.eventManager, reminderManager: viewModel.reminderManager, calendarHelper: viewModel.calendarHelper, moveToWeek: viewModel.moveToWeek))
                      .frame(width: geo.size.width, height: geo.size.height-30)
                  }
                }
            }
          .animation(.easeInOut, value: viewModel.currentOffsetX)
          .offset(x: viewModel.currentOffsetX)
          .gesture(DragGesture().onEnded({ gesture in

            if gesture.translation.width > 0 {
              viewModel.action(.moveToPreviousMonth)
            }

            if gesture.translation.width < 0 {
              viewModel.action(.moveToNextMonth)
            }
          }))
          .onChange(of: viewModel.currentIndex) { index in
            viewModel.action(.onChagnedIndex(index))
          }
        }
      }
      .background(Color.basicWhite)
      .cornerRadius(20)
      .padding(.horizontal, 4)
      .padding(.top, 10)
      .padding(.bottom, 10)
    }
    .background(Color.backgroundGray)
  }
}
