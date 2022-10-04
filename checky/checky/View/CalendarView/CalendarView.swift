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
  let eventManager: EventManager = EventManager()
  @State var events: [Event] = []
  @State var reminders: [Reminder] = []
  
  var body: some View {
    VStack(spacing: 1) {
      HeaderView()
        .environmentObject(dateHolder)
        .padding()
      
      dayOfWeekStack
      
      CalendarGrid
    }
    .onChange(of: dateHolder.date) { newValue in
      events = eventManager.getAllEventforThisMonth(date: dateHolder.date)
      eventManager.getAllReminderforThisMonth(date: dateHolder.date) { reminderList in
        reminders = reminderList
        print(reminderList)
      }
    }
    .onAppear {
      eventManager.getPermission()
      
      events = eventManager.getAllEventforThisMonth(date: dateHolder.date)
      eventManager.getAllReminderforThisMonth(date: dateHolder.date) { reminderList in
        reminders = reminderList
        print(reminderList)
      }
    }
  }
  
  var dayOfWeekStack: some View {
    HStack(spacing: 1) {
      ForEach(CalendarHelper().startingWeek.allWeeks(), id: \.rawValue) { week in
        if CalendarHelper().weekOption == WeekOption.KoreanShort {
          Text(week.koreanShort)
            .weekStyle()
        } else if CalendarHelper().weekOption == WeekOption.EnglishShort {
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
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
    let columnsCount: CGFloat = CalendarHelper().extractDates(dateHolder.date).count > 35 ? CGFloat(6) : CGFloat(5)
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(CalendarHelper().extractDates(dateHolder.date)) { value in
            
            let filteredEvent = events.filter { event in
              return event.ekevent.startDate.dateCompare(fromDate: value.date) == "Same"
              
            }
            
            let filteredReminder = reminders.filter { reminder in
              let dateComponent: DateComponents = Calendar.current.dateComponents([.day, .month], from: value.date)
              let sameDay = reminder.ekreminder.dueDateComponents?.day == dateComponent.day
              let sameMonth = reminder.ekreminder.dueDateComponents?.month == dateComponent.month
              
              return sameDay && sameMonth
            }
            
            
            CalendarCellView(dateValue: value, allEvnets: filteredEvent, allReminders: filteredReminder)
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
              dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
            } else if currentOffsetX.width > 0 {
              dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
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
