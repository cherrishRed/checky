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
  
  func daysInMonth(_ date: Date) -> Int {
    let range = calendar.range(of: .day, in: .month, for: date)!
    return range.count
  }
  
  func dayOfMonth(_ date: Date) -> Int {
    let components = calendar.dateComponents([.day], from: date)
    return components.day!
  }
  
  func firstOfMonth(_ date: Date) -> Date {
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
  }
  
  func weekDay(_ date: Date) -> Int {
    let components = calendar.dateComponents([.weekday, .month], from: date)
    
    return components.weekday! - 2
  }
}
