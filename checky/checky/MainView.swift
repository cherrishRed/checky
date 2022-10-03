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
  
  var CalendarGrid: some View {
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
      LazyVGrid(columns: columns, spacing: 15) {
        ForEach(extractDates()) { value in
          Text(value.date.day)
            .foregroundColor(value.isCurrentMonth ? .black : .gray)
        }
      }
    }
    return body
  }
  
  func extractDates() -> [DateValue] {
    return []
  }
  
  private func previousDates(firstDayOfMonth: Date) -> [Date] {
    let calendar = Calendar.current
    let customWeekStart = startingWeek
    let firstDayOfWeekday = calendar.component(.weekday, from: firstDayOfMonth)
    
    guard let firstWeekday = Week(rawValue: firstDayOfWeekday) else {
      return []
    }
    
    var previousMonthDayCount: Int = 0
    
    if customWeekStart.rawValue > firstWeekday.rawValue {
      previousMonthDayCount = 7 - customWeekStart.rawValue + firstWeekday.rawValue
    } else {
      previousMonthDayCount = firstWeekday.rawValue - customWeekStart.rawValue
    }
    
    var previousDays: [Date] = []
    
    if previousMonthDayCount != 0 {
      for number in 1...previousMonthDayCount {
        guard let day = calendar.date(byAdding: .day, value: -number, to: firstDayOfMonth) else {
          return []
        }
        previousDays.insert(day, at: 0)
      }
    }
    
    return previousDays
  }
}

extension Text {
  func weekStyle() -> some View {
    self.frame(maxWidth: .infinity)
      .padding(.top)
      .lineLimit(1)
  }
}
