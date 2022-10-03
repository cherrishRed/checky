//
//  CalenderHelper.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

struct CalendarHelper {
  let calendar = Calendar.current
  let dataFormatter = DateFormatter()

  func monthYearString(_ date: Date) -> String {
    dataFormatter.dateFormat = "LLL YYYY"
    return dataFormatter.string(from: date)
  }

  func plusMonth(_ date: Date) -> Date {
    return calendar.date(byAdding: .month, value: 1, to: date)!
  }
  
  func minusMonth(_ date: Date) -> Date {
    return calendar.date(byAdding: .month, value: -1, to: date)!
  }

}
