//
//  WeeklyStackViewModel.swift
//  checky
//
//  Created by RED on 2022/10/29.
//

import SwiftUI

class WeeklyStackViewModel: ViewModelable {
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarCanDo
  let offsetWidth: CGFloat
  var moveToMonthly: () -> ()
  
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  
  @Published var currentOffsetX: CGFloat
  @Published var currentIndex: Int
  
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarCanDo,
    events: [Event] = [],
    reminders: [Reminder] = [],
    offsetWidth: CGFloat,
    currentIndex: Int = 1,
    moveToMonthly: @escaping () -> ()
  ) {
    self.moveToMonthly = moveToMonthly
    self.dateHolder = dateHolder
    self.eventManager = eventManager
    self.reminderManager = reminderManager
    self.calendarHelper = calendarHelper
    self.events = events
    self.reminders = reminders
    self.offsetWidth = offsetWidth
    self.currentIndex = currentIndex
    
    self.currentOffsetX = -CGFloat(currentIndex) * offsetWidth
  }
  
  var pastCurrentFutureDates: [Date] {
    return calendarHelper.extractPastCurrentFutureDates(dateHolder.date)
  }
  
  enum Action {
    case actionOnAppear
    case moveToMonthly
    case moveToPreviousWeek
    case moveToNextWeek
    case onChagnedIndex(Int)
  }
  
  func action(_ action: Action) {
    switch action {
    case .actionOnAppear:
      onAppear()
    case .moveToMonthly:
      moveToMonthly()
      case .moveToPreviousWeek:
        moveToPreviousWeek()
      case .moveToNextWeek:
        moveToNextWeek()
      case .onChagnedIndex(let index):
        onChagnedIndex(index)
    }
  }
  
  func onAppear() {
    self.getPermission()
    self.fetchEvents()
    self.fetchReminder()
  }
  
  private func getPermission() {
    eventManager.getPermission()
  }
  
  private func fetchEvents() {
    eventManager.getAllTaskforThisMonth(date: dateHolder.date, completionHandler: { [weak self] eventList in
      DispatchQueue.main.async {
        self?.events = eventList
      }
    })
  }
  
  private func fetchReminder() {
    reminderManager.getAllTaskforThisMonth(date: dateHolder.date, completionHandler: { [weak self] reminderList in
      DispatchQueue.main.async {
        self?.reminders = reminderList
      }
    })
  }
  
  var allDatesForDisplay: [DateValue] {
    return calendarHelper.extractDates(dateHolder.date)
  }
    
  func filteredEvent(_ date: Date) -> [Event] {
    eventManager.filterTask(events, date)
  }
  
  func filteredReminder(_ date: Date) -> [Reminder] {
    reminderManager.filterTask(reminders, date)
  }
  
  var gridCloumnsCount: CGFloat {
    return CGFloat(calendarHelper.extractDates(dateHolder.date).count + 1)
  }

  private func moveToPreviousWeek() {
    currentOffsetX += offsetWidth
      currentIndex -= 1
  }
  
  private func moveToNextWeek() {
    currentOffsetX -= offsetWidth
    currentIndex += 1
  }
  
  private func onChagnedIndex(_ changedIndex: Int) {
    if changedIndex == 0 {
      dateHolder.date = calendarHelper.minusDate(dateHolder.date)
      currentOffsetX = -offsetWidth
      currentIndex = 1
    }
    
    if changedIndex == 2 {
      dateHolder.date = calendarHelper.plusDate(dateHolder.date)
      currentOffsetX = -offsetWidth
      currentIndex = 1
    }
  }
}
