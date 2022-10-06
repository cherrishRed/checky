//
//  HeaderViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import Foundation

class HeaderViewModel: ObservableObject {
  private let calendarHelper: CalendarHelper
  @Published var dateHolder: DateHolder
  
  init(dateHolder: DateHolder, calendarHelper: CalendarHelper) {
    self.dateHolder = dateHolder
    self.calendarHelper = calendarHelper
  }
  
  var displayMonth: String {
    return calendarHelper.monthYearString(dateHolder.date)
  }
}
