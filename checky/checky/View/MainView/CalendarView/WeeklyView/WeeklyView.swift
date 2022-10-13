//
//  WeeklyView.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import SwiftUI

struct WeeklyView: View {
  @ObservedObject var viewModel: WeeklyViewModel
  
  var body: some View {
    VStack {
      HeaderView(viewModel: HeaderViewModel(dateHolder: viewModel.dateHolder, calendarHelper: viewModel.calendarHelper))
      CalendarGrid
    }
    .onAppear {
      viewModel.getPermission()
      viewModel.fetchEvents()
      viewModel.fetchReminder()
    }
  }
  
  var CalendarGrid: some View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 2)
    let columnsCount: CGFloat = 8
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(viewModel.allDatesForDisplay) { value in
            WeeklyCellView(dateValue: value, allEvnets: viewModel.filteredEvent(value.date), allReminders: viewModel.filteredReminder(value.date))
              .frame(width: geo.size.width / 2, height: geo.size.height / columnsCount * 2)
          }
        }
      }
      .frame(maxHeight: .infinity)
    }
    return body
  }
}


