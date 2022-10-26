//
//  EventManager.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation
import EventKit

protocol ManagerProtocol {
  var store: EKEventStore { get set }
  var calendar: Calendar { get set }
  
  associatedtype task
  associatedtype EKTask
  
  func getPermission()
  func filterTask(_ taget: [task], _ date: Date) -> [task]
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([task]) -> Void)
  func createNewTask(newTask: EKTask)
  func getTaskCategories() -> [EKCalendar]
}

struct EventManager1: ManagerProtocol {
  var store: EKEventStore
  var calendar: Calendar
  
  typealias task = Event
  typealias EKTask = EKEvent
  
  func getPermission() {
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
  
  func filterTask(_ taget: [Event], _ date: Date) -> [Event] {
    taget
      .filter { $0.ekevent.startDate.compare(date) != ComparisonResult.orderedDescending &&
        $0.ekevent.endDate.compare(date) != ComparisonResult.orderedAscending }
  }
  
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([Event]) -> Void) {
    let allDates = date.getAllDates()
    guard let firstDate = allDates.first, let lastDate = allDates.last else {
      return
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
    completionHandler(list)
  }
  
  
  func createNewTask(newTask: EKEvent) {
    do {
      try store.save(newTask, span: EKSpan.futureEvents, commit: true)
    } catch {
      print("event 저장 실패🥲")
      print(error.localizedDescription)
    }
  }
  
  func getTaskCategories() -> [EKCalendar] {
    return store.calendars(for: .event)
  }
  
  private func filterFirstDayEvent(_ data: [Event], _ date: Date) -> Event? {
    
    data
      .filter { $0.ekevent.startDate.compare(date) == ComparisonResult.orderedSame }
      .first
  }

  
}

struct ReminderManager: ManagerProtocol {
  var store: EKEventStore
  var calendar: Calendar
  
  typealias task = Reminder
  typealias EKTask = EKReminder
  
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
  }
  
  func filterTask(_ taget: [Reminder], _ date: Date) -> [Reminder] {
    taget
      .filter {
        $0.ekreminder.dueDateComponents?.day == calendar.dateComponents([.day], from: date).day &&
        $0.ekreminder.dueDateComponents?.month == calendar.dateComponents([.month], from: date).month }
  }
  
  func getAllTaskforThisMonth(date: Date, completionHandler: @escaping ([Reminder]) -> Void) {
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
  
  func createNewTask(newTask: EKReminder) {
    do {
      try store.save(newTask, commit: true)
    } catch {
      print("reminder 저장 실패🥲")
      print(error.localizedDescription)
    }
  }
  
  func getTaskCategories() -> [EKCalendar] {
    return store.calendars(for: .reminder)
  }
}



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
}

// MARK: - reminder
extension EventManager {
  func createNewReminder(newReminder: EKReminder) {
    do {
      try store.save(newReminder, commit: true)
    } catch {
      print("reminder 저장 실패🥲")
      print(error.localizedDescription)
    }
  }
  
  func getReminderCategories() -> [EKCalendar] {
    return store.calendars(for: .reminder)
  }
  
  func filterReminder(_ reminders: [Reminder], _ date: Date) -> [Reminder] {
    reminders
      .filter {
        $0.ekreminder.dueDateComponents?.day == calendar.dateComponents([.day], from: date).day &&
        $0.ekreminder.dueDateComponents?.month == calendar.dateComponents([.month], from: date).month }
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
}


// MARK: - event
extension EventManager {
  func createNewEvent(newEvent: EKEvent) {
    do {
      try store.save(newEvent, span: EKSpan.futureEvents, commit: true)
    } catch {
      print("event 저장 실패🥲")
      print(error.localizedDescription)
    }
  }
  
  func getEventCategories() -> [EKCalendar] {
    return store.calendars(for: .event)
  }
  
   func filterEvent(_ data: [Event], _ date: Date) -> [Event] {
    data
      .filter { $0.ekevent.startDate.compare(date) != ComparisonResult.orderedDescending &&
        $0.ekevent.endDate.compare(date) != ComparisonResult.orderedAscending }
  }
  
  
  private func filterFirstDayEvent(_ data: [Event], _ date: Date) -> Event? {
    
    data
      .filter { $0.ekevent.startDate.compare(date) == ComparisonResult.orderedSame }
      .first
  }
  
  func getAllEventforThisMonth(date: Date, completionHandler: @escaping ([Event]) -> Void) {
    let allDates = date.getAllDates()
    guard let firstDate = allDates.first, let lastDate = allDates.last else {
      return
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
    completionHandler(list)
  }
}








extension EKCalendar: Identifiable {}
