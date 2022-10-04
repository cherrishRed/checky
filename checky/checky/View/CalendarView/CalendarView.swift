//
//  ContentView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct CalendarView: View {
  @EnvironmentObject var dateHolder: DateHolder
  @State var currentOffsetX: CGSize = .zero
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
      ForEach(CalendarHelper(date: dateHolder.date).startingWeek.allWeeks(), id: \.rawValue) { week in
        if CalendarHelper(date: dateHolder.date).weekOption == "KoreanShot" {
          Text(week.koreanShort)
            .weekStyle()
        } else if CalendarHelper(date: dateHolder.date).weekOption == "EnglishShort" {
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
    let columns = Array(repeating: GridItem(.flexible(), spacing: nil, alignment: nil), count: 7)
    let columnsCount: CGFloat = CalendarHelper(date: dateHolder.date).extractDates().count > 35 ? CGFloat(6) : CGFloat(5)
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: .zero) {
          ForEach(CalendarHelper(date: dateHolder.date).extractDates()) { value in
            ZStack(alignment: .top) {
              Rectangle()
                .fill(.white)
                .border(.gray)
              Text(value.date.day)
                .foregroundColor(value.isCurrentMonth ? .black : .gray)
            }
            .frame(width: geo.size.width / 7, height: geo.size.height / columnsCount)
          }
        }
      }
      .frame(maxHeight: .infinity)
      .offset(x: currentOffsetX.width)
      .gesture(
        DragGesture()
          .onChanged { value in
            currentOffsetX = value.translation
          }
          .onEnded { value in
            if currentOffsetX.width < 0 {
              dateHolder.date = CalendarHelper(date: dateHolder.date).plusMonth()
            } else if currentOffsetX.width > 0 {
              dateHolder.date = CalendarHelper(date: dateHolder.date).minusMonth()
            }
            withAnimation(.linear(duration: 0.4)) {
              currentOffsetX = .zero
            }
          }
      )
    }
    return body
  }
}
