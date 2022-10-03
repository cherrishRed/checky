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
  @State var currentMonth: Int = 0
  @State var startingWeek: Week = Week.sunday
  
  var body: some View {
    VStack(spacing: 1) {
      DateScrollerView()
        .environmentObject(dateHolder)
        .padding()
      
      dayOfWeekStack
      
      CalendarGrid
    }
    .onAppear {
      print(extractDate())
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
          Text(week.koreanShort)
            .weekStyle()
        }
      }
    }
  }
  
  var CalendarGrid: some View {
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
      var body: some View {
    LazyVGrid(columns: columns, spacing: 15) {
      ForEach(extractDate()) { value in
        Text("day : \(value.day)")
          .foregroundColor(value.isCurrentMonth ? .black : .gray)
      }
    }
    }
    return body
  }
  
  func extractDate() -> [DateValue] {
    let calendar = Calendar.current
    guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: dateHolder.date) else { return [] }
    
    let days = currentMonth.getAllDates()
    let firstDayOfMonth = days.first!
    let lastDayOfMonth = days.last!
    
    let previousDays = previousDates(firstDayOfMonth: firstDayOfMonth)
    let nextDays = nextDates(lastDayOfMonth: lastDayOfMonth)
    
  // case sunday = 1 시작날짜
  // case monday = 2
  // case tuesday = 3
  // case wednessday = 4
  // case thursday = 5
  // case friday = 6
  // case saturday = 7
    
  // 만약 월요일이면 이렇게 해라
    
    
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
  
  private func nextDates(lastDayOfMonth: Date) -> [Date] {
    // case sunday = 1 시작날짜
    // case monday = 2  달의 마지막날
    // case tuesday = 3
    // case wednessday = 4
    // case thursday = 5
    // case friday = 6
    // case saturday = 7 끝날짜
      
    // 만약 월요일이면 이렇게 해라
    
    let calendar = Calendar.current
    let customWeekStart = startingWeek
    
    let lastDayOfWeekday = calendar.component(.weekday, from: lastDayOfMonth)
    let lastWeekday = Week(rawValue: lastDayOfWeekday)!

    
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
        let day = calendar.date(byAdding: .day, value: number, to: lastDayOfMonth)!
        nextDays.append(day)
      }
    }

    return nextDays
  }
  
  private func previousDates(firstDayOfMonth: Date) -> [Date] {
    let calendar = Calendar.current
    let customWeekStart = startingWeek
    let firstDayOfWeekday = calendar.component(.weekday, from: firstDayOfMonth)
    let firstWeekday = Week(rawValue: firstDayOfWeekday)!
    
    var previousMonthDayCount: Int = 0
    
    if customWeekStart.rawValue > firstWeekday.rawValue {
      previousMonthDayCount = 7 - customWeekStart.rawValue + firstWeekday.rawValue
    } else {
      previousMonthDayCount = firstWeekday.rawValue - customWeekStart.rawValue
    }
    
    var previousDays: [Date] = []
    
    if previousMonthDayCount != 0 {
      for number in 1...previousMonthDayCount {
        let day = calendar.date(byAdding: .day, value: -number, to: firstDayOfMonth)!
        previousDays.insert(day, at: 0)
      }
    }
    
    return previousDays
  }
  
//  func nextDaysCount(firstweekday: Week, lastDayOfMonth: Week) -> Int {
//    let gap = 7 - firstweekday.rawValue
//
//    if firstweekday.rawValue == lastDayOfMonth.rawValue {
//      return 6
//    }
//
//  }
}


extension Text {
  func weekStyle() -> some View {
    self.frame(maxWidth: .infinity)
      .padding(.top)
      .lineLimit(1)
  }
}

struct DateValue: Identifiable {
  var id = UUID().uuidString
  var date: Date
  var isCurrentMonth: Bool = true
  
  var day: Int {
    Int(date.onlyDay)!
  }
}

extension Date {
  func getAllDates() -> [Date] {
    // 이 메서드는 그 달의 모든 날짜를 배열로 반환해 주는 메서드
    // 그러니까 10월 1일 부터 10월 31일 일까지의 정보를 반환해줌.
    
    let calendar = Calendar.current
    
    
    // getting start Date...
    let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
     
//    guard let startDate = calendar.date(byAdding: .day, value: 1, to: preLastMonth) else {
//      return []
//    }
    
    print("startDate : \(startDate)")
    
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    print("range : \(range)")
    
    // getting date...
    return range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }
  }
}

extension Date {
  var onlyDay: String {
    let dateformmater = DateFormatter()
    dateformmater.locale = Locale(identifier: "ko_KR")
    dateformmater.dateFormat = "d"
    return dateformmater.string(from: self)
  }
}
