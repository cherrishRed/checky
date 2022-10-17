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
      WeeklyView(viewModel:  WeeklyViewModel(dateHolder: DateHolder(), eventManager: EventManager(), calendarHelper: CalendarHelper(), moveToMonthly: {
        viewModel.mode.toggle()
      }))
    } else {
      MonthlyView(viewModel:  MonthlyViewModel(dateHolder: DateHolder(), eventManager: EventManager(), calendarHelper: CalendarHelper(), moveToWeek: {
        viewModel.mode.toggle()
      }))
    }
  }
}
