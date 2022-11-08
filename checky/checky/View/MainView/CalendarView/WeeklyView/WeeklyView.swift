//
//  WeeklyView.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

struct WeeklyView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: WeeklyViewModel
  
  var body: some View {
    VStack(spacing: 1) {
      HeaderView(viewModel: HeaderViewModel(dateHolder: viewModel.dateHolder, calendarHelper: viewModel.calendarHelper))
      
      HStack {
        Spacer()
        if viewModel.currentWeek == false {
          Button("Today") {
            viewModel.dateHolder.date = Date()
          }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
        }
        
        Button("Monthly") { viewModel.action(.moveToMonthly) }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
          .padding(.horizontal, 10)
      }
      
      ZStack(alignment: .topLeading) {
        
        GeometryReader { geo in
          let weeklyBlockViewModel = WeeklyBlockViewModel(dateHolder: viewModel.dateHolder, eventManager: viewModel.eventManager, reminderManager: viewModel.reminderManager, calendarHelper: viewModel.calendarHelper)
          
          WeeklyBlockView(viewModel: weeklyBlockViewModel)
          
          VStack(spacing: 0) {
            DayOfWeekStackView(viewModel: DayOfWeekStackViewModel())
              .padding(.horizontal, 16)
            
            miniCalendarView
          }
          .frame(width: geo.size.width / 2, height: geo.size.height / 4)
          .background(Color.backgroundGray)
        }
      }
      
      HStack(spacing: 10) {
        Button {
          viewModel.action(.moveToPreviousWeek)
        } label: {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.basicWhite)
            Image(systemName: "arrow.left")
              .foregroundColor(Color.fontBlack)
          }
        }
        
        Button {
          viewModel.action(.moveToNextWeek)
        } label: {
          ZStack {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color.basicWhite)
            Image(systemName: "arrow.right")
              .foregroundColor(Color.fontBlack)
          }
        }
      }
      .frame(height: 20)
      .padding(.bottom, 10)
      .padding(.horizontal, 4)
    }
    .background(Color.backgroundGray)
  }
}

extension WeeklyView {
  var miniCalendarView: some View {
    GeometryReader { geo in
      let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
      ZStack(alignment: .top) {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.backgroundLightGray)
          .padding(.horizontal, 10)
          .frame(height: 16, alignment: .center)
          .frame(maxWidth: .infinity)
          .offset(y: viewModel.minicarOffset)
          .animation(.easeInOut, value: viewModel.minicarOffset)
        
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
    .onReceive(viewModel.dateHolder.$date) { changed in
      viewModel.action(.changeMinicarOffset)
    }
  }
}
