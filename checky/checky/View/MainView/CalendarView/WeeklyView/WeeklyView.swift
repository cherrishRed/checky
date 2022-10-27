//
//  WeeklyView.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import SwiftUI

struct WeeklyView: View {
  @StateObject var viewModel: WeeklyViewModel
  
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
      
      CalendarGrid
      
      Spacer()
    }
    .background(Color.backgroundGray)
    .onAppear {
      viewModel.action(.actionOnAppear)
    }
  }
}

extension WeeklyView {
  var CalendarGrid: some View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 2)
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 0) {
          Text("달력 그릴 뷰")
          
          ForEach(viewModel.allDatesForDisplay) { value in
            
            let events = viewModel.filteredEvent(value.date)
            let reminders = viewModel.filteredReminder(value.date)
            
            WeeklyCellView(viewModel: WeeklyCellViewModel(
              dateValue: value,
              allEvnets: events,
              allReminders: reminders))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .frame(width: geo.size.width / 1.9, height: geo.size.height / viewModel.gridCloumnsCount * 2)
          }
        }
      }
      .frame(maxHeight: .infinity)
      .gesture(
        DragGesture()
          .onChanged { value in
            viewModel.currentOffsetY = value.translation
          }
          .onEnded { value in
            viewModel.action(.dragGestur)
            withAnimation(.none) {
              viewModel.action(.resetCurrentOffsetY)
            }
          }
      )
    }
    return body
  }
}
