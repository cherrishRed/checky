//
//  MonthStruct.swift
//  checky
//
//  Created by RED, Teagnel on 2022/10/03.
//

import Foundation

struct MonthStruct {
  var monthType: MonthType
  var dayInt: Int
  
  func day() -> String {
    return String(dayInt)
  }
}

enum MonthType {
  case previous
  case current
  case next
}
