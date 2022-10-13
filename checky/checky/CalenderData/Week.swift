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
      return "S"
    case .monday:
      return "M"
    case .tuesday:
      return "T"
    case .wednessday:
      return "W"
    case .thursday:
      return "T"
    case .friday:
      return "F"
    case .saturday:
      return "S"
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
