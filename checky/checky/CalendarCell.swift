//
//  CalendarCell.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import SwiftUI

struct CalendarCell: View {
  @EnvironmentObject var dateHolder: DateHolder
  var date: Date
  var isCurrentDate: Bool = true
  
    var body: some View {
//      let date = calendar.dateComponents([.day], from: date)
      Text(date.onlyDay)
    }
}

// Calendar cell 에 있어야 할 내용이
// Date 와 요일이 없다면 요일
// isCurrentMonth: Bool

extension Date {
  var onlyDay: String {
    let dateformmater = DateFormatter()
    dateformmater.dateFormat = "d"
    return dateformmater.string(from: self)
  }
}
