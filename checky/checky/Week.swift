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
  
  func allWeeks() -> [Week] {
    switch self {
    case .sunday:
      return [.sunday, .monday, .tuesday, .wednessday, .thursday, .friday, .saturday]
    case .monday:
      return [.monday, .tuesday, .wednessday, .thursday, .friday, .saturday, .sunday]
    case .tuesday:
      return [.tuesday, .wednessday, .thursday, .friday, .saturday, .sunday, .monday]
    case .wednessday:
      return [.wednessday, .thursday, .friday, .saturday, .sunday, .monday, .tuesday]
    case .thursday:
      return [.thursday, .friday, .saturday, .sunday, .monday, .tuesday, .wednessday]
    case .friday:
      return [.friday, .saturday, .sunday, .monday, .tuesday, .thursday, .wednessday]
    case .saturday:
      return [.saturday, .sunday, .monday, .tuesday, .wednessday, .thursday, .friday]
    }
  }
}
