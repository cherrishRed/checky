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
  
  func dateCompare(fromDate: Date) -> CompareDataState {
    var strDateMessage: CompareDataState
    let result:ComparisonResult = self.compare(fromDate)
    switch result {
    case .orderedAscending:
      strDateMessage = CompareDataState.orderedAscending
      break
    case .orderedDescending:
      strDateMessage = CompareDataState.orderedDescending
      break
    case .orderedSame:
      strDateMessage = CompareDataState.orderedSame
      break
    default:
      strDateMessage = CompareDataState.error
      break
    }
    return strDateMessage
  }
}

enum CompareDataState {
  case orderedAscending
  case orderedDescending
  case orderedSame
  case error
}
