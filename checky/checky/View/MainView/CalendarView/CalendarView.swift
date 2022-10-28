//
//  CalendarView.swift
//  checky
//
//  Created by song on 2022/10/17.
//

import SwiftUI
import Combine

struct CalendarView: View {
  @StateObject var viewModel: CalendarViewModel = CalendarViewModel()
  
  var body: some View {
    
    if viewModel.mode {
      WeeklyView(viewModel:  WeeklyViewModel(dateHolder: DateHolder(), eventManager: EventManager(), reminderManager: ReminderManager(), calendarHelper: WeeklyCalendarHelper(), moveToMonthly: {
        viewModel.mode.toggle()
      }))
    } else {
      MonthlyStackView(viewModel:  MonthlyStackViewModel(dateHolder: DateHolder(), eventManager: EventManager(), reminderManager: ReminderManager(), calendarHelper: MonthyCalendarHelper(), offsetWidth: UIScreen.main.bounds.width, moveToWeek: {
        viewModel.mode.toggle()
      }))
    }
  }
}
