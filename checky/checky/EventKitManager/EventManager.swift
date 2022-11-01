//
//  EventManager.swift
//  checky
//
//  Created by RED, Taeangel on 2022/10/04.
//

import Foundation
import EventKit

struct EventManager: ManagerProtocol {
  var store: EKEventStore
  var calendar: Calendar
  
  typealias task = Event

  init(store: EKEventStore = EKEventStore(),
       calendar: Calendar = Calendar(identifier: .gregorian)) {
    self.store = store
    self.calendar = calendar
  }
  
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
  
  func filterTask(_ target: [Event], _ date: Date) -> [Event] {
    return target.filter { event in
      return event.ekevent.startDate.compareWithoutTime(date) || event.ekevent.endDate.compareWithoutTime(date)
    }
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
  
  func createNewTask(newTask: EKCalendarItem) {
    guard let newTask = newTask as? EKEvent else { return }
    
    do {
      try store.save(newTask, span: EKSpan.futureEvents, commit: true)
    } catch {
      print("event 저장 실패🥲")
      print(error.localizedDescription)
    }
  }
  
  func editTask(task: EKCalendarItem) {
    guard let task = task as? EKEvent else { return }
    
    do {
      try store.save(task, span: EKSpan.futureEvents, commit: true)
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
