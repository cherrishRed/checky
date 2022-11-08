//
//  MonthlyStackViewModel.swift
//  checky
//
//  Created by RED on 2022/10/28.
//

import Foundation

class MonthlyStackViewModel: ViewModelable {
  @Published var dateHolder: DateHolder
  @Published var events: [Event]
  @Published var reminders: [Reminder]
  @Published var currentOffsetX: CGFloat
  @Published var currentIndex: Int
  
  let eventManager: EventManager
  let reminderManager: ReminderManager
  let calendarHelper: CalendarCanDo
  let offsetWidth: CGFloat
  var moveToWeek: () -> ()
    
  init(
    dateHolder: DateHolder,
    eventManager: EventManager,
    reminderManager: ReminderManager,
    calendarHelper: CalendarCanDo,
    offsetWidth: CGFloat,
    events: [Event] = [],
    reminders: [Reminder] = [],
    moveToWeek: @escaping () -> (),
    currentIndex: Int = 1
  ) {
    self.moveToWeek = moveToWeek
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
    case moveToWeekly
    case moveToPreviousMonth
    case moveToNextMonth
    case onChagnedIndex(Int)
  }
  
  func action(_ action: Action) {
    switch action {
      case .moveToWeekly:
        moveToWeek()
      case .moveToPreviousMonth:
        moveToPreviousMonth()
      case.moveToNextMonth:
        moveToNextMonth()
      case .onChagnedIndex(let changedIndex):
        onChagnedIndex(changedIndex)
    }
  }
  
  private func moveToPreviousMonth() {
    currentOffsetX += offsetWidth
      currentIndex -= 1
    dateHolder.date = calendarHelper.minusDate(dateHolder.date)
  }
  
  private func moveToNextMonth() {
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
