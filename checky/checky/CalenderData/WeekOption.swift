//
//  WeekOption.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/05.
//

import Foundation

enum WeekOption {
  case KoreanShort
  case EnglishShort
  
  var description: String {
    switch self {
    case .KoreanShort:
      return "KoreanShort"
    case .EnglishShort:
      return "EnglishShort"
    }
  }
}
