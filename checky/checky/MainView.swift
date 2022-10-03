//
//  ContentView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var dateHolder: DateHolder
  @State var weekOption = "KoreanShot"
  @State var startingWeek: Week = Week.sunday
  
  var body: some View {
    VStack(spacing: 1) {
      DateScrollerView()
        .environmentObject(dateHolder)
        .padding()
      
      dayOfWeekStack
      
      calendarGrid
    }
  }
  
  var dayOfWeekStack: some View {
    HStack(spacing: 1) {
      ForEach(startingWeek.allWeeks(), id: \.rawValue) { week in
        if weekOption == "KoreanShot" {
          Text(week.koreanShort)
            .weekStyle()
        } else if weekOption == "EnglishShort" {
          Text(week.short)
            .weekStyle()
        } else {
          Text(week.rawValue)
            .weekStyle()
        }
      }
    }
  }
  
  var calendarGrid: some View {
    
    VStack(spacing: 1) {
      
      let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
      let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
      let startingSpace = CalendarHelper().weekDay(firstDayOfMonth)
      let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
      let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
      
      ForEach(0..<6) { row in
        HStack(spacing: 1) {
          ForEach(1..<8) { column in
            let count = column + (row * 7)
            CalendarCell(count: count, startingSpaces: startingSpace, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
              .environmentObject(dateHolder)
          }
        }
      }
    }
    .frame(maxWidth: .infinity)
  }
}

extension Text {
  func weekStyle() -> some View {
    self.frame(maxWidth: .infinity)
      .padding(.top)
      .lineLimit(1)
  }
}
