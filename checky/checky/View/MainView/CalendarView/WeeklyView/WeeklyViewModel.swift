//
//  WeeklyViewModel.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import Foundation
import Combine

class WeeklyViewModel: ObservableObject {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetY: CGSize
  let eventManager: EventManager
  let calendarHelper: CalendarCanDo
  var moveToMonthly: () -> ()
  
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    calendarHelper: CalendarCanDo,
    currentOffsetY: CGSize = .zero,
    events: [Event] = [],
    reminders: [Reminder] = [],
    moveToMonthly: @escaping () -> ()
  ) {
    self.moveToMonthly = moveToMonthly
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.calendarHelper = calendarHelper
    self.currentOffsetY = currentOffsetY
    self.events = events
    self.reminders = reminders
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
    return CGFloat(calendarHelper.extractDates(dateHolder.date).count + 1)
  }
  
  func dragGestureonEnded() {
    guard currentOffsetY.height < 0 else {
      dateHolder.date = calendarHelper.minusDate(dateHolder.date)
      return
    }
    dateHolder.date = calendarHelper.plusDate(dateHolder.date)
  }
  
  func resetCurrentOffsetY() {
    currentOffsetY = .zero
  }
}
