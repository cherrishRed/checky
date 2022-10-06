//
//  EventManager.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation
import EventKit

class EventManager {
  let store: EKEventStore
  let calendar: Calendar
  
  init(
    store: EKEventStore = EKEventStore(),
    calendar: Calendar = Calendar.current
  ) {
    self.store = store
    self.calendar = calendar
  }
  
  
  func getPermission() {
    store.requestAccess(to: .reminder) { granted, error in
      guard error == nil else {
        print("에러가 있습니다")
        return
      }
      
      guard granted == true else {
        print("권한이 이상합니다")
        return
      }
    }
    
    store.requestAccess(to: .event) { granted, error in
      guard error == nil else {
        print("에러가 있습니다")
        return
      }
      
      guard granted == true else {
        print("권한이 이상합니다")
        return
      }
    }
  }
  
  func getAllEventforThisMonth(date: Date) -> [Event] {
    let allDates = date.getAllDates()
    guard let firstDate = allDates.first, let lastDate = allDates.last else {
      return []
    }
    
    let categories = store.calendars(for: .event)
    
    var list: [Event] = []
    
    for category in categories {
      let predicate = store.predicateForEvents(withStart: firstDate, end: lastDate, calendars: [category])
      let eventList = store.events(matching: predicate).map { ekevent -> Event in
        return Event(ekevent: ekevent, category: category)
      }
      list.append(contentsOf: eventList)
    }
    
    return list
  }
  
  func getAllReminderforThisMonth(date: Date, completionHandler: @escaping ([Reminder]) -> Void) {
    let categories = store.calendars(for: .reminder)
    
    var list: [Reminder] = []
    
    for category in categories {
      let predicate: NSPredicate = store.predicateForReminders(in: [category])
      
      store.fetchReminders(matching: predicate) { reminders in
        for ekreminder in reminders ?? [] {
          let reminder = Reminder(ekreminder: ekreminder, category: category)
          list.append(reminder)
        }
        completionHandler(list)
      }
    }
  }
  
  func filterReminder(_ reminders: [Reminder], _ date: Date) -> [Reminder] {
    let filteredReminder = reminders
      .filter {
        $0.ekreminder.dueDateComponents?.day == calendar.dateComponents([.day], from: date).day &&
        $0.ekreminder.dueDateComponents?.month == calendar.dateComponents([.month], from: date).month }
    return filteredReminder
  }
  
  func filterEvent(_ data: [Event], _ date: Date) -> [Event] {
    let filteredDatas = data
      .filter { $0.ekevent.startDate.dateCompare(fromDate: date) == CompareDataState.orderedSame }
    
    return filteredDatas
  }
}
