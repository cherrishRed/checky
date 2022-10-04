//
//  DateValue.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation

struct DateValue: Identifiable {
  let date: Date
  let id: String
  let isCurrentMonth: Bool
  
  init(date: Date,
       id: String = UUID().uuidString,
       isCurrentMonth: Bool = true
  ) {
    self.date = date
    self.id = id
    self.isCurrentMonth = isCurrentMonth
  }
}
