//
//  CalendarViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI
import Combine

class MonthlyViewModel: ViewModelable {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetX: CGSize
  let eventManager: EventManager
  let calendarHelper: CalendarCanDo
  var moveToWeek: () -> ()
  
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    calendarHelper: CalendarCanDo,
    events: [Event] = [],
    reminders: [Reminder] = [],
    currentOffsetX: CGSize = .zero,
    moveToWeek: @escaping () -> ()
  ) {
    self.moveToWeek = moveToWeek
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.calendarHelper = calendarHelper
    self.events = events
    self.reminders = reminders
    self.currentOffsetX = currentOffsetX
  }
  
  enum Action {
    case actionOnAppear
    case onChangeDate
    case dragGestur
    case resetCurrentOffsetX
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
      case .dragGestur:
        dragGestureonEnded()
      case .resetCurrentOffsetX:
        resetCurrentOffsetX()
      case .moveToWeekly:
        moveToWeek()
    }
  }
  
  
  func getPermission() {
    eventManager.getPermission()
  }
  
  func fetchEvents() {
    events = eventManager.getAllEventforThisMonth(date: dateHolder.date)
  }
  
  func fetchReminder() {
    eventManager.getAllReminderforThisMonth(date: dateHolder.date, completionHandler: { [weak self] reminderList in
      DispatchQueue.main.async {
        self?.reminders = reminderList
      }
    })
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(dateHolder.date)
  }
  
  func filteredEvent(_ date: Date) -> [Event] {
    eventManager.filterEvent(events, date)
  }
  
  func filteredReminder(_ date: Date) -> [Reminder] {
    eventManager.filterReminder(reminders, date)
  }
  
  var gridCloumnsCount: CGFloat {
    return calendarHelper.extractDates(dateHolder.date).count > 35 ? CGFloat(6) : CGFloat(5)
  }
  
  func dragGestureonEnded() {
    guard currentOffsetX.width < 0 else {
      dateHolder.date = calendarHelper.minusDate(dateHolder.date)
      return
    }
    dateHolder.date = calendarHelper.plusDate(dateHolder.date)
  }
  
  func resetCurrentOffsetX() {
    currentOffsetX = .zero
  }
}
