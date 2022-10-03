//
//  Week.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

enum Week: String, CaseIterable {
  case sunday
  case monday
  case tuesday
  case wednessday
  case thursday
  case friday
  case saturday
  
  var short: String {
    switch self {
    case .sunday:
      return "sun"
    case .monday:
      return "mon"
    case .tuesday:
      return "tue"
    case .wednessday:
      return "wed"
    case .thursday:
      return "thu"
    case .friday:
      return "fri"
    case .saturday:
      return "sat"
    }
  }
  
  var koreanShort: String {
    switch self {
    case .sunday:
      return "월"
    case .monday:
      return "화"
    case .tuesday:
      return "수"
    case .wednessday:
      return "목"
    case .thursday:
      return "금"
    case .friday:
      return "토"
    case .saturday:
      return "일"
    }
  }
}
