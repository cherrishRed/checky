//
//  CalendarCell.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/03.
//

import SwiftUI

struct CalendarCell: View {
  @EnvironmentObject var dateHolder: DateHolder
  let count: Int
  let startingSpaces: Int
  let daysInMonth: Int
  let daysInPrevMonth: Int
  
    var body: some View {
      Text(monthStruct().day())
        .foregroundColor(textColor(type: monthStruct().monthType))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  
  func textColor(type: MonthType) -> Color {
    return type == MonthType.current ? Color.black : Color.gray
  }
  
  func monthStruct() -> MonthStruct {
    let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
    if(count <= start) {
      let day = daysInPrevMonth + count - start
      return MonthStruct(monthType: MonthType.previous, dayInt: day)
      
    } else if (count - start > daysInMonth) {
      let day = count - start - daysInMonth
      return MonthStruct(monthType: MonthType.next, dayInt: day)
    }
    let day = count - start
    return MonthStruct(monthType: MonthType.current, dayInt: day)
  }
}
