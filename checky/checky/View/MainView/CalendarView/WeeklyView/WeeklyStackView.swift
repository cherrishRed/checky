//
//  WeeklyStackView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct WeeklyStackView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
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
      
      ZStack(alignment: .topLeading) {
        
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
          
          VStack(spacing: 0) {
            DayOfWeekStackView(viewModel: DayOfWeekStackViewModel())
              .padding(.horizontal, 16)
            miniCalendarView
          }
          .frame(width: geo.size.width / 2, height: geo.size.height / 4)
          .background(Color.backgroundGray)
        }
      }
    }
    .background(Color.backgroundGray)
  }
}

extension WeeklyStackView {
  var miniCalendarView: some View {
    GeometryReader { geo in
      let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
      ZStack(alignment: .top) {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.backgroundLightGray)
          .padding(.horizontal, 10)
          .frame(height: 16, alignment: .center)
          .frame(maxWidth: .infinity)
          .offset(y: viewModel.minimunCalendarWeekheight)
          .animation(.easeInOut, value: viewModel.minimunCalendarWeekheight)
        
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(viewModel.extractMonthDates()) { value in
            
            Text(value.date.day)
              .font(.caption2)
              .foregroundColor(value.isCurrentMonth ? Color.fontBlack : Color.fontMediumGray)
              .frame(width: 20, height: 16, alignment: .center)
          }
        }
        .padding(.horizontal)
      }
    }
  }
}
