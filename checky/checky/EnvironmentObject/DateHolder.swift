//
//  DateHolder.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import Foundation

class DateHolder: ObservableObject {
//  static func == (lhs: DateHolder, rhs: DateHolder) -> Bool {
//    return lhs.date == rhs.date
//  }
  
   @Published var date = Date()
}
