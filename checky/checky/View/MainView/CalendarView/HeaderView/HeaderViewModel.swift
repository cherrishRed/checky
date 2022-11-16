//
//  HeaderViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import Foundation

class HeaderViewModel: ObservableObject {
  private let calendarHelper: CalendarProtocol
  private let dateHolder: DateHolder
  
  init(dateHolder: DateHolder, calendarHelper: CalendarProtocol) {
    self.dateHolder = dateHolder
    self.calendarHelper = calendarHelper
  }
  
  var displayMonth: String {
    return calendarHelper.monthYearString(dateHolder.date)
  }
}
