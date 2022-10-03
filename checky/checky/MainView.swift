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
  @State var plusMinusMonth: Int = 0
  
  var body: some View {
    VStack(spacing: 1) {
      DateScrollerView()
        .environmentObject(dateHolder)
        .padding()
      
      dayOfWeekStack
      
      CalendarGrid
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
          Text("\(week.rawValue)")
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
  
  private func extractDates() -> [DateValue] {
    let calendar = Calendar.current
    guard let currentMonth = calendar.date(byAdding: .month, value: plusMinusMonth, to: dateHolder.date) else { return [] }
    
    let days = currentMonth.getAllDates()
    let firstDayOfMonth = days.first!
    let lastDayOfMonth = days.last!
    let previousDays = previousDates(firstDayOfMonth: firstDayOfMonth)
    let nextDays = nextDates(lastDayOfMonth: lastDayOfMonth)
    var result: [DateValue]  = []
    
    for previousDay in previousDays {
      let day = DateValue(date: previousDay, isCurrentMonth: false)
      result.append(day)
    }
    
    for day in days {
      result.append(DateValue(date: day))
    }
    
    for nextDay in nextDays {
      let day = DateValue(date: nextDay, isCurrentMonth: false)
      result.append(day)
    }
    
    return result
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
  
  private func nextDates(lastDayOfMonth: Date) -> [Date] {
     let calendar = Calendar.current
     let customWeekStart = startingWeek
     let lastDayOfWeekday = calendar.component(.weekday, from: lastDayOfMonth)
    guard let lastWeekday = Week(rawValue: lastDayOfWeekday) else {
      return []
    }
     
     var nextMonthDayCount: Int = 0
     
     if customWeekStart.rawValue >= lastWeekday.rawValue {
       if lastWeekday.rawValue - lastWeekday.rawValue == 0 {
         nextMonthDayCount = 6
       } else {
         nextMonthDayCount = lastWeekday.rawValue - lastWeekday.rawValue
       }
     } else {
       nextMonthDayCount = 7 - lastWeekday.rawValue
     }
     
     var nextDays: [Date] = []
     
     if nextMonthDayCount != 0 {
       for number in 1...nextMonthDayCount {
         guard let day = calendar.date(byAdding: .day, value: number, to: lastDayOfMonth) else {
           return []
         }
         nextDays.append(day)
       }
     }

     return nextDays
   }
}

extension Text {
  func weekStyle() -> some View {
    self.frame(maxWidth: .infinity)
      .padding(.top)
      .lineLimit(1)
  }
}
