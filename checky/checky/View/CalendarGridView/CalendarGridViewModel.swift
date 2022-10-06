//
//  dayOfWeekStackViewModel.swift
//  checky
//
//  Created by song on 2022/10/06.
//

import Foundation

class CalendarGridViewModel: ObservableObject {
  
  @Published var dateHolder: DateHolder
  @Published var events: [Event] = []
  @Published var reminders: [Reminder] = []
  @Published var currentOffsetX: CGSize = .zero
  
  let eventManager: EventManager
  let calendarHelper: CalendarHelper
  
  init(dateHolder: DateHolder,
       eventManager: EventManager,
       calendarHelper: CalendarHelper) {
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.calendarHelper = calendarHelper
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
    if currentOffsetX.width < 0 {
      dateHolder.date = calendarHelper.plusMonth(dateHolder.date)
    } else {
      dateHolder.date = calendarHelper.minusMonth(dateHolder.date)
    }
  }
  
  func resetCurrentOffsetX() {
    currentOffsetX = .zero
  }
  
}
