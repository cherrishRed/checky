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
  
  var body: some View {
    Group {
      if viewModel.mode {
        WeeklyStackView(viewModel: WeeklyStackViewModel(dateHolder: DateHolder(), eventManager: eventManager, reminderManager: reminderManager, calendarHelper: WeeklyCalendarHelper(), offsetWidth: UIScreen.main.bounds.width, moveToMonthly: { viewModel.mode.toggle() } ))
          .environmentObject(coordinator)
        
      } else {
        MonthlyStackView(viewModel:  MonthlyStackViewModel(dateHolder: DateHolder(), eventManager: eventManager, reminderManager: reminderManager, calendarHelper: MonthyCalendarHelper(), offsetWidth: UIScreen.main.bounds.width, moveToWeek: {
          viewModel.mode.toggle()
        }))
        .environmentObject(coordinator)
      }
    }
    .onAppear {
      eventManager.getPermission()
      reminderManager.getPermission()
    }
  }
}
