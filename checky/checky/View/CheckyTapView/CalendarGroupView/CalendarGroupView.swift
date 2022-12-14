//
//  CalendarView.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import SwiftUI
import Combine
import EventKit

struct CalendarGroupView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: CalendarGroupViewModel = CalendarGroupViewModel()
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  
  var dateHolder = DateHolder()
  var body: some View {
    Group {
      if viewModel.mode {
        WeeklyView(viewModel: WeeklyViewModel(dateHolder: dateHolder, eventManager: eventManager, reminderManager: reminderManager, calendarHelper: WeeklyCalendarHelper(), moveToMonthly: { viewModel.mode.toggle() } ))
          .environmentObject(coordinator)
        
      } else {
        MonthlyView(viewModel: MonthlyViewModel(dateHolder: dateHolder, eventManager: eventManager, reminderManager: reminderManager, calendarHelper: MonthyCalendarHelper(), moveToWeekly: { viewModel.mode.toggle() }))
        .environmentObject(coordinator)
      }
    }
    .onAppear {
      eventManager.getPermission()
      reminderManager.getPermission()
    }
  }
}
