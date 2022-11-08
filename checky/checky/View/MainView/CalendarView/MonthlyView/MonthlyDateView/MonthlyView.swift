//
//  ContentView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct MonthlyView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: MonthlyViewModel
  
  var body: some View {
    GeometryReader { geo in
      let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
      let columnsCount: CGFloat = viewModel.gridCloumnsCount
      
      LazyVGrid(columns: columns, spacing: 0) {
        ForEach(viewModel.allDatesForDisplay) { value in
          
          let events = viewModel.filteredEvent(value.date)
          let reminders = viewModel.filteredReminder(value.date)
          let clearedReminders = viewModel.filteredClearedReminder(value.date)
          
          MonthlyCellView(viewModel: MonthlyCellViewModel(dateValue: value,
                                                          allEvnets: events,
                                                          dueDateReminders: reminders,
                                                          clearedReminders: clearedReminders,
                                                          eventManager: viewModel.eventManager,
                                                          reminderManager: viewModel.reminderManager))
          
          .onTapGesture {
            coordinator.show(.daily(value.date, events, reminders, clearedReminders, viewModel.eventManager, viewModel.reminderManager))
          }
          .frame(width: geo.size.width / 7, height: geo.size.height / columnsCount, alignment: .top)
          .clipped()
        }
      }
    }
    .frame(maxHeight: .infinity)
    .onAppear {
      viewModel.action(.actionOnAppear)
    }
  }
}
