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
          
          MonthlyCellView(viewModel: MonthlyCellViewModel(dateValue: value,
                                                          allEvnets: events,
                                                          allReminders: reminders))
          .onTapGesture {
            coordinator.show(.daily(events, reminders, viewModel.reminderManager))
            print("tabbed!!!chell")
          }
          
          .frame(width: geo.size.width / 7, height: geo.size.height / columnsCount)
        }
      }
    }
    .frame(maxHeight: .infinity)
    .onAppear {
      viewModel.action(.actionOnAppear)
    }
  }
}
