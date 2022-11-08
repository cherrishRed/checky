//
//  CalendarView.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import SwiftUI
import Combine
import EventKit

struct CalendarView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
  
  var eventManager: EventManager = EventManager()
  var reminderManager: ReminderManager = ReminderManager()
  var dateHolder = DateHolder()
  var body: some View {
    Group {
      if viewModel.mode {
        WeeklyStackView(viewModel: WeeklyStackViewModel(dateHolder: dateHolder, eventManager: eventManager, reminderManager: reminderManager, calendarHelper: WeeklyCalendarHelper(), moveToMonthly: { viewModel.mode.toggle() } ))
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
