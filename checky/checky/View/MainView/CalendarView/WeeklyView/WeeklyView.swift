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
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 2)
    
    GeometryReader { geo in
      LazyVGrid(columns: columns, spacing: 0) {
        Text("")
        
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
    .onAppear {
      viewModel.action(.actionOnAppear)
    }
  }
}
