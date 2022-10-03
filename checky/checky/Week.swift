//
//  Week.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

enum Week: Int, CaseIterable {
  case sunday = 1
  case monday = 2
  case tuesday = 3
  case wednessday = 4
  case thursday = 5
  case friday = 6
  case saturday = 7
  
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
      return "일"
    case .monday:
      return "월"
    case .tuesday:
      return "화"
    case .wednessday:
      return "수"
    case .thursday:
      return "목"
    case .friday:
      return "금"
    case .saturday:
      return "토"
    }
  }
}
