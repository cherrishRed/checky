//
//  CalendarViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI
import Combine

class MonthlyViewModel: ViewModelable {
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarCanDo
  var moveToWeek: () -> ()

  @Published var date: Date
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetX: CGSize
    
  init(
    date: Date,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarCanDo,
    events: [Event] = [],
    reminders: [Reminder] = [],
    currentOffsetX: CGSize = .zero,
    moveToWeek: @escaping () -> ()
  ) {
    self.moveToWeek = moveToWeek
    self.date = date
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.events = events
    self.reminders = reminders
    self.currentOffsetX = currentOffsetX
  }
  
  enum Action {
    case actionOnAppear
    case onChangeDate
//    case dragGestur
//    case resetCurrentOffsetX
    case moveToWeekly
  }
  
  func action(_ action: Action) {
    switch action {
      case .actionOnAppear:
        getPermission()
        fetchEvents()
        fetchReminder()
      case .onChangeDate:
        fetchEvents()
        fetchReminder()
//      case .dragGestur:
//        dragGestureonEnded()
//      case .resetCurrentOffsetX:
//        resetCurrentOffsetX()
      case .moveToWeekly:
        moveToWeek()
    }
  }
  
  
  func getPermission() {
    eventManager.getPermission()
  }
  
  func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        self?.events = eventList
      }
    })
  }
  
  func fetchReminder() {
    reminderManager.getAllTaskforThisMonth(date: date) { [weak self] reminderList in
      DispatchQueue.main.async {
        self?.reminders = reminderList
      }
    }
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(date)
  }
  
  func filteredEvent(_ date: Date) -> [Event] {
    eventManager.filterTask(events, date)
  }
  
  func filteredReminder(_ date: Date) -> [Reminder] {
    reminderManager.filterTask(reminders, date)
  }
  
  var gridCloumnsCount: CGFloat {
    return calendarHelper.extractDates(date).count > 35 ? CGFloat(6) : CGFloat(5)
  }
  
//  func dragGestureonEnded() {
//    guard currentOffsetX.width < 0 else {
//      date = calendarHelper.minusDate(date)
//      return
//    }
//      date = calendarHelper.plusDate(date)
//  }
  
//  func resetCurrentOffsetX() {
//    currentOffsetX = .zero
//  }
}
