//
//  CalendarGridViewModel.swift
//  checky
//
//  Created by song on 2022/10/06.
//

import Foundation

final class DayOfWeekStackViewModel: ObservableObject {
  let calendarHelper: CalendarProtocol
  
  init(calendarHelper: CalendarProtocol = MonthyCalendarHelper()) {
    self.calendarHelper = calendarHelper
  }
}
