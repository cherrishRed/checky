//
//  DateValue.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation

struct DateValue: Identifiable {
  var id = UUID().uuidString
  var date: Date
  var isCurrentMonth: Bool = true

}
