//
//  EventManager.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation
import EventKit

class EventManager {
  let store = EKEventStore()
  let calendar = Calendar.current
  
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
  
  func getAllReminderforThisMonth(date: Date) -> [Reminder] {
    let categories = store.calendars(for: .reminder)
    
    var list: [Reminder] = []
    
    for category in categories {
      let predicate: NSPredicate = store.predicateForReminders(in: [category])
      
      var ekreminders: [EKReminder] = []
      store.fetchReminders(matching: predicate) { ekreminder in
        ekreminders = ekreminder ?? []
      }
      let reminders = ekreminders.map { ekreminder in
        Reminder(ekreminder: ekreminder, category: category)
      }
      list.append(contentsOf: reminders)
    }
    
    return list
  }
}
