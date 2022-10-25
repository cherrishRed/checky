//
//  WeeklyViewModel.swift
//  checky
//
//  Created by song on 2022/10/12.
//

import Foundation
import Combine

class WeeklyViewModel: ViewModelable {
  
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
  
  enum Action {
    case actionOnAppear
    case filteredEvent(date: Date)
    case filteredReminder(date: Date)
    case dragGestur
    case resetCurrentOffsetY
  }
  
  func action(_ action: Action) {
    switch action {
    case .actionOnAppear:
      onAppear()
    case .filteredEvent(let date):
      events = filteredEvent(date)
    case .filteredReminder(let date):
      reminders = filteredReminder(date)
    case .dragGestur:
      dragGestureonEnded()
    case .resetCurrentOffsetY:
      resetCurrentOffsetY()
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
    events = eventManager.getAllEventforThisMonth(date: dateHolder.date)
  }
  
  private func fetchReminder() {
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

protocol ViewModelable: ObservableObject {
  associatedtype Action
  
  func action(_ action: Action)
}
