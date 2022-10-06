//
//  CalendarGridViewModel.swift
//  checky
//
//  Created by song on 2022/10/06.
//

import Foundation

class DayOfWeekStackViewModel: ObservableObject {
  let calendarHelper: CalendarHelper
  
  init(calendarHelper: CalendarHelper = CalendarHelper()) {
    self.calendarHelper = calendarHelper
  }
}
