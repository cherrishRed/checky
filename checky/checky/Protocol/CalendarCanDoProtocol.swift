//
//  CalendarCanDoProtocol.swift
//  checky
//
//  Created by song on 2022/10/25.
//

import Foundation

protocol CalendarCanDo {
  var weekOption: WeekOption { get set }
  var startingWeek: Week { get set }
  var calendar: Calendar { get set }
  
  func plusDate(_ date: Date) -> Date
  func minusDate(_ date: Date) -> Date
  func extractDates(_ date: Date) -> [DateValue]
}

extension CalendarCanDo {
  func monthYearString(_ date: Date) -> String {
    let dataFormatter = DateFormatter()
    dataFormatter.dateFormat = "LLL YYYY"
    return dataFormatter.string(from: date)
  }
}
