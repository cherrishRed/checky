//
//  WeeklyStackView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct WeeklyStackView: View {
  @StateObject var viewModel: WeeklyStackViewModel
  
  var body: some View {
    VStack(spacing: 1) {
      HeaderView(viewModel: HeaderViewModel(dateHolder: viewModel.dateHolder, calendarHelper: viewModel.calendarHelper))
      
      HStack {
        Spacer()
        
        Button("Monthly") { viewModel.action(.moveToMonthly) }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
          .padding(.horizontal, 10)
      }
      
      GeometryReader { geo in
          LazyHStack {
            ForEach(viewModel.pastCurrentFutureDates, id: \.self) { date in
              WeeklyView(viewModel: WeeklyViewModel(date: date, eventManager: viewModel.eventManager, reminderManager: viewModel.reminderManager, calendarHelper: viewModel.calendarHelper))
                .frame(width: geo.size.width, height: geo.size.height)
            }
          }
          .animation(.easeInOut, value: viewModel.currentOffsetX)
          .offset(x: viewModel.currentOffsetX-8)
          .gesture(DragGesture().onEnded({ gesture in

            if gesture.translation.width > 0 {
              viewModel.action(.moveToPreviousWeek)
            }

            if gesture.translation.width < 0 {
              viewModel.action(.moveToNextWeek)
            }
          }))
          .onChange(of: viewModel.currentIndex) { index in
            viewModel.action(.onChagnedIndex(index))
          }
      }
    }
    .background(Color.backgroundGray)
  }
}
