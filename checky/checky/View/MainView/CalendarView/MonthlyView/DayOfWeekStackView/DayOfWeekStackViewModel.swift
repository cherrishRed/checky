//
//  CalendarGridViewModel.swift
//  checky
//
//  Created by song on 2022/10/06.
//

import Foundation

class DayOfWeekStackViewModel: ObservableObject {
  let calendarHelper: CalendarCanDo
  
  init(calendarHelper: CalendarCanDo = MonthyCalendarHelper()) {
    self.calendarHelper = calendarHelper
  }
}
