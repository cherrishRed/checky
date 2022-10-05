//
//  ContentView.swift
//  checky
//
//  Created by RED, Taeangel on 2022/09/30.
//

import SwiftUI

struct CalendarView: View {
  @ObservedObject var viewModel: CalendarViewModel
//  @EnvironmentObject var dateHolder: DateHolder
//  @State var currentOffsetX: CGSize = .zero
//  let eventManager: EventManager = EventManager()
//  @State var events: [Event] = []
//  @State var reminders: [Reminder] = []
  
  var body: some View {
    VStack(spacing: 1) {
//      HeaderView()
//        .environmentObject(dateHolder)
//        .padding()
      
      dayOfWeekStack
      
      CalendarGrid
    }
    .onChange(of: viewModel.dateHolder.date) { newValue in
      viewModel.fetchEvents()
      viewModel.fetchReminder()
//      events = eventManager.getAllEventforThisMonth(date: dateHolder.date)
//      eventManager.getAllReminderforThisMonth(date: dateHolder.date) { reminderList in
//        reminders = reminderList
//        print(reminderList)
      }
    .onAppear {
      viewModel.getPermission()
      viewModel.fetchEvents()
      viewModel.fetchReminder()
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
    let columnsCount: CGFloat = viewModel.gridCloumnsCount
    
    var body: some View {
      GeometryReader { geo in
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(viewModel.allDatesForDisplay) { value in
            CalendarCellView(dateValue: value,
                             allEvnets: viewModel.filteredEvent(value.date),
                             allReminders: viewModel.filteredReminder(value.date))
            .frame(width: geo.size.width / 7, height: geo.size.height / columnsCount)
          }
        }
      }
      .frame(maxHeight: .infinity)
      .gesture(
        DragGesture()
          .onChanged { value in
            viewModel.currentOffsetX = value.translation
          }
          .onEnded { value in
            viewModel.dragGestureonEnded()
            withAnimation(.linear(duration: 0.4)) {
              viewModel.resetCurrentOffsetX()
            }
          }
      )
    }
    return body
  }
}
