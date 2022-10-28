//
//  CalendarView.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import SwiftUI
import Combine

struct CalendarView: View {
  @EnvironmentObject var coordinator: Coordinator<checkyRouter>
  @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
  
  var body: some View {
    
    if viewModel.mode {
      WeeklyStackView(viewModel: WeeklyStackViewModel(dateHolder: DateHolder(), eventManager: EventManager(), reminderManager: ReminderManager(), calendarHelper: WeeklyCalendarHelper(), offsetWidth: UIScreen.main.bounds.width, moveToMonthly: { viewModel.mode.toggle() } ))
        .environmentObject(coordinator)

    } else {
      MonthlyStackView(viewModel:  MonthlyStackViewModel(dateHolder: DateHolder(), eventManager: EventManager(), reminderManager: ReminderManager(), calendarHelper: MonthyCalendarHelper(), offsetWidth: UIScreen.main.bounds.width, moveToWeek: {
        viewModel.mode.toggle()
      }))
      .environmentObject(coordinator)
    }
  }
}
