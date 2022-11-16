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
      let predicate = store.predicateForEvents(withStart: firstDate.minusSevenDates, end: lastDate.plusSevenDates, calendars: [category])
      let eventList = store.events(matching: predicate).map { ekevent -> Event in
        return Event(ekevent: ekevent, category: category)
      }
      list.append(contentsOf: eventList)
    }
    completionHandler(list)
  }
  
  func getAllTaskforThisDay(date: Date, completionHandler: @escaping ([Event]) -> Void) {
    let categories = store.calendars(for: .event)
    
    var list: [Event] = []
    
    for category in categories {
      let predicate = store.predicateForEvents(withStart: date, end: date, calendars: [category])
      let eventList = store.events(matching: predicate).map { ekevent -> Event in
        return Event(ekevent: ekevent, category: category)
      }
      list.append(contentsOf: eventList)
    }
    completionHandler(list)
  }
  
  func createNewTask(newTask: EKCalendarItem) -> Result<String, EventManagerError> {
    guard let newTask = newTask as? EKEvent else { return .failure(.EKEventTypeCastingError) }
    
    do {
      try store.save(newTask, span: EKSpan.futureEvents, commit: true)
      return .success("event 저장에 성공했습니다.")
    } catch {
      return .failure(.createError)
    }
  }
  
  func editTask(task: EKCalendarItem) -> Result<String, EventManagerError> {
    guard let task = task as? EKEvent else { return .failure(.EKEventTypeCastingError) }
    
    do {
      try store.save(task, span: EKSpan.futureEvents, commit: true)
      return .success("event 수정 성공😃")
    } catch {
      return .failure(.editError)
    }
  }
  
  func deleteTask(task: EKCalendarItem) -> Result<String, EventManagerError> {
    guard let task = task as? EKEvent else { return .failure(.EKEventTypeCastingError) }
    
    do {
      try store.remove(task, span:  EKSpan.futureEvents)
      return .success("event 삭제 성공😃")
    } catch {
      return .failure(.deleteError)
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
