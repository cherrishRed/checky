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
// 여기서부터
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
      
  //여길경계로    
        WeeklyView(viewModel:  WeeklyViewModel(dateHolder: DateHolder(), eventManager: EventManager(), reminderManager: ReminderManager(), calendarHelper: WeeklyCalendarHelper(), moveToMonthly: {
          viewModel.mode.toggle()
        }))
      } else {
        MonthlyView(viewModel:  MonthlyViewModel(dateHolder: DateHolder(), eventManager: EventManager(), reminderManager: ReminderManager(), calendarHelper: MonthyCalendarHelper(), moveToWeek: {
          viewModel.mode.toggle()
        }))
      }
    }.onAppear {
      EventManager().getPermission()
      ReminderManager().getPermission()
//여기서부터
    }
  }
}
