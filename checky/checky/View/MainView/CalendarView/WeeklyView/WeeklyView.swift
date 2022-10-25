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
        
        Button("Monthly") { viewModel.moveToMonthly() }
          .buttonStyle(ToggleButtonStyle())
          .padding(.top, 10)
          .padding(.horizontal, 10)
      }
      
      CalendarGrid
      Spacer()
    }
    .background(Color("backgroundGray"))
    .onAppear {
      viewModel.getPermission()
      viewModel.fetchEvents()
      viewModel.fetchReminder()
    }
  }
}

extension WeeklyView {
  var CalendarGrid: some View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 2)
    let columnsCount: CGFloat = 8
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 0) {
          Text("달력 그릴 뷰")
          ForEach(viewModel.allDatesForDisplay) { value in
            WeeklyCellView(viewModel: WeeklyCellViewModel(dateValue: value, allEvnets: viewModel.filteredEvent(value.date), allReminders: viewModel.filteredReminder(value.date)))
              .padding(.horizontal, 10)
              .padding(.vertical, 6)
              .frame(width: geo.size.width / 1.9, height: geo.size.height / columnsCount * 2)
          }
        }
      }
      .frame(maxHeight: .infinity)
    }
    return body
  }
}
