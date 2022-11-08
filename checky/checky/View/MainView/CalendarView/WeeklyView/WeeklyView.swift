//
//  WeeklyView.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import SwiftUI

struct WeeklyView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: WeeklyViewModel
  
  var body: some View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 2)
    
    GeometryReader { geo in
      LazyVGrid(columns: columns, spacing: 0) {
        Text("")
        
        ForEach(viewModel.allDatesForDisplay) { value in
          
          let events = viewModel.filteredEvent(value.date)
          let reminders = viewModel.filteredReminder(value.date)
          let clearedReminders = viewModel.filteredClearedReminder(value.date)
          
          WeeklyCellView(viewModel: WeeklyCellViewModel(dateValue: value,
                                                        allEvnets: events,
                                                        dueDateReminders: reminders,
                                                        clearedReminders: clearedReminders,
                                                        eventManager: viewModel.eventManager,
                                                        reminderManager: viewModel.reminderManager))
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .frame(width: geo.size.width / 1.9, height: geo.size.height / viewModel.gridCloumnsCount * 2)
          .onTapGesture {
            coordinator.show(.daily(value.date, events, reminders, clearedReminders, viewModel.eventManager, viewModel.reminderManager))
            print("tabbed!!!")
          }
        }
      }
    }
    .frame(maxHeight: .infinity)
    .onReceive(viewModel.dateHolder.$date) { output in
      print("bbb")
      viewModel.action(.actionOnAppear)
    }
    .onAppear {
      viewModel.action(.actionOnAppear)
    }
  }
}
