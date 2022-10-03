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
  
  var body: some View {
    VStack(spacing: 1) {
      DateScrollerView()
        .environmentObject(dateHolder)
        .padding()
      
      dayOfWeekStack
      
      CalendarGrid
    }
    .onAppear {
//      print(Date().getAllDates())
      extractDate()
    }
  }

  
  var dayOfWeekStack: some View {
    HStack(spacing: 1) {
      ForEach(Week.allCases, id: \.rawValue) { week in
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
    // Getting Current Month Date...
    guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else { return [] }
    
//    print("엑스트랙 currentMonth: \(currentMonth)")
    
    let days = currentMonth.getAllDates()
    let firstDayOfMonth = days.first!
    let lastDayOfMonth = days.last!
    
//    print("last day : \(lastDayOfMonth)")
    
    let firstDayOfWeekday = calendar.component(.weekday, from: firstDayOfMonth)
    let firstWeekday = Week(rawValue: firstDayOfWeekday)!
    
    let lastDayOfWeekday = calendar.component(.weekday, from: lastDayOfMonth)
    let lastWeekday = Week(rawValue: lastDayOfWeekday)!
  
    // 월 화 수 목 금 토 일
    // 시작 요일 부터 지금 요일 까지의 차이의 수를 구하고 그 수 많큼 앞에 요일의 것을 추가 해 줄 것
    
    let customWeekStart = Week.monday
    
    var previousMonthDayCount: Int = 0
    
    if customWeekStart.rawValue > firstWeekday.rawValue {
      previousMonthDayCount = 7 - customWeekStart.rawValue + firstWeekday.rawValue
    } else {
      previousMonthDayCount = firstWeekday.rawValue - customWeekStart.rawValue
    }
    
  // case sunday = 2 마지막날
  // case monday = 3 끝날짜
  // case tuesday = 4
  // case wednessday = 5 여기까지야
  // case thursday = 6
  // case friday = 7
  // case saturday = 1 오늘 날짜
    
    var previousDays: [Date] = []
    
    for number in 1...previousMonthDayCount {
      let day = calendar.date(byAdding: .day, value: -number, to: firstDayOfMonth)!
      previousDays.insert(day, at: 0)
    }
    
    print("previousDays: \n \(previousDays)")
    
    var nextMonthDayCount: Int = 0
    
    if customWeekStart.rawValue >= lastWeekday.rawValue {
      if lastWeekday.rawValue - lastWeekday.rawValue == 0 {
        nextMonthDayCount = 6
      } else {
        nextMonthDayCount = lastWeekday.rawValue - lastWeekday.rawValue
      }
    } else {
      nextMonthDayCount = 7 - lastWeekday.rawValue + customWeekStart.rawValue
    }
    
    print("nextMonthDayCount: \(nextMonthDayCount)")
    
    var nextDays: [Date] = []
    
    for number in 1...nextMonthDayCount {
      let day = calendar.date(byAdding: .day, value: number, to: lastDayOfMonth)!
      nextDays.append(day)
    }
    
    print("nexDays : \n \(nextDays)")
    
    
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
