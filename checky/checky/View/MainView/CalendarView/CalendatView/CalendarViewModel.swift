//
//  CalendarViewModel.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/06.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetX: CGSize
  let eventManager: EventManager
  let calendarHelper: CalendarHelper
  
  init(dateHolder: DateHolder,
       eventManager: EventManager,
       calendarHelper: CalendarHelper,
       events: [Event] = [],
       reminders: [Reminder] = [],
       currentOffsetX: CGSize = .zero
  ) {
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.calendarHelper = calendarHelper
    self.events = events
    self.reminders = reminders
    self.currentOffsetX = currentOffsetX
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
      dateHolder.date = calendarHelper.minusMonth(dateHolder.date)
      return
    }
    dateHolder.date = calendarHelper.plusMonth(dateHolder.date)
  }
  
  func resetCurrentOffsetX() {
    currentOffsetX = .zero
  }
}
