//
//  AlramTime.swift
//  checky
//
//  Created by RED on 2022/10/12.
//

import Foundation

enum AlramTime: CaseIterable {
  case none
  case onTime
  case fiveMinute
  case tenMinute
  case fifteenMinute
  case thirtyMinute
  case oneHour
  case twoHours
  case oneDay
  case twoDays
  case oneWeek
  
  var korean: String {
    switch self {
      case .none:
        return "알림없음"
      case .onTime:
        return "이벤트당시"
      case .fiveMinute:
        return "5분전"
      case .tenMinute:
        return "10분전"
      case .fifteenMinute:
        return "15분전"
      case .thirtyMinute:
        return "30분전"
      case .oneHour:
        return "1시간전"
      case .twoHours:
        return "2시간전"
      case .oneDay:
        return "1일 전"
      case .twoDays:
        return "2일 전"
      case .oneWeek:
        return "1주전"
    }
  }
  
  var second: Double {
    switch self {
      case .none:
        return 0
      case .onTime:
        return 0
      case .fiveMinute:
        return -300
      case .tenMinute:
        return -600
      case .fifteenMinute:
        return -900
      case .thirtyMinute:
        return -1800
      case .oneHour:
        return -3600
      case .twoHours:
        return -7200
      case .oneDay:
        return -86400
      case .twoDays:
        return -172800
      case .oneWeek:
        return -604800
    }
  }
}
