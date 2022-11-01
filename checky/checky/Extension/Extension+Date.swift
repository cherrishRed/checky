//
//  Extension+Date.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation

extension Date {
  func getAllDates() -> [Date] {
    
    let calendar = Calendar.current
    guard let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
      return []
    }
    guard let range = calendar.range(of: .day, in: .month, for: startDate) else {
      return []
    }
    
    return range.compactMap { day -> Date in
      guard let day = calendar.date(byAdding: .day, value: day - 1, to: startDate) else {
        return Date()
      }
      return day
    }
  }
  
  var day: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "d"
    return dateformmater.string(from: self)
  }
  
  var month: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "M"
    return dateformmater.string(from: self)
  }
  
  var year: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "yyyy"
    return dateformmater.string(from: self)
  }
  
  var dayOfWeek: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE"
    formatter.locale = Locale(identifier:"en_US")
    let convertStr = formatter.string(from: self).uppercased()
    return convertStr
  }
  
  var dateKoreanWithYear: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "yyyy년 M월 d일"
    return dateformmater.string(from: self)
  }
  
  var dateKorean: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "M월 d일"
    return dateformmater.string(from: self)
  }
  
  var time: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "a hh : mm "
    return dateformmater.string(from: self)
  }
  
  func compareWithoutTime(_ date: Date) -> Bool {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "yyyy년 M월 d일"
    return dateformmater.string(from: self) == dateformmater.string(from: date)
  }
}
